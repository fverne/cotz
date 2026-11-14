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
table.Copy = function(value)
	local copy = {}
	for key, entry in pairs(value) do
		copy[key] = type(entry) == "table" and table.Copy(entry) or entry
	end

	return copy
end
timer = {Simple = function() end}
dofile("gamemodes/ix_cotz/plugins/buffs/sh_bleeding.lua")
dofile("gamemodes/ix_cotz/plugins/buffs/sv_bleeding.lua")
dofile("gamemodes/ix_cotz/plugins/buffs/sv_bandageclotting.lua")
dofile("gamemodes/ix_cotz/plugins/buffs/sv_persistence.lua")
local buffs = PLUGIN
ix.plugin.Get = function() return buffs end
local world = {GetName = function() return "" end, GetClass = function() return "worldspawn" end}
game = {GetWorld = function() return world end}

-- Exercise the installed Helix sound gate and logging rather than duplicating their behavior.
local helix = {}
ix.log = {Add = function(client) client.hurtLogs = (client.hurtLogs or 0) + 1 end}
local hooksFile = assert(io.open("gamemodes/helix/gamemode/core/hooks/sv_hooks.lua"))
local hooksSource = hooksFile:read("*a")
hooksFile:close()
local methodStart = assert(hooksSource:find("function GM:PlayerHurt(", 1, true))
local methodEnd = assert(hooksSource:find("\nend", methodStart, true)) + 3
local hurtMethod = hooksSource:sub(methodStart, methodEnd):gsub("!", "not ")
assert(load(hurtMethod, "@helix/PlayerHurt", "t", setmetatable({
	GM = helix, hook = {Run = function() return "stalkersound/pain1.wav" end},
}, {__index = _G})))()
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
local function takeDamage(client, info)
	if client.blockDamage then return end

	client.health = client.health - info.amount
	client.punchAngles = {p = -2, y = 0, r = 0}
	client.punchVelocity = {p = 10, y = 0, r = 0}
	helix:PlayerHurt(client, world, client.health, info.amount)
	buffs:PostEntityTakeDamage(client, info, true)
	if not client:Alive() then buffs:PlayerDeath(client) end
	if client.afterDamage then client:afterDamage() end
end

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
	local client = {
		character = character(severity), health = 100, vars = {}, sends = 0, painSounds = {},
		punchAngles = {p = 3, y = 4, r = 5}, punchVelocity = {p = 6, y = 7, r = 8},
	}
	function client:GetCharacter() return self.character end
	function client:IsPlayer() return true end
	function client:IsFemale() return false end
	function client:Alive() return self.health > 0 end
	function client:EmitSound(sound) self.painSounds[#self.painSounds + 1] = {sound = sound, time = now} end
	function client:GetViewPunchAngles() return table.Copy(self.punchAngles) end
	function client:GetViewPunchVelocity() return table.Copy(self.punchVelocity) end
	function client:SetViewPunchAngles(value) self.punchAngles = value end
	function client:SetViewPunchVelocity(value) self.punchVelocity = value end
	function client:GetLocalVar(key, default) return self.vars[key] or default end
	function client:SetLocalVar(key, value) self.vars[key] = value self.sends = self.sends + 1 end
	function client:GetNetVar(key, default) return self.vars[key] or default end
	function client:SetNetVar(key, value) self.vars[key] = value end
	function client:GetBuffs() return self:GetNetVar("buffs", {}) end
	function client:HasBuff(name) return self:GetBuffs()[name] end
	function client:AddBuff(name, duration, parameters)
		local current = self:GetBuffs()
		current[name] = {now + duration, parameters}
		self:SetNetVar("buffs", current)
	end
	function client:RemoveBuff(name) self:GetBuffs()[name] = nil end
	function client:Health() return self.health end
	function client:GetMaxHealth() return 100 end
	function client:SetHealth(health) self.health = health end
	function client:GetPos() return {DistToSqr = function() return self.distanceSquared or 0 end} end
	function client:WorldSpaceCenter() return 0 end
	function client:TakeDamageInfo(info)
		check(info.kind == DMG_GENERIC and info.attacker == world and info.inflictor == world,
			"bleeding must use generic world damage")
		takeDamage(self, info)
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

-- Bleeding feedback uses the real Helix pain cooldown while preserving preexisting recoil.
settings.bleedingClotRate = 0
local feedback = player(100)
buffs:RestoreBleeding(feedback)
local firstTick = now + 1
for tick = 0, 5 do
	now = firstTick + tick
	buffs:ProcessBleeding()
	check(feedback.punchAngles.p == 3 and feedback.punchAngles.y == 4 and feedback.punchAngles.r == 5,
		"bleeding preserves preexisting view-punch angles")
	check(feedback.punchVelocity.p == 6 and feedback.punchVelocity.y == 7 and feedback.punchVelocity.r == 8,
		"bleeding preserves preexisting view-punch velocity")
	check(#feedback.painSounds == (tick < 5 and 1 or 2), "bleeding pain has an exact five-second cooldown")
end
check(feedback.hurtLogs == 6 and feedback.health == 76, "sound throttling preserves damage and Helix hurt logs")
check(feedback.painSounds[2].time - feedback.painSounds[1].time == 5, "sound resumes at the cooldown boundary")
now = now + 1
buffs:ProcessBleeding()
local ordinaryNextPain = feedback.ixNextPain
check(ordinaryNextPain < now, "muted bleeding does not extend the ordinary pain timer")
takeDamage(feedback, damage(1, DMG_GENERIC))
check(#feedback.painSounds == 3 and feedback.punchAngles.p == -2 and feedback.punchVelocity.p == 10,
	"ordinary damage retains pain and view punch during the bleeding cooldown")
buffs:HealBleeding(feedback, 100)
buffs:AddBleeding(feedback, 100)
now = now + 1
buffs:ProcessBleeding()
check(#feedback.painSounds == 3, "treatment and rebleeding do not reset the sound cooldown")
local otherFeedback = player(100)
buffs:RestoreBleeding(otherFeedback)
now = now + 1
buffs:ProcessBleeding()
check(#otherFeedback.painSounds == 1, "bleeding sound cooldown is independent per player")
buffs:PrePlayerLoadedCharacter(feedback)
feedback.character = character(100)
buffs:PlayerLoadedCharacter(feedback)
now = now + 1
buffs:ProcessBleeding()
check(#feedback.painSounds == 4, "new characters do not inherit the previous character's bleeding cooldown")
local blockedFeedback = player(100)
blockedFeedback.blockDamage = true
buffs:RestoreBleeding(blockedFeedback)
now = now + 1
buffs:ProcessBleeding()
check(#blockedFeedback.painSounds == 0 and blockedFeedback.cotzNextBleedingPain == nil,
	"blocked bleeding does not play pain or start a cooldown")
blockedFeedback.blockDamage = false
now = now + 1
buffs:ProcessBleeding()
check(#blockedFeedback.painSounds == 1, "first unblocked bleeding hit can play pain immediately")
local delayedFeedback = player(100)
buffs:RestoreBleeding(delayedFeedback)
delayedFeedback.ixNextPain = now + 2
now = now + 1
buffs:ProcessBleeding()
check(delayedFeedback.cotzNextBleedingPain == nil, "existing ordinary cooldown does not consume bleeding cooldown")
now = now + 2
buffs:ProcessBleeding()
check(#delayedFeedback.painSounds == 1, "bleeding plays pain after the ordinary cooldown expires")
for _, transition in ipairs({"remove", "switch", "death"}) do
	local transitioning = player(100)
	buffs:RestoreBleeding(transitioning)
	transitioning.afterDamage = function(self)
		if transition == "remove" then self.invalid = true end
		if transition == "switch" then self.character = character() end
		if transition == "death" then self.health = 0 buffs:PlayerDeath(self) end
	end
	now = now + 1
	buffs:ProcessBleeding()
	check(transitioning.punchAngles.p == -2, "view punch is not restored after damage-time " .. transition)
end
buffs:StopBleeding(feedback)
buffs:StopBleeding(otherFeedback)
buffs:StopBleeding(blockedFeedback)
buffs:StopBleeding(delayedFeedback)
settings.bleedingClotRate = 1

-- Exercise real definitions and inherited helpers with action completion/cancellation mocks.
CLIENT = false
Color = function() return {} end
Vector = function() end
Angle = function() end
ITEM = {Hook = function() end}
dofile("gamemodes/ix_cotz/schema/items/base/sh_aid.lua")
local base = ITEM
local pending, target, failAction
ix.util.PropertyDesc = function() end
ix.util.PlayerPerformItemAction = function(actor, _, _, duration, callback)
	if failAction then return false end
	check(duration == 2, "both application actions take two seconds")
	actor.vars.ix_noMenuAllowed = true
	pending = callback

	return true
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
	function item:GetData(key, default)
		if self.data[key] ~= nil then return self.data[key] end

		return default
	end
	function item:SetData(key, value) self.data[key] = value end
	actor.vars.ix_noMenuAllowed = false
	actor:SetNetVar("buffs", {})
	actor.health = 50
	buffs:SetBleedingSeverity(actor, 100)
	check(item.functions.use.OnRun(item) == false, "multi-use bandage retained")
	check(item.data.quantity == 2, "self-use consumes one charge at start")
	check(item.functions.use.OnRun(item) == false and item.data.quantity == 2, "overlap rejected")
	near(actor.health, 50, "no heal before completion")
	local completion = pending
	actor.vars.ix_noMenuAllowed = false
	completion(actor)
	near(actor.health, 50 + ({6, 9, 12})[tier], "tier completion heal")
	completion(actor)
	near(actor.health, 50 + ({6, 9, 12})[tier], "completion is idempotent")
	near(buffs:GetBleeding(actor), 100, "no instant severity subtraction")
	for second = 1, 6 do
		now = now + 1
		buffs:ProcessBandageClotting(actor)
		near(buffs:GetBleeding(actor), 100 - strength * second / 6, "even six-second clotting")
	end
	now = now + 20
	buffs:ProcessBandageClotting(actor)
	near(buffs:GetBleeding(actor), 100 - strength, "expiry cannot over-treat")
	target = player(100)
	target.health = 99
	function target:Name() return "Target" end
	item.functions.usetarget.OnRun(item)
	near(buffs:GetBleeding(target), 100, "target treatment waits for completion")
	check(item.data.quantity == 1, "target consumes once at start")
	actor.vars.ix_noMenuAllowed = false
	pending(actor)
	near(target.health, 100, "target healing capped at maximum")
	now = now + 6
	buffs:ProcessBandageClotting(target)
	near(buffs:GetBleeding(target), 100 - strength, "target strength matches self even after a delayed frame")
	buffs:SetBleedingSeverity(actor, 100)
	item.functions.use.OnRun(item)
	local callback = pending
	buffs:PrePlayerLoadedCharacter(actor)
	actor.vars.ix_noMenuAllowed = false
	callback(actor)
	near(buffs:GetBleeding(actor), 100, "character transition invalidates delayed action")
	item.data.quantity = 3
	item.functions.use.OnRun(item)
	actor.vars.ix_noMenuAllowed = false
	near(buffs:GetBleeding(actor), 100, "canceling does not treat bleeding")
	check(item.data.quantity == 2, "cancellation retains start-time consumption")
	item.functions.use.OnRun(item)
	callback = pending
	actor.health = 0
	callback(actor)
	near(buffs:GetBleeding(actor), 100, "dead actor cannot receive treatment")
	actor.health = 100
	actor.vars.ix_noMenuAllowed = false
	target.invalid = true
	local quantity = item.data.quantity
	check(item.functions.usetarget.OnRun(item) == false and item.data.quantity == quantity,
		"invalid target does not consume")
	item.data.quantity = 0
	check(item.functions.use.OnRun(item) == false, "empty bandage rejected")
	item.data.quantity = 3
	item.invID = 2
	check(item.functions.use.OnRun(item) == false, "foreign inventory rejected")
	item.invID = 1
	failAction = true
	item.functions.use.OnRun(item)
	check(item.data.quantity == 3 and actor.cotzBandageAction == nil, "failed action does not consume or lock")
	failAction = false
end
local treated = player(100)
buffs:StartBandageClotting(treated, 50, 6)
now = now + 2
buffs:StartBandageClotting(treated, 20, 6)
near(treated:HasBuff("buff_bandageclotting")[2].amount, 50 / 6, "weaker bandage cannot downgrade")
near(treated:HasBuff("buff_bandageclotting")[1] - now, 4, "weaker bandage cannot extend")
buffs:StartBandageClotting(treated, 50, 6)
near(treated:HasBuff("buff_bandageclotting")[1] - now, 6, "equal strength refreshes")
buffs:StartBandageClotting(treated, 90, 6)
near(treated:HasBuff("buff_bandageclotting")[2].amount, 15, "stronger bandage replaces")
local clotting = player(100)
settings.bleedingDamageScale = 0
buffs:RestoreBleeding(clotting)
buffs:StartBandageClotting(clotting, 20, 6)
for second = 1, 6 do
	now = now + 1
	buffs:ProcessBandageClotting(clotting)
	buffs:ProcessBleeding()
end
near(buffs:GetBleeding(clotting), 74, "natural clotting adds six to bandage's twenty")
-- Target changes invalidate completion, while the original charge remains consumed.
local item = setmetatable({player = actor, invID = 1, data = {}}, {__index = ITEM})
function item:GetData(key, default) return self.data[key] or default end
function item:SetData(key, value) self.data[key] = value end
for _, change in ipairs({"range", "visibility", "character", "death"}) do
	actor.vars.ix_noMenuAllowed = false
	actor.distanceSquared = 0
	target = player(100)
	item.data.quantity = 3
	item.functions.usetarget.OnRun(item)
	local original = target
	if change == "range" then actor.distanceSquared = 10000 end
	if change == "visibility" then target = {} end
	if change == "character" then original.character = character(100) end
	if change == "death" then original.health = 0 end
	local health = original.health
	pending(actor)
	near(original.health, health, "invalidated target: " .. change)
	check(not original:HasBuff("buff_bandageclotting"), "invalidated target receives no clotting: " .. change)
end
actor.distanceSquared = 0
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
