local att = {}
att.name = "am_dartrounds"
att.displayName = "Dart rounds"
att.displayNameShort = "Dart"

att.statModifiers = {DamageMult = 4, ClumpSpreadMult = -0.4}
	-- AimSpreadMult = 2}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/slugrounds")
	att.description = {{t = "Greatly increases accuracy.", c = CustomizableWeaponry.textColors.POSITIVE},
	{t = "Fires out only 1 pellet.", c = CustomizableWeaponry.textColors.NEGATIVE}}
end

function att:attachFunc()
	self.Shots = 1
	self.Shots_Base = 1
	self:unloadWeapon()
	self.Primary.Ammo = "12 Gauge -DT-"
end

function att:detachFunc()
	self:unloadWeapon()
	self.Shots = self.Shots_Orig
	self.Shots_Base = self.Shots_Orig
	self.Primary.Ammo = "12 Gauge"
end

CustomizableWeaponry:registerAttachment(att)