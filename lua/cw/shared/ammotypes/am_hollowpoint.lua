local att = {}
att.name = "am_hollowpoint"
att.displayName = "Overpressure rounds"
att.displayNameShort = "Overpressure"

att.statModifiers = {DamageMult = 0.3}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/matchgradeammo")
	att.description = {}
end

function att:attachFunc()
	self:unloadWeapon()
	local str = self.Primary.Ammo.." -HP-"
	self.Primary.Ammo = str
end

function att:detachFunc()
	self:unloadWeapon()
	local str = string.sub(self.Primary.Ammo, 1, -6)
	self.Primary.Ammo = str
end


CustomizableWeaponry:registerAttachment(att)