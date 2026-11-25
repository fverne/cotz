local hooks = {}
local sent = {}

function Vector(x, y, z)
	return setmetatable({x = x, y = y, z = z}, {
		__add = function(a, b) return Vector(a.x + b.x, a.y + b.y, a.z + b.z) end,
		__sub = function(a, b) return Vector(a.x - b.x, a.y - b.y, a.z - b.z) end,
	})
end

function Angle(pitch, yaw, roll)
	return {pitch = pitch, yaw = yaw, roll = roll}
end

local matrixMethods = {}
local matrixMeta
matrixMeta = {
	__index = matrixMethods,
	__mul = function(a, b)
		if getmetatable(b) == matrixMeta then
			return Matrix(a * b.pos, a.rotated, b.angles)
		end
		if a.rotated then b = Vector(-b.y, b.x, b.z) end

		return a.pos + b
	end,
}

function Matrix(position, rotated, angles)
	return setmetatable({pos = position or Vector(0, 0, 0), rotated = rotated, angles = angles}, matrixMeta)
end

function matrixMethods:SetAngles(angles)
	self.angles = angles
end

function matrixMethods:GetTranslation()
	return self.pos
end

function matrixMethods:SetTranslation(position)
	self.pos = position
end

function matrixMethods:Scale(scale)
	self.scale = scale
end

function IsValid(entity)
	return entity ~= nil and entity.valid ~= false
end

function AddCSLuaFile(path)
	sent[path or "autorun"] = true
end

function include(path)
	return assert(loadfile("lua/" .. path))()
end

hook = {Add = function(event, id, callback) hooks[id] = callback end}
EF_BONEMERGE = 1
SERVER, CLIENT = true, false
include("autorun/cotz_weapon_chands.lua")
assert(sent["cotz_weapon_chands/cl_grips.lua"], "Grip definitions must be available to clients")
assert(sent["cotz_weapon_chands/sh_rigged_models.lua"], "Clients need the same fitted model map as the server")

SERVER, CLIENT = false, true
include("autorun/cotz_weapon_chands.lua")
local fit = hooks["cotz/weapon-hands/fit"]
local conversions = include("cotz_weapon_chands/sh_definitions.lua")
local gripData = include("cotz_weapon_chands/cl_grips.lua")
local hands = {model = "stock", writes = {}, invalidations = 0, installs = 0}
local boneNames = {
	"ValveBiped.Bip01_L_Finger0", "ValveBiped.Bip01_L_Hand",
	"ValveBiped.Bip01_L_Forearm", "ValveBiped.Bip01_R_Hand",
}
local engineViewModel = {}

function hands:GetModel() return self.model end
function hands:GetParent() return self.parent end
function hands:SetParent(parent) self.parent = parent end
function hands:AddEffects(effect) assert(effect == EF_BONEMERGE) end
function hands:GetBoneName(index) return boneNames[index + 1] end
function hands:GetBoneMatrix(index) return Matrix(Vector(10 + index, 20, 30), true) end
function hands:SetBoneMatrix(index, matrix) self.writes[index] = matrix end
function hands:InvalidateBoneCache() self.invalidations = self.invalidations + 1 end
function hands:AddCallback(event, callback)
	assert(event == "BuildBonePositions" and not self.callback)
	self.installs = self.installs + 1
	self.callback = callback

	return self.installs
end
function hands:RemoveCallback(event, id)
	assert(event == "BuildBonePositions" and id == self.installs)
	self.callback = nil
end

BONE_USED_BY_BONE_MERGE = 262144

local function weapon(class, sources, unflagged)
	local model = conversions[class].model
	local parent = {GetModel = function() return model end}
	if sources then
		parent.GetBoneCount = function() return #sources end
		parent.GetBoneName = function(_, index) return sources[index + 1] end
		parent.GetBoneMatrix = function(_, index) return Matrix(Vector(index + 40, 50, 60)) end
		parent.BoneHasFlag = function(_, index, flag)
			assert(flag == BONE_USED_BY_BONE_MERGE)
			return not (unflagged and unflagged[sources[index + 1]])
		end
	end

	return {GetClass = function() return class end, ViewModel = model, CW_VM = parent, CW20Weapon = true}
end

local function near(a, b)
	assert(math.abs(a - b) < 0.000001, ("%g differs from %g"):format(a, b))
end

local dp28 = weapon("cw_dp28")
fit(hands, engineViewModel, nil, dp28)
assert(hands.parent == dp28.CW_VM)
hands.callback(hands, 4)
local left = gripData[dp28.ViewModel].left
near(hands.writes[0].pos.x, 10 - left.y)
near(hands.writes[0].pos.y, 20 + left.x)
near(hands.writes[0].pos.z, 30 + left.z)
near(hands.writes[1].pos.x, 11 - left.y)
near(hands.writes[2].pos.x, 12)
near(hands.writes[0].scale.x, conversions.cw_dp28.left.x)

local beretta = weapon("cw_beretta92", {"Right_Bone44", "Right_Bone49"})
fit(hands, engineViewModel, nil, beretta)
hands.callback(hands, 4)
assert(hands.writes[0].pos.x == 40, "Thumb must follow the source thumb at bone index zero")
assert(hands.writes[2].pos.x == 41, "Forearm must follow the source elbow")
assert(hands.writes[1].pos.x == 11, "Missing source bones fall back to the bonemerged pose")
assert(hands.installs == 1, "Switching fitted weapons must reuse the callback")

-- Older copies of the Beretta model leave the elbow chain unflagged, so the engine never poses it.
local staleBeretta = weapon("cw_beretta92", {"Right_Bone44", "Right_Bone49"}, {Right_Bone49 = true})
fit(hands, engineViewModel, nil, staleBeretta)
hands.callback(hands, 4)
assert(hands.writes[0].pos.x == 40, "Flagged source bones must still be used")
assert(hands.writes[2].pos.x == 12, "Unevaluated source bones must fall back to the bonemerged pose")
fit(hands, engineViewModel, nil, beretta)

-- A suit can change the order and number of hand bones.
hands.model = "different suit"
boneNames = {"ValveBiped.Bip01_L_Forearm", "ValveBiped.Bip01_L_Finger0"}
hands.callback(hands, 2)
assert(hands.writes[0].pos.x == 41 and hands.writes[1].pos.x == 40)

local contenderSources = {"Bip01 L Hand"}
local contenderParts = {"Hand"}
local contenderSourceIndices = {0}
for digit = 1, 4 do
	for segment = 1, 3 do
		if segment < 3 then
			contenderSources[#contenderSources + 1] = "Bip01 L Finger" .. digit .. segment
		end
		contenderSourceIndices[#contenderSourceIndices + 1] = #contenderSources - 1
		contenderParts[#contenderParts + 1] = "Finger" .. digit .. (segment == 1 and "" or segment - 1)
	end
end

boneNames = {}
for index, part in ipairs(contenderParts) do
	boneNames[index] = "ValveBiped.Bip01_L_" .. part
end
boneNames[#boneNames + 1] = "ValveBiped.Bip01_L_Finger0"

for _, class in ipairs({"cw_contender", "cw_contender500"}) do
	local contender = weapon(class, contenderSources)
	fit(hands, engineViewModel, nil, contender)
	hands.callback(hands, #boneNames)
	local pose = gripData[contender.ViewModel].pose.left
	for index, part in ipairs(contenderParts) do
		local result = hands.writes[index - 1]
		near(result.pos.x, 40 + contenderSourceIndices[index] + pose[part].matrix:GetTranslation().x)
		assert(result.angles and result.scale.x == 0.78)
	end
	assert(not hands.writes[#contenderParts].angles, "The thumb must keep its original animation")
	assert(conversions[class].right.x == 0.8)
end

local native = {GetClass = function() return "native" end}
fit(hands, engineViewModel, nil, native)
assert(hands.parent == engineViewModel)
hands.writes = {}
hands.callback(hands, 2)
assert(not next(hands.writes), "Fitting leaked into a native viewmodel")

fit(hands, engineViewModel, nil, dp28)
dp28.CW_VM.GetModel = function() return "models/other.mdl" end
fit(hands, engineViewModel, nil, dp28)
hands.callback(hands, 2)
assert(not next(hands.writes), "A stale or substituted viewmodel received another model's fit")

include("cotz_weapon_chands/cl_hands.lua")
hooks["cotz/weapon-hands/fit"](hands, engineViewModel, nil, native)
assert(not hands.callback and not hands.cotzWeaponHandsCallback, "A Lua reload must remove stale callbacks")

local riggedModels = include("cotz_weapon_chands/sh_rigged_models.lua")
local originalAnomaly = "models/flaymi/anomaly/weapons/v_models/9a91.mdl"
local legacyRig = riggedModels[conversions.cw_dp28.model].model
local stored = {
	cw_dp28 = {ViewModel = "models/legacy/dp28.mdl"},
	cw_9a91 = {ViewModel = originalAnomaly},
	cw_anomaly_9a91 = {ViewModel = originalAnomaly},
}
local installed = {}

string.StartWith = function(value, prefix) return value:sub(1, #prefix) == prefix end
file = {Exists = function(path, realm)
	assert(realm == "GAME")
	return installed[path]
end}
weapons = {
	GetStored = function(class) return stored[class] end,
	IsBasedOn = function(_, base) return base == "cw_base" end,
}

local applyModels = hooks["cotz/weapon-hands/models"]
applyModels()
assert(stored.cw_dp28.ViewModel == conversions.cw_dp28.model, "Use the original conversion without the content pack")
assert(stored.cw_9a91.ViewModel == originalAnomaly, "Native rigs use their existing model paths")

installed[legacyRig] = true
applyModels()
assert(stored.cw_dp28.ViewModel == legacyRig and stored.cw_dp28.UseHands)
assert(stored.cw_9a91.ViewModel == originalAnomaly and stored.cw_anomaly_9a91.ViewModel == originalAnomaly)
applyModels()
assert(stored.cw_dp28.ViewModel == legacyRig and stored.cw_9a91.ViewModel == originalAnomaly)

local baked = {
	GetClass = function() return "cw_dp28" end,
	ViewModel = legacyRig,
	CW_VM = {GetModel = function() return legacyRig end},
	CW20Weapon = true,
}

fit = hooks["cotz/weapon-hands/fit"]
fit(hands, engineViewModel, nil, baked)
assert(not hands.callback, "The compiled grip must use normal c_hands with no Lua pose callback")

CustomizableWeaponry = {}
include("cw/client/cw_hooks.lua")
local drawHands = hooks["CustomizableWeaponry.PreDrawPlayerHands"]
drawHands(hands, engineViewModel, nil, baked)
assert(hands:GetParent() == baked.CW_VM)
drawHands(hands, engineViewModel, nil, native)
assert(hands:GetParent() == engineViewModel, "Returning to a stock viewmodel must restore the normal parent")

print("Compiled grips use named conversions and preserve native viewmodel paths.")
