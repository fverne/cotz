local att = {}
att.name = "kk_ins2_cstm_barska"
att.displayName = "Barska Reflex Sight"
att.displayNameShort = "Barska"
att.aimPos = {"KKINS2CSTMBarskaPos", "KKINS2CSTMBarskaAng"}
att.FOVModifier = 0
att.AimViewModelFOV = 40
att.isSight = true

-- att.colorType = CustomizableWeaponry.colorableParts.COLOR_TYPE_SIGHT

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/" .. att.name)
	att.description = {
		[1] = {t = "Provides a bright reticle to ease aiming.", c = CustomizableWeaponry.textColors.POSITIVE},
		[2] = {t = "Narrow scope may decrease awareness.", c = CustomizableWeaponry.textColors.NEGATIVE}
	}

	att.reticle = "models/weapons/attachments/cw_kk_ins2_cstm_barska/barska_reticule"
	att._reticleSize = 16

	function att:elementRender()
		CustomizableWeaponry_KK.ins2.stencilSight:elementRender(self, att)
	end

end

CustomizableWeaponry:registerAttachment(att)
