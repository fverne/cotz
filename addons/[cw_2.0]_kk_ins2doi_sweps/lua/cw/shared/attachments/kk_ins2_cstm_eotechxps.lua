local att = {}
att.name = "kk_ins2_cstm_eotechxps"
att.displayNameShort = "EoTech"
att.displayName = "EoTech XPS"
att.aimPos = {"KKINS2CSTMEoTechXPSPos", "KKINS2CSTMEoTechXPSAng"}
att.FOVModifier = 0
att.AimViewModelFOV = 40
att.isSight = true

-- att.colorType = CustomizableWeaponry.colorableParts.COLOR_TYPE_SIGHT

att.statModifiers = {
	// OverallMouseSensMult = -0.02
}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/" .. att.name)
	att.description = {
		[1] = {t = "Provides a bright reticle to ease aiming.", c = CustomizableWeaponry.textColors.POSITIVE}
	}

	att.reticle = "models/weapons/optics/eotech_reticule_holo"
	att._reticleSize = 14

	function att:elementRender()
		CustomizableWeaponry_KK.ins2.stencilSight:elementRender(self, att)
	end

end

CustomizableWeaponry:registerAttachment(att)
