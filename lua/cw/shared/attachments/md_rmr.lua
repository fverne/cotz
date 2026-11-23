local att = {}
att.name = "md_rmr"
att.displayName = "Trijicon RMR"
att.displayNameShort = "RMR"
att.aimPos = {"RMRPos", "RMRAng"}
att.FOVModifier = 15
att.isSight = true
att.colorType = CustomizableWeaponry.colorableParts.COLOR_TYPE_SIGHT

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/rmr")
	att.description = {[1] = {t = "Provides a bright reticle to ease aiming.", c = CustomizableWeaponry.textColors.POSITIVE},
	[2] = {t = "Slightly increases aim zoom.", c = CustomizableWeaponry.textColors.POSITIVE},
	[3] = {t = "Narrow scope may decrease awareness.", c = CustomizableWeaponry.textColors.NEGATIVE}}
	
	att.reticle = "cw2/reticles/aim_reticule"
	att._reticleSize = 0.4
	
	function att:drawReticle()
		self:DrawCotzReticleSprite(att, self.RMRPos, self.RMRAng, "dot")
	end
end

CustomizableWeaponry:registerAttachment(att)