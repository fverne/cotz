-- Run from the addon root: luatex --luaonly tests/anomaly_detector_spec.lua
local checks = 0
local function check(value, message)
	checks = checks + 1
	assert(value, message)
end

local vectorMeta = {}
vectorMeta.__index = vectorMeta
function vectorMeta:DistToSqr(other)
	return (self.x - other.x) ^ 2
end

local function vector(x)
	return setmetatable({x = x}, vectorMeta)
end

local playerMeta = {}
local function client(position, enabled)
	return setmetatable({
		position = position, enabled = enabled, beeps = 0,
		GetPos = function(self) return vector(self.position) end,
		GetNetVar = function(self, key)
			check(key == "ixhasanomdetector", "detector retains the existing power/equipment netvar")

			return self.enabled
		end,
		EmitSound = function(self, sound)
			check(sound == "stalkerdetectors/anom_prox.wav", "detector retains the existing beep sound")
			self.beeps = self.beeps + 1
		end,
	}, {__index = playerMeta})
end

local function anomaly(position, class)
	return {
		position = position,
		GetPos = function(self) return vector(self.position) end,
		GetClass = function() return class or "anom_electra_anomaly" end,
	}
end

local now, scans = 10, 0
local wearer = client(0, true)
local bystander = client(0, false)
local near = anomaly(100)
local far = anomaly(350)
local prop = anomaly(1, "prop_physics")
local candidates = {far, prop, near}
local environment = setmetatable({
	SERVER = false, PLUGIN = {}, CurTime = function() return now end,
	FindMetaTable = function(name)
		check(name == "Player", "only the existing player API is extended")

		return playerMeta
	end,
	IsValid = function(entity) return type(entity) == "table" and entity.valid ~= false end,
	player = {Iterator = function() return ipairs({wearer, bystander}) end},
	ents = {FindInSphere = function(_, range)
		check(range == 512, "scan retains the existing query range")
		scans = scans + 1

		return candidates
	end},
}, {__index = _G})
local path = "gamemodes/ix_cotz/plugins/anomalydetector/sh_plugin.lua"
assert(loadfile(path, "t", environment))()
check(environment.PLUGIN.Think == nil and scans == 0, "clients do not register scans or duplicate beep logic")
check(wearer:hasAnomdetector() and not bystander:hasAnomdetector(), "shared power query remains compatible")
environment.SERVER = true
environment.PLUGIN = {}
assert(loadfile(path, "t", environment))()
local plugin = environment.PLUGIN
plugin:Think()
check(scans == 1 and wearer.beeps == 1 and bystander.beeps == 0, "only an enabled wearer's detector scans and beeps")
now = 10.15
plugin:Think()
check(scans == 1 and wearer.beeps == 1, "intervening ticks reuse the nearest anomaly and respect beep timing")
now = 10.2
plugin:Think()
check(scans == 2 and wearer.beeps == 1, "scan runs at the exact 0.2-second deadline")
now = 10.25
plugin:Think()
check(scans == 2 and wearer.beeps == 2, "nearest anomaly drives beeps independently of the scan deadline")
wearer.position = -400
now = 10.26
plugin:Think()
check(scans == 2 and wearer.beeps == 2, "moving away silences a cached target immediately")
wearer.position = 0
near.valid = false
now = 10.3
plugin:Think()
check(scans == 2 and wearer.beeps == 2, "removed cached entities are never used")
candidates = {far, prop}
now = 10.41
plugin:Think()
check(scans == 3 and wearer.beeps == 2, "rescan selects a remaining target without resetting the beep timer")
now = 11.2
plugin:Think()
check(wearer.beeps == 3, "remaining anomaly uses its longer distance-based interval")
wearer.enabled = false
now = 11.21
plugin:Think()
local previousScans = scans
check(wearer.beeps == 3, "powering off immediately suppresses beeps")
now = 11.22
wearer.enabled = true
plugin:Think()
check(scans == previousScans + 1, "powering on immediately refreshes the target cache")
far.position = 0
now = 11.3
plugin:Think()
check(wearer.beeps == 4, "point-blank detector has a 0.1-second minimum interval")
now = 11.31
plugin:Think()
check(wearer.beeps == 4, "point-blank proximity cannot emit a beep every tick")
now = 11.41
plugin:Think()
check(wearer.beeps == 5, "point-blank proximity resumes at the minimum beep deadline")
far.position = 400
now = 12
plugin:Think()
check(wearer.beeps == 5, "exact 400-unit boundary remains outside the beep range")
far.position = 100
bystander.enabled = true
now = 13
plugin:Think()
check(wearer.beeps == 6 and bystander.beeps == 1, "wearers retain independent scan and beep state")
candidates = {prop}
now = 14
plugin:Think()
check(wearer.beeps == 6 and bystander.beeps == 1, "unrelated nearby entities never trigger the detector")
check(environment.anoms == nil and environment.dist == nil, "detector scans do not leak globals")

print(string.format("PASS: %d anomaly detector checks", checks))
