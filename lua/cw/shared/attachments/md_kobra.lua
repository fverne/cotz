local att = {}
att.name = "md_kobra"
att.displayName = "Kobra"
att.displayNameShort = "Kobra"
att.aimPos = {"KobraPos", "KobraAng"}
att.FOVModifier = 15
att.isSight = true
att.withoutRail = true
att.colorType = CustomizableWeaponry.colorableParts.COLOR_TYPE_SIGHT
att.statModifiers = {OverallMouseSensMult = -0.05}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/kobra")
	att.description = {[1] = {t = "Provides a bright reticle to ease aiming.", c = CustomizableWeaponry.textColors.POSITIVE}}
	
	att.reticle = "cw2/reticles/kobra_sight"
	att._reticleSize = 2.5

	function att:drawReticle()
		self:DrawCotzReticleSprite(att, self.KobraPos, self.KobraAng, "kobra")
	end
end

CustomizableWeaponry:registerAttachment(att)