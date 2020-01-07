local att = {}
att.name = "fn_mag2"
att.displayName = "Mag Plus Two"
att.displayNameShort = "MPTwo"

att.statModifiers = {
    // DamageMult = 0.15
}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/magnumrounds")
	att.description = {}
end

function att:attachFunc()
	self.Primary.ClipSize = (self.Primary.ClipSize + 2)
	self.Primary.ClipSize_Orig = (self.Primary.ClipSize_Orig + 2)
end

function att:detachFunc()
    self:unloadWeapon()
	self.Primary.ClipSize = self.Primary.ClipSize_ORIG_REAL
	self.Primary.ClipSize_Orig = self.Primary.ClipSize_ORIG_REAL
end

CustomizableWeaponry:registerAttachment(att)