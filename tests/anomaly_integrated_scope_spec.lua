SWEP = {}

local function texture(name)
	return {
		GetName = function() return name end,
		IsError = function() return false end,
	}
end

local created = {}
function Material(name)
	return {GetTexture = function() return texture(name) end}
end

function CreateMaterial(name, _, params)
	local material = {
		base = texture(params["$basetexture"]),
		SetTexture = function(self, field, value)
			assert(field == "$basetexture")
			self.base = value
		end,
	}
	created[name] = material
	return material
end

util = {CRC = function() return "reticle" end}
function IsValid(value) return value ~= nil end

local depth, clipping, draws = 0, false, 0
local frame, rect, material
render = {
	PushRenderTarget = function(_, x, y, width, height)
		assert(x == 0 and y == 0 and width == 512 and height == 512)
		depth = depth + 1
	end,
	RenderView = function(view)
		assert(depth == 1)
		frame = view
		draws = draws + 1
	end,
	PopRenderTarget = function() depth = depth - 1 end,
}
function DisableClipping(enabled)
	local wasEnabled = clipping
	clipping = enabled
	return wasEnabled
end
cam = {Start2D = function() end, End2D = function() end}
surface = {
	SetDrawColor = function() end,
	SetMaterial = function(value) material = value end,
	DrawTexturedRect = function(...) rect = {...} end,
	DrawRect = function() end,
}

local hudPath
baseclass = {Get = function() return {DrawHUD = function() hudPath = "cw" end} end}

dofile("lua/weapons/cw_base/cl_cotzintegratedscope.lua")

local override
local currentAim = {}
local weapon = setmetatable({
	AimPos = currentAim,
	CurIronsightPos = currentAim,
	AnomalyScopeZoom = 4,
	AnomalyReticle = "scope/reticle",
	AnomalyState = {},
	ApplyAnomalyAttachments = function() end,
	DrawHUD = function() hudPath = "pack" end,
	dt = {},
	ScopeRT = {},
	CW_VM = {
		GetMaterials = function() return {"model/body", "model/lense_rt"} end,
		GetSubMaterial = function() return override end,
		SetSubMaterial = function(_, slot, value)
			assert(slot == 1)
			override = value
		end,
	},
	getRenderTargetSize = function() return 512 end,
	isAiming = function(self) return self.aiming end,
	canUseComplexTelescopics = function(self) return not self.simple end,
}, {__index = SWEP})

weapon:SetupCotzIntegratedScope()
weapon:DrawHUD()
assert(hudPath == "cw", "the native full-screen overlay must yield to CW for an integrated scope")
local origin, angles = {}, {}
local lens = created.cotz_integrated_scope_lens

weapon:DrawCotzIntegratedScope(origin, angles, 75)
assert(draws == 0 and override == "!cotz_integrated_scope_lens")
assert(lens.base:GetName() == "cw2/gui/lense", "the lens should have a fallback before aiming")

weapon.aiming = true
weapon:DrawCotzIntegratedScope(origin, angles, 75)
assert(draws == 1 and frame.origin == origin and frame.angles == angles and frame.fov < 10)
assert(frame.aspectratio == 1 and frame.drawviewmodel == false and frame.drawhud == false)
assert(lens.base == weapon.ScopeRT and depth == 0 and not clipping)
assert(rect[1] == 0 and rect[2] == 0 and rect[3] == 512 and rect[4] == 512)
assert(material == created.cotz_integrated_scope_reticle)

weapon.simple = true
weapon:DrawCotzIntegratedScope(origin, angles, 75)
assert(draws == 1 and lens.base:GetName() == "cw2/gui/lense")
weapon:DrawCotzSimpleIntegratedScope(weapon:GetCotzIntegratedScope(), 1920, 1080)
assert(rect[1] == 420 and rect[2] == 0 and rect[3] == 1080 and rect[4] == 1080)

weapon.AnomalyState.INS2_SightVElement = "mounted_optic"
weapon:DrawHUD()
assert(hudPath == "pack" and not weapon:GetCotzIntegratedScope())

local custom = setmetatable({
	AnomalyScopeZoom = 4,
	AnomalyReticle = "scope/reticle",
	RenderTargetFunc = function() end,
}, {__index = SWEP})
custom:SetupCotzIntegratedScope()
assert(not custom.cotzIntegratedScope, "an existing CW renderer owns its own lens")

print("Anomaly integrated scope spec passed")
