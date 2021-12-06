CustomizableWeaponry:registerRecognizedStat("HPDamageMult", "Decreases damage done to weapon", "Increases damage done to weapon", CustomizableWeaponry.textColors.NEGATIVE, CustomizableWeaponry.textColors.POSITIVE)

local att = {}
att.name = "am_armorpiercing"
att.displayName = "Armor Piercing rounds"
att.displayNameShort = "Armor Piercing"

att.statModifiers = {HPDamageMult = 0.05}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/magnumrounds")
	att.description = {}
end

function att:attachFunc()
	self:unloadWeapon()
	local str = self.Primary.Ammo.." -AP-"
	self.Primary.Ammo = str
end

function att:detachFunc()
	self:unloadWeapon()
	local str = string.sub(self.Primary.Ammo, 1, -6)
	self.Primary.Ammo = str
end

CustomizableWeaponry:registerAttachment(att)