local PLUGIN = PLUGIN
PLUGIN.name = "Item Hotkeys"
PLUGIN.author = "verne"
PLUGIN.desc = "Allows for use of hotkeys to be used for pre-defined item usage."

ix.util.Include("cl_plugin.lua")
ix.util.Include("sh_hotkeyitems.lua")

local playerMeta = FindMetaTable("Player")
local charMeta = ix.meta.character or {}

ix.char.RegisterVar("hotkeys", {
	field = "hotkeys",
	fieldType = ix.type.string,
	default = {},
	bNoDisplay = true,
})

netstream.Hook("ixHotkeyChange", function(client, hotkey, value)
	client:GetCharacter():SetHotkey(hotkey, value)
end)

if (CLIENT) then
	netstream.Hook("ixHotkeyItemUpdate", function(hotkeyindex)
		local hotkeyitem = ix.option.Get("Hotkey" .. hotkeyindex, "nil")

		for i = 1, 4 do
			if ix.option.Get("Hotkey" .. i, "nil") == hotkeyitem then
				ix.option.Set("Hotkey" .. i, "nil")
			end
		end
	end)
end

function charMeta:GetHotkeyItemName(hotkeyindex)
	local hotkeys = self:GetHotkeys()

	return hotkeys[hotkeyindex]
end

function charMeta:SetHotkey(hotkeyindex, item)
	local hotkeys = self:GetHotkeys()

	hotkeys[hotkeyindex] = item

	self:SetHotkeys(hotkeys)
end

function charMeta:ClearHotkeys()
	local emptyhotkeys = {}

	self:SetHotkeys(emptyhotkeys)
end

function playerMeta:ActivateHotkey(hotkeyindex)
	local client = self
	local char = self:GetCharacter()
	local inv = char:GetInventory()
	local item = inv:HasItem(char:GetHotkeyItemName(hotkeyindex))
	local info, action

	--items shouldnt be overlapping blackscreens
	if self:GetNetVar("ix_noMenuAllowed") then
		return
	end

	if item then
		for k, v in pairs(PLUGIN.hotkeyitems) do
			if item.uniqueID == k then
				info = item.functions[v]
				action = v
			end
		end
	end

	if (info and info.OnCanRun and info.OnCanRun(item) != false) then
		ix.item.PerformInventoryAction(client, action, item.id, inv.id)

		if !inv:HasItem(char:GetHotkeyItemName(hotkeyindex)) then
			netstream.Start(client, "ixHotkeyItemUpdate", hotkeyindex)
		end
	end
end

function PLUGIN:ShowHelp(client)
	client:ActivateHotkey(1)
end

function PLUGIN:ShowTeam(client)
	client:ActivateHotkey(2)
end

function PLUGIN:ShowSpare1(client)
	client:ActivateHotkey(3)
end

function PLUGIN:ShowSpare2(client)
	client:ActivateHotkey(4)
end

ix.option.Add("Hotkey1", ix.type.array, "nil", {
	category = "_hotkeys",
	bNetworked = true,
	populate = function()
		local entries = {
			["nil"] = "None"
		}

		for k, v in pairs(PLUGIN.hotkeyitems) do
			local itemTable = ix.item.list[k]
			local name = itemTable.name
			local item = LocalPlayer():GetCharacter():GetInventory():HasItem(k)

			if item then
				if item.name then
					entries[k] = name
				else
					continue
				end
			end
		end

		-- Check if only the nil key is present
		if table.Count(entries) == 1 then
			ix.option.Set("Hotkey1", "nil")
		end

		return entries
	end,
	OnChanged = function(oldValue, newValue)
		netstream.Start("ixHotkeyChange", 1, newValue)
	end
})

ix.option.Add("Hotkey2", ix.type.array, "nil", {
	category = "_hotkeys",
	bNetworked = true,
	populate = function()
		local entries = {
			["nil"] = "None"
		}

		for k, v in pairs(PLUGIN.hotkeyitems) do
			local itemTable = ix.item.list[k]
			local name = itemTable.name
			local item = LocalPlayer():GetCharacter():GetInventory():HasItem(k)

			if item then
				if item.name then
					entries[k] = name
				else
					continue
				end
			end
		end

		-- Check if only the nil key is present
		if table.Count(entries) == 1 then
			ix.option.Set("Hotkey2", "nil")
		end

		return entries
	end,
	OnChanged = function(oldValue, newValue)
		netstream.Start("ixHotkeyChange", 2, newValue)
	end
})

ix.option.Add("Hotkey3", ix.type.array, "nil", {
	category = "_hotkeys",
	bNetworked = true,
	populate = function()
		local entries = {
			["nil"] = "None"
		}

		for k, v in pairs(PLUGIN.hotkeyitems) do
			local itemTable = ix.item.list[k]
			local name = itemTable.name
			local item = LocalPlayer():GetCharacter():GetInventory():HasItem(k)

			if item then
				if item.name then
					entries[k] = name
				else
					continue
				end
			end
		end

		-- Check if only the nil key is present
		if table.Count(entries) == 1 then
			ix.option.Set("Hotkey3", "nil")
		end

		return entries
	end,
	OnChanged = function(oldValue, newValue)
		netstream.Start("ixHotkeyChange", 3, newValue)
	end
})

ix.option.Add("Hotkey4", ix.type.array, "nil", {
	category = "_hotkeys",
	bNetworked = true,
	populate = function()
		local entries = {
			["nil"] = "None"
		}

		for k, v in pairs(PLUGIN.hotkeyitems) do
			local itemTable = ix.item.list[k]
			local name = itemTable.name
			local item = LocalPlayer():GetCharacter():GetInventory():HasItem(k)

			if item then
				if item.name then
					entries[k] = name
				else
					continue
				end
			end
		end

		-- Check if only the nil key is present
		if table.Count(entries) == 1 then
			ix.option.Set("Hotkey4", "nil")
		end

		return entries
	end,
	OnChanged = function(oldValue, newValue)
		netstream.Start("ixHotkeyChange", 4, newValue)
	end
})