local att = {}
att.name = "md_pso1"
att.displayName = "PSO-1"
att.displayNameShort = "PSO-1"
att.aimPos = {"PSOPos", "PSOAng"}
att.FOVModifier = 15
att.isSight = true
att.withoutRail = true

att.statModifiers = {OverallMouseSensMult = -0.1}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/pso1")
	att.description = {[1] = {t = "Provides 4x magnification.", c = CustomizableWeaponry.textColors.POSITIVE},
	[2] = {t = "Narrow scope reduces awareness.", c = CustomizableWeaponry.textColors.NEGATIVE},
	[3] = {t = "Can be disorienting at close range.", c = CustomizableWeaponry.textColors.NEGATIVE}}

	local ang
	local sight = surface.GetTextureID("cw2/reticles/scope_pso")
	local sightIllum = surface.GetTextureID("cw2/reticles/scope_pso_illum")
	local reticleTip = -3.5 / 1024
	att.zoomTextures = {
		{tex = sight, offset = {0, 0}, center = {0, reticleTip}},
		{tex = sightIllum, offset = {0, 0}, center = {0, reticleTip}},
	}
	
	local lens = surface.GetTextureID("cw2/gui/lense")
	local lensMat = Material("cw2/gui/lense")
	local cd, alpha = {}, 0.5
	local Ini = true
	
	-- render target var setup
	cd.x = 0
	cd.y = 0
	cd.w = 512
	cd.h = 512
	cd.aspectratio = 1
	cd.fov = 4.5
	cd.drawviewmodel = false
	cd.drawhud = false
	cd.dopostprocess = false
	
	function att:drawRenderTarget(viewOrigin, viewAngles, glass)
		glass = glass or self.TSGlass
		local complexTelescopics = self:canUseComplexTelescopics()
		
		-- if we don't have complex telescopics enabled, don't do anything complex, and just set the texture of the lens to a fallback 'lens' texture
		if not complexTelescopics then
			glass:SetTexture("$basetexture", lensMat:GetTexture("$basetexture"))
			return
		end
		
		if self:canSeeThroughTelescopics(att.aimPos[1]) then
			alpha = math.Approach(alpha, 0, FrameTime() * 5)
		else
			alpha = math.Approach(alpha, 1, FrameTime() * 5)
		end
		
		ang = viewAngles and Angle(viewAngles.p, viewAngles.y, viewAngles.r) or self:getTelescopeAngles()
		
		if not self.freeAimOn then
			ang:RotateAroundAxis(ang:Right(), self.PSO1AxisAlign.right)
			ang:RotateAroundAxis(ang:Up(), self.PSO1AxisAlign.up)
			ang:RotateAroundAxis(ang:Forward(), self.PSO1AxisAlign.forward)
		else
			ang:RotateAroundAxis(ang:Forward(), 90)
		end
		
		local size = self:getRenderTargetSize()
		
		cd.w = size
		cd.h = size
		cd.angles = ang
		cd.origin = viewOrigin or EyePos()
		render.PushRenderTarget(self.ScopeRT, 0, 0, size, size)
			if alpha < 1 or Ini then
				render.RenderView(cd)
				Ini = false
			end
			
			ang = self.Owner:EyeAngles()
			ang.p = ang.p + self.BlendAng.x
			ang.y = ang.y + self.BlendAng.y
			ang.r = ang.r + self.BlendAng.z
			ang = -ang:Forward()
			
			local light = render.ComputeLighting(self.Owner:GetShootPos(), ang)
			
			local clippingDisabled = DisableClipping(true)
			cam.Start2D()
				surface.SetDrawColor(255, 255, 255, 255)
				surface.SetTexture(sight)
				local reticleSize = size * 0.8
				local reticleX = size * 0.5 - reticleTip * reticleSize
				surface.DrawTexturedRectRotated(reticleX, size * 0.5, reticleSize, reticleSize, 90)
				
				surface.SetDrawColor(255, 255, 255, 255)
				surface.SetTexture(sightIllum)
				surface.DrawTexturedRectRotated(reticleX, size * 0.5, reticleSize, reticleSize, 90)
				
				surface.SetDrawColor(150 * light[1], 150 * light[2], 150 * light[3], 255 * alpha)
				surface.SetTexture(lens)
				surface.DrawTexturedRectRotated(size * 0.5, size * 0.5, size, size, 90)
			cam.End2D()
			DisableClipping(clippingDisabled)
		render.PopRenderTarget()
		
		if glass then
			glass:SetTexture("$basetexture", self.ScopeRT)
		end
	end
end

function att:attachFunc()
	self.OverrideAimMouseSens = 0.25
	self.SimpleTelescopicsFOV = 70
	self.AimViewModelFOV = 50
	self.BlurOnAim = true
	self.ZoomTextures = att.zoomTextures
end

function att:detachFunc()
	self.OverrideAimMouseSens = nil
	self.SimpleTelescopicsFOV = nil
	self.AimViewModelFOV = self.AimViewModelFOV_Orig
	self.BlurOnAim = false
end

CustomizableWeaponry:registerAttachment(att)