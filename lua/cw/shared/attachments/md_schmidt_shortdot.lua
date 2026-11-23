local att = {}
att.name = "md_schmidt_shortdot"
att.displayName = "Schmidt&Bender Short dot"
att.displayNameShort = "Short dot"
att.aimPos = {"ShortDotPos", "ShortDotAng"}
att.FOVModifier = 15
att.isSight = true

att.statModifiers = {OverallMouseSensMult = -0.1}

if CLIENT then
	att.displayIcon = surface.GetTextureID("atts/shortdot")
	att.description = {[1] = {t = "Provides 2.5x magnification.", c = CustomizableWeaponry.textColors.POSITIVE},
	[2] = {t = "Narrow scope reduces awareness.", c = CustomizableWeaponry.textColors.NEGATIVE},
	[3] = {t = "Can be disorienting at close range.", c = CustomizableWeaponry.textColors.NEGATIVE}}

	local ang
	local reticle = surface.GetTextureID("cw2/reticles/aim_reticule")
	local dotOffset = 0.5 / 32
	
	att.zoomTextures = {
		{
			tex = reticle, offset = {0, 0}, center = {dotOffset, dotOffset},
			size = {16, 16}, color = Color(255, 0, 0, 150),
		},
		{
			tex = reticle, offset = {0, 0}, center = {dotOffset, dotOffset},
			size = {8, 8}, color = Color(255, 0, 0, 255),
		},
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
	cd.fov = 9
	cd.drawviewmodel = false
	cd.drawhud = false
	cd.dopostprocess = false
	
	function att:drawRenderTarget(viewOrigin, viewAngles)
		local complexTelescopics = self:canUseComplexTelescopics()
		
		-- if we don't have complex telescopics enabled, don't do anything complex, and just set the texture of the lens to a fallback 'lens' texture
		if not complexTelescopics then
			self.TSGlass:SetTexture("$basetexture", lensMat:GetTexture("$basetexture"))
			return
		end
		
		if self:canSeeThroughTelescopics(att.aimPos[1]) then
			alpha = math.Approach(alpha, 0, FrameTime() * 5)
		else
			alpha = math.Approach(alpha, 1, FrameTime() * 5)
		end
		
		ang = viewAngles and Angle(viewAngles.p, viewAngles.y, viewAngles.r) or self:getTelescopeAngles()
		
		if self.ViewModelFlip then
			ang.r = -self.BlendAng.z
		else
			ang.r = self.BlendAng.z
		end
		
		if not self.freeAimOn then
			ang:RotateAroundAxis(ang:Right(), self.SchmidtShortDotAxisAlign.right)
			ang:RotateAroundAxis(ang:Up(), self.SchmidtShortDotAxisAlign.up)
			ang:RotateAroundAxis(ang:Forward(), self.SchmidtShortDotAxisAlign.forward)
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
				surface.SetDrawColor(0, 0, 0, 200)
				surface.DrawRect(size * 0.5 - 1, 0, 2, size) -- middle top-bottom
				surface.DrawRect(0, size * 0.5 - 1, size, 2) -- middle left-right
				
				local retSize = size * 0.02
				
				surface.SetDrawColor(255, 0, 0, 255)
				surface.SetTexture(reticle)
				local dotStart = size * 0.5 - retSize * (0.5 + dotOffset)
				surface.DrawTexturedRect(dotStart, dotStart, retSize, retSize)
				
				surface.SetDrawColor(150 * light[1], 150 * light[2], 150 * light[3], 255 * alpha)
				surface.SetTexture(lens)
				surface.DrawTexturedRectRotated(size * 0.5, size * 0.5, size, size, 90)
			cam.End2D()
			DisableClipping(clippingDisabled)
		render.PopRenderTarget()
		
		if self.TSGlass then
			self.TSGlass:SetTexture("$basetexture", self.ScopeRT)
		end
	end
end

function att:attachFunc()
	self.OverrideAimMouseSens = 0.4
	self.SimpleTelescopicsFOV = 55
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