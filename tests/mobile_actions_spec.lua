-- Run from the repository root: luatex --luaonly tests/mobile_actions_spec.lua
local function read(path)
	local file = assert(io.open(path))
	local source = file:read("*a")
	file:close()

	return source
end
local checks = 0
local function check(value, message)
	checks = checks + 1
	assert(value, message)
end
CLIENT, SERVER = false, true
local timers = {}
timer = {Create = function(name, _, _, callback) timers[name] = callback end,
	Remove = function(name) timers[name] = nil end, Exists = function(name) return timers[name] ~= nil end}
net = {Start = function() end, Send = function() end}
IsValid = function(value) return value and not value.invalid end
Color = function() return {} end
SCREENFADE = {IN = 1, PURGE = 2}
PLUGIN = {}
assert(load(read("gamemodes/ix_cotz/plugins/itemhotkeys/sh_hotkeyitems.lua"):gsub("//", "--")))()
dofile("gamemodes/ix_cotz/plugins/itemhotkeys/sh_actionitems.lua")
local hotkeys = PLUGIN
ix = {util = {}, plugin = {Get = function() return hotkeys end}}
local source = read("gamemodes/ix_cotz/schema/libs/sh_gameplay.lua")
source = source:sub(1, assert(source:find("if(CLIENT)", 1, true)) - 1)
assert(load(source:gsub("!", "not ")))()
IN_ATTACK, IN_ATTACK2, IN_RELOAD, IN_FORWARD = 1, 2048, 8192, 8
bit = {bor = function(a, b, c) return a + b + c end}
Schema = {}
hook = {Add = function() end}
SERVER = false
assert(load(read("gamemodes/ix_cotz/schema/sh_hooks.lua"):gsub("!", "not ")))()
SERVER = true
local character = {}
local client = {vars = {}, alive = true, character = character, fades = 0, freezes = 0}
function client:GetNetVar(key) return self.vars[key] end
function client:SetNetVar(key, value) self.vars[key] = value end
function client:SetAction(text) self.action = text end
function client:SteamID() return "test" end
function client:Freeze(value) self.freezes = self.freezes + 1 self.frozen = value end
function client:ScreenFade() self.fades = self.fades + 1 end
function client:GetCharacter() return self.character end
function client:Alive() return self.alive end
local paid = 0
local function finish() paid = paid + 1 end
local function checkWeaponInput(blocked)
	local command = {buttons = IN_ATTACK + IN_ATTACK2 + IN_RELOAD + IN_FORWARD}
	function command:RemoveKey(mask)
		for _, key in ipairs({IN_ATTACK, IN_ATTACK2, IN_RELOAD, IN_FORWARD}) do
			if mask % (key * 2) >= key and self.buttons % (key * 2) >= key then
				self.buttons = self.buttons - key
			end
		end
	end
	check(Schema:StartCommand(client, command) == nil, "weapon filtering permits later hook handlers")
	local expected = blocked and IN_FORWARD or IN_ATTACK + IN_ATTACK2 + IN_RELOAD + IN_FORWARD
	check(command.buttons == expected, "action state blocks weapon input while preserving movement")
end
local name = "cotz/mobile-action/test"
checkWeaponInput(false)
for _, id in ipairs({"medic_medkit_1", "medic_medkit_3", "medic_medkit_5"}) do
	check(not hotkeys:UsesMobileAction(id), id .. " uses black-screen treatment")
	ix.util.PlayerPerformItemAction(client, {uniqueID = id}, "Treating", 8, finish)
	check(client.vars.ix_hasBlackScreen and client.frozen, id .. " starts stationary work")
	checkWeaponInput(true)
	ix.util.PlayerActionInterrupt(client)
end
client.freezes, client.fades = 0, 0
check(hotkeys:UsesMobileAction("medic_medkit_2"), "syrettes use mobile actions by default")
check(not hotkeys:UsesMobileAction("food_bread"), "ordinary food retains the stationary action")
ix.util.PlayerPerformItemAction(client, {uniqueID = "medic_medkit_2"}, "Treating", 3, finish)
check(client.vars.ix_hasMobileAction and not client.vars.ix_hasBlackScreen, "mobile state is independent")
check(client.freezes == 0 and client.fades == 0, "mobile work never freezes or fades")
checkWeaponInput(true)
check(not ix.util.PlayerPerformMobileAction(client, "Overlap", 3, finish), "overlapping mobile work rejected")
timers[name]()
check(paid == 1 and not client.vars.ix_noMenuAllowed, "completion clears state and pays once")
checkWeaponInput(false)
ix.util.PlayerPerformMobileAction(client, "Cancel", 3, finish)
local cancelled = timers[name]
ix.util.PlayerActionInterrupt(client)
cancelled()
check(paid == 1 and not timers[name] and not client.vars.ix_noMenuAllowed, "cancelled callbacks cannot pay")
checkWeaponInput(false)
check(client.freezes == 0 and client.fades == 0, "mobile cancellation does not alter movement or vision")
ix.util.PlayerPerformMobileAction(client, "Switch", 3, finish)
client.character = {}
timers[name]()
check(paid == 1 and not client.vars.ix_hasMobileAction, "character changes cannot receive the old effect")
client.character = character
ix.util.PlayerPerformMobileAction(client, "Death", 3, finish)
client.alive = false
timers[name]()
check(paid == 1 and not client.vars.ix_noMenuAllowed, "death clears the action without effects")
client.alive = true
hotkeys.mobileActionItems.medic_medkit_1 = false
hotkeys.mobileActionItems.food_bread = true
check(not hotkeys:UsesMobileAction("medic_medkit_1") and hotkeys:UsesMobileAction("food_bread"),
	"explicit overrides can diverge in both directions")
hotkeys.useHotkeyActionDefaults = false
check(not hotkeys:UsesMobileAction("drug_morphine"), "defaults can be disabled for an independent list")
ix.util.PlayerPerformItemAction(client, {uniqueID = "medic_medkit_1"}, "Stationary", 3, finish)
check(client.vars.ix_hasBlackScreen and client.frozen and client.fades == 1, "stationary fallback remains available")
checkWeaponInput(true)
ix.util.PlayerActionInterrupt(client)
checkWeaponInput(false)
ix.util.PlayerPerformMobileAction(client, "Moving", 3, finish)
local replaced = timers[name]
ix.util.PlayerPerformBlackScreenAction(client, "Poaching", 3, finish)
replaced()
check(paid == 1 and not client.vars.ix_hasMobileAction and client.vars.ix_hasBlackScreen,
	"world interactions cancel mobile work before starting a stationary action")
check(not timers[name], "replaced mobile timer is removed")
print("PASS: " .. checks .. " mobile action checks")
