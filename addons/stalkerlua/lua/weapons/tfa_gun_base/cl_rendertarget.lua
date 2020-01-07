--[[
Example RT

local wepcol = Color(0,0,0,255)

local cd = {}

SWEP.RTMaterialOverride = 0

SWEP.RTOpaque = true

SWEP.RTCode = function( self )

	render.OverrideAlphaWriteEnable( true, true)
	surface.SetDrawColor(color_white)
	surface.DrawRect(-512,-512,1024,1024)
	render.OverrideAlphaWriteEnable( true, true)
	
	local ang = EyeAngles()
	
	local AngPos = self.Owner:GetViewModel():GetAttachment(1)
	
	if AngPos then
	
		ang = AngPos.Ang
		
		ang:RotateAroundAxis(ang:Right(),90)
	
	end
	
	cd.angles = ang
	cd.origin = self.Owner:GetShootPos()
	
	cd.x = 0
	cd.y = 0
	cd.w = 512
	cd.h = 512
	cd.fov = 4
	cd.drawviewmodel = false
	cd.drawhud = false
	
	render.RenderView(cd)
	
	render.OverrideAlphaWriteEnable( false, true)
	
	
	cam.Start2D()
		draw.NoTexture()
		local plywepcol = self.Owner:GetWeaponColor()
		wepcol.r = plywepcol.r*255
		wepcol.g = plywepcol.g*255
		wepcol.b = plywepcol.b*255
		surface.SetDrawColor(wepcol)
		drawFilledCircle(256,256,8,16)
		surface.DrawRect(64,256-4,128,8)
		surface.DrawRect(512-64-128,256-4,128,8)
		surface.DrawRect(256-4,512-64-128,8,128)
	cam.End2D()
	
end
]]--

if CLIENT then
	local props = {
		['$translucent'] = 1
	}
	local TFA_RTMat = CreateMaterial("tfa_rtmaterial","UnLitGeneric", props )--Material("models/weapons/TFA/shared/optic")
	local TFA_RTScreen = GetRenderTargetEx("TFA_RT_Screen",	512,	512,	RT_SIZE_NO_CHANGE,	MATERIAL_RT_DEPTH_SEPARATE,	0,	CREATERENDERTARGETFLAGS_UNFILTERABLE_OK, IMAGE_FORMAT_ARGB8888	)
	local TFA_RTScreenO = GetRenderTargetEx("TFA_RT_ScreenO",	512,	512,	RT_SIZE_NO_CHANGE,	MATERIAL_RT_DEPTH_SEPARATE,	0,	CREATERENDERTARGETFLAGS_UNFILTERABLE_OK, IMAGE_FORMAT_RGB888	)
	
	local wepcol = Color(0,0,0,255)
	
	local oldVmModel = ""
	
	local oldwepclass = ""
	
	local function TFARenderScreen()
		
		for k,v in pairs(player.GetAll()) do
			
			if IsValid(v) then
			
				local self = v:GetActiveWeapon()
				
				if IsValid(self) and self!=LocalPlayer() then
					
					--start
		
					local vm = self.Owner:GetViewModel()
					
					if IsValid(vm) then
						
						if v.oldVmModel != vm:GetModel() or ( IsValid(self) and oldwepclass != self:GetClass() ) then
							local mats = vm:GetMaterials()
							if !mats then return end
							local matcount = #mats
							local i=0
							while i<=matcount do
								self.Owner:GetViewModel():SetSubMaterial(i,"")
								i=i+1
							end
							v.oldVmModel = vm:GetModel()
							
							if IsValid(self) then
								self.MaterialCached = nil
						
								v.oldwepclass = self:GetClass()
						
								local ow = self.Owner
								if IsValid(ow) then
									local owweps = ow:GetWeapons()
									for k,v in pairs(owweps) do
										if IsValid(v) and v:GetClass() == v.oldwepclass then
											v.MaterialCached = nil							
										end
									end
								end
							end
							
						else
						
							v.oldwepclass = ""
							
							v.oldwepclass = self:GetClass()
							
							if self.MaterialTable then
								
								local vm = self.Owner:GetViewModel()
								
								if !self.MaterialCached then
									self.MaterialCached = {}
								
									local mats = vm:GetMaterials()
									
									local i = 0
									
									while i<#mats do
										self:SetSubMaterial(i,"")
										vm:SetSubMaterial(i,"")
										i=i+1
									end
									
								end
								
								if #self.MaterialTable>=1 then
									self:SetMaterial(self.MaterialTable[1])
								else
									self:SetMaterial("")
								end
								
								for k,v in ipairs(self.MaterialTable) do
									if !self.MaterialCached[k] then
										self:SetSubMaterial(k-1,v)
										self:SetSubMaterial(k,v)
										vm:SetSubMaterial(k-1,v)
										self.MaterialCached[k] = true
									end
								end
								
							end
						end
					end
					
					
					--end of block
					
				end
				
			end
		
		end
		
		if !IsValid(LocalPlayer()) or !IsValid(LocalPlayer():GetActiveWeapon()) then return end
		
		local self = LocalPlayer():GetActiveWeapon()
		
		local vm = self.Owner:GetViewModel()
		
		if !IsValid(vm) then return end
		
		if oldVmModel != vm:GetModel() or ( IsValid(self) and oldwepclass != self:GetClass() ) then
			local matcount = #vm:GetMaterials()
			local i=0
			while i<=matcount do
				self.Owner:GetViewModel():SetSubMaterial(i,"")
				i=i+1
			end
			oldVmModel = vm:GetModel()
			
			if IsValid(self) then
				self.MaterialCached = nil
		
				oldwepclass = self:GetClass()
		
				local ow = self.Owner
				if IsValid(ow) then
					local owweps = ow:GetWeapons()
					for k,v in pairs(owweps) do
						if IsValid(v) and v:GetClass() == oldwepclass then
							v.MaterialCached = nil							
						end
					end
				end
			end
			
			return
		end
		
		oldwepclass = ""
		
		if !IsValid(self) then return end
		
		oldwepclass = self:GetClass()
		
		if self.MaterialTable then
			
			local vm = self.Owner:GetViewModel()
			
			if !self.MaterialCached then
				self.MaterialCached = {}
			
				local mats = vm:GetMaterials()
				
				local i = 0
				
				while i<#mats do
					vm:SetSubMaterial(i,"")
					i=i+1
				end
				
				i = 0
				
				mats = self:GetMaterials()
				
				while i<#mats do
					self:SetSubMaterial(i,"")
					i=i+1
				end
				
			end
			
			if #self.MaterialTable>=1 then
				self:SetMaterial(self.MaterialTable[1])
			else
				self:SetMaterial("")
			end
			
			for k,v in ipairs(self.MaterialTable) do
				if !self.MaterialCached[k] then
					self:SetSubMaterial(k-1,v)
					vm:SetSubMaterial(k-1,v)
					self.MaterialCached[k] = true
				end
			end
			
		end
		
		if !self.RTMaterialOverride or !self.RTCode then return end
		
		oldVmModel = vm:GetModel()
		
		local w,h = ScrW(), ScrH()
		
		local oldrt = render.GetRenderTarget()
		
		if !self.RTOpaque then
			render.SetRenderTarget(TFA_RTScreen)
		else
			render.SetRenderTarget(TFA_RTScreenO)
		end
		render.Clear( 0, 0, 0, 0, true, true )
		render.SetViewPort(0,0,512,512)
		self:RTCode(TFA_RTMat,w,h)
		render.SetRenderTarget(oldrt)
		render.SetViewPort(0,0,w,h)
		
		if !self.RTOpaque then
			TFA_RTMat:SetTexture("$basetexture",TFA_RTScreen)
		else
			TFA_RTMat:SetTexture("$basetexture",TFA_RTScreenO)
		end
		
		self.Owner:GetViewModel():SetSubMaterial(self.RTMaterialOverride,"!tfa_rtmaterial")
	end

	hook.Add("RenderScene","TFASCREENS",TFARenderScreen)
end