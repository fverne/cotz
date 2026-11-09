-- Run from the addon root: luatex --luaonly tests/flashlight_spec.lua
local checks = 0
local function check(value, message)
	checks = checks + 1
	assert(value, message)
end

SERVER = true
CLIENT = false
AddCSLuaFile = function() end
Sound = function(value) return value end
CurTime = function() return 10 end
IsValid = function(value) return type(value) == "table" and value.valid ~= false end
local callbacks = {}
timer = {Simple = function(_, callback) callbacks[#callbacks + 1] = callback end}
SWEP = {Primary = {}, Secondary = {}}
assert(loadfile("lua/weapons/weapon_flashlight.lua"))()
local weapon = setmetatable({state = {}}, {__index = SWEP})
function weapon:GetClass() return "weapon_flashlight" end
function weapon:SetNWBool(key, value) self.state[key] = value end
function weapon:GetNWBool(key, default)
	if self.state[key] == nil then return default end

	return self.state[key]
end
function weapon:SetNextSecondaryFire(value) self.nextSecondary = value end
function weapon:SetNextPrimaryFire(value) self.nextPrimary = value end
local viewModel = {
	LookupSequence = function(_, name) return name end,
	ResetSequence = function(self, name) self.sequence = name end,
	SequenceDuration = function() return 0.5 end,
}
local owner = {alive = true, headlamp = false, active = weapon, sounds = 0}
function owner:Alive() return self.alive end
function owner:GetActiveWeapon() return self.active end
function owner:GetViewModel() return viewModel end
function owner:EmitSound() self.sounds = self.sounds + 1 end
function owner:GetNWBool() return self.headlamp end
function weapon:GetOwner() return owner end

check(weapon:Deploy(), "deploy succeeds")
weapon:SecondaryAttack()
check(weapon:GetNWBool("cotz/flashlight/active"), "handheld switches on without a headlamp")
check(weapon.nextSecondary == 10.23 and owner.sounds == 1, "toggle retains fire cooldown and one sound")
check(viewModel.sequence == "trigger", "toggle plays the switch animation")
callbacks[1]()
check(viewModel.sequence == "idle01", "switch animation returns to idle")
weapon:SecondaryAttack()
check(not weapon:GetNWBool("cotz/flashlight/active"), "second toggle switches off")
CLIENT = true
SERVER = false
weapon:SecondaryAttack()
check(not weapon:GetNWBool("cotz/flashlight/active"), "client prediction cannot change authoritative power")
CLIENT = false
SERVER = true
weapon:SecondaryAttack()
owner.headlamp = true
check(weapon:Holster() and not weapon:GetNWBool("cotz/flashlight/active"), "holstering clears handheld power")
check(owner.headlamp, "holstering preserves headlamp power")
weapon:SecondaryAttack()
weapon:OnDrop()
check(not weapon:GetNWBool("cotz/flashlight/active"), "dropping clears handheld power")
owner.alive = false
weapon:SecondaryAttack()
check(not weapon:GetNWBool("cotz/flashlight/active"), "dead owners cannot toggle")
owner.alive = true
owner.active = nil
weapon:SecondaryAttack()
check(not weapon:GetNWBool("cotz/flashlight/active"), "inactive weapons cannot toggle")

-- Exercise the existing renderer's light update without the GLua-only cleanup loop.
local file = assert(io.open("gamemodes/ix_cotz/plugins/multiplayerflashlight.lua"))
local source = file:read("*a")
file:close()
local prefix = source:sub(1, assert(source:find("if %(CLIENT%) then")) - 1)
local bodyStart = assert(source:find("\tlocal flashType =", 1, true))
local bodyEnd = assert(source:find("\tfunction PLUGIN:PostPlayerDraw", 1, true))
local rendererSource = prefix .. source:sub(bodyStart, bodyEnd - 1) .. "\nreturn flashlightThink"
rendererSource = rendererSource:gsub("!=", "~="):gsub("!", "not ")
PLUGIN = {}
FindMetaTable = function() return {} end
Material = function() return {} end
Color = function() return {} end
local vectorMeta = {}
vectorMeta.__add = function(a) return a end
vectorMeta.__sub = function(a) return a end
vectorMeta.__mul = function(a) return a end
local position = setmetatable({}, vectorMeta)
local angles = {Forward = function() return position end, Up = function() return position end,
	Right = function() return position end}
function owner:EyePos() return position end
function owner:EyeAngles() return angles end
function owner:getFlashType() return 1 end
function owner:GetNoDraw() return true end
ProjectedTexture = function()
	return setmetatable({
		Remove = function(self) self.valid = false end,
		Update = function(self) self.updated = true end,
	}, {__index = function() return function() end end})
end
FLASHES = {}
local renderLight = assert(load(rendererSource, "@multiplayerflashlight-renderer"))()
owner.headlamp = false
owner.active = weapon
weapon:SecondaryAttack()
renderLight(owner)
check(owner.flash and owner.flash.updated, "handheld uses the headlamp projected-texture renderer")
weapon:Holster()
renderLight(owner)
check(not IsValid(owner.flash), "switching off removes the projected light")
owner.headlamp = true
renderLight(owner)
check(IsValid(owner.flash), "headlamp still renders with the handheld off")
owner.alive = false
renderLight(owner)
check(not IsValid(owner.flash), "death removes the projected light")
print("Flashlight: " .. checks .. " checks passed")
