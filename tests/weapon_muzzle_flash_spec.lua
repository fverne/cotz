dofile("tests/helpers/source_math.lua")

-- First-person muzzle flash placement. The Anomaly viewmodels orient their muzzle attachments sideways, so the
-- flash must use only the attachment position and aim along the view instead of following the attachment axes.
local file = assert(io.open("lua/weapons/cw_base/cl_model.lua"))
local source = file:read("*a")
file:close()

local first = assert(source:find("local function getMuzzleAttachmentIndex", 1, true))
local last = assert(source:find("function SWEP:getMuzzleModel", first, true))

SWEP = {}
CW_AIMING = 2
function IsValid(entity) return entity ~= nil end
function CurTime() return 10 end
function FrameTime() return 0.5 end

local viewAngles = {
	Forward = function() return Vector(1, 0, 0) end,
	Right = function() return Vector(0, 1, 0) end,
	Up = function() return Vector(0, 0, 1) end,
}
function EyeAngles() return viewAngles end

local effects, lights = {}, {}
function ParticleEffect(name, pos, ang, parent)
	effects[#effects + 1] = {name = name, pos = pos, ang = ang, parent = parent}
end
function ParticleEffectAttach() error("the flash must not follow the attachment axes") end
function DynamicLight()
	local light = {}
	lights[#lights + 1] = light
	return light
end

assert(load(source:sub(first, last - 1)))()

local function newWeapon(attachments, overrides)
	local model = {
		stopped = 0,
		StopParticles = function(self) self.stopped = self.stopped + 1 end,
		LookupAttachment = function(_, name) return attachments[name] or 0 end,
		GetAttachment = function(_, index)
			if index == 0 then error("attachment 0 is not a muzzle") end
			return {Pos = Vector(40 + index, 0, 0)}
		end,
	}

	local weapon = {
		Owner = {
			ShouldDrawLocalPlayer = function() return false end,
			GetVelocity = function() return Vector(100, 0, 0) end,
			GetAimVector = function() return Vector(1, 0, 0) end,
		},
		CW_VM = model,
		dt = {State = 0, Suppressed = false},
		MuzzleAttachmentName = "1",
		MuzzleAttachment = 1,
		MuzzleEffect = "flash",
		MuzzleEffectSupp = "flash_supp",
		EntIndex = function() return 7 end,
		canUseSimpleTelescopics = function() return false end,
	}

	for key, value in pairs(overrides or {}) do
		weapon[key] = value
	end

	return setmetatable(weapon, {__index = SWEP})
end

local function fire(weapon)
	effects, lights = {}, {}
	weapon:CreateMuzzle()
end

-- An Anomaly gun names only "muzzle", so the default "1" must fall back to it rather than attachment 0.
local weapon = newWeapon({muzzle = 3})
fire(weapon)
assert(#effects == 1, "one flash per shot")
assert(effects[1].name == "flash" and effects[1].parent == weapon.CW_VM, "flash belongs to the viewmodel")
assert(effects[1].ang == viewAngles, "aim the flash along the view, not along the attachment axes")
assert(math.abs(effects[1].pos.x - 46) < 1e-6, "spawn at the muzzle plus the velocity compensation")
assert(effects[1].pos.y == 0 and effects[1].pos.z == 0, "stay on the muzzle")
assert(weapon.CW_VM.stopped == 1, "clear the previous flash")
assert(#lights == 1 and math.abs(lights[1].Pos.x - 46) < 1e-6, "light the muzzle, 3 units forward")
assert(lights[1].DieTime == 10.5, "the light lasts one frame")

-- A named muzzle attachment wins over the conventional name.
weapon = newWeapon({["1"] = 2, muzzle = 3})
fire(weapon)
assert(math.abs(effects[1].pos.x - 45) < 1e-6, "prefer the configured attachment name")

-- No named attachment at all uses the configured index.
weapon = newWeapon({}, {MuzzleAttachment = 4})
fire(weapon)
assert(math.abs(effects[1].pos.x - 47) < 1e-6, "fall back to the configured index")

-- Aiming through a simulated center muzzle moves the flash in front of the sight.
weapon = newWeapon({muzzle = 3}, {SimulateCenterMuzzle = true})
weapon.dt.State = CW_AIMING
fire(weapon)
assert(math.abs(effects[1].pos.x - 116) < 1e-6 and effects[1].pos.z == -3, "center the flash while aiming")
assert(math.abs(lights[1].Pos.x - 46) < 1e-6, "the light keeps the muzzle position")

-- Muzzle position modifiers shift the flash in view space.
weapon = newWeapon({muzzle = 3}, {MuzzlePosMod = Vector(1, 2, 3)})
fire(weapon)
assert(effects[1].pos.x == 48 and effects[1].pos.y == 1 and effects[1].pos.z == 3, "apply MuzzlePosMod")

-- Suppressed shots use the suppressed effect without a light, and may opt out.
weapon = newWeapon({muzzle = 3})
weapon.dt.Suppressed = true
fire(weapon)
assert(effects[1].name == "flash_supp" and #lights == 0, "suppressed flash has no muzzle light")
weapon = newWeapon({muzzle = 3}, {NoSilMuz = true})
weapon.dt.Suppressed = true
fire(weapon)
assert(#effects == 0 and #lights == 0, "NoSilMuz skips the suppressed flash")

-- Nothing happens without a usable attachment, in third person, or without a viewmodel.
weapon = newWeapon({muzzle = 3})
weapon.CW_VM.GetAttachment = function() return nil end
fire(weapon)
assert(#effects == 0 and #lights == 0, "no attachment means no flash")
weapon = newWeapon({muzzle = 3})
weapon.Owner.ShouldDrawLocalPlayer = function() return true end
fire(weapon)
assert(#effects == 0 and weapon.CW_VM.stopped == 0, "the world effect handles third person")
weapon = newWeapon({muzzle = 3})
weapon.CW_VM = nil
fire(weapon)
assert(#effects == 0, "a missing viewmodel is never dereferenced")

print("weapon muzzle flash spec passed")
