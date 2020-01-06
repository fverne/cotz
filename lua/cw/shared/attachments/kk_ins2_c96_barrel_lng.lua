local att = {}
att.name = "kk_ins2_c96_barrel_lng"
att.displayName = "Long Barrel"
att.displayNameShort = "Long"
att.WeaponLength = 12
att.isSight = true
att.aimPos = {"LongBarrelPos", "LongBarrelAng"}
att.FOVModifier = 0

att.statModifiers = {
	VelocitySensitivityMult = -0.3,
	// OverallMouseSensMult = -0.15,
	RecoilMult = -0.2,
}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/" .. att.name)
	att.description = {}
end

function att:attachFunc()
	self.MuzzleAttachmentName_Orig = self.MuzzleAttachmentName_Orig or self.MuzzleAttachmentName
	self.MuzzleAttachmentName = "muzzle_carbine"
end

function att:detachFunc()
	self.MuzzleAttachmentName = self.MuzzleAttachmentName_Orig
end

CustomizableWeaponry:registerAttachment(att)
