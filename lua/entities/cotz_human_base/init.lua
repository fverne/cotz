AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")
include("entities/stalker_ai/sv_performance.lua")
include("weaponprops.lua")
include("models.lua")

local THINK_INTERVAL = 0.1
local SEARCH_RANGE = 2000
local SEARCH_ANGLE = 45
local MOVEMENT_RETRY = 1
local MIN_SHOT_DELAY = 0.12
local BURST_PAUSE = 0.8
local DEFAULT_RELOAD = 1.8
local MUZZLE_HEIGHT = Vector(0, 0, 55)
local CROUCH_MUZZLE_HEIGHT = Vector(0, 0, 30)
local MELEE_WINDUP = 0.45
local MELEE_RECOVERY = 1.7
local MELEE_REACH = 76
local MELEE_HIT_REACH = 190
local DROP_HEIGHT = Vector(0, 0, 32)
local RAISE_SECONDS = 0.6
local SNEAK_RANGE = 1200
local LOOK_DOT = 0.94
local NOTICE_SECONDS = 6
local AIM_SMOOTHING = 0.5
local CROUCH_CHANCE = 0.35
local CROUCH_ROLL_INTERVAL = 4
local CROUCH_MIN_DISTANCE = 400
local CROUCH_MIN_SECONDS, CROUCH_MAX_SECONDS = 2.5, 6
-- Firing moves: shooters advance until this fraction of their range, strafe inside it, and back away inside
-- their role's retreat distance. Zombies only walk straight at the target until their stop distance.
local ADVANCE_HOLD = 0.6
local FIRE_MOVE_MIN, FIRE_MOVE_MAX = 128, 320
local FIRE_MOVE_MIN_REACH = 64
local FIRE_MOVE_DRIFT = 0.6
local STRAFE_DRIFT = 0.3
local MOVE_CLEARANCE = 32
local MOVE_PROBE_HEIGHT = Vector(0, 0, 36)
local GROUND_PROBE_UP, GROUND_PROBE_DOWN = Vector(0, 0, 48), Vector(0, 0, 128)
local ZOMBIE_STEP = 256
local ZOMBIE_STOP_DISTANCE = 250
local ZOMBIE_FORWARD_ARC = 30

local ROLES = {
	pistolman = {range = 750, burst = 3},
	shotgunner = {range = 750, burst = 1},
	rifleman = {range = 2000, retreat = 550, burst = 4},
	sniper = {range = 4000, retreat = 750, burst = 1},
}

-- Pose names are the suffixes of the model's STALKER sequences (idle_<pose>, run_mp_<pose>, shoot_<pose>...).
-- Calm (the passive pose) is used while patrolling; aim while an enemy is engaged.
local STANCES = {
	pistol = {calm = "all", aim = "revolver"},
	rifle = {calm = "passive", aim = "rpg"},
	melee = {calm = "all", aim = "melee2"},
}

local MOVING_ACTIVITIES = {
	[ACT_WALK] = true,
	[ACT_WALK_AIM] = true,
	[ACT_RUN] = true,
	[ACT_RUN_AIM] = true,
}

-- Activities the engine requests once the NPC is alerted or already moving with its gun raised.
local AIM_ACTIVITIES = {
	[ACT_IDLE_ANGRY] = true,
	[ACT_WALK_AIM] = true,
	[ACT_RUN_AIM] = true,
	[ACT_WALK_CROUCH_AIM] = true,
}

local MOVEMENT_PREFIXES = {
	[ACT_IDLE] = "idle_",
	[ACT_IDLE_ANGRY] = "idle_",
	[ACT_WALK] = "walk_mp_",
	[ACT_WALK_AIM] = "walk_mp_",
	[ACT_RUN] = "run_mp_",
	[ACT_RUN_AIM] = "run_mp_",
	[ACT_CROUCHIDLE] = "cidle_",
	[ACT_WALK_CROUCH] = "cwalk_mp_",
	[ACT_WALK_CROUCH_AIM] = "cwalk_mp_",
}

local function getFallbackActivity(name)
	if name:find("RUN", 1, true) then return ACT_RUN end
	if name:find("WALK", 1, true) then return name:find("CROUCH", 1, true) and ACT_WALK_CROUCH or ACT_WALK end
	if name:find("CROUCH", 1, true) or name:find("COVER", 1, true) then return ACT_CROUCHIDLE end

	return ACT_IDLE
end

-- Every engine activity, classified once by name, so TranslateActivity can always resolve to a pose.
local FALLBACK_ACTIVITIES = {}
for name, value in pairs(_G) do
	if isstring(name) and isnumber(value) and name:sub(1, 4) == "ACT_" then
		FALLBACK_ACTIVITIES[value] = getFallbackActivity(name)
	end
end

function ENT:Initialize()
	self.combatProfile = ROLES[self.CombatRole]
	local models = self.FactionModels[self.ModelGroup]
	self:SetModel(models[math.random(#models)])
	self:SetSkin(math.random(0, math.max(0, self:SkinCount() - 1)))
	self:SetCollisionGroup(COLLISION_GROUP_NPC)
	self:SetCustomCollisionCheck(true)
	self:SetHullType(HULL_HUMAN)
	self:SetHullSizeNormal()
	self:SetSolid(SOLID_BBOX)
	self:SetMoveType(MOVETYPE_STEP)
	self:SetHealth(self.StartHealth)
	self:SetMaxHealth(self.StartHealth)
	self:SetMaxYawSpeed(360)
	self:SetLagCompensated(true)
	self:AddRelationship("player D_HT 10")
	self:CapabilitiesAdd(bit.bor(CAP_MOVE_GROUND, CAP_OPEN_DOORS, CAP_SQUAD, CAP_DUCK))

	local stance, properties = STANCES.melee
	if self.weapons then
		-- No CAP_AIM_GUN: the engine's aim ignores the muzzle point, so AimAt poses the arms.
		self:CapabilitiesAdd(CAP_USE_WEAPONS)
		local loadout = self.weapons[math.random(#self.weapons)]
		self.selectedWeaponItem = loadout[1]
		properties = self.WeaponProps[loadout[1][1]]
		if not properties then ErrorNoHalt("cotz_human_base: no weapon props for " .. loadout[1][1] .. "\n") end
		stance = STANCES[properties and properties.hold or "rifle"]
		local weapon = self:Give(loadout[2])
		-- Ammo is counted here: an empty weapon clip makes the engine start its own reload schedule.
		if IsValid(weapon) then self.clip = math.max(weapon:GetMaxClip1(), 1) end
	else
		properties = self.MeleeLoadouts[math.random(#self.MeleeLoadouts)]
		self.meleeDamage = properties.damage
	end
	self.stance = stance

	self.stanceActivities = {
		calm = self:BuildStanceActivities({stance.calm, stance.aim}),
		aim = self:BuildStanceActivities({stance.aim, stance.calm}),
	}
	self.combatProp = properties and self:AttachCombatProp(properties)
	local weapon = self:GetActiveWeapon()
	if IsValid(self.combatProp) and IsValid(weapon) then weapon:SetNoDraw(true) end
	self:InitEnemies()
end

-- Maps each movement activity to the model's own activity for the first pose that has a sequence for it.
function ENT:BuildStanceActivities(poses)
	local activities = {}
	for activity, prefix in pairs(MOVEMENT_PREFIXES) do
		for _, pose in ipairs(poses) do
			local sequence = self:LookupSequence(prefix .. pose)
			local translated = sequence >= 0 and self:GetSequenceActivity(sequence) or -1
			if translated >= 0 then
				activities[activity] = translated
				break
			end
		end
	end

	return activities
end

function ENT:TranslateActivity(activity)
	local stances = self.stanceActivities
	-- The engine still translates activities for an NPC that is being removed, where model queries return nil.
	if not stances or self.dead or not IsValid(self) then return end

	local activities = (AIM_ACTIVITIES[activity] or IsValid(self:GetEnemy())) and stances.aim or stances.calm
	local crouched = self:GetCrouchedActivity(activity)
	if crouched and activities[crouched] then return activities[crouched] end
	if activities[activity] then return activities[activity] end
	if self:SelectWeightedSequence(activity) >= 0 then return end

	-- The model has no sequence for the activities weapons and schedules request (reload, rifle run, cover),
	-- and an unresolved activity leaves the NPC in its T-pose, so play the closest locomotion pose instead.
	return activities[FALLBACK_ACTIVITIES[activity] or ACT_IDLE] or activities[ACT_IDLE]
end

-- Sneaking NPCs creep toward their target crouched; crouching NPCs hold a crouched stance while shooting.
function ENT:GetCrouchedActivity(activity)
	if self.sneaking and MOVING_ACTIVITIES[activity] then return ACT_WALK_CROUCH end
	if self.crouching and (activity == ACT_IDLE or activity == ACT_IDLE_ANGRY) then return ACT_CROUCHIDLE end
end

function ENT:SetCrouching(crouching)
	if (self.crouching or false) == crouching then return end
	self.crouching = crouching
	-- Standing NPCs keep their current sequence until the activity is translated again.
	if not self:IsMoving() then self:ResetIdealActivity(ACT_IDLE_ANGRY) end
end

-- A player looking straight at an NPC (within about 20 degrees, with a clear view) has noticed it.
function ENT:IsLookedAtBy(client)
	local toSelf = (self:WorldSpaceCenter() - client:EyePos()):GetNormalized()

	return client:GetAimVector():Dot(toSelf) > LOOK_DOT and client:Visible(self)
end

-- Targets that have not shot us, are not fighting us and, for players, have not looked at us have not engaged us.
-- A player who looked stays noticed for a few seconds so a glance does not flip the NPC between poses.
function ENT:IsTargetUnaware(enemy)
	if self.Undead or self.provokedBy == enemy then return false end
	if not enemy:IsPlayer() then return not enemy.GetEnemy or enemy:GetEnemy() ~= self end

	local now = CurTime()
	if self:IsLookedAtBy(enemy) then self.noticedUntil = now + NOTICE_SECONDS end

	return now >= (self.noticedUntil or 0)
end

-- Engaged shooters switch from the passive pose to the aimed pose before their first shot. The pose only changes
-- when the activity is translated again, so a standing NPC is told to do so.
function ENT:IsWeaponRaised(now)
	if not self.raiseReadyAt then
		self.raiseReadyAt = now + RAISE_SECONDS
		if not self:IsMoving() then self:ResetIdealActivity(ACT_IDLE_ANGRY) end
	end

	return now >= self.raiseReadyAt
end

-- Points the arms along the same line the bullets take. aim_pitch is positive downward and aim_yaw positive
-- to the left, relative to the body, matching the model's aim layers.
function ENT:AimAt(source, aim)
	local angles = (aim - source):Angle()
	self.aimPitch = Lerp(AIM_SMOOTHING, self.aimPitch or 0, math.NormalizeAngle(angles.p))
	self.aimYaw = Lerp(AIM_SMOOTHING, self.aimYaw or 0, math.NormalizeAngle(angles.y - self:GetAngles().y))
	self:SetPoseParameter("aim_pitch", self.aimPitch)
	self:SetPoseParameter("aim_yaw", self.aimYaw)
end

-- Occasionally drops into a crouch while shooting from a distance, and stands again after a few seconds.
function ENT:UpdateCrouch(now, distance)
	if self.Undead then return end
	if self.crouching then
		if now >= self.crouchUntil then self:SetCrouching(false) end
		return
	end
	if now < (self.nextCrouchRoll or 0) then return end
	self.nextCrouchRoll = now + CROUCH_ROLL_INTERVAL
	if distance < CROUCH_MIN_DISTANCE ^ 2 or math.random() > CROUCH_CHANCE then return end
	self.crouchUntil = now + math.Rand(CROUCH_MIN_SECONDS, CROUCH_MAX_SECONDS)
	self:SetCrouching(true)
end

function ENT:InitEnemies()
	if ix and ix.eventController then ix.eventController:RegisterCombatActor(self) end
end

function ENT:FindEnemyDan()
	if self.cotzSleeping or GetConVar("ai_disabled"):GetBool() then return end
	if ix and ix.eventController then return ix.eventController:FindCombatEnemy(self, SEARCH_RANGE, SEARCH_ANGLE) end
	if GetConVar("ai_ignoreplayers"):GetBool() or CurTime() < (self.nextSearch or 0) then return end

	self.nextSearch = CurTime() + 2
	for _, client in player.Iterator() do
		if client:Alive() and self:GetPos():DistToSqr(client:GetPos()) < SEARCH_RANGE ^ 2 and self:Visible(client) then
			self:SetEnemy(client)
			self:UpdateEnemyMemory(client, client:GetPos())
			return client
		end
	end
end

function ENT:SelectSchedule()
	if self.cotzSleeping or self.cotzRegrouping or self.cotzPursuitScheduled then return end
	if GetConVar("ai_disabled"):GetBool() or IsValid(self:GetEnemy()) then return end
	self:SetSchedule(SCHED_PATROL_WALK)
end

function ENT:PlayCombatGesture(prefix)
	local sequence = self:LookupSequence(prefix .. self.stance.aim)
	if sequence < 0 then sequence = self:LookupSequence(prefix .. self.stance.calm) end
	if sequence < 0 then return end
	if self.combatLayer and self:IsValidLayer(self.combatLayer) then self:RemoveLayer(self.combatLayer) end
	self.combatLayer = self:AddGestureSequence(sequence, true)

	return self:SequenceDuration(sequence)
end

function ENT:STALKERNPCClearAnimation()
	if self.combatLayer and self:IsValidLayer(self.combatLayer) then self:RemoveLayer(self.combatLayer) end
	self.combatLayer, self.reloadAt, self.swingAt, self.swingTarget = nil, nil, nil, nil
	self.crouching, self.sneaking, self.raiseReadyAt, self.noticedUntil = nil, nil, nil, nil
	if self.aimPitch then
		self:SetPoseParameter("aim_pitch", 0)
		self:SetPoseParameter("aim_yaw", 0)
		self.aimPitch, self.aimYaw = nil, nil
	end
end

function ENT:EndCombatMovement()
	if not self.combatMovement then return end
	if self:IsCurrentSchedule(self.combatMovement) then
		self:ClearSchedule()
		self:EngineScheduleFinish()
		self:StopMoving()
	end
	self.combatMovement, self.firingMove, self.sneaking = nil, nil, nil
end

function ENT:StartCombatMovement(schedule, now, sneaking)
	sneaking = sneaking or false
	local running = (self.sneaking or false) == sneaking and self:IsCurrentSchedule(schedule)
	if running or now < (self.nextMovement or 0) then return end
	self.nextMovement = now + MOVEMENT_RETRY
	self.combatMovement, self.firingMove, self.sneaking = schedule, nil, sneaking
	self.crouching = nil
	self:SetSchedule(schedule)
end

function ENT:CanEngage(enemy, controller)
	if not IsValid(enemy) or enemy:Health() <= 0 then return false end
	if controller then return controller:CanActorAttack(self, enemy) end

	return not enemy:IsPlayer() or not GetConVar("ai_ignoreplayers"):GetBool()
end

function ENT:GetCombatLane(enemy, controller)
	local source = self:GetPos() + (self.crouching and CROUCH_MUZZLE_HEIGHT or MUZZLE_HEIGHT)
	local aim = controller and controller:GetHumanAimPosition(enemy) or enemy:WorldSpaceCenter()
	local weapon = self:GetActiveWeapon()
	local trace = util.TraceLine({start = source, endpos = aim, filter = {self, weapon, self.combatProp},
		mask = MASK_SHOT})

	return not trace.Hit or trace.Entity == enemy, source, aim
end

function ENT:FaceCombatTarget(enemy)
	local yaw = (enemy:GetPos() - self:GetPos()):Angle().y
	self:SetIdealYawAndUpdate(yaw)

	return math.abs(math.NormalizeAngle(yaw - self:GetAngles().y)) < 20
end

-- Engine hook for each navigation step. A shooter keeps its body on the target while the model's 3x3
-- move_x (forward positive) and move_y (right positive) blend plays the matching run, strafe or backpedal.
function ENT:OverrideMoveFacing(_, move)
	local target = self.moveFireTarget
	if not IsValid(target) or target ~= self:GetEnemy() then
		-- The centre of the blend is the forward run.
		self:SetPoseParameter("move_x", 0)
		self:SetPoseParameter("move_y", 0)
		return
	end

	self:SetIdealYawAndUpdate((target:GetPos() - self:GetPos()):Angle().y)
	local heading = math.rad(move.dir:Angle().y - self:GetAngles().y)
	local forward, left = math.cos(heading), math.sin(heading)
	-- Stay on the edge of the blend: values toward the centre would mix in the forward run.
	local scale = math.max(math.abs(forward), math.abs(left))
	self:SetPoseParameter("move_x", forward / scale)
	self:SetPoseParameter("move_y", -left / scale)

	return true
end

function ENT:IsHeadingToward(position)
	local origin = self:GetPos()
	local pathYaw = (self:GetCurWaypointPos() - origin):Angle().y

	return math.abs(math.NormalizeAngle((position - origin):Angle().y - pathYaw)) <= ZOMBIE_FORWARD_ARC
end

function ENT:IsFiringMoveActive()
	return self.firingMove == true and self:IsCurrentSchedule(self.combatMovement)
end

-- Returns the move relative to the target (forward toward it, lateral to its right), its length and schedule.
function ENT:GetFiringMove(distance)
	if self.Undead then
		return 1, 0, math.min(ZOMBIE_STEP, math.sqrt(distance) - ZOMBIE_STOP_DISTANCE), SCHED_FORCED_GO
	end

	local profile = self.combatProfile
	local side = math.random(2) == 1 and -1 or 1
	local length = math.Rand(FIRE_MOVE_MIN, FIRE_MOVE_MAX)
	if profile.retreat and distance < profile.retreat ^ 2 then
		return -1, side * math.Rand(0, FIRE_MOVE_DRIFT), length, SCHED_FORCED_GO_RUN
	end
	if distance > (profile.range * ADVANCE_HOLD) ^ 2 then
		return 1, side * math.Rand(0, FIRE_MOVE_DRIFT), length, SCHED_FORCED_GO_RUN
	end

	return math.Rand(-STRAFE_DRIFT, STRAFE_DRIFT), side, length, SCHED_FORCED_GO
end

-- Shortens the move before walls and rejects goals without ground under them; pathfinding does the rest.
function ENT:FindFiringMoveGoal(enemy, forward, lateral, length)
	local origin = self:GetPos()
	local offset = enemy:GetPos() - origin
	local toward = Vector(offset.x, offset.y, 0):GetNormalized()
	local right = Vector(toward.y, -toward.x, 0)
	local direction = (toward * forward + right * lateral):GetNormalized()
	local start = origin + MOVE_PROBE_HEIGHT
	local wall = util.TraceLine({start = start, endpos = start + direction * length, filter = self,
		mask = MASK_NPCSOLID_BRUSHONLY})
	local reach = wall.Fraction * length - MOVE_CLEARANCE
	if reach < FIRE_MOVE_MIN_REACH then return end

	local goal = origin + direction * reach
	local ground = util.TraceLine({start = goal + GROUND_PROBE_UP, endpos = goal - GROUND_PROBE_DOWN,
		filter = self, mask = MASK_NPCSOLID_BRUSHONLY})
	if not ground.Hit then return end

	return ground.HitPos
end

-- Forced-go schedules are not interrupted by combat conditions, unlike chase or cover, so the move survives the
-- target being in sight and in range.
function ENT:StartFiringMove(enemy, now, distance)
	if now < (self.nextMovement or 0) then return end
	self.nextMovement = now + MOVEMENT_RETRY
	local forward, lateral, length, schedule = self:GetFiringMove(distance)
	if length < FIRE_MOVE_MIN_REACH then return end
	local goal = self:FindFiringMoveGoal(enemy, forward, lateral, length)
	if not goal then return end

	self.combatMovement, self.firingMove, self.sneaking = schedule, true, nil
	self:SetLastPosition(goal)
	self:SetSchedule(schedule)
end

function ENT:UpdateFiringMovement(enemy, now, distance, sneaking)
	if sneaking then
		self:EndCombatMovement()
		self:UpdateCrouch(now, distance)
		return
	end
	if self:IsFiringMoveActive() then return end

	if self.combatMovement and self:IsCurrentSchedule(self.combatMovement) then
		-- A chase that reached firing range turns straight into a firing move.
		self.nextMovement = 0
	else
		self:UpdateCrouch(now, distance)
	end
	if not self.crouching then self:StartFiringMove(enemy, now, distance) end
	if not self:IsFiringMoveActive() then self:EndCombatMovement() end
end

function ENT:UpdateGunCombat(enemy, controller, now, distance)
	local weapon = self:GetActiveWeapon()
	if not IsValid(weapon) then return end

	local clear, source, aim = self:GetCombatLane(enemy, controller)
	self:AimAt(source, aim)
	local sneaking = distance < SNEAK_RANGE ^ 2 and self:IsTargetUnaware(enemy)
	if distance > self.combatProfile.range ^ 2 then
		self:StartCombatMovement(SCHED_CHASE_ENEMY, now, sneaking)
		return
	end
	if not clear then
		self:StartCombatMovement(SCHED_ESTABLISH_LINE_OF_FIRE, now, sneaking)
		return
	end

	self:UpdateFiringMovement(enemy, now, distance, sneaking)
	self:FireAtEnemy(enemy, weapon, now, source, aim)
end

function ENT:FireAtEnemy(enemy, weapon, now, source, aim)
	if self.Undead then
		-- Zombies cannot strafe or backpedal with a gun up: any movement while firing has to be forward.
		if self:IsMoving() and not self:IsHeadingToward(enemy:GetPos()) then return end
	else
		self.moveFireTarget = enemy
	end
	if not self:IsWeaponRaised(now) then return end
	if not self:FaceCombatTarget(enemy) or self.reloadAt or now < (self.nextShot or 0) then return end
	if self.clip <= 0 then
		local duration = self:PlayCombatGesture("reload_")
		self.reloadAt = now + math.max(duration or DEFAULT_RELOAD, 0.25)
		if weapon.ReloadSound then weapon:EmitSound(weapon.ReloadSound) end
		return
	end

	local primary = weapon.Primary
	local spread = primary.Cone / 90
	self:FireBullets({
		Num = primary.NumShots, Src = source, Dir = (aim - source):GetNormalized(), AmmoType = primary.Ammo,
		Spread = Vector(spread, spread, 0), Damage = primary.Damage, Force = primary.Force,
		Tracer = primary.Tracer, Inflictor = weapon,
	})
	self:MuzzleFlash()
	weapon:EmitSound(primary.Sound, 100, weapon.firepitch or 100)
	self.clip = self.clip - 1
	self:PlayCombatGesture("shoot_")
	self.burstShots = (self.burstShots or 0) + 1
	local delay = math.max(primary.Delay, MIN_SHOT_DELAY)
	if self.burstShots >= self.combatProfile.burst then
		self.burstShots = 0
		delay = math.max(delay, BURST_PAUSE)
	end
	self.nextShot = now + delay
end

function ENT:Think()
	-- Set again below only while this tick still has a shot to keep the body turned toward.
	self.moveFireTarget = nil
	if self.cotzSleeping or self.dead or GetConVar("ai_disabled"):GetBool() then
		self:STALKERNPCClearAnimation()
		return
	end
	local now = CurTime()
	self:NextThink(now + THINK_INTERVAL)
	local controller = ix and ix.eventController
	if controller then
		controller:ValidateCombatEnemy(self)
		if controller:UpdateCombatSchedule(self) then
			-- The controller owns the schedule now, so forget ours without clearing it.
			self.combatMovement, self.firingMove, self.sneaking = nil, nil, nil
			if self.swingAt then self:STALKERNPCClearAnimation() end
			return true
		end
	end

	if self.reloadAt and now >= self.reloadAt then
		local weapon = self:GetActiveWeapon()
		if IsValid(weapon) then self.clip = math.max(weapon:GetMaxClip1(), 1) end
		self.reloadAt = nil
	end
	local enemy = self:GetEnemy()
	if not self:CanEngage(enemy, controller) then
		self:EndCombatMovement()
		self:STALKERNPCClearAnimation()
		self:FindEnemyDan()
		return true
	end
	if not self.Alerted then
		self.Alerted = true
		self:PlayRandomSound(self.alertsounds)
	elseif now >= (self.nextCombatSpeech or 0) then
		self.nextCombatSpeech = now + 8
		if math.random(100) < 30 then self:PlayRandomSound(self.attacksounds) end
	end
	local distance = self:GetPos():DistToSqr(enemy:GetPos())
	if self.weapons then
		self:UpdateGunCombat(enemy, controller, now, distance)
	else
		self:UpdateMeleeCombat(enemy, controller, now, distance)
	end

	return true
end

function ENT:PlayRandomSound(sounds)
	if CurTime() < (self.nextSpeech or 0) then return end
	local sound = sounds[math.random(#sounds)]
	self:EmitSound(sound, 100, 100)
	self.nextSpeech = CurTime() + SoundDuration(sound) + 2.5
end

function ENT:OnTakeDamage(damage)
	local controller = ix and ix.eventController
	if self.dead or (controller and not controller:AllowCombatDamage(self, damage)) then return end
	if not controller or not controller:GetCombatDamageActor(damage) then self:STALKERNPCWake() end
	if damage:IsDamageType(DMG_BULLET) then
		damage:SubtractDamage(self.flatbulletresistance)
		damage:ScaleDamage(1 - self.percentbulletresistance / 100)
		damage:SetDamage(math.max(3, damage:GetDamage()))
	end
	self:SpawnBlood(damage)
	self:SetHealth(self:Health() - damage:GetDamage())
	local attacker = damage:GetAttacker()
	self.provokedBy = attacker
	if controller then
		controller:RetaliateCombatActor(self, attacker)
	elseif IsValid(attacker) and attacker:IsPlayer() then
		self:SetEnemy(attacker)
	end
	self.Alerted = true
	if self:Health() <= 0 then
		self.dead = true
		self:KilledDan(damage)
	elseif math.random(2) == 1 then
		self:StopSpeechSounds()
		self:PlayRandomSound(self.hurtsounds)
	end
end

function ENT:StopSpeechSounds()
	for _, sound in ipairs(self.alertsounds) do self:StopSound(sound) end
	for _, sound in ipairs(self.attacksounds) do self:StopSound(sound) end
end

function ENT:SpawnBlood(damage)
	local effect = ents.Create("info_particle_system")
	if not IsValid(effect) then return end
	effect:SetKeyValue("effect_name", "blood_impact_red_01")
	effect:SetPos(damage:GetDamagePosition())
	effect:Spawn()
	effect:Fire("Start", "", 0)
	effect:Fire("Kill", "", 0.1)
end

function ENT:KilledDan(damage)
	self:StopSpeechSounds()
	for _, sound in ipairs(self.hurtsounds) do self:StopSound(sound) end
	self:EmitSound(self.diesounds[math.random(#self.diesounds)], 100, 100)

	local ragdoll = ents.Create("prop_ragdoll")
	if IsValid(ragdoll) then
		ragdoll:SetModel(self:GetModel())
		ragdoll:SetPos(self:GetPos())
		ragdoll:SetAngles(self:GetAngles())
		ragdoll:Spawn()
		ragdoll:SetSkin(self:GetSkin())
		ragdoll:SetColor(self:GetColor())
		ragdoll:SetMaterial(self:GetMaterial())
		ragdoll:SetCollisionGroup(COLLISION_GROUP_WEAPON)
		-- The looting plugin identifies corpses by this, so any model in models.lua works.
		ragdoll.cotzHumanCorpse = true
		self.cotzRagdoll = ragdoll
		cleanup.ReplaceEntity(self, ragdoll)
		undo.ReplaceEntity(self, ragdoll)
		if self:IsOnFire() then ragdoll:Ignite(math.Rand(8, 10), 0) end
		for index = 0, ragdoll:GetPhysicsObjectCount() - 1 do
			local physics = ragdoll:GetPhysicsObjectNum(index)
			local bone = ragdoll:TranslatePhysBoneToBone(index)
			if IsValid(physics) and bone >= 0 then
				local position, angles = self:GetBonePosition(bone)
				if position then physics:SetPos(position) end
				if angles then physics:SetAngles(angles) end
			end
		end
		if ix and self.lootGroup and math.random(100) <= self.lootChance then
			ragdoll:SetNetVar("loot", self.lootGroup)
		end
		ragdoll:Fire("Kill", "", 180)
	end

	local item = self.selectedWeaponItem
	if ix and item then
		ix.item.Spawn(item[1], self:GetPos() + MUZZLE_HEIGHT + DROP_HEIGHT, function(instance, entity)
			instance:SetData("bTemporary", true)
			entity.bTemporary = true
		end, AngleRand(), table.Copy(item[2] or {}))
	end
	gamemode.Call("OnNPCKilled", self, damage:GetAttacker(), damage:GetInflictor())
	self:Remove()
end

-- Held weapons are separate props on the hand. The engine attaches NPC weapons to anim_attachment_RH, which
-- the original STALKER rig places on the head, and the rig flags no bones for bone-merge. The placement is in
-- the RHand frame: weaponprops.lua for guns, the loadout itself for melee weapons.
function ENT:AttachCombatProp(properties)
	if not util.IsValidModel(properties.model) then return end
	local attachment = self:LookupAttachment("RHand")
	if attachment <= 0 then
		ErrorNoHalt("cotz_human_base: model has no RHand attachment\n")
		return
	end
	local prop = ents.Create("prop_dynamic")
	if not IsValid(prop) then return end
	local position, angles = properties.hand.pos, properties.hand.ang
	prop:SetModel(properties.model)
	prop:SetPos(self:GetPos())
	prop:SetKeyValue("solid", "0")
	prop:Spawn()
	prop:SetParent(self, attachment)
	prop:SetLocalPos(Vector(position[1], position[2], position[3]))
	prop:SetLocalAngles(Angle(angles[1], angles[2], angles[3]))
	self:DeleteOnRemove(prop)

	return prop
end

function ENT:UpdateMeleeCombat(enemy, controller, now, distance)
	if self.swingAt then
		if self.swingTarget ~= enemy then
			self:STALKERNPCClearAnimation()
			return
		end
		if now < self.swingAt then return end
		self.swingAt, self.swingTarget = nil, nil
		if distance > MELEE_HIT_REACH ^ 2 or not self:FaceCombatTarget(enemy) then return end
		local clear, _, hitPosition = self:GetCombatLane(enemy, controller)
		if not clear then return end

		local damage = DamageInfo()
		damage:SetAttacker(self)
		damage:SetInflictor(self)
		damage:SetDamageType(DMG_CLUB)
		damage:SetDamage(self.meleeDamage)
		damage:SetDamagePosition(hitPosition)
		enemy:TakeDamageInfo(damage)
		return
	end

	if distance > MELEE_REACH ^ 2 or not self:GetCombatLane(enemy, controller) then
		self:StartCombatMovement(SCHED_CHASE_ENEMY, now, distance < SNEAK_RANGE ^ 2 and self:IsTargetUnaware(enemy))
		return
	end
	self:EndCombatMovement()
	if now < (self.nextSwing or 0) or not self:FaceCombatTarget(enemy) then return end
	self:PlayCombatGesture("shoot_")
	self.swingTarget, self.swingAt = enemy, now + MELEE_WINDUP
	self.nextSwing = now + MELEE_RECOVERY
end
