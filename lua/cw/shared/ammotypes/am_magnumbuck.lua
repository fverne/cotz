local att = {}
att.name = "am_magnumbuck"
att.displayName = "Magnum Buck rounds"
att.displayNameShort = "Magnum"

att.statModifiers = {DamageMult = 0.3, RecoilMult = 0.5,}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/slugrounds")
	att.description = {{t = "Increases damage.", c = CustomizableWeaponry.textColors.POSITIVE},
	{t = "Increases recoil.", c = CustomizableWeaponry.textColors.NEGATIVE}}
end

function att:attachFunc()
	self:unloadWeapon()
	self.Primary.Ammo = "12 Gauge -MG-"
end

function att:detachFunc()
	self:unloadWeapon()
	self.Primary.Ammo = "12 Gauge"
end

CustomizableWeaponry:registerAttachment(att)