local att = {}
att.name = "md_aimpoint"
att.displayName = "Aimpoint"
att.displayNameShort = "Aimpoint"
att.aimPos = {"AimpointPos", "AimpointAng"}
att.FOVModifier = 20
att.isSight = true
att.colorType = CustomizableWeaponry.colorableParts.COLOR_TYPE_SIGHT
att.statModifiers = {OverallMouseSensMult = -0.07}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/compm4")
	att.description = {[1] = {t = "Provides a bright reticle to ease aiming.", c = CustomizableWeaponry.textColors.POSITIVE},
	[2] = {t = "Slightly increases aim zoom.", c = CustomizableWeaponry.textColors.POSITIVE},
	[3] = {t = "Narrow scope may decrease awareness.", c = CustomizableWeaponry.textColors.NEGATIVE}}
	
	att.reticle = "cw2/reticles/aim_reticule"
	att._reticleSize = 0.4
	
	function att:drawReticle()
		self:DrawCotzReticleSprite(att, self.AimpointPos, self.AimpointAng, "dot")
	end
end

CustomizableWeaponry:registerAttachment(att)