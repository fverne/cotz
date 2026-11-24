AddCSLuaFile()

-- Shared behaviour for the artifact detectors, using the viewmodels from the
-- "Devices of Anomaly Redone" workshop addon (3769766699). The display logic follows
-- S.T.A.L.K.E.R. Anomaly's CSimpleDetector, CAdvancedDetector and CEliteDetector,
-- while detection radius and beep cadence keep the original COTZ behaviour.

SWEP.Base = "weapon_base"
SWEP.PrintName = "Artifact Detector"
SWEP.Category = "S.T.A.L.K.E.R. Detector Sweps"
SWEP.Author = "COTZ"
SWEP.Instructions = "Left click to throw a bolt. Right click for a short throw."
SWEP.Spawnable = false
SWEP.AdminSpawnable = false
SWEP.IsCotzDetector = true

SWEP.Slot = 4
SWEP.SlotPos = 1
-- Helix lowers "slam" to "normal" (device at the side); raised, it holds the detector forward at chest height.
SWEP.HoldType = "slam"
SWEP.ViewModelFOV = 70
SWEP.ViewModelFlip = false
-- The Devices of Anomaly Redone viewmodels carry ValveBiped arm bones for the player's c_hands.
SWEP.UseHands = true

SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "none"
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "none"

-- Concrete detectors configure these.
SWEP.DetectRadius = 300
SWEP.DisplayMode = "none"
SWEP.ExtraArtifactModels = nil
SWEP.EmissionBodygroup = nil
SWEP.OverlayLifts = nil
SWEP.HiddenBones = nil
SWEP.BoltReleaseCycle = 0
SWEP.WorldModelOffset = {
	bone = "ValveBiped.Bip01_R_Hand",
	pos = Vector(4.675, 1.557, -2.597),
	ang = Angle(-106.364, -167.144, 12.857),
}

local SCAN_INTERVAL = 0.5
local MIN_BEEP_INTERVAL = 0.1
local BEEP_SOUND = "stalkerdetectors/echo.wav"
local BEEP_LEVEL = 70

local BOLT_COOLDOWN = 3
local BOLT_LIFETIME = 12
local BOLT_SPAWN_OFFSET = 10
local BOLT_SPIN = 500
local BOLT_THROW_SOUND = "weapons/slam/throw.wav"

local MOVE_SPEED_SQR = 20 * 20
local SPRINT_SPEED_SQR = 150 * 150

-- Echo: Anomaly flashes light_bone_2 after each beep; light_bone_1 is the power light.
local FLASH_BONE = "light_bone_2"
local FLASH_FRACTION = 0.5

-- Bear: Anomaly rotates screen_bone about its local Y axis in 24 steps of 15 degrees,
-- easing towards the target with angle_inertion_var(PI/4, 4*PI, 2*PI).
local ARROW_BONE = "screen_bone"
local ARROW_STEP = 15
local ARROW_MIN_SPEED = 45
local ARROW_MAX_SPEED = 720
local ARROW_CONTROL_SPEED = 2 * math.pi

-- Veles: the radar printed on the cover_power screen texture, in that bone's local units.
-- Its origin is the user's position and its outer ring corresponds to DetectRadius.
local SCREEN_BONE = "cover_power"
local SCREEN_ORIGIN = Vector(0.035, -0.77, 0.01)
local SCREEN_RADIUS = 1.375
local SCREEN_SCALE = 0.005
local SCREEN_DOT_SIZE = 20
local SCREEN_DOT_COLOR = Color(200, 255, 120, 255)

local VISIBLE_SCALE = Vector(1, 1, 1)
local HIDDEN_SCALE = Vector(0, 0, 0)

local ARTIFACT_MODELS = {
	["models/nasca/etherealsrp_artifacts/urchin.mdl"] = true, -- Urchin
	["models/lostsignalproject/items/artefacts/needles.mdl"] = true, -- Thorn
	["models/lostsignalproject/items/artefacts/electra_flash.mdl"] = true, -- Sparkler
	["models/lostsignalproject/items/artefacts/slug.mdl"] = true, -- Slug
	["models/lostsignalproject/items/artefacts/sparkler.mdl"] = true, -- Slime
	["models/lostsignalproject/items/artefacts/kislushka.mdl"] = true, -- Mycelia
	["models/lostsignalproject/items/artefacts/moonlight.mdl"] = true, -- Moonlight
	["models/lostsignalproject/items/artefacts/mica.mdl"] = true, -- Mica
	["models/gibs/hgibs.mdl"] = true, -- Memento Mori
	["models/lostsignalproject/items/artefacts/glassbeads.mdl"] = true, -- Mama's Beads
	["models/lostsignalproject/items/artefacts/kolobok.mdl"] = true, -- Kolobok
	["models/lostsignalproject/items/artefacts/ring.mdl"] = true, -- Halo
	["models/lostsignalproject/items/artefacts/chelust.mdl"] = true, -- Grandmama's Beads
	["models/artefacts/atom.mdl"] = true, -- Galaxy
	["models/lostsignalproject/items/artefacts/glass.mdl"] = true, -- Flash
	["models/lostsignalproject/items/artefacts/flame.mdl"] = true, -- Flame
	["models/lostsignalproject/items/artefacts/eye.mdl"] = true, -- Eye
	["models/lostsignalproject/items/artefacts/atom.mdl"] = true, -- Dwarf Galaxy
	["models/lostsignalproject/items/artefacts/drop.mdl"] = true, -- Droplet
	["models/lostsignalproject/items/artefacts/crystal.mdl"] = true, -- Crystal
	["models/artefacts/full_empty.mdl"] = true, -- Capacitor
	["models/lostsignalproject/items/artefacts/cocoon.mdl"] = true, -- Bone Cluster
	["models/artefacts/empty.mdl"] = true, -- Blown Capacitor
	["models/nasca/etherealsrp_artifacts/battery.mdl"] = true, -- Battery
	["models/lostsignalproject/items/artefacts/black_angel.mdl"] = true, -- Arachno
	["models/artefacts/sandstone.mdl"] = true, -- Midas
	["models/lostsignalproject/items/artefacts/cell.mdl"] = true, -- Cell
	["models/lostsignalproject/items/artefacts/bracelet.mdl"] = true, -- Panacea
	["models/lostsignalproject/items/artefacts/bat.mdl"] = true, -- Gaia
	["models/jessev92/stalker/weapons/bolt_w.mdl"] = true, -- Bolt
	["models/lostsignalproject/items/artefacts/grapes.mdl"] = true, -- Grapes
}

-- The workshop addon registers these from its own autorun file, which only runs when the
-- server mounts the addon's Lua. The viewmodel animation events need them either way.
local DAR_SOUNDS = {
	["DAR.SHARED.ShowQuick"] = "stalker/dar_anomaly/new_detectors/shared/quick_hide.wav",
	["DAR.ECHO.Show2H"] = "stalker/dar_anomaly/new_detectors/echo/echo_draw_2h.wav",
	["DAR.ECHO.Show"] = "stalker/dar_anomaly/new_detectors/echo/echo_draw.wav",
	["DAR.ECHO.Hide2H"] = "stalker/dar_anomaly/new_detectors/echo/echo_holster_2h.wav",
	["DAR.ECHO.Hide"] = "stalker/dar_anomaly/new_detectors/echo/echo_holster.wav",
	["DAR.BEAR.Show2H"] = "stalker/dar_anomaly/new_detectors/bear/bear_draw_2h.wav",
	["DAR.BEAR.Show"] = "stalker/dar_anomaly/new_detectors/bear/bear_draw.wav",
	["DAR.BEAR.ShowDead"] = "stalker/dar_anomaly/new_detectors/bear/bear_draw_2h_dead.wav",
	["DAR.BEAR.Hide2H"] = "stalker/dar_anomaly/new_detectors/bear/bear_holster_2h.wav",
	["DAR.BEAR.Hide"] = "stalker/dar_anomaly/new_detectors/bear/bear_holster.wav",
	["DAR.VELES.Show"] = "stalker/dar_anomaly/new_detectors/veles/veles_draw.wav",
	["DAR.VELES.Show2H"] = "stalker/dar_anomaly/new_detectors/veles/veles_draw.wav",
	["DAR.VELES.Hide2H"] = "stalker/dar_anomaly/new_detectors/veles/veles_holster_2h.wav",
	["DAR.VELES.Hide"] = "stalker/dar_anomaly/new_detectors/veles/veles_holster.wav",
}

for name, path in pairs(DAR_SOUNDS) do
	if not sound.GetProperties(name) then
		sound.Add({
			name = name,
			channel = CHAN_AUTO,
			volume = 1,
			level = 75,
			pitch = 100,
			sound = path,
		})
	end
end

-- The anomalous bolt is reusable; ordinary bolts are consumed one at a time.
local function consumeBolt(inventory)
	if inventory:HasItem("artifact_bolt") then
		return true
	end

	local item = inventory:HasItem("value_bolts")

	if not item then
		return false
	end

	if item.quantity then
		local remaining = item:GetData("quantity", item.quantity) - 1

		if remaining > 0 then
			item:SetData("quantity", remaining)
			return true
		end
	end

	item:Remove()
	return true
end

function SWEP:SetupDataTables()
	self:NetworkVar("Float", 0, "IdleTime")
	-- 0 while deployed, the hide animation's end time while holstering, -1 once it has finished.
	self:NetworkVar("Float", 1, "HolsterTime")
	self:NetworkVar("Entity", 0, "HolsterTarget")
	-- End of the predicted throw windup. Zero outside the windup.
	self:NetworkVar("Float", 2, "BoltThrowTime")
end

function SWEP:Initialize()
	self:SetHoldType(self.HoldType)

	self.artifacts = {}
	self.nextScan = 0
	self.lastBeep = 0
	self.arrowYaw = 0
	self.flashUntil = 0
end

function SWEP:IsArtifactModel(model)
	if not model then
		return false
	end

	model = string.lower(model)

	if ARTIFACT_MODELS[model] then
		return true
	end

	return self.ExtraArtifactModels ~= nil and self.ExtraArtifactModels[model] == true
end

function SWEP:ScanArtifacts()
	if self.nextScan > CurTime() then
		return
	end

	self.nextScan = CurTime() + SCAN_INTERVAL

	local artifacts = {}

	for _, entity in ipairs(ents.FindByClass("ix_item")) do
		if self:IsArtifactModel(entity:GetModel()) then
			artifacts[#artifacts + 1] = entity
		end
	end

	self.artifacts = artifacts
end

function SWEP:FindNearestArtifact(origin)
	local nearest
	local nearestDistanceSqr = self.DetectRadius * self.DetectRadius

	for _, entity in ipairs(self.artifacts) do
		if IsValid(entity) then
			local distanceSqr = entity:GetPos():DistToSqr(origin)

			if distanceSqr < nearestDistanceSqr then
				nearest = entity
				nearestDistanceSqr = distanceSqr
			end
		end
	end

	if nearest then
		return nearest, math.sqrt(nearestDistanceSqr)
	end
end

-- Original COTZ cadence: one beep every (distance / radius) seconds, at most ten per second.
function SWEP:GetBeepInterval(distance)
	return math.max(distance / self.DetectRadius, MIN_BEEP_INTERVAL)
end

function SWEP:PlaySequence(name)
	local owner = self:GetOwner()

	if not IsValid(owner) then
		return 0
	end

	local viewModel = owner:GetViewModel()

	if not IsValid(viewModel) then
		return 0
	end

	local sequence = viewModel:LookupSequence(name)

	if sequence < 0 then
		return 0
	end

	viewModel:SendViewModelMatchingSequence(sequence)

	local duration = viewModel:SequenceDuration(sequence)
	self:SetIdleTime(CurTime() + duration)

	return duration
end

function SWEP:GetIdleSequence(owner)
	local speedSqr = owner:GetVelocity():Length2DSqr()

	if owner:IsSprinting() and speedSqr > SPRINT_SPEED_SQR then
		return "anm_idle_sprint"
	end

	if owner:OnGround() and speedSqr > MOVE_SPEED_SQR then
		return "anm_idle_moving"
	end

	return "anm_idle"
end

function SWEP:UpdateIdle(owner)
	if self:GetIdleTime() > CurTime() then
		return
	end

	local viewModel = owner:GetViewModel()

	if not IsValid(viewModel) then
		return
	end

	local sequence = viewModel:LookupSequence(self:GetIdleSequence(owner))

	if sequence >= 0 and viewModel:GetSequence() ~= sequence then
		viewModel:SendViewModelMatchingSequence(sequence)
	end
end

function SWEP:Deploy()
	self:SetHolsterTime(0)
	self:SetHolsterTarget(NULL)
	self:SetBoltThrowTime(0)
	self.pendingBolt = nil
	self:PlaySequence("anm_show")

	return true
end

-- Delays the switch until the hide animation has played, then selects the requested weapon.
-- Switches without a target (death, stripping) still happen immediately.
function SWEP:Holster(nextWeapon)
	self:SetBoltThrowTime(0)
	self.pendingBolt = nil

	if self:GetHolsterTime() < 0 or not IsValid(nextWeapon) or nextWeapon == self then
		self:SetHolsterTime(0)
		self:OnHolsterFinished()

		return true
	end

	self:SetHolsterTarget(nextWeapon)

	if self:GetHolsterTime() == 0 then
		self:SetHolsterTime(CurTime() + self:PlaySequence("anm_hide"))
	end

	return false
end

function SWEP:UpdateHolster(owner)
	local holsterTime = self:GetHolsterTime()

	if holsterTime <= 0 or holsterTime > CurTime() then
		return
	end

	local target = self:GetHolsterTarget()

	if not IsValid(target) or target:GetOwner() ~= owner then
		self:SetHolsterTime(0)
		self:PlaySequence("anm_show")
		return
	end

	self:SetHolsterTime(-1)

	if game.SinglePlayer() then
		if SERVER then
			owner:SelectWeapon(target:GetClass())
		end
	elseif CLIENT and IsFirstTimePredicted() then
		input.SelectWeapon(target)
	end
end

function SWEP:OnHolsterFinished()
end

function SWEP:CanThrowBolt(owner)
	local character = owner:GetCharacter()
	local inventory = character and character:GetInventory()

	if not inventory then
		return false
	end

	return inventory:HasItem("artifact_bolt") or inventory:HasItem("value_bolts") or false
end

function SWEP:ThrowBolt(force, punch)
	local owner = self:GetOwner()
	local now = CurTime()

	if not IsValid(owner) or self:GetHolsterTime() ~= 0 then
		return
	end

	if self:GetBoltThrowTime() > 0 or self:GetNextPrimaryFire() > now then
		return
	end

	if not self:CanThrowBolt(owner) then
		return
	end

	if self:PlaySequence("anm_throw_s") <= 0 then
		return
	end

	self:SetBoltThrowTime(self:GetIdleTime())
	self:SetNextPrimaryFire(now + BOLT_COOLDOWN)
	self:SetNextSecondaryFire(now + BOLT_COOLDOWN)

	if SERVER then
		self.pendingBolt = {
			owner = owner,
			character = owner:GetCharacter(),
			force = force,
			punch = punch,
		}
	end
end

function SWEP:UpdateBoltThrow()
	local now = CurTime()
	local windupEnd = self:GetBoltThrowTime()
	local pending = self.pendingBolt

	if windupEnd > 0 and now >= windupEnd then
		self:SetBoltThrowTime(0)

		-- The looping anm_throw pose is for holding a throw. Clicks go straight into follow-through.
		local duration = self:PlaySequence("anm_throw_e")

		if duration <= 0 then
			self.pendingBolt = nil
			return
		end

		local nextThrow = math.max(self:GetNextPrimaryFire(), self:GetIdleTime())
		self:SetNextPrimaryFire(nextThrow)
		self:SetNextSecondaryFire(nextThrow)

		if pending then
			pending.releaseAt = now + duration * self.BoltReleaseCycle
		end
	end

	if pending and pending.releaseAt and now >= pending.releaseAt then
		self.pendingBolt = nil
		self:ReleaseBolt(pending.owner, pending.character, pending.force, pending.punch)
	end
end

function SWEP:ReleaseBolt(owner, character, force, punch)
	if not IsValid(owner) or not owner:Alive() or owner:GetActiveWeapon() ~= self then
		return
	end

	if not character or owner:GetCharacter() ~= character then
		return
	end

	if not consumeBolt(character:GetInventory()) then
		return
	end

	owner:DoAttackEvent()
	owner:ViewPunch(punch)
	self:EmitSound(BOLT_THROW_SOUND)

	local bolt = ents.Create("ent_stalker_bolt")

	if not IsValid(bolt) then
		return
	end

	bolt:SetPos(owner:GetShootPos() + owner:GetAimVector() * BOLT_SPAWN_OFFSET)
	bolt:SetAngles(owner:EyeAngles())
	bolt:Spawn()
	bolt:SetOwner(owner)
	bolt:Fire("kill", "", BOLT_LIFETIME)

	local physics = bolt:GetPhysicsObject()

	if IsValid(physics) then
		physics:ApplyForceCenter(owner:GetVelocity() + owner:GetAimVector() * force)
		physics:AddAngleVelocity(VectorRand(-BOLT_SPIN, BOLT_SPIN))
		physics:SetMass(1)
	end
end

function SWEP:PrimaryAttack()
	self:ThrowBolt(5000, Angle(10, -10, 0))
end

function SWEP:SecondaryAttack()
	self:ThrowBolt(2500, Angle(-2, 0, 0))
end

function SWEP:Reload()
end

function SWEP:Think()
	local owner = self:GetOwner()

	if not IsValid(owner) then
		return
	end

	self:UpdateHolster(owner)
	self:UpdateBoltThrow()
	self:UpdateIdle(owner)

	if CLIENT then
		self:UpdateClientState()
		return
	end

	self:ScanArtifacts()

	local nearest, distance = self:FindNearestArtifact(owner:GetPos())

	if not nearest or self.lastBeep + self:GetBeepInterval(distance) > CurTime() then
		return
	end

	self.lastBeep = CurTime()

	-- The owner hears the client-side beep; everyone else hears it from the server.
	local filter = RecipientFilter()
	filter:AddAllPlayers()
	filter:RemovePlayer(owner)
	owner:EmitSound(BEEP_SOUND, BEEP_LEVEL, 100, 1, CHAN_AUTO, 0, 1, filter)
end

if SERVER then
	return
end

local rotateYaw = Angle()

local function trackBone(viewModel, bone)
	viewModel.cotzDetectorBones = viewModel.cotzDetectorBones or {}
	viewModel.cotzDetectorBones[bone] = true
end

local function setBoneVisible(viewModel, bone, visible)
	local scale = visible and VISIBLE_SCALE or HIDDEN_SCALE

	if viewModel:GetManipulateBoneScale(bone) ~= scale then
		viewModel:ManipulateBoneScale(bone, scale)
	end
end

-- Bone manipulations are stored per bone index on the shared viewmodel entity, so they
-- must be cleared before another weapon's model uses those indices.
local function resetViewModel(viewModel)
	if not IsValid(viewModel) or not viewModel.cotzDetectorBones then
		return
	end

	for bone in pairs(viewModel.cotzDetectorBones) do
		viewModel:ManipulateBoneScale(bone, VISIBLE_SCALE)
		viewModel:ManipulateBoneAngles(bone, angle_zero)
		viewModel:ManipulateBonePosition(bone, vector_origin)
	end

	viewModel.cotzDetectorBones = nil
end

hook.Add("PreDrawViewModel", "cotz/detector/resetViewModel", function(viewModel, client, weapon)
	if viewModel.cotzDetectorBones and not (IsValid(weapon) and weapon.IsCotzDetector) then
		resetViewModel(viewModel)
	end
end)

-- Runs at most once per frame, from Think and from viewmodel drawing; Think is not
-- called client-side in singleplayer.
function SWEP:UpdateClientState()
	local frame = FrameNumber()

	if self.lastClientFrame == frame then
		return
	end

	self.lastClientFrame = frame

	local owner = self:GetOwner()

	if not IsValid(owner) or owner ~= LocalPlayer() then
		return
	end

	self:ScanArtifacts()

	local nearest, distance = self:FindNearestArtifact(owner:GetPos())
	self.nearestArtifact = nearest

	if self.DisplayMode == "arrow" then
		self:UpdateArrow(owner, nearest)
	end

	if not nearest then
		return
	end

	local interval = self:GetBeepInterval(distance)

	if self.lastBeep + interval <= CurTime() then
		self.lastBeep = CurTime()
		self.flashUntil = CurTime() + interval * FLASH_FRACTION
		owner:EmitSound(BEEP_SOUND, BEEP_LEVEL, 100)
	end
end

function SWEP:UpdateArrow(owner, nearest)
	if not IsValid(nearest) then
		return
	end

	local direction = nearest:GetPos() - owner:GetShootPos()
	local target = math.NormalizeAngle(direction:Angle().y - owner:EyeAngles().y)
	local difference = math.AngleDifference(target, self.arrowYaw)
	local speed = math.Clamp(math.abs(difference) * ARROW_CONTROL_SPEED, ARROW_MIN_SPEED, ARROW_MAX_SPEED)
	local step = speed * FrameTime()

	self.arrowYaw = math.NormalizeAngle(self.arrowYaw + math.Clamp(difference, -step, step))
end

-- The light glows are separate meshes a few thousandths of a unit above the bodies and
-- z-fight with them, so each one is lifted slightly along its outward normal.
function SWEP:ApplyOverlayLifts(viewModel)
	if not self.OverlayLifts then
		return
	end

	for boneName, lift in pairs(self.OverlayLifts) do
		local bone = viewModel:LookupBone(boneName)

		if bone then
			trackBone(viewModel, bone)

			if viewModel:GetManipulateBonePosition(bone) ~= lift then
				viewModel:ManipulateBonePosition(bone, lift)
			end
		end
	end
end

function SWEP:ApplyViewModelBones(viewModel)
	self:ApplyOverlayLifts(viewModel)

	if self.HiddenBones then
		for _, boneName in ipairs(self.HiddenBones) do
			local bone = viewModel:LookupBone(boneName)

			if bone then
				trackBone(viewModel, bone)
				setBoneVisible(viewModel, bone, false)
			end
		end
	end

	if self.DisplayMode == "flash" then
		local bone = viewModel:LookupBone(FLASH_BONE)

		if bone then
			trackBone(viewModel, bone)
			setBoneVisible(viewModel, bone, self.flashUntil > CurTime())
		end
	elseif self.DisplayMode == "arrow" then
		local bone = viewModel:LookupBone(ARROW_BONE)

		if not bone then
			return
		end

		trackBone(viewModel, bone)
		setBoneVisible(viewModel, bone, IsValid(self.nearestArtifact))

		-- Positive pitch turns the segment counter-clockwise as seen by the user, which
		-- matches Source's yaw direction. Anomaly truncates to the segment, as fmod does.
		local segmentYaw = self.arrowYaw - math.fmod(self.arrowYaw, ARROW_STEP)

		if viewModel:GetManipulateBoneAngles(bone).p ~= segmentYaw then
			viewModel:ManipulateBoneAngles(bone, Angle(segmentYaw, 0, 0))
		end
	end
end

function SWEP:PreDrawViewModel(viewModel)
	self:UpdateClientState()
	self:ApplyViewModelBones(viewModel)

	-- Bodygroups are read while drawing, so this is restored in PostDrawViewModel.
	if self.EmissionBodygroup then
		local group = viewModel:FindBodygroupByName("emission")

		if group >= 0 then
			self.restoreBodygroup = {group, viewModel:GetBodygroup(group)}
			viewModel:SetBodygroup(group, self.EmissionBodygroup)
		end
	end
end

function SWEP:DrawScreen(viewModel)
	local owner = self:GetOwner()
	local bone = viewModel:LookupBone(SCREEN_BONE)
	local matrix = bone and viewModel:GetBoneMatrix(bone)

	if not IsValid(owner) or not matrix then
		return
	end

	local origin = LocalToWorld(SCREEN_ORIGIN, angle_zero, matrix:GetTranslation(), matrix:GetAngles())
	local eyePos = owner:EyePos()
	local pixelsPerUnit = SCREEN_RADIUS / SCREEN_SCALE / self.DetectRadius
	local radiusSqr = self.DetectRadius * self.DetectRadius
	local ownerPos = owner:GetPos()
	local halfDot = SCREEN_DOT_SIZE / 2

	rotateYaw.y = -owner:EyeAngles().y

	-- The bone's X axis is screen-right, its Y axis points up the screen and Z faces the user,
	-- which is the same layout cam.Start3D2D uses for the bone's own angles.
	cam.Start3D2D(origin, matrix:GetAngles(), SCREEN_SCALE)
		for _, entity in ipairs(self.artifacts) do
			if IsValid(entity) and entity:GetPos():DistToSqr(ownerPos) < radiusSqr then
				local offset = entity:GetPos() - eyePos
				offset:Rotate(rotateYaw)

				local x = -offset.y * pixelsPerUnit
				local y = -offset.x * pixelsPerUnit

				draw.RoundedBox(
					halfDot, x - halfDot, y - halfDot, SCREEN_DOT_SIZE, SCREEN_DOT_SIZE, SCREEN_DOT_COLOR
				)
			end
		end
	cam.End3D2D()
end

function SWEP:PostDrawViewModel(viewModel)
	if self.restoreBodygroup then
		viewModel:SetBodygroup(self.restoreBodygroup[1], self.restoreBodygroup[2])
		self.restoreBodygroup = nil
	end

	if self.DisplayMode == "screen" then
		self:DrawScreen(viewModel)
	end
end

function SWEP:OnHolsterFinished()
	local owner = self:GetOwner()

	if IsValid(owner) and owner == LocalPlayer() then
		resetViewModel(owner:GetViewModel())
	end
end

function SWEP:GetWorldModelEntity()
	if not IsValid(self.worldModelEntity) then
		self.worldModelEntity = ClientsideModel(self.WorldModel, RENDERGROUP_OPAQUE)

		if IsValid(self.worldModelEntity) then
			self.worldModelEntity:SetNoDraw(true)
		end
	end

	return self.worldModelEntity
end

function SWEP:DrawWorldModel(flags)
	local owner = self:GetOwner()
	local offset = self.WorldModelOffset
	local bone = IsValid(owner) and owner:LookupBone(offset.bone)
	local matrix = bone and owner:GetBoneMatrix(bone)

	if not matrix then
		self:DrawModel(flags)
		return
	end

	local model = self:GetWorldModelEntity()

	if not IsValid(model) then
		return
	end


	local pos, ang = matrix:GetTranslation(), matrix:GetAngles()
	pos = pos + ang:Forward() * offset.pos.x + ang:Right() * offset.pos.y + ang:Up() * offset.pos.z
	ang:RotateAroundAxis(ang:Up(), offset.ang.y)
	ang:RotateAroundAxis(ang:Right(), offset.ang.p)
	ang:RotateAroundAxis(ang:Forward(), offset.ang.r)

	model:SetPos(pos)
	model:SetAngles(ang)
	model:SetupBones()
	model:DrawModel(flags)
end

function SWEP:OnRemove()
	local owner = self:GetOwner()

	if IsValid(owner) and owner == LocalPlayer() then
		resetViewModel(owner:GetViewModel())
	end

	if IsValid(self.worldModelEntity) then
		self.worldModelEntity:Remove()
	end
end
