local BASE_HIT_TIME_OFFSET = 0.2
local MELEE_ROTATION = 1
local SPECIAL_ROTATION = 2
local LEAP_SPEED = 3
local DEATH_RANGE = 120
local DEATH_DAMAGE = 45
local DEFAULT_CAST = "ambient/levels/citadel/weapon_disintegrate1.wav"
local HIT_SOUNDS = {"Stalker.Claw.Hit"}
local MISS_SOUNDS = {"Stalker.Dog.Miss1"}
local MELEE_SEQUENCES = {"ACT_MELEE_ATTACK_SWING", "ACT_MELEE_ATTACK1", "attack", "attack1", "stand_attack_0"}
local RANGE_SEQUENCES = {"ACT_RANGE_ATTACK1", "ACT_RANGE_ATTACK_AR2", "ACT_RANGE_ATTACK_SMG1"}
local MELEE_FIELDS = {
	"MeleeAttackSequence", "MeleeAttackGesture", "MeleeDamageCount", "MeleeDamageTime",
	"MeleeDamageDamage", "MeleeDamageType", "MeleeDamageDistance", "MeleeDamageBone",
	"MeleeDamageRadius", "MeleeHitSound", "MeleeMissSound",
}

local function findSequence(npc, candidates)
	for _, name in ipairs(candidates) do
		local index, time = npc:LookupSequence(name)
		if index >= 0 and time > 0 then return npc:GetSequenceName(index), time end
	end
end

local function meleeArc(arc)
	return arc == 360 and 360 or math.rad(arc * 0.5)
end

local function damageType(attack)
	return _G[attack.damageType] or DMG_GENERIC
end

local function randomDamage(attack)
	return math.random(attack.damage[1], attack.damage[2])
end

local function resolveAttack(npc, profile, defaults)
	if not profile then return end
	local sequence, duration = findSequence(npc, profile.animation)
	if not sequence then sequence, duration = findSequence(npc, defaults) end

	return {
		profile = profile,
		sequence = sequence,
		windup = duration and math.min(profile.windup, duration * 0.9) or profile.windup,
		duration = duration or profile.windup,
	}
end

local function hullDistanceSqr(npc, target)
	local targetPoint = target:NearestPoint(npc:WorldSpaceCenter())

	return npc:NearestPoint(targetPoint):DistToSqr(targetPoint)
end

local function directDamage(npc, target, amount, kind)
	local position = target:WorldSpaceCenter()
	local info = DamageInfo()
	info:SetAttacker(npc)
	info:SetInflictor(npc)
	info:SetDamage(amount)
	info:SetDamageType(kind)
	info:SetDamagePosition(position)
	info:SetDamageForce((position - npc:WorldSpaceCenter()):GetNormalized() * amount * 15)
	target:TakeDamageInfo(info)
end

function ENT:ConfigureWorkshopAttacks(profile)
	self.IdleSequence = findSequence(self, {"ACT_IDLE", "idle", "stand_idle_0"}) or self:GetSequenceName(0)
	self.workshopMelee = resolveAttack(self, profile.melee, MELEE_SEQUENCES)
	self.workshopRanged = resolveAttack(self, profile.ranged, RANGE_SEQUENCES)
	if self.workshopRanged then
		self.navigationRangedMinRange = profile.ranged.minRange
		self.navigationRangedRange = profile.ranged.range
	end
	if profile.leap then
		self.workshopLeap = resolveAttack(self, profile.leap, {"ACT_JUMP", "ACT_LEAP"})
		self.navigationLeapRange = profile.leap.range
		self.navigationLeapAimHeight = profile.leap.height
		self.navigationLeapSpeed = LEAP_SPEED
	end

	if not self.workshopMelee then
		self.MeleeAttackDistance = 0
		return
	end

	local attack = self.workshopMelee
	self.MeleeAttackDistance = attack.profile.range
	if not attack.sequence then
		self.workshopActive = true
		return
	end

	for _, field in ipairs(MELEE_FIELDS) do
		self[field] = {}
	end
	local hit = self:STALKERNPCCreateMeleeTable()
	hit.damage[1] = randomDamage(attack.profile)
	hit.damagetype[1] = damageType(attack.profile)
	hit.distance[1] = attack.profile.reach
	hit.radius[1] = meleeArc(attack.profile.arc)
	hit.time[1] = attack.windup + BASE_HIT_TIME_OFFSET
	hit.bone[1] = "bip01_head"
	self:STALKERNPCSetMeleeParams(1, attack.sequence, 1, hit, HIT_SOUNDS, MISS_SOUNDS)
end

function ENT:PlayWorkshopSound(sounds, fallback)
	if sounds and #sounds > 0 then
		self:EmitSound(table.Random(sounds))
	elseif fallback then
		self:EmitSound(fallback)
	end
end

function ENT:CanWorkshopAttack(target)
	if self.workshopProfile.passive then return false end
	if not IsValid(target) or target:Health() <= 0 or self.cotzPlayerVisible == false then return false end

	return self:STALKERNPCCanAttackThis(target) and self:Visible(target)
end

function ENT:STALKERNPCMeleePlay()
	if self.workshopProfile.passive or not self.workshopMelee or not self.workshopMelee.sequence then return end
	if self.workshopAction or self.PlayingAnimation or self.workshopMovement then return end
	if self.workshopProfile.cloak then self:SetWorkshopAlpha(255) end
	baseclass.Get("stalker_ai").STALKERNPCMeleePlay(self, 1, MELEE_ROTATION)
end

function ENT:STALKERNPCMeleeAttackEvent()
	self:PlayWorkshopSound(self.workshopMelee.profile.sounds)
end

function ENT:StartWorkshopAction(kind, attack, target, now)
	if self.workshopProfile.cloak then self:SetWorkshopAlpha(255) end
	local direction = target:WorldSpaceCenter() - self:WorldSpaceCenter()
	self:SetAngles(Angle(0, direction:Angle().y, 0))
	self:StopMoving()
	if self.workshopMovement then self:SetLocalVelocity(vector_origin) end

	if attack.sequence and not self.workshopMovement then
		self:STALKERNPCPlayAnimation(attack.sequence, SPECIAL_ROTATION)
	else
		self.PlayingAnimation = true
		if attack.sequence then self:ResetSequence(attack.sequence) end
	end

	local windup = attack.windup
	if kind == "leap" then windup = math.max(windup, attack.profile.launchDelay + 0.15) end
	self.workshopAction = {
		kind = kind,
		attack = attack.profile,
		target = target,
		impactAt = now + windup,
		finishAt = now + math.max(windup, attack.duration) + 0.12,
		launchAt = kind == "leap" and (now + attack.profile.launchDelay) or nil,
	}
	local fallback
	if kind == "ranged" then
		fallback = attack.profile.damageType == "DMG_BULLET" and "Weapon_AR2.Single" or DEFAULT_CAST
	end
	self:PlayWorkshopSound(attack.profile.sounds, fallback)
end

function ENT:STALKERNPCDistanceForMeleeTooBig(_, forceJump)
	if not forceJump or not self.workshopLeap or self.workshopAction then return end
	local target = self:GetEnemy()
	if not self:CanWorkshopAttack(target) then return end
	local now = CurTime()
	self.CanJump = now + self.workshopLeap.profile.cooldown
	self:StartWorkshopAction("leap", self.workshopLeap, target, now)
end

function ENT:TryWorkshopAttack(target, now)
	local distanceSqr = self:GetPos():DistToSqr(target:GetPos())
	local ranged = self.workshopRanged
	if ranged and now >= (self.workshopNextRanged or 0) and distanceSqr <= ranged.profile.range ^ 2
		and distanceSqr >= ranged.profile.minRange ^ 2 and not self.cotzNavigationRetreat then
		self.workshopNextRanged = now + ranged.profile.cooldown
		self:StartWorkshopAction("ranged", ranged, target, now)

		return true
	end

	local melee = self.workshopMelee
	if melee and (self.workshopMovement or not melee.sequence)
		and hullDistanceSqr(self, target) <= melee.profile.range ^ 2 then
		self:StartWorkshopAction("melee", melee, target, now)

		return true
	end
	if self.workshopLeap and not self.cotzNavigationRetreat and now >= (self.workshopNextLeapCheck or 0)
		and distanceSqr <= self.navigationLeapRange ^ 2 and distanceSqr > (self.MeleeAttackDistance + 24) ^ 2 then
		self.workshopNextLeapCheck = now + 0.8

		return self:STALKERNPCTryNavigationJump(target)
	end

	return false
end

function ENT:ApplyWorkshopAttack(action)
	local target, attack = action.target, action.attack
	if not self:CanWorkshopAttack(target) then return end
	if action.kind == "leap" then
		self:STALKERNPCDoMeleeDamage(
			randomDamage(attack), damageType(attack), attack.reach, meleeArc(140), "bip01_head", HIT_SOUNDS, MISS_SOUNDS
		)
	elseif action.kind == "melee" then
		if hullDistanceSqr(self, target) > attack.reach ^ 2 then return end
		directDamage(self, target, randomDamage(attack), damageType(attack))
	elseif self:GetPos():DistToSqr(target:GetPos()) <= attack.range ^ 2 then
		if attack.damageType == "DMG_BULLET" then
			local start = self:GetShootPos()
			self:FireBullets({
				Attacker = self,
				Src = start,
				Dir = (target:WorldSpaceCenter() - start):GetNormalized(),
				Distance = attack.range,
				Damage = attack.damage,
				Tracer = 1,
			})
		else
			directDamage(self, target, attack.damage, damageType(attack))
		end
	end
end

function ENT:UpdateWorkshopAction()
	local action = self.workshopAction
	if not self.PlayingAnimation then
		self.workshopAction = nil
		return
	end

	local now = CurTime()
	if action.launchAt and now >= action.launchAt then
		action.launchAt = nil
		if self:CanWorkshopAttack(action.target) and self:IsOnGround() then
			self:SetVelocity(self:STALKERNPCNavigationJumpVelocity(action.target, false))
		else
			action.impactAt = nil
		end
	end
	if action.impactAt and now >= action.impactAt then
		action.impactAt = nil
		self:ApplyWorkshopAttack(action)
	end
	if now >= action.finishAt then
		self.workshopAction = nil
		self:STALKERNPCClearAnimation()
		if self.workshopMovement then self:ResetSequence(self.IdleSequence) end
	end
end

function ENT:STALKERNPCKill(info)
	local burst = self.workshopProfile and self.workshopProfile.deathBurst
	if burst and self.IsAlive and not self.workshopBurst then
		self.workshopBurst = true
		for _, target in ipairs(ents.FindInSphere(self:GetPos(), DEATH_RANGE)) do
			if (target:IsPlayer() or target:IsNPC()) and self:CanWorkshopAttack(target) then
				directDamage(self, target, DEATH_DAMAGE, _G[burst])
			end
		end
	end
	baseclass.Get("stalker_ai").STALKERNPCKill(self, info)
end
