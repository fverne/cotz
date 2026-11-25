local OPTIC_APERTURES = include("cotz/optic_apertures.lua")

SWEP.BlendPos = Vector(0, 0, 0)
SWEP.BlendAng = Vector(0, 0, 0)
SWEP.OldDelta = Angle(0, 0, 0)
SWEP.AngleDelta = Angle(0, 0, 0)
SWEP.AngleDelta2 = Angle(0, 0, 0)
SWEP.AngDiff = Angle(0, 0, 0)
SWEP.BipodPos = Vector(0, 0, 0)
SWEP.BipodAng = Vector(0, 0, 0)
SWEP.RecoilPos = Vector(0, 0, 0)
SWEP.RecoilAng = Angle(0, 0, 0)
SWEP.RecoilPos2 = Vector(0, 0, 0)
SWEP.RecoilAng2 = Angle(0, 0, 0)
SWEP.RecoilPosDiff = Vector(0, 0, 0)
SWEP.RecoilAngDiff = Angle(0, 0, 0)
SWEP.GrenadePos = Vector(0, 0, -10)
SWEP.BipodMoveTime = 0
SWEP.BlurAmount = 0
SWEP.FireMove = 0
SWEP.ViewModelMovementScale = 1
SWEP.RecoilRestoreSpeed = 5
SWEP.Sequence = ""
SWEP.Cycle = 0
SWEP.NoStockShells = true
SWEP.NoStockMuzzle = true
SWEP.grenadeTime = 0
SWEP.HUD_3D2DAlpha = 255

-- TS means Telescopic Sight
SWEP.TSGlass = Material("cw2/attachments/lens/rt")

local Vec0, Ang0 = Vector(0, 0, 0), Angle(0, 0, 0)
local TargetPos, TargetAng, cos1, sin1, tan, ws, rs, mod, EA, delta, mul, vm, muz, muz2, tr, att, CT
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

-- since these are often-called functions (and somewhat expensive), we make local references to them to reduce the overhead as much as possible
local ManipulateBonePosition, ManipulateBoneAngles = reg.Entity.ManipulateBonePosition, reg.Entity.ManipulateBoneAngles

-- default GMod LerpVector/LerpAngle generate a new vector/angle object every time they're called (wtf garry ???), so I wrote my own to keep garbage generation low
local function LerpVectorCW20(delta, start, finish)
	delta = delta > 1 and 1 or delta

	start.x = start.x + delta * (finish.x - start.x)
	start.y = start.y + delta * (finish.y - start.y)
	start.z = start.z + delta * (finish.z - start.z)

	return start
end

local function LerpAngleCW20(delta, start, finish)
	delta = delta > 1 and 1 or delta

	start.p = start.p + delta * (finish.p - start.p)
	start.y = start.y + delta * (finish.y - start.y)
	start.r = start.r + delta * (finish.r - start.r)

	return start
end

function SWEP:initRenderTarget(size)
	self.ScopeRT = GetRenderTarget("cw2_scope_rt_" .. size, size, size, false)
end

function SWEP:getRenderTargetSize()
	return self.ScopeRT:GetMappingWidth()
end

function SWEP:GetTracerOrigin()
	if self.dt.State == CW_AIMING and self.SimulateCenterMuzzle then
		return self.CenterPos
	end

	local muzzle = self:getMuzzlePosition()

	return muzzle and muzzle.Pos or self:GetPos()
end

function SWEP:FireAnimationEvent(pos, ang, event, name)
	if event == 5003 then -- disable default muzzleflashes in third person
		return true
	end
end

function SWEP:getAnimSeek()
	local seek = self.CW_VM:GetCycle() * self.CW_VM:SequenceDuration()
	local cut = self.ActiveReloadChamberCut
	if cut and self.ReloadChamberCutPassed then
		seek = seek - (cut.to - cut.from)
	end

	return seek
end

function SWEP:CreateShell(sh)
	if self.Owner:ShouldDrawLocalPlayer() or self.NoShells then
		return
	end

	sh = self.Shell or sh
	vm = self.CW_VM

	att = vm:GetAttachment(2)

	if att then
		if self.ShellDelay then
			CustomizableWeaponry.actionSequence.new(self, self.ShellDelay, nil, function()
				att = vm:GetAttachment(2)

				local dir

				if self.InvertShellEjectAngle then
					dir = -att.Ang:Forward()
				else
					dir = att.Ang:Forward()
				end

				if self.ShellPosOffset then
					att.Pos = att.Pos + self.ShellPosOffset.x * att.Ang:Right()
					att.Pos = att.Pos + self.ShellPosOffset.y * att.Ang:Forward()
					att.Pos = att.Pos + self.ShellPosOffset.z * att.Ang:Up()
				end

				CustomizableWeaponry.shells.make(self, att.Pos + dir * self.ShellOffsetMul, EyeAngles(), dir * 200, 0.6, 10)
			end)
		else
			att = vm:GetAttachment(2)

			local dir

			if self.InvertShellEjectAngle then
				dir = -att.Ang:Forward()
			else
				dir = att.Ang:Forward()
			end

			if self.ShellPosOffset then
				att.Pos = att.Pos + self.ShellPosOffset.x * att.Ang:Right()
				att.Pos = att.Pos + self.ShellPosOffset.y * att.Ang:Forward()
				att.Pos = att.Pos + self.ShellPosOffset.z * att.Ang:Up()
			end

			CustomizableWeaponry.shells.make(self, att.Pos + dir * self.ShellOffsetMul, EyeAngles(), dir * 200, 0.6, 10)
		end
	end
end

function SWEP:offsetBoltBone()
	if self.DontMoveBoltOnHipFire and self.dt.State ~= CW_AIMING then
		return
	end

	self.CurBoltBonePos = self.BoltShootOffset * 1
	ManipulateBonePosition(self.CW_VM, self.BoltBoneID, self.CurBoltBonePos)
end

local Vec50 = Vector(-50, 0, 0)

function SWEP:offsetM203ArmBone(restore)
	if not self.M203ArmBone then
		self.M203ArmBone = self.AttachmentModelsVM.md_m203.ent:LookupBone("Bip01 L Clavicle")
	end

	if restore then
		ManipulateBonePosition(self.AttachmentModelsVM.md_m203.ent, self.M203ArmBone, Vec0)
	else
		ManipulateBonePosition(self.AttachmentModelsVM.md_m203.ent, self.M203ArmBone, Vec50)
	end
end

function SWEP:setBoltBonePosition(pos)
	self.CurBoltBonePos = pos
	ManipulateBonePosition(self.CW_VM, self.BoltBoneID, pos)
end

function SWEP:buildBoneTable()
	local vm = self.CW_VM

	for i = 0, vm:GetBoneCount() - 1 do
		local boneName = vm:GetBoneName(i)
		local bone

		if boneName then
			bone = vm:LookupBone(boneName)
		end

		-- save the bone indexes and bone names so that we don't have to get it again when we're offsetting them
		self.vmBones[i + 1] = {boneName = boneName, bone = bone, curPos = Vector(0, 0, 0), curAng = Angle(0, 0, 0), targetPos = Vector(0, 0, 0), targetAng = Angle(0, 0, 0)}
	end
end

function SWEP:setupBoneTable()
	self.vmBones = {}

	-- this sets up a table for things like bone position/angle manipulation
	-- we do everything in advance to avoid expensive function calls (such as LookupBone) later on
	self:buildBoneTable()

	self:setupBoltBone()

	if self.BaseArm then
		self.BaseArmBone = self.CW_VM:LookupBone(self.BaseArm)
	end
end

function SWEP:setupBoltBone(boltName)
	boltName = boltName or self.BoltBone

	if boltName then
		self.BoltBoneID = self.CW_VM:LookupBone(boltName)
		self.CurBoltBonePos = Vector(0, 0, 0)
	end
end

function SWEP:resetM203Anim()
	local vm = self.AttachmentModelsVM.md_m203.ent
	vm:ResetSequence(self.M203Anims.ready_to_idle)
	vm:SetCycle(0)

	self.curM203Anim = self.M203Anims.ready_to_idle
end

function SWEP:setM203Anim(animName, cycle, speed)
	cycle = cycle or 0
	speed = speed or 1

	local vm = self.AttachmentModelsVM.md_m203.ent
	vm:ResetSequence(animName)
	vm:SetCycle(cycle)
	vm:SetPlaybackRate(speed)

	self.curM203Anim = animName
end

function SWEP:offsetBones()
	local vm = self.CW_VM

	-- if the animation cycle is past reload/draw no offset time of bones, then it falls within the bone offset timeline
	local FT = FrameTime()

	if self.AttachmentModelsVM then
		local can = false
		local canModifyBones = self.AttachmentModelsVM.md_foregrip or self.AttachmentModelsVM.md_m203 or self.ForegripOverride

		local foregrip = (self.AttachmentModelsVM.md_foregrip and self.AttachmentModelsVM.md_foregrip.active)
		local m203 = (self.AttachmentModelsVM.md_m203 and self.AttachmentModelsVM.md_m203.active)

		if foregrip or self.ForegripOverride then
			if self.Sequence == self.Animations.reload or self.Sequence == self.Animations.reload_empty then
				if self.wasEmpty then
					if self.Cycle >= self.ForeGripOffsetCycle_Reload_Empty then
						can = true
					end
				else
					if self.Cycle >= self.ForeGripOffsetCycle_Reload then
						can = true
					end
				end
			elseif self.Sequence == self.Animations.draw then
				if self.Cycle >= self.ForeGripOffsetCycle_Draw then
					can = true
				end
			else
				can = true
			end
		end

		if m203 and not self.dt.M203Active then
			if self.Sequence == self.Animations.reload or self.Sequence == self.Animations.reload_empty then
				if self.wasEmpty then
					if self.Cycle >= self.M203OffsetCycle_Reload_Empty then
						can = true
					end
				else
					if self.Cycle >= self.M203OffsetCycle_Reload then
						can = true
					end
				end
			elseif self.Sequence == self.Animations.draw then
				if self.Cycle >= self.M203OffsetCycle_Draw then
					can = true
				end
			else
				can = true
			end
		end

		local targetTbl = false

		-- select the desired offset table
		if can then
			if self.ForegripOverride then
				if self.ForegripOverridePos then
					local desiredTarget = self.ForegripOverridePos[self.ForegripParent]

					if desiredTarget then
						targetTbl = desiredTarget
						canModifyBones = true
					end
				end
			else
				if foregrip or self.ForegripOverride then
					targetTbl = self.ForeGripHoldPos
				elseif m203 then
					targetTbl = self.M203HoldPos
				end
			end
		end

		if not targetTbl then
			can = false
		end

		if m203 then
			if self.dt.M203Active or UnPredictedCurTime() < self.M203Time then
				self:offsetM203ArmBone(true)
				ManipulateBonePosition(vm, self.BaseArmBone, self.BaseArmBoneOffset)

				return
			else
				if self.curM203Anim ~= self.M203Anims.ready_to_idle then
					self:resetM203Anim()
				end

				self:offsetM203ArmBone(false)
			end
		end

		if canModifyBones then
			for k, v in pairs(self.vmBones) do
				if can then
					local index = targetTbl[v.boneName]

					v.curPos = LerpVectorCW20(FT * 15, v.curPos, (index and index.pos or Vec0))
					v.curAng = LerpAngleCW20(FT * 15, v.curAng, (index and index.angle or Ang0))
				else
					v.curPos = LerpVectorCW20(FT * 15, v.curPos, Vec0)
					v.curAng = LerpAngleCW20(FT * 15, v.curAng, Ang0)
				end

				ManipulateBonePosition(vm, v.bone, v.curPos)
				ManipulateBoneAngles(vm, v.bone, v.curAng)
			end
		end
	end

	if self.BoltBoneID then
		local can = true
		local recoverySpeed = self.BoltBonePositionRecoverySpeed

		if self.BoltShootOffset then
			if self.HoldBoltWhileEmpty then
				if self:Clip1() == 0 then
					if self.Sequence ~= self.EmptyBoltHoldAnimExclusion then
						if (self.IsReloading and self.Cycle > 0.98) or not self.IsReloading then
							can = false
							self.CurBoltBonePos = self.BoltShootOffset * 1
						end
					end
				end
			end

			ManipulateBonePosition(vm, self.BoltBoneID, self.CurBoltBonePos)
		end

		if self.OffsetBoltDuringNonEmptyReload then
			if self.IsReloading and self.Cycle <= self.StopReloadBoneOffset and self:Clip1() > 0 then
				self.CurBoltBonePos = math.ApproachVector(self.CurBoltBonePos, self.BoltReloadOffset, FT * self.ReloadBoltBonePositionMoveSpeed)
				can = false
			else
				if can then
					recoverySpeed = self.ReloadBoltBonePositionRecoverySpeed
				end
			end

			ManipulateBonePosition(vm, self.BoltBoneID, self.CurBoltBonePos)
		end

		if can then
			self.CurBoltBonePos = math.ApproachVector(self.CurBoltBonePos, Vec0, FT * recoverySpeed)
		end
	end
end

-- LookupAttachment returns 0 for a missing name, and 0 is not a usable attachment. Weapons that never
-- named their muzzle fall back to the conventional name, then the configured index.
local function getMuzzleAttachmentIndex(weapon, model)
	local index = model:LookupAttachment(weapon.MuzzleAttachmentName)
	if index > 0 then return index end

	index = model:LookupAttachment("muzzle")
	if index > 0 then return index end

	return weapon.MuzzleAttachment
end

-- The flash uses only the muzzle attachment's position and is aimed along the view. Attaching the particle
-- to the point would also follow its axes, and the Anomaly models orient them differently from the legacy
-- CW2 models (forward points sideways, up points back toward the stock), which throws the flash off the gun.
function SWEP:CreateMuzzle()
	if self.Owner:ShouldDrawLocalPlayer() then
		return
	end

	local model = self.CW_VM

	if not IsValid(model) then
		return
	end

	model:StopParticles()

	local muzzle = model:GetAttachment(getMuzzleAttachmentIndex(self, model))

	if not muzzle then
		return
	end

	local viewAngles = EyeAngles()
	local pos = muzzle.Pos

	local posMod = self.MuzzlePosMod

	if posMod then
		pos = pos + viewAngles:Right() * posMod.x + viewAngles:Forward() * posMod.y + viewAngles:Up() * posMod.z
	end

	-- Adding velocity 'simulates' attaching the effect to the moving muzzle.
	local effectPos = pos + self.Owner:GetVelocity() * 0.03

	if self.dt.State == CW_AIMING and (self.SimulateCenterMuzzle or self:canUseSimpleTelescopics()) then
		effectPos = effectPos + viewAngles:Forward() * 70 - viewAngles:Up() * 3
	end

	if self.dt.Suppressed then
		if self.MuzzleEffectSupp and not self.NoSilMuz then
			ParticleEffect(self.MuzzleEffectSupp, effectPos, viewAngles, model)
		end

		return
	end

	if self.MuzzleEffect then
		ParticleEffect(self.MuzzleEffect, effectPos, viewAngles, model)
	end

	local dlight = DynamicLight(self:EntIndex())

	dlight.r = 255
	dlight.g = 218
	dlight.b = 74
	dlight.Brightness = 4
	dlight.Pos = pos + self.Owner:GetAimVector() * 3
	dlight.Size = 96
	dlight.Decay = 128
	dlight.DieTime = CurTime() + FrameTime()
end

function SWEP:getMuzzleModel()
	return self.WMEnt and self.WMEnt or self
end

function SWEP:getWorldAttachments() -- used for third person
	return self.WorldMuzzleAttachmentID, self.WorldShellEjectionAttachmentID
end

SWEP.shellBoundBox = {Vector(-0.5, -0.15, -0.5), Vector(0.5, 0.15, 0.5)}

function CW_MakeFakeShell(ent, shell, pos, ang, vel, time, removetime, shellscale)
	if not shell or not pos or not ang then
		return
	end

	local t = ent._shellTable

	if not t then
		return
	end

	vel = vel or Vector(0, 0, -100)
	vel = vel + VectorRand() * 5
	time = time or 0.5
	removetime = removetime or 5
	shellscale = shellscale or 1

	local ent = ClientsideModel(t.m, RENDERGROUP_BOTH)
	ent:SetPos(pos)
	ent:PhysicsInitBox(ent.shellBoundBox[1], ent.shellBoundBox[2])
	ent:SetAngles(ang)
	ent:SetModelScale(shellscale, 0)
	ent:SetMoveType(MOVETYPE_VPHYSICS)
	ent:SetSolid(SOLID_VPHYSICS)
	ent:SetCollisionGroup(COLLISION_GROUP_DEBRIS)

	local phys = ent:GetPhysicsObject()
	phys:SetMaterial("gmod_silent")
	phys:SetMass(10)
	phys:SetVelocity(vel)

	timer.Simple(time, function()
		if t.s then
			ent:EmitSound(table.Random(t.s), 35, 100)
		end
	end)

	SafeRemoveEntityDelayed(ent, removetime)
end

function SWEP:createManagedCModel(...)
	local ent = ClientsideModel(...)
	CustomizableWeaponry.cmodels:add(ent, self)

	return ent
end

function SWEP:_setupAttachmentModel(data)
	data.origPos = data.pos
	data.origAng = data.angle

	-- create the attachment model
	data.ent = self:createManagedCModel(data.model, RENDERGROUP_BOTH)
	data.ent:SetNoDraw(true)

	-- make it active if it's supposed to be active, or not, if nothing is defined
	data.active = data.active or false

	-- scale the model if there is a scaling vector
	-- keep in mind that I scale it once upon creation, in order to not call Matrix and EnableMatrix over and over again each frame
	if data.size then
		data.matrix = Matrix()

		data.matrix:Scale(data.size)
		data.ent:EnableMatrix("RenderMultiply", data.matrix)
	end

	-- get the bone ID in advance so that we don't have to look it up every frame for every attachment that's active on the weapon
	data._bone = self.CW_VM:LookupBone(data.bone)

	-- set bodygroups in case they are defined
	if data.bodygroups then
		for main, sec in pairs(data.bodygroups) do
			data.ent:SetBodygroup(main, sec)
		end
	end

	data.ent:SetupBones()
end

local function getAttachmentPoint(model, name, fallback)
	local index = model:LookupAttachment(name)
	return model:GetAttachment(index > 0 and index or fallback)
end

local function getMuzzleDistance(model, muzzle)
	local bone = model:LookupBone("wpn_body")
	local matrix = bone and model:GetBoneMatrix(bone)

	if matrix then
		return muzzle.Pos:Distance(matrix:GetTranslation())
	end
end

local function sampleViewmodelMounts(weapon)
	local vm = weapon.CW_VM
	local idle = weapon.Animations and weapon.Animations.idle
	if type(idle) == "table" then
		idle = idle[1]
	end

	-- Initialization samples the idle pose before the draw animation starts.
	if idle then
		vm:ResetSequence(idle)
		vm:SetCycle(0)
		vm:InvalidateBoneCache()
	end

	vm:SetupBones()
	local muzzle = getAttachmentPoint(vm, weapon.MuzzleAttachmentName, weapon.MuzzleAttachment)
	if not muzzle then return end

	weapon.cotzWorldAttachmentSource = {
		muzzle = muzzle,
		distance = getMuzzleDistance(vm, muzzle),
		bones = {},
	}
end

-- Rail-mounted sights on a moving slide bone can name a stationary bone in staticBone. The slide's idle pose
-- is stored relative to that bone, so the sight stays put while the slide cycles.
local function recordStaticMount(weapon, data)
	data._staticRel, data._staticBone = nil, nil
	if not data.staticBone or not data._bone then return end

	local staticBone = weapon.CW_VM:LookupBone(data.staticBone)
	local staticMatrix = staticBone and weapon.CW_VM:GetBoneMatrix(staticBone)
	local boneMatrix = weapon.CW_VM:GetBoneMatrix(data._bone)
	if not staticMatrix or not boneMatrix then return end

	data._staticBone = staticBone
	data._staticRel = staticMatrix:GetInverseTR() * boneMatrix
end

local function recordViewmodelMount(weapon, data)
	recordStaticMount(weapon, data)

	local source = weapon.cotzWorldAttachmentSource
	local bone = data._bone
	if not source or not bone or source.bones[bone] then return end

	local pos, ang = weapon:getBoneOrientation(bone)
	if not pos then return end

	pos, ang = WorldToLocal(pos, ang, source.muzzle.Pos, source.muzzle.Ang)
	source.bones[bone] = {pos = pos, ang = ang}
end

function SWEP:setupAttachmentModels()
	if self.DefaultSightModel then
		local sight = self:createManagedCModel(self.DefaultSightModel, RENDERGROUP_BOTH)
		if IsValid(sight) then
			sight:SetNoDraw(true)
			sight:SetParent(self.CW_VM)
			sight:AddEffects(EF_BONEMERGE)
			self.defaultSight = sight
		end
	end

	if self.AttachmentModelsVM then
		sampleViewmodelMounts(self)

		for k, v in pairs(self.AttachmentModelsVM) do
			if v.models then
				for key, data in ipairs(v.models) do
					self:_setupAttachmentModel(data)
					recordViewmodelMount(self, data)
				end
			else
				self:_setupAttachmentModel(v)
				recordViewmodelMount(self, v)
			end
		end
	end
end

SWEP.ApproachSpeed = 10
SWEP.RunTime = 0
local SP = game.SinglePlayer()
local PosMod, AngMod = Vector(0, 0, 0), Vector(0, 0, 0)
local CurPosMod, CurAngMod = Vector(0, 0, 0), Vector(0, 0, 0)
local veldepend = {pitch = 0, yaw = 0, roll = 0}
local mod2 = 0
local EA2

function SWEP:scaleMovement(val, mod)
	return val * self.ViewModelMovementScale * mod
end

function SWEP:createCustomVM(mdl)
	self.CW_VM = self:createManagedCModel(mdl, RENDERGROUP_BOTH)
	self.CW_VM:SetNoDraw(true)
	self.CW_VM:SetupBones()

	if self.ViewModelFlip then
		local mtr = Matrix()
		mtr:Scale(Vector(1, -1, 1))

		self.CW_VM:EnableMatrix("RenderMultiply", mtr)
	end
end

function SWEP:createGrenadeModel()
	self.CW_GREN = self:createManagedCModel("models/weapons/v_cw_fraggrenade.mdl", RENDERGROUP_BOTH)
	self.CW_GREN:SetNoDraw(true)
	self.CW_GREN:SetupBones()
end

function SWEP:PreDrawViewModel()
	-- this will make the 'default' viewmodel invisible, since we're using a custom VM entity
	--render.SetBlend(0)
end

-- this draws the custom viewmodel
function SWEP:drawViewModel()
	if not self.CW_VM then
		return
	end

	--if self.offsetFunc then
		--self.offsetFunc(self) -- :)
	--end

	self:offsetBones()

	local FT = FrameTime()

	self.LuaVMRecoilIntensity = math.Approach(self.LuaVMRecoilIntensity, 0, FT * 10 * self.LuaVMRecoilLowerSpeed)
	self.LuaVMRecoilLowerSpeed = math.Approach(self.LuaVMRecoilLowerSpeed, 1, FT * 2)

	self:applyOffsetToVM()
	self:_drawViewModel()
	self:drawGrenade()
end

function SWEP:drawGrenade()
	if CurTime() > self.grenadeTime then
		return
	end

	if self.CW_GREN:GetCycle() >= 0.98 then
		return
	end

	local pos, ang = EyePos(), EyeAngles()

	self.GrenadePos.z = LerpCW20(FrameTime() * 10, self.GrenadePos.z, 0)

	pos = pos + ang:Up() * self.GrenadePos.z
	pos = pos + ang:Forward() * 2

	self.CW_GREN:SetPos(pos)
	self.CW_GREN:SetAngles(ang)
	self.CW_GREN:FrameAdvance(FrameTime())

	cam.IgnoreZ(true)
		self.CW_GREN:DrawModel()
	cam.IgnoreZ(false)
end

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

	local hideModel = self.MoveWepAwayWhenAiming and not self:GetCotzIntegratedScope()
	if CT > self.AimTime and self.dt.State == CW_AIMING and (hideModel or self:canUseSimpleTelescopics()) then
		if not self.dt.M203Active or not self.M203Chamber
			or CustomizableWeaponry.grenadeTypes:canUseProperSights(self.Grenade40MM) then
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

local cw_customhud_ammo = GetConVar("cw_customhud_ammo")

local function advanceReloadChamberCut(weapon, vm)
	local cut = weapon.ActiveReloadChamberCut
	if not cut or weapon.ReloadChamberCutPassed then return end

	local duration = vm:SequenceDuration()
	local cycle = vm:GetCycle()
	if duration <= 0 or cycle * duration < cut.from then return end

	vm:SetCycle(math.min(1, cycle + (cut.to - cut.from) / duration))
	vm:InvalidateBoneCache()
	weapon.ReloadChamberCutPassed = true
end

function SWEP:_drawViewModel()
	-- draw the viewmodel

	if self.ViewModelFlip then
		render.CullMode(MATERIAL_CULLMODE_CW)
	end

	local POS = EyePos() - self.CW_VM:GetPos()

	self.CW_VM:FrameAdvance(FrameTime())
	advanceReloadChamberCut(self, self.CW_VM)
	self.CW_VM:SetupBones()
	self:CenterCotzOptic()
	self.CW_VM:DrawModel()

	if self.ViewModelFlip then
		render.CullMode(MATERIAL_CULLMODE_CCW)
	end

	-- draw the attachments
	self:drawAttachments()

	-- draw the customization menu
	self:drawInteractionMenu()

	-- draw the unique scope behavior if it is defined
	if self.reticleFunc then
		self.reticleFunc(self)
	end
end

SWEP.HUD_3D2D_MagColor = Color(255, 255, 255, 255)
SWEP.HUD_3D2d_ReserveColor = Color(255, 255, 255, 255)

local bullet = surface.GetTextureID("cw2/gui/bullet")

function SWEP:getReserveAmmoText()
	local shouldOverride, text, targetColor = CustomizableWeaponry.callbacks.processCategory(self, "overrideReserveAmmoText")

	if shouldOverride then
		return text, shouldOverride, targetColor
	end

	return self.Owner:GetAmmoCount(self.Primary.Ammo), shouldOverride, targetColor
end

function SWEP:draw3D2DHUD()
	local muzzle = self:getMuzzlePosition()

	if not muzzle then
		return
	end

	local position
	local ang = EyeAngles()
	ang:RotateAroundAxis(ang:Right(), 90)
	ang:RotateAroundAxis(ang:Up(), -90)

	cam.Start3D()
	position = muzzle.Pos:ToScreen()
	cam.End3D()

	local x, y = position.x + 90, position.y
	local FT = FrameTime()

	if self.dt.State == CW_AIMING or (self.InactiveWeaponStates[self.dt.State] and not (self.IsReloading and self.Cycle <= 0.98)) then
		self.HUD_3D2DAlpha = math.Approach(self.HUD_3D2DAlpha, 0, FT * 1000)
	else
		self.HUD_3D2DAlpha = math.Approach(self.HUD_3D2DAlpha, 255, FT * 1000)
	end

	self.HUDColors.white.a = self.HUD_3D2DAlpha
	self.HUDColors.black.a = self.HUD_3D2DAlpha

	local mag = self:Clip1()

	self.HUDColors.black.a = self.HUD_3D2DAlpha

	local reloadProgress = self:getReloadProgress()

	-- if our mag has not much ammo or we're reloading, make the text red
	if mag <= self.Primary.ClipSize * 0.25 or reloadProgress then
		self.HUD_3D2D_MagColor = LerpColor(FT * 10, self.HUD_3D2D_MagColor, self.HUDColors.red)
	else
		self.HUD_3D2D_MagColor = LerpColor(FT * 10, self.HUD_3D2D_MagColor, self.HUDColors.white)
	end

	self.HUD_3D2D_MagColor.a = self.HUD_3D2DAlpha

	-- only show the reload progress if we're reloading
	if reloadProgress then
		draw.ShadowText("RELOADING " .. reloadProgress .. "%", "CW_HUD32", x, y + 50, self.HUD_3D2D_MagColor, self.HUDColors.black, 2, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
	else
		draw.ShadowText(self:getMagCapacity() .. " / " .. self:getReserveAmmoText(), "CW_HUD32", x, y + 50, self.HUD_3D2D_MagColor, self.HUDColors.black, 2, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
	end

	if self.BulletDisplay and self.BulletDisplay > 0 then
		local bulletDisplayAlpha = self.HUD_3D2DAlpha
		local bulletDisplayOffset = 0

		if #self.FireModes > 1 then -- if we have more than 1 firemode for the current weapon, we don't let the firemode display fade and instead reposition it a bit to let the player see what firemode he's using while aiming
			local aiming = self.dt.State == CW_AIMING

			bulletDisplayAlpha = aiming and 255 or self.HUD_3D2DAlpha
			bulletDisplayOffset = aiming and -255 or 0
		end

		surface.SetTexture(bullet)
		surface.SetDrawColor(0, 0, 0, bulletDisplayAlpha)

		for i = 1, self.BulletDisplay do
			surface.DrawTexturedRectRotated(x + 25 + bulletDisplayOffset, y + 38 + (i - 1) * 12, 20, 16, 180)
		end

		surface.SetTexture(bullet)
		surface.SetDrawColor(255, 255, 255, bulletDisplayAlpha)

		for i = 1, self.BulletDisplay do
			surface.DrawTexturedRectRotated(x + 23 + bulletDisplayOffset, y + 38 + (i - 1) * 12 - 2, 20, 16, 180)
		end
	end

	draw.ShadowText(self.FireModeDisplay, "CW_HUD24", x, y + 72, self.HUDColors.white, self.HUDColors.black, 2, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)

	local grenades = self.Owner:GetAmmoCount("Frag Grenades")

	if grenades > 0 then
		draw.ShadowText(grenades .. "x FRAG", "CW_HUD24", x, y + 94, self.HUDColors.white, self.HUDColors.black, 2, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
	end

	self.HUDColors.white.a = 255
	self.HUDColors.black.a = 255

	if self.dt.M203Active then
		-- display the text when we either have a round in, or have no rounds but aren't aiming
		if (not self.M203Chamber and self.dt.State ~= CW_AIMING) or self.M203Chamber then
			if not self.M203Chamber then
				draw.ShadowText("M203 EMPTY", "CW_HUD24", x, y + -70, self.HUDColors.red, self.HUDColors.black, 1, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
			else
				draw.ShadowText("M203 READY", "CW_HUD24", x, y + -70, self.HUDColors.white, self.HUDColors.black, 1, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
			end

			local curGrenade = CustomizableWeaponry.grenadeTypes.getGrenadeText(self)

			draw.ShadowText(self.Owner:GetAmmoCount("40MM") .. "x RESERVE", "CW_HUD20", x, y + -40, self.HUDColors.white, self.HUDColors.black, 1, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
			draw.ShadowText("TYPE" .. curGrenade, "CW_HUD20", x, y + -10, self.HUDColors.white, self.HUDColors.black, 1, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
		end
	end

	CustomizableWeaponry.callbacks.processCategory(self, "drawTo3D2DHUD")
end

function SWEP:lengthAngle(ang)
	ang.p, ang.y, ang.r = math.abs(ang.p), math.abs(ang.y), math.abs(ang.r)
	return ang
end

-- Normalized offsets from the texture center to the dot or chevron tip.
local RETICLE_TEXTURE_OFFSETS = {
	dot = {0.5 / 32, 0.5 / 32},
	eotech = {0.24 / 128, -0.18 / 128},
	delta = {0.5 / 64, 0.5 / 64},
	kobra = {0.5 / 64, 0.5 / 64},
}
local RETICLE_DISTANCE = 100
local RETICLE_FADE = 0.13
-- Source's MATERIAL_VAR_IGNOREZ material flag; Garry's Mod does not expose it as a global.
local MATERIAL_FLAG_IGNOREZ = 32768
local depthFreeReticles = {}

-- Toggling cam.IgnoreZ inside the viewmodel pass leaves the bonemerged c_hands, drawn after it, behind the gun.
-- The reticle material skips the depth test itself instead, so the pass's depth state is never changed.
local function getDepthFreeReticle(attachment)
	local material = attachment._reticle
	if not depthFreeReticles[material] then
		material:SetInt("$flags", bit.bor(material:GetInt("$flags") or 0, MATERIAL_FLAG_IGNOREZ))
		depthFreeReticles[material] = true
	end

	return material
end

function SWEP:DrawCotzReticleSprite(attachment, aimPos, aimAng, pattern)
	if not self:isAiming() then return end
	if not attachment.keepReticleAfterShot and not self:isReticleActive() then return end

	local size = attachment._reticleSize
	local difference = self:getDifferenceToAimPos(aimPos, aimAng, pattern == "dot" and 1 or size)
	if difference <= 0.9 or difference >= 1.1 then return end

	local angles = EyeAngles()
	local direction = self.freeAimOn and self:getReticleAngles():Forward() or angles:Forward()
	local offset = RETICLE_TEXTURE_OFFSETS[pattern]
	local position = EyePos() + direction * RETICLE_DISTANCE
		- angles:Right() * (offset[1] * size) + angles:Up() * (offset[2] * size)
	local color = self:getSightColor(attachment.name)
	local distance = math.min(math.abs(difference - 1) * math.sqrt(2), RETICLE_FADE)
	color.a = (1 - distance / RETICLE_FADE) * 255

	render.SetMaterial(getDepthFreeReticle(attachment))
	render.DrawSprite(position, size, size, color)
	render.DrawSprite(position, size, size, color)
end

function SWEP:getDifferenceToAimPos(pos, ang, vertDependance, horDependance, dependMod)
	dependMod = dependMod or 1
	vertDependance = vertDependance or 1
	horDependance = horDependance or 1

	local sway = (self.AngleDelta.p * 0.65 * vertDependance + self.AngleDelta.y * 0.75 * horDependance) * 0.05 * dependMod
	local pos = self.BlendPos - pos
	local ang = self.BlendAng - ang
	ang.z = 0

	pos = pos:Length()
	ang = ang:Length() - sway

	local dependance = pos + ang

	return 1 - dependance
end

local blurMaterial = Material("pp/toytown-top")
blurMaterial:SetTexture("$fbtexture", render.GetScreenEffectTexture())

function SWEP:drawBlur()
	local x, y = ScrW(), ScrH()

	cam.Start2D()
		surface.SetMaterial(blurMaterial)
		surface.SetDrawColor(255, 255, 255, 255)

		for i = 1, self.BlurAmount do
			render.UpdateScreenEffectTexture()
			surface.DrawTexturedRect(0, 0, x, y * 2)
		end

	cam.End2D()
end

-- cache the convar objects
local cw_blur_reload = GetConVar("cw_blur_reload")
local cw_blur_customize = GetConVar("cw_blur_customize")
local cw_blur_aim_telescopic = GetConVar("cw_blur_aim_telescopic")
local cw_simple_telescopics = GetConVar("cw_simple_telescopics")

function SWEP:processBlur()
	-- if we're aiming and have enabled telescopic sight aim blur, blur our stuff
	local FT = FrameTime()

	local can = false

	if self.IsReloading and self.Cycle <= 0.9 and cw_blur_reload:GetInt() >= 1 then
		can = true
	elseif self.dt.State == CW_CUSTOMIZE and cw_blur_customize:GetInt() >= 1 then
		can = true
	elseif self.dt.State == CW_AIMING and self.BlurOnAim and cw_blur_aim_telescopic:GetInt() >= 1 and cw_simple_telescopics:GetInt() <= 0 then
		if self.dt.M203Active and self.M203Chamber then
			can = false
		else
			if self.ActualSightPos then
				if self.AimPos == self.ActualSightPos then
					can = true
				end
			else
				can = true
			end
		end
	end

	if can then
		self.BlurAmount = math.Approach(self.BlurAmount, 10, FT * 15)
	else
		self.BlurAmount = math.Approach(self.BlurAmount, 0, FT * 30)
	end

	if self.BlurAmount > 0 then
		self:drawBlur()
	end
end

function SWEP:PostDrawViewModel()
	render.SetBlend(1)
end

function SWEP:getMuzzlePosition()
	if not IsValid(self.CW_VM) then return end

	return self.CW_VM:GetAttachment(self.MuzzleAttachment)
end

-- interaction menu, AKA weapon interaction menu
function SWEP:drawInteractionMenu()
	local FT = FrameTime()

	if self.dt.State == CW_CUSTOMIZE then
		self.CustomizeMenuAlpha = math.Approach(self.CustomizeMenuAlpha, 1, FT * 5)
	else
		self.CustomizeMenuAlpha = math.Approach(self.CustomizeMenuAlpha, 0, FT * 15)
	end

	if self.CustomizeMenuAlpha > 0 then
		local att = self:getMuzzlePosition()
		if not att then return end
		local ang = EyeAngles()
		ang:RotateAroundAxis(ang:Right(), 90)
		ang:RotateAroundAxis(ang:Up(), -90)
		ang:RotateAroundAxis(ang:Right(), -10)

		cam.Start3D2D(att.Pos, ang, self.CustomizationMenuScale)
			-- disable depth checks

			cam.IgnoreZ(true)
				CustomizableWeaponry.interactionMenu.draw(self)
			cam.IgnoreZ(false)
		cam.End3D2D()
	end
end

function SWEP:getBoneOrientation(boneId)
	local m = self.CW_VM:GetBoneMatrix(boneId)

	if m then
		local pos, ang = m:GetTranslation(), m:GetAngles()

		-- fix model inversion
		if self.ViewModelFlip then
			ang.r = -ang.r
		end

		return pos, ang
	end
end

local function offsetAttachment(pos, ang, offset, rotation)
	pos = pos + ang:Forward() * offset.x + ang:Right() * offset.y + ang:Up() * offset.z
	ang:RotateAroundAxis(ang:Up(), rotation.y)
	ang:RotateAroundAxis(ang:Right(), rotation.p)
	ang:RotateAroundAxis(ang:Forward(), rotation.r)

	return pos, ang
end

function SWEP:getStaticMountOrientation(data)
	local matrix = self.CW_VM:GetBoneMatrix(data._staticBone)
	if not matrix then return end

	matrix = matrix * data._staticRel
	local ang = matrix:GetAngles()

	-- fix model inversion, as in getBoneOrientation
	if self.ViewModelFlip then
		ang.r = -ang.r
	end

	return matrix:GetTranslation(), ang
end

local function attachmentOrientation(weapon, data, offset)
	local pos, ang
	if data._staticRel then
		pos, ang = weapon:getStaticMountOrientation(data)
	end
	if not pos and data._bone then
		pos, ang = weapon:getBoneOrientation(data._bone)
	end
	if not pos then return end

	return offsetAttachment(pos, ang, offset or data.pos, data.angle)
end

local ADS_CENTER_BLEND_START = 0.5
local ADS_CENTER_BLEND_END = 0.05
local ADS_CENTER_EPSILON = 0.0001

function SWEP:CenterCotzOptic()
	local model = self.cotzAimModel
	local aperture = model and OPTIC_APERTURES[model.model]
	if not aperture or not model.active or not self:isAiming() or self.freeAimOn then return end
	if not self.ActualSightPos or self.AimPos ~= self.ActualSightPos then return end

	local offset = (self.BlendPos - self.ActualSightPos):Length()
	local weight = math.Clamp((ADS_CENTER_BLEND_START - offset) / (ADS_CENTER_BLEND_START - ADS_CENTER_BLEND_END), 0, 1)
	if weight == 0 then return end

	local pos, ang = attachmentOrientation(self, model)
	if not pos then return end

	-- Use the same mount pose as the optic draw, including an anchored slide mount.
	local center = LocalToWorld(model.size and aperture * model.size or aperture, Ang0, pos, ang)
	local view = EyeAngles()
	local forward = view:Forward()
	local fromEye = center - EyePos()
	local depth = fromEye:Dot(forward)
	if depth <= 0 then return end

	-- Shift the whole viewmodel sideways and vertically to put the aperture on the view ray.
	local correction = (fromEye - forward * depth) * weight
	if correction:LengthSqr() <= ADS_CENTER_EPSILON * ADS_CENTER_EPSILON then return end

	local vm = self.CW_VM
	vm:SetPos(vm:GetPos() - correction)
	vm:InvalidateBoneCache()
	vm:SetupBones()
end

function SWEP:_drawAttachmentModel(data, offset)
	local model = data.ent
	local pos, ang = attachmentOrientation(self, data, offset)
	if not pos then return end

	model:SetPos(pos)
	model:SetAngles(ang)

	if data.animated then
		model:FrameAdvance(FrameTime())
		model:SetupBones()
	end

	model:DrawModel()
end

function SWEP:_drawAttachmentModels(data)
	if data.models then
		for key, modelData in ipairs(data.models) do
			self:_drawAttachmentModels(modelData)
		end
	else
		self:_drawAttachmentModel(data)
	end
end

function SWEP:drawAttachments()
	if self.DefaultSightModel and self.AimPos == self.CurIronsightPos and IsValid(self.defaultSight) then
		self.defaultSight:SetupBones()
		self.defaultSight:DrawModel()
	end

	if not self.AttachmentModelsVM then
		return false
	end

	local preview = self.cotzAttachmentPreview
	local previewData = preview and (preview.data or self.AttachmentModelsVM[preview.id])
	if previewData and IsValid(previewData.ent) and previewData._bone
		and self.CW_VM:GetBoneMatrix(previewData._bone) then
		self:_drawAttachmentModel(previewData, preview.pos)
	end

	for k, v in pairs(self.AttachmentModelsVM) do
		if v.active and (not preview or (k ~= preview.id and not preview.slot[k])) then
			self:_drawAttachmentModels(v)
		end
	end

	-- call various functions that attachments may (or may not) add (such as laser sights)
	for k, v in pairs(self.elementRender) do
		v(self)
	end

	return true
end

function SWEP:processSwayDelta(deltaTime, eyeAngles)
	if self:isBipodIdle() then
		self.AngleDelta = LerpAngle(math.Clamp(deltaTime * 10, 0, 1), self.AngleDelta, Ang0)
	else
		delta = Angle(eyeAngles.p, eyeAngles.y, 0) - self.OldDelta
		delta.p = math.Clamp(delta.p, -10, 10)
		local FT = FrameTime()

		if self.SwayInterpolation == "linear" then
			self.AngleDelta = LerpAngle(math.Clamp(FT * 15, 0, 1), self.AngleDelta, delta)
			self.AngleDelta.y = math.Clamp(self.AngleDelta.y, -15, 15)
		else
			delta.p = math.Clamp(delta.p, -5, 5)
			self.AngleDelta2 = LerpAngle(math.Clamp(FT * 12, 0, 1), self.AngleDelta2, self.AngleDelta)
			self.AngDiff.p = (self.AngleDelta.p - self.AngleDelta2.p)
			self.AngDiff.y = (self.AngleDelta.y - self.AngleDelta2.y)
			self.AngleDelta = LerpAngle(math.Clamp(FT * 10, 0, 1), self.AngleDelta, delta + self.AngDiff)
			self.AngleDelta.y = math.Clamp(self.AngleDelta.y, -25, 25)
		end

		self.OldDelta.p = eyeAngles.p
		self.OldDelta.y = eyeAngles.y
	end
end

function SWEP:processFOVChanges(deltaTime)
	if self.dt.State == CW_AIMING then
		if self.dt.M203Active and self.M203Chamber then
			self.CurVMFOV = LerpCW20(deltaTime * 10, self.CurVMFOV, 60)
		else
			self.CurVMFOV = LerpCW20(deltaTime * 10, self.CurVMFOV, self.AimViewModelFOV)
		end
	else
		self.CurVMFOV = LerpCW20(deltaTime * 10, self.CurVMFOV, self.ViewModelFOV_Orig)
	end

	self.ViewModelFOV = self.CurVMFOV
end

local cw_alternative_vm_pos = GetConVar("cw_alternative_vm_pos")

local STUDIO_LOOPING_FLAG = 1

-- Looping idle sequences contain a built-in breathing sway. Hold them at their rest pose while aiming
-- so the sights stay steady, and let them play again once the player stops aiming.
function SWEP:suppressIdleSwayWhileAiming(vm)
	local idle = self.Animations and self.Animations.idle
	local sequenceID = vm:GetSequence()
	local sequence = vm:GetSequenceName(sequenceID)
	local isIdle = sequence == idle or (type(idle) == "table" and table.HasValue(idle, sequence))

	if not isIdle then
		self.idleSwayFrozen = nil
		return
	end

	-- Some weapons use the final pose of a one-shot reload as their idle.
	local model = vm:GetModel()
	if self.idleSwaySequenceID ~= sequenceID or self.idleSwayModel ~= model then
		self.idleSwaySequenceID = sequenceID
		self.idleSwayModel = model
		local info = vm:GetSequenceInfo(sequenceID)
		self.idleSwayLoops = info and bit.band(info.flags, STUDIO_LOOPING_FLAG) ~= 0
	end

	if not self.idleSwayLoops then
		self.idleSwayFrozen = nil
		return
	end

	if self.dt.State == CW_AIMING then
		vm:SetCycle(0)
		vm:SetPlaybackRate(0)
		self.idleSwayFrozen = true
	elseif self.idleSwayFrozen then
		vm:SetPlaybackRate(1)
		self.idleSwayFrozen = nil
	end
end

function SWEP:performViewmodelMovement()
	CT = UnPredictedCurTime()
	vm = self.CW_VM

	-- PostDrawViewModel can run before the custom viewmodel exists, e.g. while the weapon is still
	-- being equipped. drawViewModel skips the same case.
	if not IsValid(vm) then
		return
	end

	self:suppressIdleSwayWhileAiming(vm)

	self.Cycle = vm:GetCycle()
	self.Sequence = vm:GetSequenceName(vm:GetSequence())
	self.IsReloading = (self.Sequence == self.Animations.reload or self.Sequence == self.Animations.reload_empty or self.Sequence == self.Animations.reload_start or self.Sequence == self.Animations.reload_end)

	if not self.IsReloading then
		self.IsReloading = self.Sequence == self.Animations.insert
			or self.Sequence == self.Animations.reload_start_empty
			or self.Sequence == self.Animations.reload_end_empty
			or self.Sequence == self.Animations.insert_empty
			or self.Sequence:find("insert")
	end

	if not self.IsReloading then
		self.IsFiddlingWithSuppressor = self.Sequence:find("silencer")
	end

	local FT = FrameTime()
	local EA = EyeAngles()

	self:processSwayDelta(FT, EA)

	EA = EyeAngles()
	self:processFOVChanges(FT)

	local vel = GetVelocity(self.Owner)
	local len = Length(vel)
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
		local tan1 = math.atan(cos1 * sin1, cos1 * sin1) * mul

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
		local tan1 = math.atan(cos1 * sin1, cos1 * sin1) * mul

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
		local tan1 = math.atan(cos1 * sin1, cos1 * sin1) * mul

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
			if not self.Owner:IsWepRaised() then
				TargetPos, TargetAng = self.SprintPos * 1, self.SprintAng * 1
			else
				if cw_alternative_vm_pos:GetInt() > 0 and self.AlternativePos then
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
		local tan1 = math.atan(cos1 * sin1, cos1 * sin1) * mul

		AngMod.x = AngMod.x + self:scaleMovement(tan1 * 2, mod2) -- up/down
		AngMod.y = AngMod.y + self:scaleMovement(cos1, mod2) -- left/right
		AngMod.z = AngMod.z + self:scaleMovement(sin1, mod2) -- rotation left/right
		PosMod.x = PosMod.x + self:scaleMovement(sin1 * 0.1, mod2) -- left/right

		if self.MoveType == 1 and not self.Owner:IsWepRaised() then
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

function SWEP:makeVMRecoil(mod)
	mod = mod or 1

	-- make the recoil get stronger as the player spends more time firing the weapon non-stop
	local overallMul = 0.25 + 0.75 * self.LuaVMRecoilIntensity * self.LuaVMRecoilMod

	-- get the offset multipliers
	local vertMul = math.Rand(0.3, 0.4) * overallMul * 2 * mod
	local forwardMul = math.Rand(0.75, 0.85) * overallMul  * mod
	local sideMul = math.Rand(-0.2, 0.2) * overallMul * 0.5 * mod
	local rollMul = math.Rand(-0.25, 0.25) * overallMul * 5 * mod

	-- clamp the maximum kick
	local strength = math.Clamp(self.Recoil, 0.3, 1.8)

	self.RecoilRestoreSpeed = 5
	self.RecoilPos.x = strength * sideMul * self.LuaVMRecoilAxisMod.hor
	self.RecoilPos.y = strength * forwardMul * 2 * self.LuaVMRecoilAxisMod.forward --math.Rand(self.Recoil * 0.75, self.Recoil)
	self.RecoilPos.z = strength * vertMul * self.LuaVMRecoilAxisMod.vert

	self.RecoilAng.p = strength * vertMul * 5 * self.LuaVMRecoilAxisMod.pitch
	self.RecoilAng.y = strength * sideMul * self.LuaVMRecoilAxisMod.hor --math.Rand(-self.Recoil, self.Recoil) * 0.1
	self.RecoilAng.r = strength * rollMul * self.LuaVMRecoilAxisMod.roll --math.Rand(-self.Recoil, self.Recoil) * 0.1
end

function SWEP:GetViewModelPosition(pos, ang)
	pos = pos + ang:Forward() * -100 -- move the default viewmodel away
	return pos, ang
end

local function getWorldAttachmentSelection(weapon)
	local replicated = weapon:GetWorldAttachments()
	if replicated == weapon.cotzWorldAttachmentSnapshot then
		return weapon.cotzWorldAttachmentSelection
	end

	local active = {}
	for name in replicated:gmatch("%S+") do
		active[name] = true
		local attachment = CustomizableWeaponry.registeredAttachmentsSKey[name]
		if weapon.SightWithRail and attachment and attachment.isSight and not attachment.withoutRail then
			active.md_rail = true
		end
	end

	weapon.cotzWorldAttachmentSnapshot = replicated
	weapon.cotzWorldAttachmentSelection = active
	return active
end

local function worldAttachmentOffset(default, overrides, name, active)
	local options = overrides and overrides[name]
	if options then
		for dependency, offset in pairs(options) do
			if active[dependency] then return offset end
		end
	end

	return default
end

local function drawWorldAttachment(weapon, data, name, active, muzzle, scale)
	if data.models then
		for _, model in ipairs(data.models) do
			drawWorldAttachment(weapon, model, name, active, muzzle, scale)
		end
		return
	end

	local bone = weapon.cotzWorldAttachmentSource.bones[data._bone]
	if not bone then return end

	local model = data.worldEnt
	if not IsValid(model) then
		model = ClientsideModel(data.model, RENDERGROUP_BOTH)
		if not IsValid(model) then return end

		model:SetNoDraw(true)
		CustomizableWeaponry.cmodels:add(model, weapon)
		data.worldEnt = model

		data.worldScale = nil

		if data.bodygroups then
			for group, value in pairs(data.bodygroups) do
				model:SetBodygroup(group, value)
			end
		end
	end

	if data.worldScale ~= scale then
		local matrix = Matrix()
		matrix:Scale(data.size and data.size * scale or Vector(scale, scale, scale))
		model:EnableMatrix("RenderMultiply", matrix)
		data.worldScale = scale
	end

	local offset = worldAttachmentOffset(data.origPos, weapon.AttachmentPosDependency, name, active)
	local rotation = worldAttachmentOffset(data.origAng, weapon.AttachmentAngDependency, name, active)
	local pos, ang = offsetAttachment(bone.pos, Angle(bone.ang.p, bone.ang.y, bone.ang.r), offset, rotation)

	-- Optional fit of the viewmodel muzzle frame inside the worldmodel's (WorldAttachmentShift, WorldAttachmentAngle).
	pos = pos * scale
	local shift, turn = weapon.WorldAttachmentShift, weapon.WorldAttachmentAngle
	if shift or turn then
		pos, ang = LocalToWorld(pos, ang, shift or vector_origin, turn or angle_zero)
	end

	pos, ang = LocalToWorld(pos, ang, muzzle.Pos, muzzle.Ang)

	model:SetPos(pos)
	model:SetAngles(ang)
	model:DrawModel()
end

function SWEP:DrawWorldAttachments(worldModel)
	local source = self.cotzWorldAttachmentSource
	if not source then return end

	local active = getWorldAttachmentSelection(self)
	if not next(active) then return end

	local muzzle
	if self.WorldAttachmentBone then
		local bone = worldModel:LookupBone(self.WorldAttachmentBone)
		local matrix = bone and worldModel:GetBoneMatrix(bone)
		if matrix then
			muzzle = {Pos = matrix:GetTranslation(), Ang = matrix:GetAngles()}
		end
	else
		muzzle = getAttachmentPoint(worldModel, "muzzle", self.WorldMuzzleAttachmentID)
	end
	if not muzzle then return end

	-- The Anomaly pairs have the same muzzle axes, but their viewmodels can be larger. A weapon that measured
	-- its own pair (docs/attachments/weapon_fit.py) names the scale; the muzzle-to-wpn_body estimate is wrong
	-- when that bone is not at the same place of both models.
	local scale = self.WorldAttachmentScale or 1
	local distance = not self.WorldAttachmentScale and source.distance and getMuzzleDistance(worldModel, muzzle)
	if distance and source.distance > 0 then
		scale = math.Clamp(distance / source.distance, 0.5, 1.5)
	end

	for name in pairs(active) do
		local data = self.AttachmentModelsVM[name]
		if data then
			drawWorldAttachment(self, data, name, active, muzzle, scale)
		end
	end
end

function SWEP:DrawWorldModel()
	if (IsValid(self.Owner)) then
		if not self.Owner:IsWepRaised() then
			if self.CHoldType != self.RunHoldType then
				self:SetHoldType(self.RunHoldType)
				self.CHoldType = self.RunHoldType
			end
		else
			if self.dt.State == CW_RUNNING or self.dt.State == CW_ACTION then
				if self.CHoldType != self.RunHoldType then
					self:SetHoldType(self.RunHoldType)
					self.CHoldType = self.RunHoldType
				end
			else
				if self.CHoldType != self.NormalHoldType then
					self:SetHoldType(self.NormalHoldType)
					self.CHoldType = self.NormalHoldType
				end
			end
		end
	end

	if self.DrawTraditionalWorldModel then
		local owner = self:GetOwner()

		-- A parented world model needs bone merging to follow the owner's hand.
		if IsValid(owner) and self:GetParent() == owner and not self:IsEffectActive(EF_BONEMERGE) then
			self:AddEffects(EF_BONEMERGE)
			self:InvalidateBoneCache()
		end

		self:DrawModel()
		self:DrawWorldAttachments(self)
	else
		local wm = self.WMEnt

		-- Clientside models can disappear while the weapon entity remains valid.
		if not IsValid(wm) and self.WM then
			wm = ClientsideModel(self.WM, RENDERGROUP_BOTH)

			if IsValid(wm) then
				wm:SetNoDraw(true)
				CustomizableWeaponry.cmodels:add(wm, self)
				self.WMEnt = wm
			end
		end

		if IsValid(wm) then
			if IsValid(self.Owner) then
				local pos, ang = GetBonePosition(self.Owner, self.Owner:LookupBone("ValveBiped.Bip01_R_Hand"))

				if pos and ang then
					RotateAroundAxis(ang, Right(ang), self.WMAng[1])
					RotateAroundAxis(ang, Up(ang), self.WMAng[2])
					RotateAroundAxis(ang, Forward(ang), self.WMAng[3])

					pos = pos + self.WMPos[1] * Right(ang)
					pos = pos + self.WMPos[2] * Forward(ang)
					pos = pos + self.WMPos[3] * Up(ang)

					wm:SetRenderOrigin(pos)
					wm:SetRenderAngles(ang)
					wm:DrawModel()
					self:DrawWorldAttachments(wm)
				end
			else
				wm:SetRenderOrigin(self:GetPos())
				wm:SetRenderAngles(self:GetAngles())
				wm:DrawModel()
				self:DrawWorldAttachments(wm)
				wm:DrawShadow()
			end
		else
			self:DrawModel()
			self:DrawWorldAttachments(self)
		end
	end
end
