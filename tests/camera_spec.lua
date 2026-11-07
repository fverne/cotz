-- Run from the addon root: luatex --luaonly tests/camera_spec.lua
local checks = 0
local function check(value, message)
	checks = checks + 1
	assert(value, message)
end

local vectorMeta = {}
vectorMeta.__index = vectorMeta
function Vector(x, y, z) return setmetatable({x = x, y = y, z = z}, vectorMeta) end
function vectorMeta:Dot(other) return self.x * other.x + self.y * other.y + self.z * other.z end
function vectorMeta:LengthSqr() return self:Dot(self) end
function vectorMeta:DistToSqr(other) return (self - other):LengthSqr() end
function vectorMeta.__sub(a, b) return Vector(a.x - b.x, a.y - b.y, a.z - b.z) end
function vectorMeta.__add(a, b) return Vector(a.x + b.x, a.y + b.y, a.z + b.z) end
function vectorMeta.__mul(a, scale) return Vector(a.x * scale, a.y * scale, a.z * scale) end
local angles = {
	Forward = function() return Vector(1, 0, 0) end,
	Right = function() return Vector(0, 1, 0) end,
	Up = function() return Vector(0, 0, 1) end,
}
local now, traceMode, traces = 10, "clear", 0
CurTime = function() return now end
IsValid = function(entity) return type(entity) == "table" and not entity.invalid end
isvector = function(value) return getmetatable(value) == vectorMeta end
MASK_VISIBLE, ACT_VM_PRIMARYATTACK, ACT_VM_DRAW, ACT_VM_IDLE = 1, 2, 3, 4
bit = {band = function(value, flag) return math.floor(value / flag) % 2 == 1 and flag or 0 end}
SERVER, CLIENT = true, false
local photoEvents = {}
hook = {Run = function(event, photo)
	if event == "cotz/camera/photo-taken" then photoEvents[#photoEvents + 1] = photo end
end}
game = {GetMap = function() return "test_map" end}
local root = "gamemodes/ix_cotz/plugins/"
local plugins, candidates, sent, assets, included = {}, {}, 0, {}, {}
local client, weapon
util = {
	AddNetworkString = function() end,
	TraceLine = function(data)
		traces = traces + 1
		check(data.mask == MASK_VISIBLE, "Visibility mask")
		check(data.filter[1] == client and data.filter[2] == weapon, "Owner and camera ignored")
		if traceMode == "clear" then return {Hit = false} end
		if traceMode == "target" then return {Hit = true, Entity = candidates[1]} end
		if traceMode == "solid" then return {StartSolid = true} end
		return {Hit = true, HitPos = Vector(20, 0, 0)}
	end,
}
resource = {AddSingleFile = function(path) assets[#assets + 1] = path end}
net = {
	Start = function() end, WriteVector = function() end, WriteAngle = function() end,
	WriteBool = function() end, WriteUInt = function() end, WriteString = function() end,
	Send = function(recipient) check(recipient == client, "Only photographer receives result") sent = sent + 1 end,
	Receive = function() end,
}
ents = {
	FindInSphere = function() return candidates end,
	FindByClass = function(class)
		local found = {}
		for _, entity in ipairs(candidates) do
			if entity:GetClass() == class then found[#found + 1] = entity end
		end

		return found
	end,
}
ix = {
	plugin = {list = plugins, Get = function(id) return plugins[id] end},
	util = {Include = function(path)
		included[#included + 1] = path
		if path:sub(1, 3) ~= "cl_" then dofile(root .. "camera/" .. path) end
	end},
}
PLUGIN = {}
dofile(root .. "camera/sh_plugin.lua")
local camera = PLUGIN
plugins.camera = camera
check(#assets == 0 and #included == 3, "Realm includes load without registering asset downloads")
local aspectError = math.abs(camera.photoWidth / camera.photoHeight - camera.photoAspect)
check(aspectError <= 1 / camera.photoHeight, "Photo dimensions match geometry within pixel rounding")
check(camera.HUDPaint == nil, "Client render code does not execute on server")

local photo = {origin = Vector(0, 0, 0), angles = angles, subjects = {}}
local character = {GetID = function() return 42 end}
client = {
	IsPlayer = function() return true end, Alive = function() return true end,
	GetCharacter = function() return character end, InVehicle = function() return false end,
	GetShootPos = function() return Vector(0, 0, 0) end, EyeAngles = function() return angles end,
	GetViewEntity = function(self) return self end,
}
weapon = {
	GetClass = function() return "ix_camera" end, GetOwner = function() return client end,
	SendWeaponAnim = function() end, EmitSound = function() end,
}
client.GetActiveWeapon = function() return weapon end
photo.client, photo.weapon = client, weapon
check(camera:IsPhotoPointVisible(Vector(100, 0, 0), photo), "Centered point visible")
check(not camera:IsPhotoPointVisible(Vector(-100, 0, 0), photo), "Behind camera excluded")
check(not camera:IsPhotoPointVisible(Vector(camera.photoRange + 1, 0, 0), photo), "Range enforced")
local halfWidth = 100 * math.tan(math.rad(camera.photoFOV / 2))
local halfHeight = halfWidth / camera.photoAspect
check(camera:IsPhotoPointVisible(Vector(100, halfWidth - 1, 0), photo), "Horizontal frame edge included")
check(not camera:IsPhotoPointVisible(Vector(100, halfWidth + 1, 0), photo), "Outside horizontal frame excluded")
check(camera:IsPhotoPointVisible(Vector(100, 0, halfHeight - 1), photo), "Vertical frame edge included")
check(not camera:IsPhotoPointVisible(Vector(100, 0, halfHeight + 1), photo), "Rectangular vertical limit enforced")
traceMode = "wall"
check(not camera:IsPhotoPointVisible(Vector(100, 0, 0), photo), "Opaque wall blocks point")
check(not camera:IsPhotoPointVisible(Vector(22, 0, 0), photo), "Even thin foreground walls block points")
traceMode = "solid"
check(not camera:IsPhotoPointVisible(Vector(100, 0, 0), photo), "Starting inside solid blocks photo")
traceMode = "clear"

local function entity(class, index, position)
	return {
		GetClass = function() return class end, EntIndex = function() return index end,
		GetNoDraw = function() return false end, WorldSpaceCenter = function() return position end,
		GetPos = function() return position end, LocalToWorld = function(_, point) return position + point end,
		OBBMins = function() return Vector(-1, -1, -1) end,
		OBBMaxs = function() return Vector(1, 1, 1) end,
	}
end
local visible = entity("npc_mutant_dog", 15, Vector(100, 0, 0))
local outside = entity("ix_item", 16, Vector(100, 0, halfHeight + 3))
local unrelated = entity("prop_physics", 17, Vector(100, 0, 0))
local hidden = entity("ix_item", 18, Vector(100, 0, 0))
hidden.GetNoDraw = function() return true end
candidates = {visible, outside, unrelated, hidden}
camera:CollectPhotoSubjects(photo)
check(#photo.subjects == 1 and photo.subjects[1].id == "15", "Only visible CotZ entities recorded")
traceMode = "target"
check(camera:IsPhotoPointVisible(visible:WorldSpaceCenter(), photo, visible), "Trace hitting subject is visible")
traceMode = "clear"
local partial = entity("ix_item", 19, Vector(100, 0, halfHeight + 0.25))
check(camera:IsPhotoEntityVisible(partial, photo), "Visible corner includes partially framed entity")

-- Exercise the shared spawn collector rather than supplying camera-specific mock records.
PLUGIN = {}
local originalInclude = ix.util.Include
ix.util.Include = function() end
dofile(root .. "spawnpointesp/sh_plugin.lua")
dofile(root .. "spawnpointesp/sv_plugin.lua")
plugins.spawnpointesp = PLUGIN
ix.util.Include = originalInclude
plugins.anomalycontroller = {anomalypoints = {
	test_map = {[8] = {Vector(100, 0, 0), 400, "electra"}},
	other_map = {{Vector(100, 0, 0), 400, "burner"}},
}}
plugins.spawns = {spawns = {loner = {default = {[3] = Vector(100, 0, 0)}}}}
plugins.simplecrossserver = {mapdata = {test_map = {loadzones = {gate = {pos = Vector(100, 0, 0)}}}}}
local container = entity("ix_container", 20, Vector(100, 0, 0))
container.GetSpawnCategory = function() return "tools" end
container.GetCyclicalCategory = function() return "" end
candidates = {visible, container}
photo.subjects = {}
camera:CollectPhotoSubjects(photo)
local found = {}
for _, subject in ipairs(photo.subjects) do found[subject.kind .. ":" .. subject.id] = subject end
check(found["spawnpoint:anomalies/8"] ~= nil, "Saved map record ID preserved")
check(found["spawnpoint:anomalies/1"] == nil, "Other map not photographed")
check(found["spawnpoint:players/loner / default/3"] ~= nil, "Faction/class spawn identity preserved")
check(found["spawnpoint:arrivals/gate"] ~= nil, "Arrival named identity preserved")
check(found["spawnpoint:containers/20"] ~= nil, "Entity-backed container spawn recorded")
local containerPoints = plugins.spawnpointesp:CollectSpawnPoints({key = "containers"})
check(containerPoints[1].entity == container, "Spawn collector preserves entity for occlusion")

local result = camera:TakePhoto(client, weapon)
check(result and result.characterID == 42 and result.map == "test_map", "Server character and map recorded")
check(weapon.lastPhoto == result and sent == 1, "Latest result retained and sent once")
check(camera:TakePhoto(client, weapon) == nil and sent == 1, "Repeated shutter is rate-limited")
now = now + 2
local otherWeapon = {}
client.GetActiveWeapon = function() return otherWeapon end
check(camera:TakePhoto(client, weapon) == nil, "Inactive weapon rejected")
client.GetActiveWeapon = function() return weapon end
weapon.GetOwner = function() return otherWeapon end
check(camera:TakePhoto(client, weapon) == nil, "Foreign weapon rejected")
weapon.GetOwner = function() return client end
client.GetCharacter = function() return nil end
check(camera:TakePhoto(client, weapon) == nil, "Missing character rejected")
client.GetCharacter = function() return character end
client.Alive = function() return false end
check(camera:TakePhoto(client, weapon) == nil, "Dead player rejected")
client.Alive = function() return true end

camera.maxPhotoSubjects = 2
result = camera:TakePhoto(client, weapon)
check(#result.subjects == 2 and result.truncated, "Photo list bounded with explicit truncation")
now = now + 2
candidates, plugins.spawnpointesp = {}, nil
result = camera:TakePhoto(client, weapon)
check(#result.subjects == 0 and not result.truncated, "Empty photo replaces previous result")

SWEP = {Primary = {}, Secondary = {}}
dofile(root .. "camera/entities/weapons/ix_camera.lua")
check(SWEP.Primary.Ammo == "none" and SWEP.Primary.ClipSize == -1, "Camera needs no ammo")
check(SWEP:TranslateFOV(75) == 75 and SWEP:TranslateFOV(100) == 100, "Camera preserves the player's world FOV")
check(type(SWEP.PrimaryAttack) == "function", "SWEP registers without capturing loader PLUGIN")

SERVER, CLIENT, PLUGIN = false, true, camera
dofile(root .. "camera/entities/weapons/ix_camera.lua")
local activity, cycle = ACT_VM_IDLE, 0.4
local animatedViewModel = {
	GetSequence = function() return 0 end,
	GetSequenceActivity = function() return activity end,
	SetCycle = function(_, value) cycle = value end,
}
check(SWEP:PreDrawViewModel(animatedViewModel) == nil, "Idle camera still allows the model and screen to render")
check(cycle == 0, "Animated idle holds a fixed hand pose")
cycle = 0.8
SWEP:PreDrawViewModel(animatedViewModel)
check(cycle == 0, "Idle pose stays fixed after each frame's viewmodel interpolation")
for _, animation in ipairs({ACT_VM_DRAW, ACT_VM_PRIMARYATTACK}) do
	activity, cycle = animation, 0.5
	SWEP:PreDrawViewModel(animatedViewModel)
	check(cycle == 0.5, "Draw and shutter animations keep their progress")
end

-- Client rendering must use the authoritative viewpoint and replace only the latest artifact pair.
local receive, saved, renderView, renderDepth = nil, {}, nil, 0
local captureFails = false
local sounds, targets, screenViews = 0, 0, 0
LocalPlayer = function() return client end
client.ShouldDrawLocalPlayer = function() return false end
client.GetFOV = function() return 90 end
EyePos = client.GetShootPos
EyeAngles = function() return angles end
local cameraHidden = false
weapon.GetNoDraw = function() return cameraHidden end
weapon.SetNoDraw = function(_, hidden) cameraHidden = hidden end
surface = {
	PlaySound = function(path)
		check(path == "items/camera/snap.wav", "Original shutter sound used")
		sounds = sounds + 1
	end,
	SetDrawColor = function() end, DrawRect = function() end,
	SetMaterial = function() end, DrawTexturedRect = function() end,
}
local values, cursor
local function read()
	cursor = cursor + 1

	return values[cursor]
end
net.Receive = function(_, callback) receive = callback end
net.ReadVector, net.ReadAngle, net.ReadBool, net.ReadUInt, net.ReadString = read, read, read, read, read
ix.cotzUI = {colors = {text = {}, red = {}}}
chat = {AddText = function() end}
file = {
	CreateDir = function() end,
	Write = function(path, data) saved[path] = data end,
}
util.TableToJSON = function(data) return data end
GetRenderTarget = function(name, width, height)
	targets = targets + 1
	if name == "cotz_camera_photo" then
		check(width == camera.photoWidth and height == camera.photoHeight, "Configured capture dimensions")
	else
		check(width == 512 and height == 512, "Live screen uses a small reusable texture")
	end

	return {GetName = function() return name end}
end
CreateMaterial = function() return {} end
local clipDepth, clipping = 0, false
render = {
	PushRenderTarget = function() renderDepth = renderDepth + 1 end,
	PopRenderTarget = function() renderDepth = renderDepth - 1 end,
	Clear = function() end,
	RenderView = function(view)
		renderView = view
		if view.w == 512 then
			screenViews = screenViews + 1
			camera:PostRender()
		end
	end,
	Capture = function() return not captureFails and "jpeg-data" or nil end,
	EnableClipping = function(enabled)
		local previous = clipping
		clipping = enabled

		return previous
	end,
	PushCustomClipPlane = function() clipDepth = clipDepth + 1 end,
	PopCustomClipPlane = function() clipDepth = clipDepth - 1 end,
}
cam = {Start2D = function() end, End2D = function() end, Start3D2D = function() end, End3D2D = function() end}
dofile(root .. "camera/cl_viewfinder.lua")
dofile(root .. "camera/cl_plugin.lua")
values = {Vector(12, 13, 14), angles, false, 1, true, "anomalies/8", "anomalies", "Electra", Vector(100, 0, 0)}
cursor = 0
receive()
camera:PostRender()
check(renderView.origin.x == 12 and renderView.angles == angles, "Photo uses server shutter viewpoint")
check(renderView.drawhud == false and renderView.drawviewmodel == false, "Photo excludes HUD and weapon")
check(renderView.fov == camera.photoFOV and renderView.aspect == camera.photoAspect, "Image matches subject frame")
check(renderDepth == 0, "Render target restored after capture")
check(saved["cotz/camera/latest.jpg"] == "jpeg-data", "JPEG saved")
check(saved["cotz/camera/latest.json"].subjects[1].id == "anomalies/8", "Typed subject data saved beside JPEG")
check(sounds == 1, "One local shutter sound per accepted photo")
check(screenViews == 1 and not cameraHidden, "Live view renders once and restores weapon visibility")
local viewModel = {
	LookupAttachment = function(_, name) return name == "controlpanel0_ll" and 1 or 2 end,
	GetAttachment = function(_, index) return {Pos = Vector(10, index, 0), Ang = angles} end,
}
camera:DrawCameraScreen(viewModel, 90)
check(clipDepth == 0 and not clipping, "Screen drawing restores clipping state")
check(screenViews == 1, "Screen drawing does not recursively render the world")
camera:PostRender()
check(screenViews == 2 and targets == 2, "Live preview refreshes without taking photos or allocating textures")
check(sounds == 1, "Live preview does not play shutter sounds")
client.ShouldDrawLocalPlayer = function() return true end
camera:PostRender()
check(screenViews == 2, "Third person does not update the first-person screen")
client.ShouldDrawLocalPlayer = function() return false end
values, cursor = {Vector(0, 0, 0), angles, false, 0}, 0
receive()
camera:PostRender()
check(#saved["cotz/camera/latest.json"].subjects == 0, "Empty client photo replaces old subject list")
captureFails = true
values, cursor = {Vector(0, 0, 0), angles, false, 0}, 0
receive()
camera:PostRender()
check(renderDepth == 0 and saved["cotz/camera/latest.jpg"] == "jpeg-data", "Failed capture restores render state")
print("camera_spec: " .. checks .. " checks passed")
