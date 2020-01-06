
local Vec0, Ang0 = Vector(0, 0, 0), Angle(0, 0, 0)
local TargetPos, TargetAng, cos1, sin1, tan, ws, rs, mod, EA, delta, sin2, mul, vm, muz, muz2, tr, att, CT
local td = {}
local LerpVector, LerpAngle, Lerp = LerpVector, LerpAngle, Lerp

local reg = debug.getregistry()
local GetVelocity = reg.Entity.GetVelocity
local Length = reg.Vector.Length
local Right = reg.Angle.Right
local Up = reg.Angle.Up
local Forward = reg.Angle.Forward
local RotateAroundAxis = reg.Angle.RotateAroundAxis
local GetBonePosition = reg.Entity.GetBonePosition

local ManipulateBonePosition, ManipulateBoneAngles = reg.Entity.ManipulateBonePosition, reg.Entity.ManipulateBoneAngles

local Vec50 = Vector(-50, 0, 0)

local SP = game.SinglePlayer()
local PosMod, AngMod = Vector(0, 0, 0), Vector(0, 0, 0)
local CurPosMod, CurAngMod = Vector(0, 0, 0), Vector(0, 0, 0)
local veldepend = {pitch = 0, yaw = 0, roll = 0}
local mod2 = 0
local EA2

function SWEP:applyOffsetToVM()
	local CT = UnPredictedCurTime()

	local pos = EyePos()
	local ang

	if self.freeAimOn and (self.freeAimOn and not self.dt.BipodDeployed) then
		-- take FOV changes into account (including the breath FOV modifier, but excluding the 'continuous fire' FOV modifier)
		local fovDiff = math.Clamp(60 / (self.ViewModelFOV - self.BreathFOVModifier * 0.5), -math.huge, math.huge)

		if self.ViewModelFOV < 60 then
			fovDiff = fovDiff * 1.1
		end

		local eyeAngles = self.Owner:EyeAngles()
		local actualEyeAngles = EyeAngles()

		--local fovDiffNonWep = 1 + (1 - GetConVarNumber("fov_desired") / 90)

		-- get the difference between the real eye angles and the 'virtual' eye angles
		local pitchDiff = math.AngleDifference(eyeAngles.p, actualEyeAngles.p) * 0.45 * fovDiff
		local yawDiff = math.AngleDifference(eyeAngles.y, actualEyeAngles.y) * 0.45 * fovDiff

		-- normalize the angles after subtracting the difference in both axes
		local normalizedPitch = math.NormalizeAngle(eyeAngles.p - pitchDiff)
		local normalizedYaw = math.NormalizeAngle(eyeAngles.y - yawDiff)

		-- apply the angles
		eyeAngles.p = normalizedPitch
		eyeAngles.y = normalizedYaw

		ang = eyeAngles
	else -- if we're not using free aim, fall back to 'virtual' eye angles
		ang = EyeAngles()
	end

	if self.InstantDissapearOnAim and self.dt.State == CW_AIMING then
		self.ViewModelFOV = 90
		pos = pos - ang:Forward() * 100
		--return pos, ang
	end

	if CT > self.AimTime then
		if ((self.MoveWepAwayWhenAiming and self.dt.State == CW_AIMING) or (self:canUseSimpleTelescopics() and self.dt.State == CW_AIMING)) and (self.dt.M203Active and (not self.M203Chamber or CustomizableWeaponry.grenadeTypes:canUseProperSights(self.Grenade40MM))  or not self.dt.M203Active) then
			self.ViewModelFOV = 90
			pos = pos - ang:Forward() * 100
			--return pos, ang
		end
	end

	RotateAroundAxis(ang, Right(ang), self.BlendAng.x + self.RecoilAng.p)

	local swayIntensity = self.dt.State == CW_AIMING and self.AimSwayIntensity or self.SwayIntensity

	-- first we offset the viewmodel position
	if not self.ViewModelFlip then
		RotateAroundAxis(ang, Up(ang), self.BlendAng.y + self.RecoilAng.y - self.AngleDelta.y * 0.4 * swayIntensity)
		RotateAroundAxis(ang, Forward(ang), self.BlendAng.z + self.RecoilAng.r + self.AngleDelta.y * 0.4 * swayIntensity)
	else
		RotateAroundAxis(ang, Up(ang), -self.BlendAng.y + self.RecoilAng.y - self.AngleDelta.y * 0.4 * swayIntensity)
		RotateAroundAxis(ang, Forward(ang), -self.BlendAng.z + self.RecoilAng.r + self.AngleDelta.y * 0.4 * swayIntensity)
	end

	if not self.ViewModelFlip then
		pos = pos + (self.BlendPos.x + self.AngleDelta.y * 0.05 * swayIntensity + self.RecoilPos.z) * Right(ang)
	else
		pos = pos - (self.BlendPos.x - self.AngleDelta.y * 0.05 * swayIntensity - self.RecoilPos.z) * Right(ang)
	end

	pos = pos + (self.BlendPos.y - self.FireMove - self.RecoilPos.y) * Forward(ang)
	pos = pos + (self.BlendPos.z - self.AngleDelta.p * 0.1 * swayIntensity - self.RecoilPos.z) * Up(ang)

	-- then we apply the viewmodel movement
	RotateAroundAxis(ang, Right(ang), CurAngMod.x + self.BipodAng[1])

	if not self.ViewModelFlip then
		RotateAroundAxis(ang, Up(ang), CurAngMod.y + self.BipodAng[2])
		RotateAroundAxis(ang, Forward(ang), CurAngMod.z + self.BipodAng[3])
	else
		RotateAroundAxis(ang, Up(ang), CurAngMod.y + self.BipodAng[2])
		RotateAroundAxis(ang, Forward(ang), CurAngMod.z + self.BipodAng[3])
	end

	if not self.ViewModelFlip then
		pos = pos + (CurPosMod.x + self.BipodPos[1] + self.RecoilAng.y) * Right(ang)
	else
		pos = pos + (CurPosMod.x + self.BipodPos[1] + self.RecoilAng.y) * Right(ang)
	end

	pos = pos + (CurPosMod.y + self.BipodPos[2]) * Forward(ang)
	pos = pos + (CurPosMod.z + self.BipodPos[3]) * Up(ang)

	self.CW_VM:SetPos(pos)
	self.CW_VM:SetAngles(ang)
end

function SWEP:performViewmodelMovement()
	CT = UnPredictedCurTime()
	vm = self.CW_VM

	self.Cycle = vm:GetCycle()
	self.Sequence = vm:GetSequenceName(vm:GetSequence())
	self.IsReloading = (self.Sequence == self.Animations.reload or self.Sequence == self.Animations.reload_empty or self.Sequence == self.Animations.reload_start or self.Sequence == self.Animations.reload_end)

	if not self.IsReloading then
		self.IsReloading = self.Sequence:find("insert")
	end

	if not self.IsReloading then
		self.IsFiddlingWithSuppressor = self.Sequence:find("silencer")
	end

	local FT = FrameTime()
	local EA = EyeAngles()

	self:processSwayDelta(FT, EA)

	EA = EyeAngles()
	self:processFOVChanges(FT)

	vel = GetVelocity(self.Owner)
	len = Length(vel)
	ws = self.Owner:GetWalkSpeed()

	PosMod, AngMod = Vec0 * 1, Vec0 * 1
	mod2 = 1

	veldepend.roll = math.Clamp((vel:DotProduct(EA:Right()) * 0.04) * len / ws, -5, 5)

	self.reloadingM203 = self:isReloadingM203()

	if self.dt.State == CW_AIMING then
		-- aim VM movement modifiers
		mod2 = 1

		-- check if we can use regular sights with the current grenade type, and if we can, let us do so
		-- also check for existing ammo in the M203, if there is none, resort to regular ironsights
		self.properM203Sights = CustomizableWeaponry.grenadeTypes:canUseProperSights(self.Grenade40MM)

		if self.dt.M203Active and not self.properM203Sights and self.M203Chamber then
			TargetPos, TargetAng = self.M203Pos * 1, self.M203Ang * 1
		else
			TargetPos, TargetAng = self.AimPos * 1, self.AimAng * 1
		end

		self.ApproachSpeed = math.Approach(self.ApproachSpeed, 10, FT * 300)
		CurPosMod, CurAngMod = Vec0 * 1, Vec0 * 1
	elseif self.dt.State == CW_ACTION or self.dt.State == CW_HOLSTER_START or self.dt.State == CW_HOLSTER_END then
		-- ladder climb/swim movement modifiers
		TargetPos, TargetAng = self.SwimPos * 1, self.SwimAng * 1
		self.ApproachSpeed = math.Approach(self.ApproachSpeed, 5, FT * 100)
	elseif self.dt.State == CW_RUNNING or (((len > ws * self.RunStateVelocity and self.Owner:KeyDown(IN_SPEED)) or len > ws * 3 or (self.ForceRunStateVelocity and len > self.ForceRunStateVelocity)) and self.Owner:OnGround()) then
		local runMod = 1

		-- if we're running and our movement speed is fit for run movement speed

		if ((self.IsReloading or self.IsFiddlingWithSuppressor) and self.Cycle < 0.9) or self.reloadingM203 then
			-- if we're reloading, then go back to the 'gun forward' position
			TargetPos, TargetAng = Vec0 * 1, Vec0 * 1
			self.ApproachSpeed = math.Approach(self.ApproachSpeed, 4, FT * 100)
			runMod = 0.25
		else
			-- check whether sprinting is enabled or not, in the case it isn't, don't use any running positions

			if self.SprintingEnabled then
				TargetPos, TargetAng = self.SprintPos * 1, self.SprintAng * 1
			else
				TargetPos, TargetAng = Vec0 * 1, Vec0 * 1
			end

			self.ApproachSpeed = math.Approach(self.ApproachSpeed, 5, FT * 200)
		end

		-- move the weapon away if the player is looking up/down while sprinting

		if not self.DisableSprintViewSimulation then
			local verticalOffset = EyeAngles().p * 0.4 * runMod
			TargetAng.x = TargetAng.x - math.Clamp(verticalOffset, 0, 10) * self.SprintViewNormals.x
			TargetAng.y = TargetAng.y - verticalOffset * 0.5 * self.SprintViewNormals.y
			TargetAng.z = TargetAng.z - verticalOffset * 0.2 * self.SprintViewNormals.z
			--TargetAng.z = TargetAng.z - verticalOffset * 0.2]]--
			TargetPos.z = TargetPos.z + math.Clamp(verticalOffset * 0.2, -10, 3)
		end

		rs = self.Owner:GetRunSpeed()
		mul = math.Clamp(len / rs, 0, 1)

		self.RunTime = self.RunTime + FT * (7.5 + math.Clamp(len / 120, 0, 5))
		local runTime = self.RunTime
		sin1 = math.sin(runTime) * mul
		cos1 = math.cos(runTime) * mul
		tan1 = math.atan(cos1 * sin1, cos1 * sin1) * mul

		if self.MoveType == 1 then -- pistol VM movement
			AngMod.x = AngMod.x + tan1 * 0.2 * self.ViewModelMovementScale * mul
			AngMod.y = AngMod.y - cos1 * 3 * self.ViewModelMovementScale * mul
			AngMod.z = AngMod.z + cos1 * 3 * self.ViewModelMovementScale * mul
			PosMod.x = PosMod.x - sin1 * 0.8 * self.ViewModelMovementScale * mul
			PosMod.y = PosMod.y + tan1 * 1.8 * self.ViewModelMovementScale * mul
			PosMod.z = PosMod.z + tan1 * 1.5 * self.ViewModelMovementScale * mul
		else
			AngMod.x = AngMod.x + tan1 * self.ViewModelMovementScale * mul
			AngMod.y = AngMod.y - sin1 * -10 * self.ViewModelMovementScale * mul
			AngMod.z = AngMod.z + cos1 * 4 * self.ViewModelMovementScale * mul

			PosMod.x = PosMod.x - cos1 * 0.6 * self.ViewModelMovementScale * mul
			PosMod.y = PosMod.y + sin1 * 0.6 * self.ViewModelMovementScale * mul
			PosMod.z = PosMod.z + tan1 * 2 * self.ViewModelMovementScale * mul
		end
	elseif self.dt.State == CW_PRONE_BUSY then
		TargetPos, TargetAng = Vec0 * 1, Vec0 * 1

		local mul = 1

		self.RunTime = self.RunTime + FT * 5
		local runTime = self.RunTime
		sin1 = math.sin(runTime) * mul
		cos1 = math.cos(runTime) * mul
		tan1 = math.atan(cos1 * sin1, cos1 * sin1) * mul

		AngMod.x = AngMod.x + tan1 * 5 * self.ViewModelMovementScale * mul
		AngMod.y = AngMod.y - cos1 * -3 * self.ViewModelMovementScale * mul
		AngMod.z = AngMod.z + sin1 * 4 * self.ViewModelMovementScale * mul

		PosMod.x = PosMod.x - sin1 * 0.25 * self.ViewModelMovementScale * mul
		PosMod.y = PosMod.y + cos1 * self.ViewModelMovementScale * mul
		PosMod.z = PosMod.z + tan1 * 0.25 * self.ViewModelMovementScale * mul
	elseif self.dt.State == CW_PRONE_MOVING then
		local modifier = self.ViewModelFlip and -1 or 1

		TargetPos, TargetAng = self.PronePos * 1, self.ProneAng * 1

		local proneVelMul = len / self.BusyProneVelocity * self.ViewmodelProneVelocityMultiplier
		local mul = math.Clamp(len / ws, 0, 1) * proneVelMul

	-- SWEP.PronePos = Vector(6.717, -6.273, -6.577)
	-- SWEP.ProneAng = Vector(5.618, 49.055, -15.311)

	-- SWEP.PronePos = Vector(-7.397, -2.497, -1.551)
	-- SWEP.ProneAng = Vector(5.618, -49.056, -15.311)

		self.RunTime = self.RunTime + FT * (6 + math.Clamp(len / 120, 0, 5))
		local runTime = self.RunTime
		sin1 = math.sin(runTime) * mul
		cos1 = math.cos(runTime) * mul
		tan1 = math.atan(cos1 * sin1, cos1 * sin1) * mul

		AngMod.x = AngMod.x - tan1 * 30 * self.ViewModelMovementScale * mul * modifier
		AngMod.y = AngMod.y + cos1 * -30 * self.ViewModelMovementScale * mul * modifier
		AngMod.z = AngMod.z - sin1 * 20 * self.ViewModelMovementScale * mul

		PosMod.x = PosMod.x + cos1 * -5 * self.ViewModelMovementScale * mul * modifier
		PosMod.y = PosMod.y - cos1 * 3 * self.ViewModelMovementScale * mul
		PosMod.z = PosMod.z + tan1 * 20 * self.ViewModelMovementScale * mul * modifier

		local runMod = 1

		local verticalOffset = EyeAngles().p * 0.4 * runMod
		TargetAng.x = TargetAng.x - math.min(0, math.Clamp(verticalOffset, 0, 10) * self.SprintViewNormals.x)
		TargetAng.y = TargetAng.y - math.min(0, verticalOffset * 0.5 * self.SprintViewNormals.y)
		TargetAng.z = TargetAng.z - math.min(0, verticalOffset * 0.2 * self.SprintViewNormals.z)
		--TargetAng.z = TargetAng.z - verticalOffset * 0.2]]--
		TargetPos.z = TargetPos.z + math.min(0,math.Clamp(verticalOffset * 0.2, -10, 3))
	else
		if self.dt.State == CW_CUSTOMIZE then
			TargetPos, TargetAng = self.CustomizePos * 1, self.CustomizeAng * 1
		else
			if self.dt.Safe then
				TargetPos, TargetAng = self.SprintPos * 1, self.SprintAng * 1
			else
				if GetConVarNumber("cw_alternative_vm_pos") > 0 and self.AlternativePos then
					TargetPos, TargetAng = self.AlternativePos * 1, self.AlternativeAng * 1
				else
					TargetPos, TargetAng = Vec0 * 1, Vec0 * 1
				end
			end

			self.NearWall = false

			if self.NearWallEnabled then
				-- get anything in front of us, if there is something, enable near wall
				td.start = self.Owner:GetShootPos()
				td.endpos = td.start + self.Owner:EyeAngles():Forward() * 30
				td.filter = self.Owner

				tr = util.TraceLine(td)

				if tr.Hit or (IsValid(tr.Entity) and not tr.Entity:IsPlayer()) then
					--TargetPos.y = TargetPos.y - math.Clamp(30 * (1 - tr.Fraction), 0, 15)
					--TargetPos.y = TargetPos.y - math.Clamp(30 * (1 - tr.Fraction), 0, 15)

					TargetPos = self.SprintPos * (1 - tr.Fraction)
					TargetAng = self.SprintAng * (1 - tr.Fraction)
					self.NearWall = true
				end
			end
		end

		self.ApproachSpeed = math.Approach(self.ApproachSpeed, 10, FT * 100)

		--if tr.Hit then
			--self.NearWall = true

		--end
	end

	if self.M203AngDiff then
		TargetPos.x = TargetPos.x + self.M203AngDiff.y * 0.3
		TargetPos.y = TargetPos.y + self.M203AngDiff.p * -0.5
		TargetPos.z = TargetPos.z - self.M203AngDiff.p * 0.5

		TargetAng.x = TargetAng.x - self.M203AngDiff.y * 2
		TargetAng.y = TargetAng.y - self.M203AngDiff.p * 2
	end

	if len < 10 or not self.Owner:OnGround() then
		-- idle viewmodel movement

		if self.dt.State != CW_AIMING and not self:isBipodIdle() then
			cos1, sin1 = math.cos(CT), math.sin(CT)
			tan = math.atan(cos1 * sin1, cos1 * sin1)

			AngMod.x = AngMod.x + tan * 1.15
			AngMod.y = AngMod.y + cos1 * 0.4
			AngMod.z = AngMod.z + tan

			PosMod.y = PosMod.y + tan * 0.2 * mod2
		end
	elseif len > 10 and len < ws * 1.2 then
		-- walk viewmodel movement
		mod = 6 + ws / 130
		mul = math.Clamp(len / ws, 0, 1)

		if self.dt.State == CW_AIMING then
			mul = mul * self.AimMobilitySpreadMod * 0.666
		end

		sin1 = math.sin(CT * mod) * mul
		cos1 = math.cos(CT * mod) * mul
		tan1 = math.atan(cos1 * sin1, cos1 * sin1) * mul

		AngMod.x = AngMod.x + self:scaleMovement(tan1 * 2, mod2) -- up/down
		AngMod.y = AngMod.y + self:scaleMovement(cos1, mod2) -- left/right
		AngMod.z = AngMod.z + self:scaleMovement(sin1, mod2) -- rotation left/right
		PosMod.x = PosMod.x + self:scaleMovement(sin1 * 0.1, mod2) -- left/right

		if self.MoveType == 1 and self.FireMode == "safe" then
			PosMod.y = PosMod.y + self:scaleMovement(tan1 * 0.6, mod2) -- forward/backwards
		else
			PosMod.y = PosMod.y + self:scaleMovement(tan1 * 0.4, mod2) -- forward/backwards
		end

		PosMod.z = PosMod.z - self:scaleMovement(tan1 * 0.1, mod2) -- up/down

		-- apply viewmodel tilt when moving and not aiming based on velocity dot product relative to aim direction
		local norm = math.Clamp(vel:GetNormal():DotProduct(self.Owner:EyeAngles():Forward()), 0, 1)

		if self.dt.State ~= CW_AIMING then
			TargetPos[2] = TargetPos[2] - mul * 0.8 * norm
			TargetPos[3] = TargetPos[3] - mul * 0.5 * norm
		end
	end

	if (self.dt.BipodDeployed and self.DeployAngle and self.dt.State == CW_IDLE) and not self:isReloading() then
		local dif1 = math.AngleDifference(self.DeployAngle.y, EA.y)
		local dif2 = math.AngleDifference(self.DeployAngle.p, EA.p)
		TargetPos[3] = TargetPos[3] - 2
		TargetPos[2] = TargetPos[2] + 2

		if CT < self.BipodMoveTime then
			self.BipodPos[1] = math.Approach(self.BipodPos[1], dif1 * self.BipodSensitivity.x, FT * 50)
			self.BipodPos[3] = math.Approach(self.BipodPos[3], dif2 * self.BipodSensitivity.z, FT * 50)

			self.BipodAng[1] = math.Approach(self.BipodAng[1], dif2 * self.BipodSensitivity.p, FT * 50)
			self.BipodAng[3] = math.Approach(self.BipodAng[3], dif2 * self.BipodSensitivity.r, FT * 50)
		else
			self.BipodPos[1] = dif1 * self.BipodSensitivity.x
			self.BipodPos[3] = dif2 * self.BipodSensitivity.z

			self.BipodAng[1] = dif2 * self.BipodSensitivity.p
			--self.BipodAng[2] = dif1 * -0.1
			self.BipodAng[3] = dif2 * self.BipodSensitivity.r
		end
	else
		self.BipodPos = LerpVectorCW20(FT * 10, self.BipodPos, Vec0)
		self.BipodAng = LerpVectorCW20(FT * 10, self.BipodAng, Vec0)
		self.BipodMoveTime = CT + 0.2
	end

	FT = FrameTime()

	if self.ViewModelFlip then
		TargetAng.z = TargetAng.z - veldepend.roll
	else
		TargetAng.z = TargetAng.z + veldepend.roll
	end

	local newTargetPos, newTargetAng = CustomizableWeaponry.callbacks.processCategory(self, "adjustViewmodelPosition", TargetPos, TargetAng)

	TargetPos = newTargetPos or TargetPos
	TargetAng = newTargetAng or TargetAng

	-- the position of the weapon (running/walking/aiming)
	self.BlendPos = LerpVectorCW20(FT * self.ApproachSpeed, self.BlendPos, TargetPos)
	self.BlendAng = LerpVectorCW20(FT * self.ApproachSpeed, self.BlendAng, TargetAng)

	-- the viewmodel movement position of the weapon
	CurPosMod = LerpVectorCW20(FT * 10, CurPosMod, PosMod)
	CurAngMod = LerpVectorCW20(FT * 10, CurAngMod, AngMod)

	-- the 'fake' weapon recoil
	if self.LuaViewmodelRecoil then
		-- the 'fake' viewmodel weapon recoil should only be reset if the weapon in question is using it
		self.RecoilRestoreSpeed = math.Approach(self.RecoilRestoreSpeed, 10, FT * 10)
		self.RecoilPos2 = LerpVectorCW20(FT * self.RecoilRestoreSpeed * 0.9, self.RecoilPos2, self.RecoilPos)
		self.RecoilAng2 = LerpAngleCW20(FT * self.RecoilRestoreSpeed * 0.9, self.RecoilAng2, self.RecoilAng)

		self.RecoilPosDiff.x = self.RecoilPos.x - self.RecoilPos2.x
		self.RecoilPosDiff.y = self.RecoilPos.y - self.RecoilPos2.y
		self.RecoilPosDiff.z = self.RecoilPos.z - self.RecoilPos2.z

		self.RecoilAngDiff.x = self.RecoilAng.x - self.RecoilAng2.x
		self.RecoilAngDiff.y = self.RecoilAng.y - self.RecoilAng2.y
		self.RecoilAngDiff.z = self.RecoilAng.z - self.RecoilAng2.z

		self.RecoilPos = LerpVectorCW20(FT * self.RecoilRestoreSpeed, self.RecoilPos, Vec0 + self.RecoilPosDiff)
		self.RecoilAng = LerpAngleCW20(FT * self.RecoilRestoreSpeed, self.RecoilAng, Ang0 + self.RecoilAngDiff)
	end

	-- the 'fake' viewmodel recoil from shooting while aiming
	self.FireMove = LerpCW20(FT * 15, self.FireMove, 0)
end
