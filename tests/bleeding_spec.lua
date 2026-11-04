-- Run from the addon root: luatex --luaonly tests/bleeding_spec.lua
local checks = 0
local function check(value, message)
	checks = checks + 1
	assert(value, message)
end
local function near(actual, expected, message)
	check(math.abs(actual - expected) < 0.000001, message)
end
local now, roll, rolls = 0, 0, 0
CurTime = function() return now end
IsValid = function(value) return type(value) == "table" and not value.invalid end
math.Clamp = function(value, low, high) return math.max(low, math.min(high, value)) end
math.Rand = function() rolls = rolls + 1 return roll end
DMG_GENERIC, DMG_BULLET, DMG_SLASH = 0, 1, 2
local settings = {}
ix = {config = {
	Add = function(key, value) settings[key] = value end,
	Get = function(key, default) return settings[key] or default end,
}, util = {Include = function() end}, plugin = {}}
PLUGIN = {}
dofile("gamemodes/ix_cotz/plugins/buffs/sh_bleeding.lua")
dofile("gamemodes/ix_cotz/plugins/buffs/sv_bleeding.lua")
local buffs = PLUGIN
ix.plugin.Get = function() return buffs end
local world = {}
game = {GetWorld = function() return world end}
local function damage(amount, kind)
	return {
		amount = amount, kind = kind,
		GetDamage = function(self) return self.amount end,
		IsDamageType = function(self, flag) return self.kind == flag or self.kind == 3 end,
		SetDamage = function(self, value) self.amount = value end,
		SetDamageType = function(self, value) self.kind = value end,
		SetAttacker = function(self, value) self.attacker = value end,
		SetInflictor = function(self, value) self.inflictor = value end,
	}
end
DamageInfo = function() return damage(0, 0) end
local function character(severity)
	return {
		data = {bleedingSeverity = severity or 0},
		GetData = function(self, key, default) return self.data[key] or default end,
		SetData = function(self, key, value, noReplication)
			check(noReplication == true, "severity must not replicate character data")
			self.data[key] = value
		end,
		GetInventory = function() return {GetID = function() return 1 end} end,
	}
end
local function player(severity)
	local client = {character = character(severity), health = 100, vars = {}, sends = 0}
	function client:GetCharacter() return self.character end
	function client:IsPlayer() return true end
	function client:Alive() return self.health > 0 end
	function client:GetLocalVar(key, default) return self.vars[key] or default end
	function client:SetLocalVar(key, value) self.vars[key] = value self.sends = self.sends + 1 end
	function client:GetNetVar(key, default) return self.vars[key] or default end
	function client:AddBuff(_, duration, parameters) self.healing = {duration, parameters.amount} end
	function client:TakeDamageInfo(info)
		check(info.kind == DMG_GENERIC and info.attacker == world and info.inflictor == world,
			"bleeding must use generic world damage")
		self.health = self.health - info.amount
		buffs:PostEntityTakeDamage(self, info, true)
		if not self:Alive() then buffs:PlayerDeath(self) end
	end

	return client
end
local client = player()
for _, amount in ipairs({10, 20, 40, 60, 80, 100, 150}) do
	local chance = math.min(amount / 100, 1) ^ 2
	buffs:SetBleedingSeverity(client, 0)
	roll = chance - 0.000001
	buffs:PostEntityTakeDamage(client, damage(amount, DMG_BULLET), true)
	near(buffs:GetBleeding(client), math.min(amount, 100), "successful chance boundary")
	buffs:SetBleedingSeverity(client, 0)
	roll = chance
	buffs:PostEntityTakeDamage(client, damage(amount, DMG_SLASH), true)
	near(buffs:GetBleeding(client), chance >= 1 and 100 or 0, "chance boundary and guaranteed severe hit")
end
buffs:SetBleedingSeverity(client, 0)
roll = 0
local previousRolls = rolls
for _, event in ipairs({damage(0, 1), damage(-1, 1), damage(20, 0)}) do
	buffs:PostEntityTakeDamage(client, event, true)
end
buffs:PostEntityTakeDamage(client, damage(20, 1), false)
client.health = 0
buffs:PostEntityTakeDamage(client, damage(20, 1), true)
client.health = 100
check(rolls == previousRolls, "excluded damage must not roll")
buffs:PostEntityTakeDamage(client, damage(20, 3), true)
check(rolls == previousRolls + 1, "combined flags roll once")
buffs:PostEntityTakeDamage(client, damage(20, 1), true)
near(buffs:GetBleeding(client), 40, "further hits add severity")
buffs:AddBleeding(client, math.huge)
buffs:AddBleeding(client, 0 / 0)
buffs:HealBleeding(client, -10)
near(buffs:GetBleeding(client), 40, "invalid API amounts ignored")
buffs:AddBleeding(client, 500)
near(buffs:GetBleeding(client), 100, "severity capped")
buffs:HealBleeding(client, 500)
near(buffs:GetBleeding(client), 0, "treatment clamps at zero")
buffs:AddBleeding(client, 20)
for _ = 1, 6 do now = now + 1 buffs:ProcessBleeding() end
check(client.health == 96, "fractional damage accumulates")
near(buffs:GetBleeding(client), 14, "natural clotting")
local saved = client.character
buffs:PlayerDisconnected(client)
now = now + 10000
buffs:ProcessBleeding()
near(saved.data.bleedingSeverity, 14, "offline time pauses severity")
local reconnect = player()
reconnect.character = saved
buffs:PlayerLoadedCharacter(reconnect)
near(buffs:GetBleeding(reconnect), 14, "reconnect/cross-server data restore")
local sends = reconnect.sends
buffs:RestoreBleeding(reconnect)
check(reconnect.sends == sends, "unchanged display does not send")
now = now + 1
buffs:ProcessBleeding()
near(buffs:GetBleeding(reconnect), 13, "spawn restore resumes bleeding")
buffs:PrePlayerLoadedCharacter(reconnect)
reconnect.character = character()
buffs:PlayerLoadedCharacter(reconnect)
now = now + 1
buffs:ProcessBleeding()
near(saved.data.bleedingSeverity, 13, "character switch preserves old character")
local dying = player(100)
dying.health = 1
buffs:PlayerLoadedCharacter(dying)
now = now + 1
buffs:ProcessBleeding()
check(not dying:Alive() and buffs:GetBleeding(dying) == 0, "lethal tick clears saved bleeding")
dying.health = 100
buffs:RestoreBleeding(dying)
near(buffs:GetBleeding(dying), 0, "revive cannot restore cleared bleeding")

-- Exercise the real bandage definitions and inherited aid helpers with action mocks.
CLIENT = false
Color = function() return {} end
Vector = function() end
Angle = function() end
ITEM = {Hook = function() end}
dofile("gamemodes/ix_cotz/schema/items/base/sh_aid.lua")
local base = ITEM
local pending, target
ix.util.PropertyDesc = function() end
ix.util.PlayerPerformBlackScreenAction = function(actor, _, _, callback)
	actor.vars.ix_hasBlackScreen = true
	pending = callback
end
ix.chat = {Send = function() end}
util = {TraceLine = function() return {Entity = target} end}
local actor = player(100)
function actor:GetShootPos() return 0 end
function actor:GetAimVector() return 0 end
function actor:SetData() end
function actor:Notify() end
function actor:Name() return "Test" end
for tier, strength in ipairs({20, 50, 90}) do
	ITEM = setmetatable({functions = {}}, {__index = base})
	dofile("gamemodes/ix_cotz/schema/items/aid/sh_medic_bandage_" .. tier .. ".lua")
	local item = setmetatable({player = actor, invID = 1, data = {}}, {__index = ITEM})
	function item:GetData(key, default) return self.data[key] or default end
	function item:SetData(key, value) self.data[key] = value end
	actor.vars.ix_hasBlackScreen = false
	buffs:SetBleedingSeverity(actor, 100)
	check(item.functions.use.OnRun(item) == false, "multi-use bandage retained")
	check(item.data.quantity == 2, "self-use consumes one charge at start")
	check(item.functions.use.OnRun(item) == false and item.data.quantity == 2, "overlap rejected")
	actor.vars.ix_hasBlackScreen = false
	pending(actor)
	near(buffs:GetBleeding(actor), 100 - strength, "self treatment strength")
	target = player(100)
	function target:Name() return "Target" end
	item.functions.usetarget.OnRun(item)
	near(buffs:GetBleeding(target), 100 - strength, "target treatment strength")
	check(item.data.quantity == 1, "target consumes once")
	buffs:SetBleedingSeverity(actor, 100)
	item.functions.use.OnRun(item)
	local callback = pending
	buffs:PrePlayerLoadedCharacter(actor)
	actor.vars.ix_hasBlackScreen = false
	callback(actor)
	near(buffs:GetBleeding(actor), 100, "character transition invalidates delayed action")
	item.data.quantity = 3
	item.functions.use.OnRun(item)
	-- The shared black-screen helper suppresses callbacks on cancellation.
	actor.vars.ix_hasBlackScreen = false
	near(buffs:GetBleeding(actor), 100, "canceling does not treat bleeding")
	check(item.data.quantity == 2, "cancellation retains start-time consumption")
	item.functions.use.OnRun(item)
	callback = pending
	actor.health = 0
	callback(actor)
	near(buffs:GetBleeding(actor), 100, "dead actor cannot receive delayed treatment")
	actor.health = 100
	actor.vars.ix_hasBlackScreen = false
	target.invalid = true
	local quantity = item.data.quantity
	check(item.functions.usetarget.OnRun(item) == false and item.data.quantity == quantity,
		"invalid target does not consume a charge")
	item.data.quantity = 0
	check(item.functions.use.OnRun(item) == false, "empty bandage rejected")
	item.data.quantity = 3
	item.invID = 2
	check(item.functions.use.OnRun(item) == false, "foreign inventory rejected")
end
-- Failed rolls must not postpone the already scheduled clot/damage tick.
local ongoing = player(40)
buffs:PlayerLoadedCharacter(ongoing)
roll = 0.99
buffs:PostEntityTakeDamage(ongoing, damage(20, DMG_BULLET), true)
now = now + 1
buffs:ProcessBleeding()
near(buffs:GetBleeding(ongoing), 39, "failed roll does not delay clotting")
local health = ongoing.health
buffs:ProcessBleeding()
check(ongoing.health == health, "repeated frames do not advance bleeding")
local invalid = player(40)
buffs:PlayerLoadedCharacter(invalid)
invalid.invalid = true
now = now + 1
buffs:ProcessBleeding()
near(invalid.character.data.bleedingSeverity, 40, "invalid players removed without ticking")
print("bleeding_spec: " .. checks .. " checks passed")
