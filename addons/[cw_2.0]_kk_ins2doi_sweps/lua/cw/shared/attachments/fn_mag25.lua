local att = {}
att.name = "fn_mag25"
att.displayName = "Mag Plus Twenty Five"
att.displayNameShort = "MP25"

att.statModifiers = {
    // DamageMult = 0.15
}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/magnumrounds")
	att.description = {}
end

function att:attachFunc()
	self.Primary.ClipSize = (self.Primary.ClipSize + 25)
	self.Primary.ClipSize_Orig = (self.Primary.ClipSize_Orig + 25)
end

function att:detachFunc()
    self:unloadWeapon()
	self.Primary.ClipSize = self.Primary.ClipSize_ORIG_REAL
	self.Primary.ClipSize_Orig = self.Primary.ClipSize_ORIG_REAL
end

CustomizableWeaponry:registerAttachment(att)