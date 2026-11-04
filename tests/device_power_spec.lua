-- Run from the addon root: luatex --luaonly tests/device_power_spec.lua
local checks = 0
local function check(value, message)
	checks = checks + 1
	assert(value, message)
end
local now = 0
CLIENT = false
CurTime = function() return now end
IsValid = function(value) return type(value) == "table" and value.valid ~= false end
Vector = function() return {} end
Angle = Vector
ix = {util = {GetMaterial = function() return {} end}}
for _, device in ipairs({
	{"gamemodes/ix_cotz/plugins/anomalydetector/items/miscellaneous/sh_anomalydetector.lua", "ixhasanomdetector"},
	{"gamemodes/ix_cotz/plugins/radiation/items/miscellaneous/sh_geigercounter.lua", "ixhasgeiger"},
}) do
	ITEM = {functions = {}, Hook = function() end}
	local file = assert(io.open(device[1]))
	local source = file:read("*a"):gsub("!=", "~="):gsub("!", "not ")
	file:close()
	assert(load(source, "@" .. device[1]))()
	local state = {equip = true}
	local netvars = {}
	local inventory = {GetID = function() return 1 end}
	local character = {GetInventory = function() return inventory end}
	local client = {
		GetCharacter = function() return character end, Alive = function() return true end,
		SetNetVar = function(_, key, value) netvars[key] = value end,
		SetData = function() end, Notify = function() end,
	}
	local item = setmetatable({player = client, invID = 1}, {__index = ITEM})
	function item:GetData(key, default) if state[key] == nil then return default end return state[key] end
	function item:SetData(key, value) state[key] = value end
	function item:GetName() return self.name end
	item:OnLoadout()
	check(netvars[device[2]] == true, "Legacy equipped devices default to on")
	local toggle = item.functions.TogglePower
	now = now + 1
	check(toggle.OnRun(item) == false, "Power toggles preserve the item instance")
	check(state.equip and state.powered == false and netvars[device[2]] == false,
		"Turning off leaves the item equipped and stops its detector effects")
	toggle.OnRun(item)
	check(state.powered == false, "Repeated toggles are rate limited")
	item:OnLoadout()
	check(netvars[device[2]] == false, "Loadout preserves saved off state")
	now = now + 1
	toggle.OnRun(item)
	check(state.equip and state.powered and netvars[device[2]], "Turning on restores effects without unequipping")
	item.invID = 2
	check(not toggle.OnCanRun(item), "Power cannot be changed in a foreign inventory")
	item.invID = 1
	state.equip = false
	check(not toggle.OnCanRun(item), "Power requires an equipped device")
	item:OnLoadout()
	check(netvars[device[2]] == false, "Unequipped devices stay inactive on loadout")
end
print("Device power: " .. checks .. " checks passed")
