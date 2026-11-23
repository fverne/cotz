AddCSLuaFile()

SWEP.Base = "cw_anomaly_gun_base"
SWEP.PrintName = "Anomaly CW2 throwable base"
SWEP.Spawnable = false
SWEP.AimingEnabled = false
SWEP.CanCustomize = false
SWEP.CanRestOnObjects = false

function SWEP:Reload()
end

function SWEP:BeginAnomalyThrow(underhand)
	if self.AnomalyThrow or CurTime() < self:GetNextPrimaryFire() then return end
	if not self:canFireWeapon(1) or not self:canFireWeapon(3) then return end
	if self:Clip1() < 1 then return end
	if underhand and not self.AnomalyUnderhand then return end
	self:sendWeaponAnim(underhand and "pullpin_low" or "pullpin")
	local owner = self:GetOwner()
	local animation = underhand and "anm_throw_begin_low" or "anm_throw_begin"
	local ready = CurTime() + self.AnomalySequences[animation]
	local cooking = not underhand and self.AnomalyCanCook and owner:KeyDown(IN_USE)
	self.AnomalyThrow = {
		ready = ready,
		underhand = underhand,
		owner = owner,
		character = owner.GetCharacter and owner:GetCharacter(),
		deadline = cooking and CurTime() + self.AnomalyCookStart + self.AnomalyCookTime or nil,
	}
end

function SWEP:PrimaryAttack()
	self:BeginAnomalyThrow(false)
end

function SWEP:SecondaryAttack()
	self:BeginAnomalyThrow(true)
end

function SWEP:ReleaseAnomalyThrowable(thrown)
	if not SERVER then return end
	local owner = self:GetOwner()
	local projectile = self:SpawnAnomalyProjectile(self.AnomalyThrownEntity,
		thrown.underhand and self.AnomalyUnderhandVelocity or self.AnomalyThrowVelocity)
	if not IsValid(projectile) then return end

	projectile.KaboomTime = thrown.deadline or CurTime() + self.AnomalyCookTime

	self:TakePrimaryAmmo(1)

	if self:Clip1() == 0 and owner:GetAmmoCount(self.Primary.Ammo) > 0 then
		owner:RemoveAmmo(1, self.Primary.Ammo)
		self:SetClip1(1)
	end
end

function SWEP:IndividualThink()
	local thrown = self.AnomalyThrow
	if not thrown then return end
	local owner = self:GetOwner()

	if not IsValid(owner) or owner ~= thrown.owner or owner:GetActiveWeapon() ~= self
		or (owner.GetCharacter and owner:GetCharacter() ~= thrown.character) then
		self.AnomalyThrow = nil
		return
	end

	local now = CurTime()
	if now < thrown.ready then return end
	local expired = thrown.deadline and now >= thrown.deadline

	if not thrown.releaseAt and (expired or not owner:KeyDown(thrown.underhand and IN_ATTACK2 or IN_ATTACK)) then
		self:sendWeaponAnim(thrown.underhand and "throw_low" or "throw")
		local delay = thrown.deadline and self.AnomalyCookedDelay
			or (thrown.underhand and self.AnomalyUnderhandDelay or self.AnomalyThrowDelay)
		thrown.releaseAt = expired and now or now + delay
	end

	if thrown.releaseAt and now >= thrown.releaseAt then
		self.AnomalyThrow = nil
		self:ReleaseAnomalyThrowable(thrown)
		self:SetNextPrimaryFire(now + self.DeployTime)
		self:SetNextSecondaryFire(now + self.DeployTime)
		self:sendWeaponAnim("draw")

		if SERVER and self:Clip1() == 0 then
			owner:StripWeapon(self:GetClass())
		end
	end
end

-- Keep a live cooked grenade attached to its owner until it is released or its fuse expires.
function SWEP:Holster(weapon)
	if self.AnomalyThrow then return false end

	return baseclass.Get("cw_base").Holster(self, weapon)
end
