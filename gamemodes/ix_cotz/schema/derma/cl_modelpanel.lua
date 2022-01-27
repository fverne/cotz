
tegnmanden = false

local PANEL = {}
	local MODEL_ANGLE = Angle(0, 45, 0)

	function PANEL:Init()
		self.brightness = 1

		self:SetCursor("none")
		self.OldSetModel = self.SetModel
		self.SetModel = function(self, model)
			self:OldSetModel(model)

			local entity = self.Entity

			if (IsValid(entity)) then
				local sequence = entity:SelectWeightedSequence(ACT_IDLE)

				if (sequence <= 0) then
					sequence = entity:LookupSequence("idle_unarmed")
				end

				if (sequence > 0) then
					entity:ResetSequence(sequence)
				else
					local found = false

					for k, v in ipairs(entity:GetSequenceList()) do
						if ((v:lower():find("idle") or v:lower():find("fly")) and v != "idlenoise") then
							entity:ResetSequence(v)
							found = true

							break
						end
					end

					if (!found) then
						entity:ResetSequence(4)
					end
				end

				entity:SetIK(false)
			end
		end
	end

	function PANEL:LayoutEntity()
		local scrW, scrH = ScrW(), ScrH()
		local xRatio = gui.MouseX() / scrW
		local yRatio = gui.MouseY() / scrH
		local x, y = self:LocalToScreen(self:GetWide() / 2)
		local xRatio2 = x / scrW
		local entity = self.Entity

		entity:SetPoseParameter("head_pitch", yRatio*90 - 30)
		entity:SetPoseParameter("head_yaw", (xRatio - xRatio2)*90 - 5)
		entity:SetAngles(MODEL_ANGLE)
		entity:SetIK(false)

		if (self.copyLocalSequence) then
			entity:SetSequence(LocalPlayer():GetSequence())
		 	entity:SetPoseParameter("move_yaw", 360 * LocalPlayer():GetPoseParameter("move_yaw") - 180)
		end

		self:RunAnimation()
	end

	function PANEL:DrawModel()
		local brightness = self.brightness * 0.4
		local brightness2 = self.brightness * 1.5

		render.SetModelLighting(0, brightness2, brightness2, brightness2)

		for i = 1, 4 do
			render.SetModelLighting(i, brightness, brightness, brightness)
		end

		local fraction = (brightness / 1) * 0.1

		render.SetModelLighting(5, fraction, fraction, fraction)

		if IsValid(self.Entity:GetActiveWeapon()) then
			self.Entity:GetActiveWeapon():DrawModel()
		end

		self.Entity:DrawModel()
	
		if (self.enableHook) then
			hook.Run("PostDrawHelixModelView", self, self.Entity)
		end
	end

	function PANEL:OnMousePressed()
	end

	function PANEL:Paint(w,h)
		--draw.RoundedBox(4,0,0,w,h,Color(53,53,53,200))
		if (!IsValid(self.Entity)) then return end

		if ix.gui.menu.bClosing then
			return 
		end

		local x,y = self:LocalToScreen()

		tegnmanden = true

		local angx, angy, angz = self.Entity:GetAngles():Unpack()

		local fwd = Angle(0,angy,0):Forward()*100

		local campos = self.Entity:GetPos() + fwd + Vector(0,0,36)
		local camtarget = self.Entity:GetPos() + Vector(0,0,36)

		cam.Start3D(campos,(camtarget-campos):Angle(),36,x,y,w,h,5,4096)
		--cam.Start3D(self.Entity:LocalToWorld(self.Entity:OBBCenter())-ang:Forward()*100,ang,self.fFOV,x,y,w,h,5,4096)
		cam.IgnoreZ(true)

		local pac = pac
		if pac then
			pac.ForceRendering(true)
			pac.RenderOverride(self.Entity,"opaque")
			pac.RenderOverride(self.Entity,"translucent", true)
			pac.EyePos = self:GetCamPos()
			pac.EyeAng = (self.vLookatPos-self.vCamPos):Angle()
		end

		self:DrawModel()

		if pac then
			pac.ForceRendering(false)
		end

		cam.IgnoreZ(false)
		cam.End3D()

		tegnmanden = false

		self.LastPaint = RealTime()
	end

vgui.Register("ixPlayerModelPanel", PANEL, "DModelPanel")

hook.Add("ShouldDrawLocalPlayer", "PACPlayerPreview", function()
	if tegnmanden then return true end
end)