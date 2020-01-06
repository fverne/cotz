local att = {}
att.name = "kk_ins2_hoovy"
att.displayName = "Heavy Barrel"
att.displayNameShort = "Heavy"

att.statModifiers = {
	VelocitySensitivityMult = -0.3,
	// OverallMouseSensMult = -0.15,
	RecoilMult = -0.2,
}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/" .. att.name)
	att.description = {}
end

CustomizableWeaponry:registerAttachment(att)
