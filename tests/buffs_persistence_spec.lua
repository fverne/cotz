-- Run from the addon root: luatex --luaonly tests/buffs_persistence_spec.lua
local checks = 0
local function check(value, message)
	checks = checks + 1
	assert(value, message)
end

local function near(actual, expected, message)
	check(math.abs(actual - expected) < 0.000001, message)
end

function table.Copy(value)
	local copy = {}
	for key, entry in pairs(value) do
		copy[key] = type(entry) == "table" and table.Copy(entry) or entry
	end

	return copy
end

local root = "gamemodes/ix_cotz/plugins/buffs/"
local now, pending, clients = 100, {}, {}
local playerMeta = {}
SERVER, CLIENT = true, false
CurTime = function() return now end
IsValid = function(value) return type(value) == "table" and not value.invalid end
FindMetaTable = function() return playerMeta end
math.Clamp = function(value, low, high) return math.max(low, math.min(high, value)) end
timer = {Simple = function(_, callback) pending[#pending + 1] = callback end}
player = {Iterator = function() return ipairs(clients) end}
hook = {Call = function() end}
GAMEMODE = {}
local settings = {jumpPower = 160}
ix = {
	config = {
		Add = function(key, value) settings[key] = value end,
		Get = function(key, default) return settings[key] or default end,
	},
	weight = {Update = function(character)
		check(character ~= nil, "weight update requires a character")
		character.weightUpdates = (character.weightUpdates or 0) + 1
	end},
	util = {},
}
ix.util.Include = function(path)
	if path:sub(1, 3) == "cl_" then return end

	local file = assert(io.open(root .. path))
	local source = file:read("*a")
	file:close()
	-- Buff definitions still contain an inactive GLua block comment.
	source = source:gsub("/%*.-%*/", "")
	assert(load(source, "@" .. root .. path))()
end
PLUGIN = {}
dofile(root .. "sh_plugin.lua")
local buffs = PLUGIN
PLUGIN = {} -- Loader globals must not be resolved by deferred callbacks or player methods.

local function flush()
	while #pending > 0 do
		local callbacks = pending
		pending = {}
		for _, callback in ipairs(callbacks) do callback() end
	end
end

local function character(data)
	return {
		data = table.Copy(data or {}),
		GetData = function(self, key, default) return self.data[key] or default end,
		SetData = function(self, key, value, noReplication)
			check(noReplication == true, "persistence must not replicate character data")
			self.data[key] = value
		end,
		GetPlayer = function(self) return self.client end,
		Save = function(self)
			buffs:CharacterPreSave(self)
			return table.Copy(self.data)
		end,
	}
end

local function playerObject(saved)
	local client = setmetatable({vars = {}, health = 100, jump = 160}, {__index = playerMeta})
	client.character = saved or character()
	client.character.client = client
	function client:GetCharacter() return self.character end
	function client:IsValid() return IsValid(self) end
	function client:Alive() return self.health > 0 end
	function client:GetNetVar(key, default) return self.vars[key] or default end
	function client:SetNetVar(key, value) self.vars[key] = value end
	client.GetLocalVar, client.SetLocalVar = client.GetNetVar, client.SetNetVar
	client.GetNWFloat, client.SetNWFloat = client.GetNetVar, client.SetNetVar
	client.GetNWBool, client.SetNWBool = client.GetNetVar, client.SetNetVar
	function client:SetJumpPower(value) self.jump = value end
	function client:Health() return self.health end
	function client:GetMaxHealth() return 100 end
	function client:SetHealth(value) self.health = value end
	function client:addRadiation(value) self.radiation = (self.radiation or 0) + value end
	function client:HealPsyHealth(value) self.psyHealing = (self.psyHealing or 0) + value end
	function client:DamagePsyHealth(value) self.psyDamage = (self.psyDamage or 0) + value end

	return client
end

local function loadCharacter(client)
	buffs:PlayerSpawn(client)
	-- Equipment resistance recalculation occurs after plugin spawn/load hooks.
	client:SetNWFloat("ixflatpsyres", 8)
	buffs:PlayerLoadedCharacter(client)
	client:SetNWFloat("ixflatpsyres", 8)
	flush()
end

local client = playerObject()
loadCharacter(client)
local count = 0
for name in pairs(buffs.buffs) do
	count = count + 1
	client:AddBuff(name, 60, {amount = 3, dps = 1, nested = {value = 7}})
end
flush()
now = now + 12.5
local snapshot = client.character:Save()
for name in pairs(buffs.buffs) do
	near(snapshot.buffs[name][1], 47.5, name .. " saves remaining duration")
	check(snapshot.buffs[name][2].nested.value == 7, name .. " saves parameters")
end
check(count == 14, "all registered buffs and debuffs exercised")
snapshot.buffs.buff_slowheal[2].nested.value = 99
check(client:HasBuff("buff_slowheal")[2].nested.value == 7, "save parameters are copied")
near(client:GetNWFloat("ixflatpsyres"), 11, "psyblock initially applied")
check(client:GetNWBool("ix_psysuppressed"), "suppression initially applied")
buffs:PlayerDisconnected(client)
near(client:GetNWFloat("ixflatpsyres"), 8, "disconnect removes psyblock callback effect")
check(not client:GetNWBool("ix_psysuppressed"), "disconnect removes suppression")
check(client.jump == 160 and next(client:GetBuffs()) == nil, "disconnect clears live effects")
-- Helix saves after the plugin disconnect hook, before clearing the entity's netvars.
local disconnected = client.character:Save()
check(disconnected.buffs.buff_slowheal ~= nil, "framework disconnect save retains snapshot")
client.invalid = true
flush()
now = 10 -- Simulate a different server's CurTime after a long offline interval.
local reconnect = playerObject(character(disconnected))
loadCharacter(reconnect)
for name in pairs(buffs.buffs) do
	near(reconnect:HasBuff(name)[1] - now, 47.5, name .. " resumes paused duration")
	check(reconnect:HasBuff(name)[2].nested.value == 7, name .. " restores parameters")
end
near(reconnect:GetNWFloat("ixflatpsyres"), 11, "psyblock restored after equipment loadout")
check(reconnect:GetNWBool("ix_psysuppressed") and reconnect.jump == 163, "callback effects restored")
buffs:PlayerLoadedCharacter(reconnect)
flush()
near(reconnect:GetNWFloat("ixflatpsyres"), 11, "duplicate load does not stack callbacks")

now = now + 5
local previous = reconnect.character
previous:Save()
buffs:PrePlayerLoadedCharacter(reconnect)
reconnect.character = character()
reconnect.character.client = reconnect
loadCharacter(reconnect)
check(next(reconnect:GetBuffs()) == nil, "new character does not inherit effects")
near(reconnect:GetNWFloat("ixflatpsyres"), 8, "new character does not inherit resistance")
near(previous.data.buffs.buff_slowheal[1], 42.5, "switch preserves old character's remaining time")
local previousData = table.Copy(previous.data)
previous:Save()
near(previous.data.buffs.buff_slowheal[1], 42.5, "saving inactive character cannot overwrite its snapshot")
now = now + 500
buffs:PrePlayerLoadedCharacter(reconnect)
reconnect.character = previous
loadCharacter(reconnect)
near(reconnect:HasBuff("buff_slowheal")[1] - now, 42.5, "switching back resumes duration")
buffs:PlayerSpawn(reconnect)
flush()
near(reconnect:GetNWFloat("ixflatpsyres"), 11, "spawn reapplication does not stack resistance")

reconnect:RemoveBuff("buff_psyblock")
near(reconnect:GetNWFloat("ixflatpsyres"), 8, "manual removal uses saved parameters")
reconnect:RemoveBuff("buff_psyblock")
near(reconnect:GetNWFloat("ixflatpsyres"), 8, "repeated removal is harmless")
now = now + 42.5
clients = {reconnect}
buffs:Think()
check(next(reconnect:GetBuffs()) == nil, "all restored effects expire")
check(reconnect.psyDamage == nil and reconnect.radiation == nil, "expired debuffs do not tick again")
check(next(reconnect.character:Save().buffs) == nil, "expired effects removed from snapshot")

reconnect:AddBuff("buff_psyblock", 60, {amount = 3})
reconnect:AddBuff("debuff_psy", 60, {amount = 2})
reconnect.health = 0
buffs:PlayerDeath(reconnect)
check(next(reconnect.character:Save().buffs) == nil, "death clears persistent effects")
reconnect.health = 100
loadCharacter(reconnect)
check(next(reconnect:GetBuffs()) == nil, "revive cannot restore effects cleared by death")

local pendingClient = playerObject(character(previousData))
buffs:PlayerSpawn(pendingClient)
local pendingSave = pendingClient.character:Save()
near(pendingSave.buffs.buff_slowheal[1], 42.5, "save before deferred restoration preserves effects")
buffs:PrePlayerLoadedCharacter(pendingClient)
pendingClient.character = character()
pendingClient.character.client = pendingClient
flush()
check(next(pendingClient:GetBuffs()) == nil, "stale restoration cannot affect another character")
local removed = playerObject(character(previousData))
buffs:PlayerSpawn(removed)
removed.invalid = true
flush()
check(next(removed:GetBuffs()) == nil, "stale restoration ignores disconnected player")

local invalid = playerObject(character({buffs = {
	removed_definition = {60, {}},
	buff_slowheal = {0, {}},
	buff_rapidheal = {-5, {}},
	buff_hijump = {math.huge, {}},
	debuff_psy = "invalid",
}}))
loadCharacter(invalid)
check(next(invalid:GetBuffs()) == nil, "invalid or removed definitions are discarded")
invalid:AddBuff("buff_radprotect", -1, {})
now = now + 20
buffs:PlayerDisconnected(invalid)
local permanent = playerObject(character(invalid.character:Save()))
loadCharacter(permanent)
near(permanent:HasBuff("buff_radprotect")[1] - now, 999980, "negative-duration API semantics persist")

local ticking = playerObject(character({buffs = {
	buff_slowheal = {10, {amount = 4}},
	buff_staminarestore = {10, {amount = 6}},
	debuff_radiation = {10, {amount = 2}},
	debuff_psy = {10, {amount = 3}},
	buff_psyheal = {10, {amount = 5}},
}}))
loadCharacter(ticking)
ticking.health = 50
ticking:SetLocalVar("stm", 20)
clients = {ticking}
buffs:Think()
now = now + 1
buffs:Think()
near(ticking.health, 54, "restored healing uses saved strength")
near(ticking:GetLocalVar("stm"), 26, "restored stamina uses saved strength")
near(ticking.radiation, 2, "restored radiation debuff uses saved strength")
near(ticking.psyDamage, 3, "restored psychic debuff uses saved strength")
near(ticking.psyHealing, 5, "restored psychic healing uses saved strength")
print("buffs_persistence_spec: " .. checks .. " checks passed")
