-- Run from the addon root: luatex --luaonly tests/burer_stamina_spec.lua
-- Exercises the burer's real ability definitions and methods on the stalker_ai ability runner.
local fixture = dofile("tests/helpers/mutant_base.lua")
local checks = 0
local function check(value, message)
	checks = checks + 1
	assert(value, message)
end

local base = fixture.LoadBase("sv_abilities")
local path = "lua/entities/npc_mutant_burer/init.lua"
local file = assert(io.open(path))
local source = file:read("*a"):gsub("^\239\187\191", "")
file:close()

AddCSLuaFile, include = function() end, function() end
-- Inherited sound tables come from STALKERNPCBaseVars; give the class missing keys as empty tables.
ENT = setmetatable({}, {__index = function(entity, key)
	local value = base[key]
	if value ~= nil then return value end
	value = {}
	rawset(entity, key, value)

	return value
end})
assert(load(source, "@" .. path))()
local burer = setmetatable(ENT, {__index = base})

local effects = 0
EffectData = function()
	return setmetatable({}, {__index = function() return function() end end})
end
util = {Effect = function() effects = effects + 1 end}

local function makeBurer(enemy)
	local actor = fixture.Actor(burer, {enemy = enemy})
	actor:STALKERNPCInitAbilities()

	return actor
end

local punches, stamina = 0, 100
local weapon = {valid = true, GetNoDraw = function() return false end}
local player = fixture.Target(Vector(600), {
	player = true,
	GetActiveWeapon = function() return weapon end,
	ViewPunch = function() punches = punches + 1 end,
	RestoreStamina = function(_, amount) stamina = stamina + amount end,
})
local npc = fixture.Target(Vector(600))
local removed = fixture.Target(Vector(600), {valid = false})

for _, enemy in ipairs({npc, removed, false, player}) do
	fixture.now = 10
	local actor = makeBurer(enemy or nil)
	check(actor:STALKERNPCStartAbility(actor.cotzAbilityByName.stamina, enemy or nil), "stamina attack starts")
	actor.enemy = nil
	actor:STALKERNPCCancelAbilityWindup()
	actor.enemy = enemy or nil
	check(actor.cotzAbility and actor.Animation == "S_Stamina_Attack", "target loss keeps the stamina windup")
	fixture.now = 10.5
	actor:STALKERNPCUpdateAbility()
	check(actor.cotzAbility.phase == 2, "impact advances to recovery for every target type")
	fixture.now = 13
	actor:STALKERNPCUpdateAbility()
	check(actor.cotzAbility == nil and actor.stopped == 1, "recovery clears the attack after target loss")
	check(actor.NextAbilityTime == 13.5, "recovery preserves the ability cooldown")
end
check(punches == 1 and stamina == 20, "only the player receives the original effects, exactly once")

local originalRandom = math.random
-- Chance rolls pass and integer rolls take their lowest value, which also raises the shield.
math.random = function(low) return low or 0 end
for _, enemy in ipairs({npc, player}) do
	fixture.now = 20
	local actor = makeBurer(enemy)
	fixture.now = 21
	actor:STALKERNPCTryAbilities(enemy, 0)
	local started = actor.cotzAbility and actor.cotzAbility.definition.name
	check(started == (enemy == player and "stamina" or "blast"), "only players start stamina attacks")
end

fixture.now = 30
local actor = makeBurer(player)
fixture.now = 31
check(not actor:STALKERNPCTryAbilities(player, 2), "ranged abilities wait while the target is in melee reach")
actor.cotzNextAbilityCheck = 0
actor.cotzAbilityReady.stamina = 100
actor:STALKERNPCTryAbilities(player, 0)
check(actor.cotzAbility.definition.name == "blast" and actor.Animation == "S_Power_Attack", "blast winds up")

local damage = {
	GetDamagePosition = function() return Vector(10) end,
	GetDamageType = function() return DMG_SONIC end,
}
check(actor:STALKERNPCDamageTake(damage, 1) == 1 and actor.cotzAbility.definition.name == "shield",
	"damage raises the shield and interrupts the blast")
check(actor:STALKERNPCDamageTake(damage, 1) == 1 and actor.Animation == "S_Shield_Start",
	"the shield cooldown prevents restarting it")
fixture.now = 31.7
actor:STALKERNPCUpdateAbility()
check(actor:STALKERNPCDamageTake(damage, 1) == 0.1 and effects == 1, "the raised shield absorbs damage")
damage.GetDamageType = function() return DMG_AIRBOAT end
check(actor:STALKERNPCDamageTake(damage, 1) == 0.5, "armour-piercing damage partially penetrates the shield")
fixture.now = 34.5
actor:STALKERNPCUpdateAbility()
check(actor.cotzAbility == nil and actor.PlayingAnimation == false, "the shield lowers after its hold")
math.random = originalRandom

print("Burer ability checks passed: " .. checks)
