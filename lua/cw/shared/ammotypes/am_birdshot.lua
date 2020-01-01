local att = {}
att.name = "am_birdshot"
att.displayName = "Birdshot"
att.displayNameShort = "Birdshot"

att.statModifiers = {DamageMult = -0.70, ClumpSpreadMult = 1.5}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/flechetterounds")
	att.description = {{t = "Increases amount of rounds per shot to 35.", c = CustomizableWeaponry.textColors.POSITIVE}}
end

function att:attachFunc()
	self.Shots = 35
	self:unloadWeapon()
	self.Primary.Ammo = "12 Gauge -BD-"
end

function att:detachFunc()
	self:unloadWeapon()
	self.Shots = self.Shots_Orig
	self.Primary.Ammo = "12 Gauge"
end

CustomizableWeaponry:registerAttachment(att)