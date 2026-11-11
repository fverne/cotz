-- Run from the addon root: luatex --luaonly tests/burer_stamina_spec.lua
local path = "lua/entities/npc_mutant_burer/init.lua"
local file = assert(io.open(path))
local source = file:read("*a")
file:close()

-- Translate legacy GLua operators for the standalone Lua runner.
local start = assert(source:find("function ENT:STALKERNPCThink()", 1, true))
local finish = assert(source:find("function ENT:STALKERNPCDamageTake", start, true))
source = source:sub(start, finish - 1):gsub("&&", " and "):gsub("!=", "~=")
ENT = {}
assert(load(source, "@" .. path))()

local now = 10
function CurTime() return now end
function IsValid(entity) return entity ~= nil and entity.valid == true end
function Angle(pitch, yaw, roll) return {pitch, yaw, roll} end

local function makeBurer(enemy)
	return setmetatable({
		valid = true,
		enemy = enemy,
		shield1 = 0, shield2 = 0, shield3 = 0, IsShielding = 0,
		stam1 = 9, stam2 = 12, IsStamAttack = 1,
		blast1 = 0, blast2 = 0, IsBlast = 0,
		MustShield = 0, PlayingAnimation = false, CanGrab = 0, CanPush = 100,
		GetEnemy = function(self) return self.enemy end,
		STALKERNPCStopAllTimers = function(self) self.stopped = true end,
		STALKERNPCClearAnimation = function(self) self.PlayingAnimation = false end,
		STALKERNPCPlayAnimation = function(self) self.PlayingAnimation = true end,
	}, {__index = ENT})
end

local punches = 0
local stamina = 100
local weapon = {valid = true, GetNoDraw = function() return false end}
local player = {
	valid = true,
	IsPlayer = function() return true end,
	GetActiveWeapon = function() return weapon end,
	ViewPunch = function() punches = punches + 1 end,
	RestoreStamina = function(_, amount) stamina = stamina + amount end,
}
local npc = {valid = true, IsPlayer = function() return false end}
local removed = {valid = false}

for _, enemy in ipairs({npc, removed, false, player}) do
	now = 10
	local burer = makeBurer(enemy or nil)
	burer:STALKERNPCThink()
	assert(burer.IsStamAttack == 2, "impact advances to recovery for every target type")
	burer:STALKERNPCThink()
	now = 13
	burer:STALKERNPCThink()
	assert(burer.IsStamAttack == 0 and burer.stopped, "recovery clears the attack after target loss")
	assert(burer.NextAbilityTime == 13.5, "recovery preserves the ability cooldown")
end
assert(punches == 1 and stamina == 20, "only the player receives the original effects, exactly once")

-- Force the grab roll to verify target eligibility without random test failures.
local originalRandom = math.random
math.random = function() return 1 end
now = 10
for _, enemy in ipairs({npc, removed, false, player}) do
	local burer = makeBurer(enemy or nil)
	burer.IsStamAttack = 0
	burer:STALKERNPCDistanceForMeleeTooBig()
	assert(burer.IsStamAttack == (enemy == player and 1 or 0), "only players start stamina attacks")
end
math.random = originalRandom

print("Burer stamina regression checks passed")
