//-----------------------------------------------------------------------------
// AdjustMouseSensitivity edited to take dt.INS2GLActive into account
//-----------------------------------------------------------------------------

function SWEP:AdjustMouseSensitivity()
	local sensitivity = 1
	local mod = math.Clamp(self.OverallMouseSens, 0.1, 1) -- not lower than 10% and not higher than 100% (in case someone uses atts that increase handling)
	local freeAimMod = 1

	if self.freeAimOn and not self.dt.BipodDeployed then
		local dist = math.abs(self:getFreeAimDotToCenter())

		local mouseImpendance = GetConVarNumber("cw_freeaim_center_mouse_impendance")
		freeAimMod = 1 - (mouseImpendance - mouseImpendance * dist)
	end

	if self.dt.State == CW_RUNNING then
		if self.RunMouseSensMod then
			return self.RunMouseSensMod * mod
		end
	end

	if self.dt.State == CW_AIMING then
		-- if we're aiming and our aiming position is that of the sight we have installed - decrease our mouse sensitivity
		if (self.OverrideAimMouseSens and self.AimPos == self.ActualSightPos) and not (self.dt.INS2GLActive) then
			--return self.OverrideAimMouseSens * mod
			sensitivity = self.OverrideAimMouseSens
		end

		--return math.Clamp(1 - self.ZoomAmount / 100, 0.1, 1) * mod
		sensitivity = math.Clamp(sensitivity - self.ZoomAmount / 100, 0.1, 1)
	end

	sensitivity = sensitivity * mod
	sensitivity = sensitivity * freeAimMod

	return sensitivity --1 * self.OverallMouseSens
end

//-----------------------------------------------------------------------------
// CalcView edited to use different source for ViewBob
//-----------------------------------------------------------------------------

local FT, CT, cos1, cos2, ws, vel, att, ang
local Ang0, curang, curviewbob = Angle(0, 0, 0), Angle(0, 0, 0), Angle(0, 0, 0)
local reg = debug.getregistry()
local GetVelocity = reg.Entity.GetVelocity
local Length = reg.Vector.Length
local Right = reg.Angle.Right
local Up = reg.Angle.Up
local Forward = reg.Angle.Forward
local RotateAroundAxis = reg.Angle.RotateAroundAxis

function SWEP:CalcView(ply, pos, ang, fov)
	self.freeAimOn = self:isFreeAimOn()
	self.autoCenterFreeAim = GetConVarNumber("cw_freeaim_autocenter") > 0

	if self.dt.BipodDeployed then
		if not self.forceFreeAimOffTime then
			self.forceFreeAimOffTime = CurTime() + 0.5
		end
	else
		self.forceFreeAimOffTime = false
	end

	if self.freeAimOn then
		fov = 90 -- force FOV to 90 when in free aim mode, unfortunately, due to angles getting fucked up when FOV is not 90
		RunConsoleCommand("fov_desired", 90)
	end

	-- if we have free aim on, and we are not using a bipod, or we're using a bipod and we have not run out of "free aim time", then we should simulate free aim
	if self.freeAimOn and (not self.forceFreeAimOffTime or CurTime() < self.forceFreeAimOffTime) then
		local aiming = self.dt.State == CW_AIMING

		if self.shouldUpdateAngles then
			self.lastEyeAngle = self.Owner:EyeAngles()
			self.shouldUpdateAngles = false
		else
			local dot = math.Clamp(math.abs(self:getFreeAimDotToCenter()) + 0.3, 0.3, 1)

			local lazyAim = GetConVarNumber("cw_freeaim_lazyaim")
			self.lastEyeAngle.y = math.NormalizeAngle(self.lastEyeAngle.y - self.mouseX * lazyAim * dot)

			if not aiming and CurTime() > self.lastShotTime then -- we only want to modify pitch if we haven't shot lately
				self.lastEyeAngle.p = math.Clamp(self.lastEyeAngle.p + self.mouseY * lazyAim * dot, -89, 89)
			end
		end

		if self.autoCenterFreeAim then
			if self.mouseActive then
				self.lastMouseActivity = CurTime() + GetConVarNumber("cw_freeaim_autocenter_time")
			end

			local canAutoCenter = CurTime() > self.lastMouseActivity
			local shouldAutoCenter = false
			local aimAutoCenter = GetConVarNumber("cw_freeaim_autocenter_aim") > 0

			if aiming then
				canAutoCenter = true
				shouldAutoCenter = true
			end

			if self.autoCenterExclusions[self.dt.State] then
				canAutoCenter = true
				shouldAutoCenter = true
			end

			if self.forceFreeAimOffTime then -- if we're being forced to turn free-aim off, do so
				canAutoCenter = true
				shouldAutoCenter = true
			end

			if canAutoCenter then
				local frameTime = FrameTime()

				self.freeAimAutoCenterSpeed = frameTime * 16

				if aiming then
					self.freeAimAutoCenterSpeed = frameTime * 25 --math.Approach(self.freeAimAutoCenterSpeed, frameTime * 40, frameTime * 6)
				end

				if self.autoCenterExclusions[self.dt.State] then
					shouldAutoCenter = true
				else
					if CurTime() > self.lastMouseActivity then
						shouldAutoCenter = true
						self.freeAimAutoCenterSpeed = frameTime * 6 --math.Approach(self.freeAimAutoCenterSpeed, frameTime * 6, frameTime * 6)
					end
				end

				self.freeAimAutoCenterSpeed = math.Clamp(self.freeAimAutoCenterSpeed, 0, 1)

				if shouldAutoCenter then
					self.lastEyeAngle = LerpAngle(self.freeAimAutoCenterSpeed, self.lastEyeAngle, self.Owner:EyeAngles())
				end
			end
		end

		local yawDiff = math.AngleDifference(self.lastEyeAngle.y, ang.y)
		local pitchDiff = math.AngleDifference(self.lastEyeAngle.p, ang.p)

		local yawLimit = GetConVarNumber("cw_freeaim_yawlimit")
		local pitchLimit = GetConVarNumber("cw_freeaim_pitchlimit")

		if yawDiff >= yawLimit then
			self.lastEyeAngle.y = math.NormalizeAngle(ang.y + yawLimit)
		elseif yawDiff <= -yawLimit then
			self.lastEyeAngle.y = math.NormalizeAngle(ang.y - yawLimit)
		end

		if pitchDiff >= pitchLimit then
			self.lastEyeAngle.p = math.NormalizeAngle(ang.p + pitchLimit)
		elseif pitchDiff <= -pitchLimit then
			self.lastEyeAngle.p = math.NormalizeAngle(ang.p - pitchLimit)
		end

		ang.y = self.lastEyeAngle.y
		ang.p = self.lastEyeAngle.p

		ang = ang
	else
		self.shouldUpdateAngles = true
	end

	FT, CT = FrameTime(), CurTime()

	local resetM203Angles = false

	self.M203CameraActive = false

	if self.AttachmentModelsVM then
		local m203 = self.AttachmentModelsVM.md_m203

		if m203 then
			if self.dt.State ~= CW_CUSTOMIZE then
				local CAMERA = m203.ent:GetAttachment(m203.ent:LookupAttachment("Camera")).Ang
				local modelAng = m203.ent:GetAngles()

				RotateAroundAxis(CAMERA, Right(CAMERA), self.M203CameraRotation.p)
				RotateAroundAxis(CAMERA, Up(CAMERA), self.M203CameraRotation.y)
				RotateAroundAxis(CAMERA, Forward(CAMERA), self.M203CameraRotation.r)

				local factor = math.abs(ang.p)
				local intensity = 1

				if factor >= 60 then
					factor = factor - 60
					intensity = math.Clamp(1 - math.abs(factor / 15), 0, 1)
				end

				self.M203AngDiff = math.NormalizeAngles((modelAng - CAMERA)) * 0.5 * intensity
			end
		end
	end

	ang = ang - self.M203AngDiff
	ang = ang - self.CurM203Angles * 0.5
	ang.r = ang.r + self.lastViewRoll

	if UnPredictedCurTime() > self.lastViewRollTime then
		self.lastViewRoll = LerpCW20(FrameTime() * 10, self.lastViewRoll, 0)
	end

	if UnPredictedCurTime() > self.FOVHoldTime or freeAimOn then
		self.FOVTarget = LerpCW20(FT * 10, self.FOVTarget, 0)
	end

	if self._vmCamAttach > 0 then
		local vm = self.CW_VM

		// yea this one IS better
		local CAMERA = vm:GetAttachment(self._vmCamAttach).Ang
		local modelAng = vm:GetAngles()

		local factor = math.abs(ang.p)
		local intensity = 2

		if factor >= 60 then
			factor = factor - 60
			intensity = math.Clamp(1 - math.abs(factor / 15), 0, 1)
		end

		local bobAngDiff = math.NormalizeAngles((modelAng - CAMERA)) * 0.5 * intensity

		ang = ang - bobAngDiff
	end

	if self.dt.State == CW_AIMING then
		if self.dt.M203Active and self.M203Chamber and not CustomizableWeaponry.grenadeTypes:canUseProperSights(self.Grenade40MM) then
			self.CurFOVMod = LerpCW20(FT * 10, self.CurFOVMod, 5)
		else
			local zoomAmount = self.ZoomAmount
			local simpleTelescopics = not self:canUseComplexTelescopics()
			local shouldDelay = false

			if simpleTelescopics then
				if self.SimpleTelescopicsFOV then
					zoomAmount = self.SimpleTelescopicsFOV
					shouldDelay = true
				end
			end

			if self.DelayedZoom or shouldDelay then
				if CT > self.AimTime then
					if self.SnapZoom or (self.SimpleTelescopicsFOV and simpleTelescopics) then
						self.CurFOVMod = zoomAmount
					else
						self.CurFOVMod = LerpCW20(FT * 10, self.CurFOVMod, zoomAmount)
					end
				else
					self.CurFOVMod = LerpCW20(FT * 10, self.CurFOVMod, 0)
				end
			else
				if self.SnapZoom or (self.SimpleTelescopicsFOV and simpleTelescopics) then
					self.CurFOVMod = zoomAmount
				else
					self.CurFOVMod = LerpCW20(FT * 10, self.CurFOVMod, zoomAmount)
				end
			end
		end
	else
		self.CurFOVMod = LerpCW20(FT * 10, self.CurFOVMod, 0)
	end

	if self.holdingBreath then
		self.BreathFOVModifier = math.Approach(self.BreathFOVModifier, 7, FT * 12)
	else
		self.BreathFOVModifier = math.Approach(self.BreathFOVModifier, 0, FT * 10)
	end

	fov = math.Clamp(fov - self.CurFOVMod - self.BreathFOVModifier, 5, 90)
	fov = fov - self.FOVTarget
	self.curFOV = fov

	return pos, ang + curviewbob * self.ViewbobIntensity, fov
end