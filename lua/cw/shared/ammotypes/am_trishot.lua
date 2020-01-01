local att = {}
att.name = "am_trishot"
att.displayName = "Triball"
att.displayNameShort = "Triball"

att.statModifiers = {DamageMult = 4, ClumpSpreadMult = 0.5}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/flechetterounds")
	att.description = {{t = "Decreases amount of rounds per shot to 3.", c = CustomizableWeaponry.textColors.POSITIVE}}
end

function att:attachFunc()
	self.Shots = 3
	self:unloadWeapon()
	self.Primary.Ammo = "12 Gauge -TR-"
end

function att:detachFunc()
	self:unloadWeapon()
	self.Shots = self.Shots_Orig
	self.Primary.Ammo = "12 Gauge"
end

CustomizableWeaponry:registerAttachment(att)