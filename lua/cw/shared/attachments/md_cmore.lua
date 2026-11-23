local att = {}
att.name = "md_cmore"
att.displayName = "C-More Railway Sight"
att.displayNameShort = "C-More"
att.aimPos = {"CmorePos", "CmoreAng"}
att.FOVModifier = 15
att.isSight = true
att.colorType = CustomizableWeaponry.colorableParts.COLOR_TYPE_SIGHT
att.statModifiers = {OverallMouseSensMult = -0.04}

if CLIENT then
	att.displayIcon = surface.GetTextureID("cw20_extras/icons/upgr_cmore")
	att.description = {[1] = {t = "Provides a bright reticle to ease aiming.", c = CustomizableWeaponry.textColors.POSITIVE}}
	
	att.reticle = "cw2/reticles/delta_chevron"
	att._reticleSize = 2.4
	att.keepReticleAfterShot = true

	function att:drawReticle()
		self:DrawCotzReticleSprite(att, self.CmorePos, self.CmoreAng, "delta")
	end
end

CustomizableWeaponry:registerAttachment(att)