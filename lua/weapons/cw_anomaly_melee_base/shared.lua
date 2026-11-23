AddCSLuaFile()

SWEP.Base = "cw_anomaly_gun_base"
SWEP.PrintName = "Anomaly CW2 melee base"
SWEP.Spawnable = false
SWEP.AimingEnabled = false
SWEP.CanCustomize = false
SWEP.CanRestOnObjects = false
SWEP.SprintingEnabled = true

local HULL_MIN = Vector(-10, -10, -10)
local HULL_MAX = Vector(10, 10, 10)

function SWEP:Reload()
end

function SWEP:StartAnomalySwing(secondary)
	if CurTime() < self:GetNextPrimaryFire() or self.AnomalySwing then return end
	if not self:canFireWeapon(1) or not self:canFireWeapon(3) then return end
	local attack = secondary and self.AnomalyMeleeSecondary or self.AnomalyMeleePrimary
	self:SetNextPrimaryFire(CurTime() + 60 / attack.RPM)
	self:SetNextSecondaryFire(self:GetNextPrimaryFire())

	if IsFirstTimePredicted() then
		self:sendWeaponAnim(secondary and "stab" or "fire")
		self:EmitSound(self.AnomalyMissSound)
	end

	if SERVER then
		local owner = self:GetOwner()
		self.AnomalySwing = {
			at = CurTime() + attack.Delay,
			owner = owner,
			character = owner.GetCharacter and owner:GetCharacter(),
			attack = attack,
		}
	end
end

function SWEP:PrimaryAttack()
	self:StartAnomalySwing(false)
end

function SWEP:SecondaryAttack()
	self:StartAnomalySwing(true)
end

function SWEP:IndividualThink()
	local swing = self.AnomalySwing
	if not SERVER or not swing or CurTime() < swing.at then return end
	self.AnomalySwing = nil
	local owner = self:GetOwner()
	if not IsValid(owner) or owner ~= swing.owner or owner:GetActiveWeapon() ~= self then return end
	if owner.GetCharacter and owner:GetCharacter() ~= swing.character then return end
	owner:LagCompensation(true)
	local trace = util.TraceHull({
		start = owner:GetShootPos(),
		endpos = owner:GetShootPos() + owner:GetAimVector() * swing.attack.Length,
		filter = owner,
		mins = HULL_MIN,
		maxs = HULL_MAX,
		mask = MASK_SHOT_HULL,
	})
	owner:LagCompensation(false)
	if not trace.Hit then return end
	local flesh = trace.MatType == MAT_FLESH or trace.MatType == MAT_BLOODYFLESH
	self:EmitSound(flesh and self.AnomalyHitSound or self.AnomalyWorldHitSound)
	if not IsValid(trace.Entity) then return end
	local damage = DamageInfo()
	damage:SetAttacker(owner)
	damage:SetInflictor(self)
	damage:SetDamage(swing.attack.Damage)
	damage:SetDamageType(DMG_SLASH)
	damage:SetDamagePosition(trace.HitPos)
	damage:SetDamageForce(owner:GetAimVector() * swing.attack.Damage)
	trace.Entity:TakeDamageInfo(damage)
end
