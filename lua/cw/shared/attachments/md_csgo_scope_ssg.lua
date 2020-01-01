local att = {}
att.name = "md_csgo_scope_ssg"
att.displayName = "Schmidt Bender 12x Scope"
att.displayNameShort = "Bender"
att.aimPos = {"CSGOSSGPos", "CSGOSSGAng"}
att.FOVModifier = 15
att.isSight = true

att.statModifiers = {OverallMouseSensMult = -0.25}

if CLIENT then
	att.displayIcon = surface.GetTextureID("cw20_extras/icons/upgr_csgo_ssgscope")
	att.description = {[1] = {t = "Provides 12x magnification.", c = CustomizableWeaponry.textColors.POSITIVE},
	[2] = {t = "Narrow scope reduces awareness.", c = CustomizableWeaponry.textColors.NEGATIVE},
	[3] = {t = "Can be disorienting at close range.", c = CustomizableWeaponry.textColors.NEGATIVE}}

	local old, x, y, ang
	local reticle = surface.GetTextureID("cw20_extras/ssg_scope_reticle")
	local reticle_normal = surface.GetTextureID("cw2/reticles/scope_leo")
	
	att.zoomTextures = {[1] = {tex = reticle_normal, offset = {0, 1}}}
	
	local lens = surface.GetTextureID("cw2/gui/lense")
	local lensMat = Material("cw2/gui/lense")
	local cd, alpha = {}, 0.5
	local Ini = true
	
	-- render target var setup
	cd.x = 0
	cd.y = 0
	cd.w = 512
	cd.h = 512
	cd.fov = 1.2
	cd.drawviewmodel = false
	cd.drawhud = false
	cd.dopostprocess = false
	
	function att:drawRenderTarget()
		local complexTelescopics = self:canUseComplexTelescopics()
		
		-- if we don't have complex telescopics enabled, don't do anything complex, and just set the texture of the lens to a fallback 'lens' texture
		if not complexTelescopics then
			Material("models/kali/weapons/csgo/t5_weapon_longscope_lens_c"):SetTexture("$basetexture", lensMat:GetTexture("$basetexture"))
			return
		end
		
		if self:canSeeThroughTelescopics(att.aimPos[1]) then
			alpha = math.Approach(alpha, 0, FrameTime() * 5)
		else
			alpha = math.Approach(alpha, 1, FrameTime() * 5)
		end
		
		x, y = ScrW(), ScrH()
		old = render.GetRenderTarget()
	
		ang = LocalPlayer():EyeAngles() + LocalPlayer():GetPunchAngle() -- fucking fix for some models
		
		if self.ViewModelFlip then
			ang.r = -self.BlendAng.z
		else
			ang.r = self.BlendAng.z
		end
		
		ang:RotateAroundAxis(ang:Right(), self.CSGOSSGAxisAlign.right)
		ang:RotateAroundAxis(ang:Up(), self.CSGOSSGAxisAlign.up)
		ang:RotateAroundAxis(ang:Forward(), self.CSGOSSGAxisAlign.forward)
		
		cd.angles = ang
		cd.origin = self.Owner:GetShootPos()
		render.SetRenderTarget(self.ScopeRT)
		render.SetViewPort(0, 0, 512, 512)
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
			
			cam.Start2D()
				surface.SetDrawColor(255, 255, 255, 255)
				surface.SetTexture(reticle)
				surface.DrawTexturedRect(0, 0, 512, 512)
				
				surface.SetDrawColor(150 * light[1], 150 * light[2], 150 * light[3], 255 * alpha)
				surface.SetTexture(lens)
				surface.DrawTexturedRectRotated(256, 256, 512, 512, 90)
			cam.End2D()
		render.SetViewPort(0, 0, x, y)
		render.SetRenderTarget(old)
		
		if Material("models/kali/weapons/csgo/t5_weapon_longscope_lens_c") then
			Material("models/kali/weapons/csgo/t5_weapon_longscope_lens_c"):SetTexture("$basetexture", self.ScopeRT)
		end
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