local att = {}
att.name = "kk_ins2_vertgrip"
att.displayName = "Foregrip"
att.displayNameShort = "Grip"
att.KK_INS2_playIdle = true

att.statModifiers = {
	VelocitySensitivityMult = -0.3,
	// OverallMouseSensMult = -0.15,
	RecoilMult = -0.2
}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/" .. att.name)
	att.description = {}
end

-- function att:attachFunc()
-- end

-- function att:detachFunc()
-- end

CustomizableWeaponry:registerAttachment(att)
