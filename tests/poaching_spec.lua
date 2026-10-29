-- Run from the addon root: luatex --luaonly tests/poaching_spec.lua
local checks = 0
local function check(condition, message)
	checks = checks + 1
	assert(condition, message)
end

math.Round = function(value) return math.floor(value + 0.5) end
math.Clamp = function(value, minimum, maximum) return math.max(minimum, math.min(maximum, value)) end
IsValid = function(value) return type(value) == "table" and not value.invalid end
istable = function(value) return type(value) == "table" end
Vector = function() return {Distance = function() return 0 end} end
Angle = function() return {} end
KEY_F, IN_USE = 1, 2
ix = {util = {}, item = {}, weight = {Update = function() end}}
PLUGIN = {}
local action
local timers = {}
timer = {Simple = function(_, callback) timers[#timers + 1] = callback end}
ix.util.PlayerPerformBlackScreenAction = function(_, _, _, callback) action = callback end
ix.util.PlayerActionInterrupt = function(client) client:SetNetVar("IsPoaching", false) end
ix.util.GetMutantMeatWeight = function(_, tier) return tier + 1 end
local pluginPath = "gamemodes/ix_cotz/plugins/mutantpoaching/"
dofile(pluginPath .. "sh_sharpness.lua")
dofile(pluginPath .. "sv_plugin.lua")

local function item(id, properties)
	local result = properties or {}
	result.id, result.data = id, {}
	function result:GetID() return self.id end
	function result:GetData(key, default)
		local value = self.data[key]
		if value == nil then return default end

		return value
	end
	function result:SetData(key, value) self.data[key] = value end

	return result
end

local knife = item(1, {isPoachKnife = true, knifetier = 5, class = "tfa_nmrih_combatknife", name = "Knife"})
knife:SetData("equip", true)
check(ix.poaching.GetSharpness(knife) == 100, "existing knives default to full sharpness")
knife:SetData("sharpness", 110)
check(ix.poaching.GetSharpness(knife) == 101, "legacy sharpness above cap is clamped")
check(ix.poaching.GetKnifeTier(knife) == 6, "top knife can exceed its base tier")
ix.poaching.WearKnife(knife)
check(ix.poaching.GetSharpness(knife) == 98, "over-sharp poach consumes all excess plus wear")
check(ix.poaching.GetKnifeTier(knife) == 5, "bonus does not persist")
knife:SetData("sharpness", 1)
ix.poaching.WearKnife(knife)
check(ix.poaching.GetSharpness(knife) == 0, "wear cannot go negative")

local loot = {}
local items = {[1] = knife}
local inventory = {GetItems = function() return items end}
function inventory:Add(uniqueID, _, data) loot[#loot + 1] = {uniqueID = uniqueID, data = data} return true end
local character = {GetInventory = function() return inventory end}
local client = {data = {}, GetCharacter = function() return character end, Alive = function() return true end}
function client:GetNetVar(key, default)
	if self.data[key] == nil then return default end

	return self.data[key]
end
function client:SetNetVar(key, value) self.data[key] = value end
function client:Notify(message) self.notice = message end
function client:GetPos() return Vector() end
function client:GetItemDropPos() return Vector() end
function client:GetActiveWeapon() return nil end
local npc
function client:GetEyeTraceNoCursor() return {Entity = npc} end
local function corpse()
	return {
		GetModel = function() return "models/monsters/slep_dog2.mdl" end,
		IsRagdoll = function() return true end,
		GetPos = function() return Vector() end,
		GetNetVar = client.GetNetVar,
		SetNetVar = client.SetNetVar,
		EmitSound = function() end,
		StopSound = function() end,
		Remove = function(self) self.invalid = true end,
		data = {},
	}
end
npc = corpse()
action = nil
PLUGIN:OpenPoachMenu(client, "dog", 1)
check(action == nil and not npc.invalid, "dull knife cannot start poaching")
knife:SetData("sharpness", 101)
PLUGIN:OpenPoachMenu(client, "dog", 1)
PLUGIN:PlayerButtonDown(client, KEY_F)
check(ix.poaching.GetSharpness(knife) == 101 and not npc.invalid, "cancel preserves bonus and corpse")
check(not npc:GetNetVar("beingSkinned"), "cancel releases the original corpse")
PLUGIN:OpenPoachMenu(client, "dog", 1)
local complete = action
for _, callback in ipairs(timers) do
	-- Earlier cleanup must not unlock a newer operation on the same corpse.
	if callback ~= timers[#timers] then callback() end
end
check(npc:GetNetVar("beingSkinned"), "old timers do not release new poaches")
complete(client)
check(npc.invalid and #loot > 0, "completed poach grants loot and removes corpse")
check(loot[1].data.tier == 6 and loot[1].data.weight == 7, "bonus affects both tier and meat weight")
check(ix.poaching.GetSharpness(knife) == 98, "completed poach charges wear once")
complete(client)
check(ix.poaching.GetSharpness(knife) == 98, "duplicate completion cannot charge twice")
npc = corpse()
PLUGIN:OpenPoachMenu(client, "dog", 1)
action(client)
check(loot[#loot].data.tier == 5, "next poach uses original tier")
check(ix.poaching.GetSharpness(knife) == 96, "normal poach charges wear")
npc = corpse()
PLUGIN:OpenPoachMenu(client, "dog", 1)
items[1] = nil
action(client)
check(not npc.invalid and ix.poaching.GetSharpness(knife) == 96, "transferred knife cannot complete poach")
items[1] = knife
npc = corpse()
PLUGIN:OpenPoachMenu(client, "dog", 1)
knife:SetData("equip", false)
action(client)
check(not npc.invalid and ix.poaching.GetSharpness(knife) == 96, "unequipped knife cannot complete poach")
knife:SetData("equip", true)

ITEM = {functions = {}}
dofile("gamemodes/ix_cotz/schema/items/base/sh_sharpeningstones.lua")
local stoneBase = ITEM
local stone = item(2, setmetatable({player = client}, {__index = stoneBase}))
items[2] = stone
local sharpen = stone.functions.Sharpen
check(sharpen.OnCanRun(stone), "owned stone is usable")
ix.option = {Get = function(_, default) return default end}
dofile("gamemodes/helix/gamemode/core/libs/sh_language.lua")
ix.lang.stored.english = {}
knife:SetData("sharpness", 50)
local options = sharpen.multiOptions(stone, client)
check(#options == 1 and L(options[1].name) == "Knife (50%)", "right-click knife label localizes without errors")
knife.name = "Knife 100%"
options = sharpen.multiOptions(stone, client)
check(L(options[1].name) == "Knife 100% (50%)", "percent signs in knife names also display correctly")
knife.name = "Knife"
knife:SetData("sharpness", 101)
check(#sharpen.multiOptions(stone, client) == 0, "fully sharpened knives stay out of the menu")
knife:SetData("sharpness", 70)
check(stone:GetData("quantity", stone.quantity) == 3, "new stones have three uses")
check(sharpen.OnRun(stone, {1}) == false, "first sharpening keeps the stone")
check(stone:GetData("quantity") == 2 and stone:GetPrice() == 100, "first use reduces quantity and resale value")
check(ix.poaching.GetSharpness(knife) == 85, "stone restores 15 sharpness")
check(sharpen.OnRun(stone, {1}) == false and ix.poaching.GetSharpness(knife) == 100, "second use keeps stone")
check(stone:GetData("quantity") == 1, "second sharpening leaves one use")
check(sharpen.OnRun(stone, {1}) == true and ix.poaching.GetSharpness(knife) == 101, "sharpness caps at 101")
check(stone:GetData("quantity") == 0 and not sharpen.OnCanRun(stone), "third use exhausts stone")
knife:SetData("sharpness", 0)
check(sharpen.OnRun(stone, {1}) == false, "exhausted stones cannot sharpen")
stone:SetData("quantity", 3)
knife:SetData("sharpness", 101)
check(sharpen.OnRun(stone, {1}) == false, "full knife does not consume a stone")
check(stone:GetData("quantity") == 3, "failed sharpening preserves remaining uses")
check(sharpen.OnRun(stone, {}) == false, "missing target is rejected")
check(sharpen.OnRun(stone, "bad") == false, "malformed target is rejected")
items[1] = nil
check(sharpen.OnRun(stone, {1}) == false, "unowned target is rejected")
items[1] = knife
items[2] = nil
check(sharpen.OnRun(stone, {1}) == false, "unowned stone is rejected")
items[2] = stone
client:SetNetVar("IsPoaching", true)
check(not sharpen.OnCanRun(stone) and sharpen.OnRun(stone, {1}) == false, "cannot sharpen during poaching")
client:SetNetVar("IsPoaching", false)
ITEM = {}
dofile("gamemodes/ix_cotz/schema/items/sharpeningstones/sh_sharpening_stone_fine.lua")
stone.sharpnessRestored = ITEM.sharpnessRestored
knife:SetData("sharpness", 0)
check(sharpen.OnRun(stone, {1}) == false and ix.poaching.GetSharpness(knife) == 50, "fine stone restores dull knife")
check(stone:GetData("quantity") == 2, "fine stone also retains two remaining uses")
for index = 1, 4 do
	ITEM = {}
	dofile("gamemodes/ix_cotz/schema/items/miscweapons/sh_knife" .. index .. ".lua")
	check(ITEM.canRepair == false, "knife is excluded from NPC repair")
end
CLIENT = true
Material = function(path) return path end
Color = function(r, g, b, a) return {r = r, g = g, b = b, a = a} end
ix.util.GetMaterial = Material
local drawColor
local bars = {}
surface = {
	SetMaterial = function() end,
	SetDrawColor = function(r, g, b, a)
		drawColor = type(r) == "table" and r or Color(r, g, b, a)
	end,
	DrawTexturedRect = function() end,
	DrawTexturedRectUV = function(_, _, width)
		bars[#bars + 1] = {color = drawColor, width = width}
	end,
}
local source = assert(io.open("gamemodes/ix_cotz/schema/items/base/sh_miscweapons.lua", "r"))
local clientSource = source:read("*a"):match("^(.-)\nfunction ITEM:GetDescription")
source:close()
ITEM = {}
-- Translate legacy GLua comments for the standalone Lua runner.
assert(load(clientSource:gsub("//[^\n]*", "")))()
local function paint(sharpness)
	bars = {}
	knife:SetData("sharpness", sharpness)
	ITEM:PaintOver(knife, 64, 64)

	return bars[#bars]
end
local bar = paint(101)
check(bar.color.b == 255 and bar.color.r == 80, "over-sharp knife bar is blue")
check(bar.width == 38, "over-sharp bar stays within its track")
bar = paint(100)
check(bar.color.g == 255 and bar.color.b == 120, "100 percent knife bar is green")
bar = paint(50)
check(bar.width == 19, "knife bar uses sharpness rather than generic durability")
bar = paint(0)
check(#bars == 2 and bar.width == 0, "dull knife still displays an empty track")
local otherWeapon = item(3)
otherWeapon:SetData("durability", 50)
bars = {}
ITEM:PaintOver(otherWeapon, 64, 64)
check(bars[#bars].width == 19, "other weapons retain their durability bars")
print("Poaching checks passed: " .. checks)
