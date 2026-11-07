-- Run from the repository root: luatex --luaonly tests/town_ammo_exchange_spec.lua
local fixture = dofile("tests/helpers/progression.lua")
local checks = 0
local function check(value, message)
	checks = checks + 1
	assert(value, message)
end
local now = 100
CurTime = function() return now end
PLUGIN = {}
dofile("gamemodes/ix_cotz/plugins/townnpcs/libs/sh_00_townnpcs.lua")
dofile("gamemodes/ix_cotz/plugins/townnpcs/libs/sv_services.lua")
ix.townNPCs.settings = {actionInterval = 0.25, interactionDistance = 192}
local hpID, apID = "exchange/hp", "exchange/ap"
ix.townNPCs.ammoExchanges = {
	["9x19hp"] = {id = hpID, npc = "Brass", input = "9x19", output = "9x19hp", boxes = 2},
	["9x19ap"] = {id = apID, npc = "Carbon", input = "9x19", output = "9x19ap", boxes = 3},
}
ix.item.list["9x19"] = {name = "9x19", ammoAmount = 60}
ix.item.list["9x19hp"] = {name = "HP", ammoAmount = 60}
ix.item.list["9x19ap"] = {name = "AP", ammoAmount = 60}
for _, id in ipairs({hpID, apID}) do
	ix.progression.Register(id, {name = id, keyNpc = "Brass", defaultActive = true, nextProgressions = {}})
end
local target = {name = "Brass", GetClass = function() return "ix_vendor_adv" end,
	GetDisplayName = function(self) return self.name end, CanAccess = function() return true end,
	GetPos = function() return fixture.position end}
ix.townNPCs.byName.Brass = {}
ix.townNPCs.byName.Carbon = {}
local function character(completed)
	local owner = fixture.character()
	owner.items = {}
	owner.client.Notify = function(self, message) self.notice = message end
	owner.inventory.GetItems = function() return owner.items end
	owner.inventory.GetID = function() return 1 end
	local record = ix.progression.GetCharacterProgression(owner)
	for _, id in ipairs(completed or {}) do record.lines[id] = {completed = true} end
	ix.progression.SetCharacterProgression(owner, record)
	return owner
end
local function addAmmo(owner, id, quantity, fail)
	local item = {uniqueID = "9x19", ammoAmount = 60, quantity = quantity, invID = 1}
	function item:GetID() return id end
	function item:GetData(key, default) if key == "quantity" then return self.quantity end return default end
	function item:SetData(key, value) if key == "quantity" then self.quantity = value end end
	function item:Remove()
		if fail then return false end
		owner.items[id] = nil
		return true
	end
	owner.items[id] = item
	return item
end
local function exchange(owner, output)
	now = now + 1
	return ix.townNPCs:ExchangeAmmo(owner.client, target, output)
end
local locked = character()
addAmmo(locked, 1, 120)
check(not exchange(locked, "9x19hp") and locked.items[1].quantity == 120, "locked exchange cannot consume inputs")
local owner = character({hpID})
local remainder = addAmmo(owner, 1, 150)
check(exchange(owner, "9x19hp"), "two standard-box equivalents buy one HP box")
check(remainder.quantity == 30 and #owner.inventory.rewards == 1, "only the required rounds are consumed")
check(owner.inventory.rewards[1].item == "9x19hp" and owner.inventory.rewards[1].data.quantity == 60,
	"the reward is one full output box")
check(not ix.townNPCs:ExchangeAmmo(owner.client, target, "9x19hp"), "server cooldown blocks duplicate immediate requests")
check(not exchange(owner, "9x19ap"), "Brass cannot execute Carbon's exchange")
check(not exchange(owner, "arbitrary-item"), "unknown output IDs are rejected")
local full = character({hpID})
addAmmo(full, 1, 60)
addAmmo(full, 2, 60)
full.inventory.Add = function() return false end
check(exchange(full, "9x19hp"), "a full inventory preserves a paid pending reward")
local pending = ix.progression.GetLine(full, "taskRewardClaims").pendingRewards
check(#pending == 1 and pending[1].quantity == 60 and not next(full.items), "full-inventory output stays queued once")
check(not exchange(full, "9x19hp"), "replay without new inputs cannot queue another output")
full.inventory.Add = fixture.addReward
check(ix.progression.ClaimRewards(full, "taskRewardClaims"), "pending ammunition can be collected after making space")
check(#ix.progression.GetLine(full, "taskRewardClaims").pendingRewards == 0, "successful recovery clears the pending output")
local async = character({hpID})
addAmmo(async, 1, 120)
local reservationData
async.inventory.Add = function(_, _, _, data) reservationData = data return 1, 1, 1 end
check(exchange(async, "9x19hp"), "asynchronous inventory reservation accepts a paid exchange")
check(#ix.progression.GetLine(async, "taskRewardClaims").pendingRewards == 1,
	"a reserved slot does not acknowledge delivery before the item exists")
check(not ix.progression.ClaimRewards(async, "taskRewardClaims"), "an in-flight reward cannot reserve a duplicate")
ix.char = {loaded = {[101] = async}}
fixture.callbacks["cotz/progression/confirm-reward"](nil, {owner = 101}, {
	GetData = function(_, key) return reservationData[key] end,
})
check(#ix.progression.GetLine(async, "taskRewardClaims").pendingRewards == 0,
	"the real InventoryItemAdded acknowledgement finishes exactly the queued exchange")
local failed = character({hpID})
addAmmo(failed, 1, 60)
addAmmo(failed, 2, 60, true)
check(not exchange(failed, "9x19hp"), "a failed whole-stack removal does not issue output")
check(not failed.inventory.rewards and failed:GetData("townAmmoExchangeRounds")["9x19"] == 60,
	"earlier successful debits remain recoverable credit")
addAmmo(failed, 2, 60)
check(exchange(failed, "9x19hp") and #failed.inventory.rewards == 1, "retry spends the saved rounds and remaining inputs once")
check(failed:GetData("townAmmoExchangeRounds")["9x19"] == 0, "successful retry consumes the credit")
local short = character({hpID})
addAmmo(short, 1, 119)
check(not exchange(short, "9x19hp") and short.items[1].quantity == 119, "insufficient rounds never partially consume inputs")
target.name = "Carbon"
local ap = character({apID})
addAmmo(ap, 1, 180)
check(exchange(ap, "9x19ap") and ap.inventory.rewards[1].item == "9x19ap", "AP consumes three regular boxes at Carbon")
target.CanAccess = function() return false end
check(not exchange(ap, "9x19ap"), "vendor access is revalidated on the server")
print("PASS: " .. checks .. " town ammunition exchange checks")
