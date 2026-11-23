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
	DrawTexturedRectUV = function(...) rect = {...} end,
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

local lensOverride
local sightPos = {}
local tulip = setmetatable({
	AimPos = sightPos,
	ActualSightPos = sightPos,
	cotzLensScope = {zoom = 4, reticlePath = "tulip/reticle", reticleCenter = {0, -0.25}},
	cotzAimModel = {
		active = true,
		ent = {
			GetMaterials = function() return {"scope/body", "scope/lense_rt"} end,
			GetSubMaterial = function() return lensOverride end,
			SetSubMaterial = function(_, slot, value)
				assert(slot == 1)
				lensOverride = value
			end,
		},
	},
	dt = {},
	ScopeRT = {},
	getRenderTargetSize = function() return 512 end,
	isAiming = function(self) return self.aiming end,
	canUseComplexTelescopics = function(self) return not self.simple end,
}, {__index = SWEP})
local attachmentLens = created.cotz_attachment_scope_lens

tulip:DrawCotzLensScope(origin, angles, 75)
assert(lensOverride == "!cotz_attachment_scope_lens" and draws == 1)
assert(attachmentLens.base:GetName() == "cw2/gui/lense", "an attachment lens needs a fallback before aiming")

tulip.aiming = true
tulip:DrawCotzLensScope(origin, angles, 75)
assert(draws == 2 and frame.fov < 10 and attachmentLens.base == tulip.ScopeRT)
assert(rect[3] == 512 and rect[6] == -0.25 and rect[8] == 0.75, "the reticle keeps its configured centre")
assert(material == created.cotz_integrated_scope_reticle)

tulip.AimPos = {}
tulip:DrawCotzLensScope(origin, angles, 75)
assert(draws == 2 and attachmentLens.base:GetName() == "cw2/gui/lense", "backup sights do not render the lens")

tulip.AimPos = sightPos
tulip.simple = true
tulip:DrawCotzLensScope(origin, angles, 75)
assert(draws == 2, "simple telescopics keep the full-screen reticle")

tulip.cotzAimModel.active = false
assert(not tulip:GetCotzLensScope())

local legacy = setmetatable({
	CW20Weapon = true,
	ScopeRT = {},
	cotzAimModel = {
		active = true,
		ent = {
			GetMaterials = function() return {"cw2/attachments/lens/rt", "scope/body"} end,
			GetSubMaterial = function() return lensOverride end,
			SetSubMaterial = function(_, slot, value)
				assert(slot == 0)
				lensOverride = value
			end,
		},
	},
}, {__index = SWEP})

local renderScene
hook = {Add = function(event, _, callback)
	if event == "RenderScene" then renderScene = callback end
end}
function LocalPlayer() return {GetActiveWeapon = function() return legacy end} end

local currentTarget
render.GetRenderTarget = function() return currentTarget end
local shortdot
CLIENT = true
CustomizableWeaponry = {
	textColors = {},
	registerAttachment = function(_, attachment) shortdot = attachment end,
}
surface.GetTextureID = function(path) return path end
surface.SetTexture = function() end
surface.DrawTexturedRectRotated = function() end
function Color(...) return {...} end
function Angle(p, y, r)
	return {p = p, y = y, r = r, Forward = function() return 1 end}
end
function FrameTime() return 0.1 end
function math.Approach(current, target, step)
	return current < target and math.min(current + step, target) or math.max(current - step, target)
end
render.ComputeLighting = function() return {1, 1, 1} end
dofile("lua/cw/shared/attachments/md_schmidt_shortdot.lua")

legacy.freeAimOn = true
legacy.BlendAng = {x = 0, y = 0, z = 0}
legacy.Owner = {EyeAngles = function() return Angle(0, 0, 0) end, GetShootPos = function() return origin end}
legacy.getRenderTargetSize = function() return 512 end
legacy.canSeeThroughTelescopics = function() return true end
legacy.canUseComplexTelescopics = function(self) return not self.simple end
legacy.TSGlass = {SetTexture = function() error("the weapon's built-in lens was changed") end}
shortdot.attachFunc(legacy)
assert(shortdot.FOVModifier == 15 and legacy.SimpleTelescopicsFOV == 55)

local lensDraws = 0
legacy.renderTargetFunc = function(self, sceneOrigin, sceneAngles, glass)
	assert(sceneOrigin == origin and sceneAngles == angles)
	assert(glass == attachmentLens and lensOverride == "!cotz_attachment_scope_lens")
	lensDraws = lensDraws + 1
	currentTarget = self.ScopeRT
	renderScene(origin, angles, 75)
	currentTarget = nil
	shortdot.drawRenderTarget(self, sceneOrigin, sceneAngles, glass)
end

dofile("lua/weapons/cw_base/cl_hooks.lua")
lensOverride = nil
angles.p, angles.y, angles.r = 0, 0, 0
renderScene(origin, angles, 75)
assert(lensDraws == 1, "the attachment renderer owns its lens and skips nested scope views")
assert(draws == 3 and frame.fov == 9 and attachmentLens.base == legacy.ScopeRT)

legacy.simple = true
renderScene(origin, angles, 75)
assert(draws == 3 and attachmentLens.base:GetName() == "cw2/gui/lense")

print("Anomaly integrated scope spec passed")
