local sourceMath = dofile("tests/helpers/source_math.lua")

local function read(path)
	local file = assert(io.open("lua/weapons/cw_base/" .. path))
	local source = file:read("*a")
	file:close()
	return source
end

SWEP = {}
SERVER = true
CLIENT = false
umsg = setmetatable({}, {__index = function() return function() end end})
CustomizableWeaponry = {
	callbacks = {processCategory = function() end},
	knownVariableTexts = {},
	registeredAttachmentsSKey = {optic = {name = "optic", isSight = true}},
}

function CustomizableWeaponry:findAttachment(name)
	return self.registeredAttachmentsSKey[name]
end

include = function(path) return dofile("lua/" .. path) end
assert(load(read("sh_cotzattachments.lua")))()
assert(load(read("sh_attachments.lua")))()
local weapon = setmetatable({
	Attachments = {[1] = {atts = {"optic"}}},
	ActiveAttachments = {},
	SightWithRail = true,
	RailBGs = {main = 1, off = 0},
	addStatModifiers = function() end,
	removeStatModifiers = function() end,
	checkAttachmentDependency = function() end,
	recalculateStats = function() end,
	SetWorldAttachments = function(self, value) self.snapshot = value end,
	GetWorldAttachments = function(self) return self.snapshot end,
}, {__index = SWEP})

weapon:_attach(1, 1)
assert(weapon.snapshot == "optic", "successful attach should replicate the installed ID")
weapon:_detach(1, 1)
assert(weapon.snapshot == "", "detach should clear the replicated ID")
assert(not weapon.ActiveAttachments.optic and weapon.Attachments[1].last == nil,
	"server detach must clear the sight without a client model table")

SERVER = false
CLIENT = true
weapon.elementRender = {}
weapon.resetAimToIronsights = function(self) self.aimReset = true end
weapon.setBodygroup = function(_, group, value)
	assert(group == 1 and value == 0, "client detach must hide the rail bodygroup")
end
local optic = CustomizableWeaponry.registeredAttachmentsSKey.optic
weapon.Attachments[1].last = 1
weapon.renderTargetFunc = function() end
weapon:resetPostDetach(optic, weapon.Attachments[1])
assert(weapon.renderTargetFunc == nil, "detached scope camera must stop rendering")
assert(weapon.aimReset, "client detach must reset aim even before the models are available")

weapon.AttachmentModelsVM = {optic = {active = true}, md_rail = {active = true}}
weapon.Attachments[1].last = 1
weapon:resetPostDetach(optic, weapon.Attachments[1])
assert(not weapon.AttachmentModelsVM.optic.active and not weapon.AttachmentModelsVM.md_rail.active)
CLIENT = false

local renderCode = read("cl_model.lua")
local function loadSection(first, last)
	local start = assert(renderCode:find(first, 1, true))
	local finish = assert(renderCode:find(last, start, true))
	return renderCode:sub(start, finish - 1)
end

local sourceMounts = loadSection("local function getAttachmentPoint", "function SWEP:setupAttachmentModels")
local sampleViewmodelMounts, recordViewmodelMount = assert(load(sourceMounts
	.. loadSection("local function offsetAttachment", "function SWEP:_drawAttachmentModel")
	.. loadSection("local function getWorldAttachmentSelection", "function SWEP:DrawWorldModel")
	.. "return sampleViewmodelMounts, recordViewmodelMount"))()

local angleMethods = getmetatable(Angle()).__index
function angleMethods:Forward() return sourceMath.toMatrix(self)[1] end
function angleMethods:Right() return -sourceMath.toMatrix(self)[2] end
function angleMethods:Up() return sourceMath.toMatrix(self)[3] end
function angleMethods:RotateAroundAxis(_, degrees) assert(degrees == 0) end

local vectorMethods = getmetatable(Vector()).__index
function vectorMethods:Distance(other) return (self - other):Length() end
function math.Clamp(value, min, max) return math.min(max, math.max(min, value)) end
vector_origin, angle_zero = Vector(), Angle()

local drawn = {}
local created = 0
function IsValid(entity) return entity ~= nil end
function Matrix() return {Scale = function(self, scale) self.scale = scale end} end
function ClientsideModel(name)
	created = created + 1
	return {
		SetNoDraw = function() end,
		EnableMatrix = function(self, _, matrix) self.scale = matrix.scale end,
		SetPos = function(self, pos) self.pos = pos end,
		SetAngles = function(self, ang) self.ang = ang end,
		DrawModel = function(self) drawn[name] = self end,
	}
end

CustomizableWeaponry.cmodels = {add = function() end}
CustomizableWeaponry.registeredAttachmentsSKey.dovetail = {name = "dovetail", isSight = true, withoutRail = true}
weapon.SightWithRail = true
weapon.Animations = {idle = {"idle"}}
weapon.CW_VM = {
	ResetSequence = function(_, sequence) assert(sequence == "idle") end,
	SetCycle = function(_, cycle) assert(cycle == 0) end,
	InvalidateBoneCache = function() end,
	SetupBones = function() end,
	LookupAttachment = function() return 0 end,
	GetAttachment = function(_, index)
		assert(index == 1, "fall back to the configured muzzle index")
		return {Pos = Vector(30, 0, 0), Ang = Angle()}
	end,
	LookupBone = function() return 0 end,
	GetBoneMatrix = function() return SourceMathMatrix(Vector(20, 0, 0), Angle()) end,
}
weapon.MuzzleAttachmentName = "muzzle"
weapon.MuzzleAttachment = 1
weapon.getBoneOrientation = function() return Vector(26, 0, 0), Angle() end
sampleViewmodelMounts(weapon)
recordViewmodelMount(weapon, {_bone = 0})
weapon.AttachmentModelsVM = {
	optic = {model = "optic", _bone = 0, origPos = Vector(0, 0, 2), origAng = Angle()},
	dovetail = {model = "dovetail", _bone = 0, origPos = Vector(), origAng = Angle()},
	md_rail = {model = "rail", _bone = 0, origPos = Vector(), origAng = Angle()},
}
local worldModel = {
	LookupAttachment = function() return 1 end,
	GetAttachment = function() return {Pos = Vector(10, 20, 30), Ang = Angle(0, 90, 0)} end,
	LookupBone = function() return 0 end,
	GetBoneMatrix = function() return SourceMathMatrix(Vector(10, 12, 30), Angle()) end,
}

weapon:SetWorldAttachments("optic")
weapon:DrawWorldAttachments(worldModel)
assert(drawn.rail and drawn.optic, "an observer should draw the installed optic and its rail")
assert((drawn.optic.pos - Vector(10, 16.8, 31.6)):Length() < 1e-6, "apply scale and world muzzle rotation")
assert(math.abs(drawn.optic.ang.y - 90) < 1e-6, "rotate the attachment with the worldmodel")
assert(drawn.optic.scale.x == 0.8, "scale the mesh with the copied offset")
weapon:DrawWorldAttachments(worldModel)
assert(created == 2, "repeat draws should reuse the existing client models")

-- A weapon that measured its model pair names the scale instead of the muzzle-to-wpn_body estimate.
drawn = {}
weapon.WorldAttachmentScale = 0.5
weapon:DrawWorldAttachments(worldModel)
assert((drawn.optic.pos - Vector(10, 18, 31.6 - 0.6)):Length() < 1e-6, "use the measured scale")
assert(drawn.optic.scale.x == 0.5, "scale the mesh with the measured scale")

drawn = {}
weapon.WorldAttachmentShift = Vector(0, 0, 1)
weapon:DrawWorldAttachments(worldModel)
assert((drawn.optic.pos - Vector(10, 18, 32)):Length() < 1e-6, "shift along the worldmodel muzzle axes")

-- Opposite muzzle frames: 180 degrees of roll turns the viewmodel offsets onto the worldmodel's.
drawn = {}
weapon.WorldAttachmentAngle = Angle(0, 0, 180)
weapon:DrawWorldAttachments(worldModel)
assert((drawn.optic.pos - Vector(10, 18, 30)):Length() < 1e-6, "turn the viewmodel muzzle frame before shifting")
weapon.WorldAttachmentScale, weapon.WorldAttachmentShift, weapon.WorldAttachmentAngle = nil, nil, nil

drawn = {}
weapon.WorldAttachmentBone = "receiver"
weapon.WorldAttachmentScale = 0.5
local receiverModel = {
	LookupBone = function(_, name)
		assert(name == "receiver")
		return 0
	end,
	GetBoneMatrix = function() return SourceMathMatrix(Vector(10, 20, 30), Angle(0, 90, 0)) end,
}
weapon:DrawWorldAttachments(receiverModel)
assert((drawn.optic.pos - Vector(10, 18, 31)):Length() < 1e-6, "an authored bone also works without a muzzle")
assert(drawn.optic.scale.x == 0.5)
weapon.WorldAttachmentBone, weapon.WorldAttachmentScale = nil, nil

drawn = {}
weapon:SetWorldAttachments("dovetail")
weapon:DrawWorldAttachments(worldModel)
assert(drawn.dovetail and not drawn.rail and not drawn.optic, "replace the visual and hide the unneeded adapter")

drawn = {}
weapon:SetWorldAttachments("")
weapon:DrawWorldAttachments(worldModel)
assert(not next(drawn), "empty server state should hide previously drawn models")

print("PASS: CW attachment replication, mount transfer and rail visibility")
