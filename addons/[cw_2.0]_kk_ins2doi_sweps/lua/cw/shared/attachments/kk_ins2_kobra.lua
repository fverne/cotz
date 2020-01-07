local att = {}
att.name = "kk_ins2_kobra"
att.displayName = "Kobra"
att.displayNameShort = "Kobra"
att.aimPos = {"KKINS2KobraPos", "KKINS2KobraAng"}
att.FOVModifier = 0
att.AimViewModelFOV = 40
att.isSight = true

att.colorType = CustomizableWeaponry.colorableParts.COLOR_TYPE_SIGHT

att.statModifiers = {
	// OverallMouseSensMult = -0.05
}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/" .. att.name)
	att.description = {
		[1] = {t = "Provides a bright reticle to ease aiming.", c = CustomizableWeaponry.textColors.POSITIVE}
	}

	att.reticleCol = "cwkk/reticles/kobra_dot_col"
	att.reticleTop = "cwkk/reticles/kobra_dot_top"
	att._reticleCol = Material(att.reticleCol)
	att._reticleTop = Material(att.reticleTop)

	att.reticle = att.reticleCol
	att._reticleSize = 16

	-- att.reticle = "models/weapons/optics/kobra_dot"
	-- att._reticleSize = 16

	function att:elementRender()
		-- CustomizableWeaponry_KK.ins2.stencilSight:elementRender(self, att)
		CustomizableWeaponry_KK.ins2.stencilSight:elementRenderColorable(self, att)
	end
end

CustomizableWeaponry:registerAttachment(att)
