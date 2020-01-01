CustomizableWeaponry:registerRecognizedStat("HPDamageMult", "Decreases damage done to weapon", "Increases damage done to weapon", CustomizableWeaponry.textColors.NEGATIVE, CustomizableWeaponry.textColors.POSITIVE)

local att = {}
att.name = "am_zoneloaded"
att.displayName = "Zone-loaded rounds"
att.displayNameShort = "Zone-loaded"

att.statModifiers = {HPDamageMult = 0.15,
	AimSpreadMult = 0.2}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/magnumrounds")
	att.description = {}
end

function att:attachFunc()
	self:unloadWeapon()
	local str = self.Primary.Ammo.." -ZL-"
	self.Primary.Ammo = str
end

function att:detachFunc()
	self:unloadWeapon()
	local str = string.sub(self.Primary.Ammo, 1, -6)
	self.Primary.Ammo = str
end

CustomizableWeaponry:registerAttachment(att)