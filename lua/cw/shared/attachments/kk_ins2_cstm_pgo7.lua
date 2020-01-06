local att = {}
att.name = "kk_ins2_cstm_pgo7"
att.displayName = "PGO-7V Scope"
att.displayNameShort = "PGO-7V"
att.aimPos = {"KKINS2CSTMPGO7Pos", "KKINS2CSTMPGO7Ang"}
att.FOVModifier = 0
att.AimViewModelFOV = 30
att.isSight = true

att.statModifiers = {
	// OverallMouseSensMult = -0.1,
	DrawSpeedMult = -0.2
}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/" .. att.name)
	att.description = {
		[1] = {t = "Provides 2x magnification.", c = CustomizableWeaponry.textColors.POSITIVE},
		[2] = {t = "Narrow scope reduces awareness.", c = CustomizableWeaponry.textColors.NEGATIVE},
		[3] = {t = "Staring at your gun reduces awareness too.", c = CustomizableWeaponry.textColors.NEGATIVE},
	}

	local path = "cwkk/reticles/pgo7"

	att.zoomTextures = {
		{tex = surface.GetTextureID(path), offset = {0, 1}},
	}

	att._rtFov = 15
	att._rtReticle = surface.GetTextureID(path)
	att._reticleMat = Material(path)

	function att:drawRenderTarget()
		CustomizableWeaponry_KK.ins2.rtSight:renderTarget(self, att)
	end

	function att:elementRender()
		CustomizableWeaponry_KK.ins2.rtSight:stencil(self, att)
	end
end

function att:attachFunc()
	self.OverrideAimMouseSens = 0.25
	self.SimpleTelescopicsFOV = 70
	self.BlurOnAim = true
	self.ZoomTextures = att.zoomTextures
end

function att:detachFunc()
	self.OverrideAimMouseSens = nil
	self.SimpleTelescopicsFOV = nil
	self.BlurOnAim = false
end

CustomizableWeaponry:registerAttachment(att)
