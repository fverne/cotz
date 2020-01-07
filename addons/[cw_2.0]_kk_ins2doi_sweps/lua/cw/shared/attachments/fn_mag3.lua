local att = {}
att.name = "fn_mag3"
att.displayName = "Mag Plus Three"
att.displayNameShort = "MPThree"

att.statModifiers = {
    // DamageMult = 0.15
}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/magnumrounds")
	att.description = {}
end

function att:attachFunc()
	self.Primary.ClipSize = (self.Primary.ClipSize + 3)
	self.Primary.ClipSize_Orig = (self.Primary.ClipSize_Orig + 3)
end

function att:detachFunc()
    self:unloadWeapon()
	self.Primary.ClipSize = self.Primary.ClipSize_ORIG_REAL
	self.Primary.ClipSize_Orig = self.Primary.ClipSize_ORIG_REAL
end

CustomizableWeaponry:registerAttachment(att)