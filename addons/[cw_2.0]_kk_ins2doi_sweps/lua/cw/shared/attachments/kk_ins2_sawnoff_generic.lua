local att = {}
att.name = "kk_ins2_sawnoff_generic"
att.displayNameShort = "Hacksaw"
att.displayName = "CQC Variant"
att.isBG = true
att.KK_INS2_playIdle = true
att.WeaponLength = -16

att.statModifiers = {
	AimSpreadMult = 0.1,
	DrawSpeedMult = 0.05,
	VelocitySensitivityMult = 0.2,
	// OverallMouseSensMult = 0.1,
	DamageMult = 0.1,
	RecoilMult = 0.2,
}

if CLIENT then
	-- att.displayIcon = surface.GetTextureID("atts/" .. att.name)
	att.displayIcon = surface.GetTextureID("atts/kk_dogg")
	att.description = {}
end

CustomizableWeaponry:registerAttachment(att)
