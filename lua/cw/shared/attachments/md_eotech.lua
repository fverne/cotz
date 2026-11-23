local att = {}
att.name = "md_eotech"
att.displayName = "EoTech 552"
att.displayNameShort = "EoTech"
att.aimPos = {"EoTechPos", "EoTechAng"}
att.FOVModifier = 15
att.isSight = true
att.colorType = CustomizableWeaponry.colorableParts.COLOR_TYPE_SIGHT
att.statModifiers = {OverallMouseSensMult = -0.05}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/eotech553")
	att.description = {[1] = {t = "Provides a bright reticle to ease aiming.", c = CustomizableWeaponry.textColors.POSITIVE}}
	
	att.reticle = "cw2/reticles/eotech_reddot"
	att._reticleSize = 3

	function att:drawReticle()
		self:DrawCotzReticleSprite(att, self.EoTechPos, self.EoTechAng, "eotech")
	end
end

CustomizableWeaponry:registerAttachment(att)