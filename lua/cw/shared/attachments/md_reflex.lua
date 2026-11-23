local att = {}
att.name = "md_reflex"
att.displayName = "Rifle Reflex Sight"
att.displayNameShort = "Reflex"
att.aimPos = {"ReflexPos", "ReflexAng"}
att.FOVModifier = 15
att.isSight = true
att.colorType = CustomizableWeaponry.colorableParts.COLOR_TYPE_SIGHT
att.statModifiers = {OverallMouseSensMult = -0.07}

if CLIENT then
	att.displayIcon = surface.GetTextureID("cw20_extras/icons/upgr_riflereflex")
	att.description = {[1] = {t = "Provides a bright reticle to ease aiming.", c = CustomizableWeaponry.textColors.POSITIVE}}
	
	att.reticle = "cw2/reticles/kobra_sight"
	att._reticleSize = 3.4
	att.keepReticleAfterShot = true
	
	function att:drawReticle()
		self:DrawCotzReticleSprite(att, self.ReflexPos, self.ReflexAng, "kobra")
	end
end

CustomizableWeaponry:registerAttachment(att)