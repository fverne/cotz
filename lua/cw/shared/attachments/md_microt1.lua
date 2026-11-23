local att = {}
att.name = "md_microt1"
att.displayName = "Micro T1"
att.displayNameShort = "M-T1"
att.aimPos = {"MicroT1Pos", "MicroT1Ang"}
att.FOVModifier = 15
att.isSight = true
att.colorType = CustomizableWeaponry.colorableParts.COLOR_TYPE_SIGHT

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/microt1")
	att.description = {[1] = {t = "Provides a bright reticle to ease aiming.", c = CustomizableWeaponry.textColors.POSITIVE},
	[3] = {t = "Narrow scope may decrease awareness.", c = CustomizableWeaponry.textColors.NEGATIVE}}
	
	att.reticle = "cw2/reticles/aim_reticule"
	att._reticleSize = 0.2
	
	function att:drawReticle()
		self:DrawCotzReticleSprite(att, self.MicroT1Pos, self.MicroT1Ang, "dot")
	end

	function att:attachFunc()
		self.AimViewModelFOV = 35
	end

	function att:detachFunc()
		self.AimViewModelFOV = self.AimViewModelFOV_Orig
	end
end

CustomizableWeaponry:registerAttachment(att)