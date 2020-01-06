local att = {}
att.name = "kk_ins2_cstm_cmore"
att.displayNameShort = "C-More"
att.displayName = "C-More Reflex Sight"
att.aimPos = {"KKINS2CSTMCMorePos", "KKINS2CSTMCMoreAng"}
att.FOVModifier = 0
att.AimViewModelFOV = 40
att.isSight = true

-- att.colorType = CustomizableWeaponry.colorableParts.COLOR_TYPE_SIGHT

att.statModifiers = {
	// OverallMouseSensMult = -0.05
}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/" .. att.name)
	att.description = {
		[1] = {t = "Provides a bright reticle to ease aiming.", c = CustomizableWeaponry.textColors.POSITIVE}
	}

	att.reticle = "models/weapons/optics/aimpoint_reticule_holo"
	att._reticleSize = 5

	function att:elementRender()
		CustomizableWeaponry_KK.ins2.stencilSight:elementRender(self, att)
	end

end

CustomizableWeaponry:registerAttachment(att)
