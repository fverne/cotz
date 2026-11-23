local sourceMath = dofile("tests/helpers/source_math.lua")

local function loadSection(path, first, last)
	local file = assert(io.open(path))
	local source = file:read("*a")
	file:close()
	local start = assert(source:find(first, 1, true))
	local finish = assert(source:find(last, start, true))

	return source:sub(start, finish - 1)
end

local function close(actual, expected)
	assert(math.abs(actual - expected) < 0.000001, ("%f != %f"):format(actual, expected))
end

local angleMethods = getmetatable(Angle()).__index
function angleMethods:Forward() return sourceMath.toMatrix(self)[1] end
function angleMethods:Right() return -sourceMath.toMatrix(self)[2] end
function angleMethods:Up() return sourceMath.toMatrix(self)[3] end

SWEP = {}
assert(load(loadSection("lua/weapons/cw_base/cl_model.lua", "local RETICLE_TEXTURE_OFFSETS",
	"function SWEP:getDifferenceToAimPos")))()

local camera = Angle(20, 40, 5)
local eye = Vector(8, -15, 2)
local spritePos
EyeAngles = function() return camera end
EyePos = function() return eye end
cam = {IgnoreZ = function() end}
render = {
	SetMaterial = function() end,
	DrawSprite = function(pos) spritePos = pos end,
}
local weapon = setmetatable({
	isAiming = function() return true end,
	isReticleActive = function() return true end,
	getDifferenceToAimPos = function() return 1 end,
	getSightColor = function() return {} end,
	getReticleAngles = function() return Angle(0, 0, 0) end,
}, {__index = SWEP})
local attachment = {name = "dot", _reticleSize = 1}
weapon:DrawCotzReticleSprite(attachment, Vector(), Vector(), "dot")
local dot = spritePos + camera:Right() * (0.5 / 32) - camera:Up() * (0.5 / 32)
close((dot - (eye + camera:Forward() * 100)):Length(), 0)

weapon.freeAimOn = true
weapon:DrawCotzReticleSprite(attachment, Vector(), Vector(), "dot")
dot = spritePos + camera:Right() * (0.5 / 32) - camera:Up() * (0.5 / 32)
close((dot - (eye + Vector(100, 0, 0))):Length(), 0)

local rect
surface = {
	SetTexture = function() end,
	DrawTexturedRect = function(...) rect = {...} end,
}
local drawScopeTexture = assert(load(loadSection("lua/weapons/cw_base/cl_hud.lua",
	"local function drawScopeTexture", "function SWEP:DrawHUD") .. "return drawScopeTexture"))()
local chevron = {tex = 1, offset = {0, 0}, center = {0, 2 / 512}}
local screenWidth, screenHeight = 2560, 1080
drawScopeTexture(chevron, (screenWidth - screenHeight) * 0.5, 0, screenHeight, screenHeight)
close(rect[1] + rect[3] * 0.5, screenWidth * 0.5)
close(rect[2] + rect[4] * (0.5 + chevron.center[2]), screenHeight * 0.5)

local registered
CLIENT = true
CustomizableWeaponry = {
	textColors = {},
	registerAttachment = function(_, value) registered = value end,
}
surface.GetTextureID = function(path) return path end
surface.SetDrawColor = function() end
surface.DrawTexturedRectRotated = function() end
local reticleRect
surface.DrawTexturedRectUV = function(...) reticleRect = {...} end
Material = function() return {} end
ScrW = function() return screenWidth end
ScrH = function() return screenHeight end
FrameTime = function() return 1 end
function math.Approach(_, target) return target end
cam.Start2D = function() end
cam.End2D = function() end
function angleMethods:RotateAroundAxis(_, degrees) close(degrees, 0) end

local view
local targetDepth, clipping = 0, false
render.PushRenderTarget = function(_, _, _, width, height)
	assert(width == height)
	targetDepth = targetDepth + 1
end
render.PopRenderTarget = function() targetDepth = targetDepth - 1 end
DisableClipping = function(disabled)
	local wasDisabled = clipping
	clipping = disabled

	return wasDisabled
end
render.RenderView = function(cameraData) view = cameraData end
render.ComputeLighting = function() return {1, 1, 1} end

local scope = {
	ACOGAxisAlign = {right = 0, up = 0, forward = 0},
	BlendAng = Vector(),
	Owner = {
		EyeAngles = function() return Angle() end,
		GetShootPos = function() return Vector() end,
	},
	canUseComplexTelescopics = function() return true end,
	canSeeThroughTelescopics = function() return true end,
	getTelescopeAngles = function() error("scope must use the supplied scene camera") end,
	getRenderTargetSize = function(self) return self.size end,
}
local scopeOrigin, scopeAngles = Vector(5, 10, 15), Angle(-20, 35, 0)
for _, id in ipairs({"md_acog", "md_acog_fixed"}) do
	dofile("lua/cw/shared/attachments/" .. id .. ".lua")
	for _, size in ipairs({256, 1024}) do
		scope.size = size
		registered.drawRenderTarget(scope, scopeOrigin, scopeAngles)
		assert(view.origin == scopeOrigin and view.angles.p == -20 and view.angles.y == 35)
		assert(view.w == size and view.h == size and view.aspectratio == 1)
		assert(targetDepth == 0 and not clipping, "scope must restore the scene viewport and clipping")
		close(reticleRect[1] + reticleRect[3] * 0.5, size * 0.5)

		local topUV, bottomUV = reticleRect[6], reticleRect[8]
		local chevronUV = 0.5 + 2.5 / 512
		local projectedY = reticleRect[2] + reticleRect[4] * (chevronUV - topUV) / (bottomUV - topUV)
		close(projectedY, size * 0.5)
	end
end

local apertures = dofile("lua/cotz/optic_apertures.lua")
local environment = setmetatable({
	SWEP = SWEP,
	OPTIC_APERTURES = apertures,
	Ang0 = Angle(),
}, {__index = _G})
assert(load(loadSection("lua/weapons/cw_base/cl_model.lua",
	"local function offsetAttachment", "function SWEP:_drawAttachmentModel"), nil, "t", environment))()
local vectors = getmetatable(Vector()).__index
function vectors:LengthSqr() return self:Dot(self) end
function math.Clamp(value, minimum, maximum) return math.max(minimum, math.min(maximum, value)) end

local opticPath = "models/cw2/attachments/microt1.mdl"
local origin = eye + camera:Forward() * 5 - camera:Right() * 0.3 + camera:Up() * 0.2
local current = origin
local cached = 0
weapon.CW_VM = {
	GetPos = function() return current end,
	SetPos = function(_, value) current = value end,
	InvalidateBoneCache = function() cached = cached + 1 end,
	SetupBones = function() cached = cached + 1 end,
}
weapon.getStaticMountOrientation = function()
	return current, Angle()
end
weapon.getBoneOrientation = function()
	error("centering must use the rendered static slide mount")
end
weapon.ActualSightPos = Vector(1, 2, 3)
weapon.AimPos = weapon.ActualSightPos
weapon.BlendPos = weapon.AimPos
weapon.freeAimOn = false
weapon.cotzAimModel = {
	active = true, model = opticPath,
	pos = Vector(), angle = Angle(), size = Vector(0.3, 0.3, 0.3), _staticRel = true,
}

weapon:CenterCotzOptic()
local center = current + apertures[opticPath] * weapon.cotzAimModel.size
local fromEye = center - eye
close(fromEye:Dot(camera:Right()), 0)
close(fromEye:Dot(camera:Up()), 0)
close((current - origin):Dot(camera:Forward()), 0)
assert(cached == 2, "moving the viewmodel must rebuild its mount bones before drawing")

current = origin
weapon.AimPos = Vector()
weapon:CenterCotzOptic()
assert(current == origin, "backup sights must use their own aim")
weapon.AimPos = weapon.ActualSightPos
weapon.freeAimOn = true
weapon:CenterCotzOptic()
assert(current == origin, "Free Aim must keep its weapon-relative pose")
print("weapon reticle spec passed")
