local att = {}
att.name = "am_410buck"
att.displayName = ".45 ACP"
att.displayNameShort = ".45 ACP"
att.isBG = true

att.statModifiers = {DamageMult = -0.50,
	AimSpreadMult = .25,
	RecoilMult = -.25,}

function att:attachFunc()
	self:unloadWeapon()
	self.Shots = 5
	self.ClumpSpread_Orig = 0.03
	self.ClumpSpread = 0.03
	local str = self.Primary.Ammo.." -41-"
	self.Primary.Ammo = str
end

function att:detachFunc()
	self:unloadWeapon()
	self.Shots = self.Shots_Orig
	self.ClumpSpread_Orig = nil
	self.ClumpSpread = nil
	local str = string.sub(self.Primary.Ammo, 1, -6)
	self.Primary.Ammo = str
end

CustomizableWeaponry:registerAttachment(att)