local att = {}
att.name = "kk_ins2_cstm_sureshot"
att.displayName = "SureShot Reflex Sight"
att.displayNameShort = "Sureshot"
att.aimPos = {"KKINS2CSTMSureShotPos", "KKINS2CSTMSureShotAng"}
att.FOVModifier = 0
att.AimViewModelFOV = 40
att.isSight = true

-- att.colorType = CustomizableWeaponry.colorableParts.COLOR_TYPE_SIGHT

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/" .. att.name)
	att.description = {
		[1] = {t = "Provides a bright reticle to ease aiming.", c = CustomizableWeaponry.textColors.POSITIVE},
	}

	att.reticle = "models/weapons/optics/aimpoint_reticule_holo"
	att._reticleSize = 8

	function att:elementRender()
		CustomizableWeaponry_KK.ins2.stencilSight:elementRender(self, att)
	end

end

CustomizableWeaponry:registerAttachment(att)
