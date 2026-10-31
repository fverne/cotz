local PLUGIN = PLUGIN

PLUGIN.name = "Equipment Slots"
PLUGIN.author = "verne"
PLUGIN.description = "Named equipment slots that retain normal character inventory behavior."

-- Helix encodes inventory dimensions and coordinates with six bits. Keep normal storage left of this region.
PLUGIN.storageX = 32
PLUGIN.cellSize = 8
PLUGIN.storageColumns = 4
PLUGIN.storageWidth = 63
PLUGIN.storageHeight = 32
PLUGIN.slots = {
	{id = "suit", name = "Suit", field = "isBodyArmor"},
	{id = "helmet", name = "Helmet", field = "isHelmet"},
	{id = "gasmask", name = "Gasmask", field = "isGasmask"},
	{id = "backpack", name = "Backpack", field = "isBackpack"},
	{id = "exoskeleton", name = "Exoskeleton", field = "isExoskeleton"},
	{id = "primary", name = "Primary weapon", category = "primary"},
	{id = "secondary", name = "Secondary weapon", category = "secondary"},
	{id = "knife", name = "Knife", category = "knife"},
	{id = "artifactdetector", name = "Artifact detector", category = "artifactdetector"},
	{id = "binoculars", name = "Binoculars", category = "Binoculars"},
	{id = "geiger", name = "Geiger counter", field = "isGeiger"},
	{id = "anomalydetector", name = "Anomaly detector", field = "isAnomalydetector"},
	{id = "headlamp", name = "Headlamp", field = "isHeadLamp"},
	{id = "compass", name = "Compass", field = "isCompass"},
	{id = "gps", name = "GPS tracker", field = "isGpstracker"},
}

function PLUGIN:GetItemSlots(item, x)
	local slots = {}

	-- Retain access to PDAs saved in the former slot until their owner returns them to the backpack.
	if item.isPDA and self:IsEquipmentCell(x or item.gridX) then return {10} end

	for index, slot in ipairs(self.slots) do
		if (slot.field and item[slot.field]) or (slot.category and item.weaponCategory == slot.category) then
			slots[#slots + 1] = index
		end
	end

	return slots
end

function PLUGIN:IsEquipmentCell(x)
	return x and x >= self.storageX
end

function PLUGIN:GetStoragePosition(index)
	return self.storageX + ((index - 1) % self.storageColumns) * self.cellSize,
		1 + math.floor((index - 1) / self.storageColumns) * self.cellSize
end

function PLUGIN:GetSlotItems(inventory)
	local occupied = {}

	-- Sync stores client items at their anchor cells without assigning item.gridX/gridY.
	for item, x in inventory:Iter() do
		if item:GetData("equip") or self:IsEquipmentCell(x) then
			for _, index in ipairs(self:GetItemSlots(item, x)) do
				occupied[index] = item
			end
		end
	end

	return occupied
end

function PLUGIN:ConfigureInventory(inventory, width, height)
	if not inventory or inventory.vars.cotzEquipmentWidth then return end
	width = width or inventory.w
	height = height or inventory.h
	assert(width < self.storageX and height <= 63, "Equipment slots require a backpack smaller than 32 x 64")
	inventory.vars.cotzEquipmentWidth = width
	inventory.vars.cotzEquipmentHeight = height
	inventory:SetSize(self.storageWidth, math.max(height, self.storageHeight))
end

function PLUGIN:GetUnequipPosition(item, inventory, position)
	if not position then return inventory:FindEmptySlot(item.width, item.height, true) end
	if not istable(position) then return end
	local x, y = position[1], position[2]
	if not isnumber(x) or not isnumber(y) or x % 1 ~= 0 or y % 1 ~= 0 then return end
	if not inventory:CanItemFit(x, y, item.width, item.height) then return end

	return x, y
end

function PLUGIN:CheckEquipmentAction(item, client, equipping, dropping, position)
	local character = IsValid(client) and client:GetCharacter()
	local inventory = character and character:GetInventory()
	if not inventory or item.invID ~= inventory:GetID() or inventory:GetItemByID(item.id, true) ~= item then
		return false, "This item must belong to your current character's inventory."
	end
	if not client:Alive() then return false, "You cannot change equipment while dead." end
	local event = equipping and "CanPlayerEquipItem" or "CanPlayerUnequipItem"
	if hook.Run(event, client, item) == false then return false, "You cannot change equipment right now." end
	local slots = self:GetItemSlots(item)
	if #slots == 0 then return false, "This item has no equipment slot." end
	if equipping then
		if item.isPDA then return false, "PDAs no longer have an equipment slot." end
		if item.width > self.cellSize or item.height > self.cellSize then
			return false, "This item is too large for an equipment slot."
		end
		local occupied = self:GetSlotItems(inventory)

		for _, index in ipairs(slots) do
			if occupied[index] and occupied[index] ~= item then
				return false, self.slots[index].name .. " is already occupied. Unequip it first."
			end
		end
	elseif self:IsEquipmentCell(item.gridX) or position then
		if not dropping then
			local x = self:GetUnequipPosition(item, inventory, position)
			if not x then return false, "The item does not fit in the requested backpack space." end
		end
		if item.GetCarryInc and item:GetCarryInc() and not character:CanRemoveCarry(item) then
			return false, "Removing this item would make you too overencumbered."
		end
	end

	return true
end

function PLUGIN:InstallInventoryCompatibility()
	if self.inventoryOriginals then return end
	local meta = ix.meta.inventory
	local originals = {
		GetSize = meta.GetSize, CanItemFit = meta.CanItemFit, FindEmptySlot = meta.FindEmptySlot, Add = meta.Add,
	}
	self.inventoryOriginals = originals

	function meta:GetSize()
		if self.vars.cotzEquipmentWidth then
			return self.vars.cotzEquipmentWidth, self.vars.cotzEquipmentHeight
		end

		return originals.GetSize(self)
	end

	function meta:CanItemFit(x, y, width, height, item)
		if self.vars.cotzEquipmentWidth then
			local backpackWidth, backpackHeight = self:GetSize()
			if x < 1 or y < 1 or x + width - 1 > backpackWidth or y + height - 1 > backpackHeight then
				return false
			end
			-- Normal inventory moves must not pull an equipped item out of its reserved cells.
			if item and PLUGIN:IsEquipmentCell(item.gridX) then return false end
		end

		return originals.CanItemFit(self, x, y, width, height, item)
	end

	function meta:FindEmptySlot(width, height, onlyMain)
		if not self.vars.cotzEquipmentWidth then
			return originals.FindEmptySlot(self, width, height, onlyMain)
		end
		-- A read-only view lets the bundled search keep its bag behavior without scanning reserved cells.
		local backpackWidth, backpackHeight = self:GetSize()
		local backpack = setmetatable({w = backpackWidth, h = backpackHeight}, {__index = self})

		return originals.FindEmptySlot(backpack, width, height, onlyMain)
	end

	if SERVER then
		function meta:Add(uniqueID, quantity, data, x, y, noReplication)
			local item = isnumber(uniqueID) and ix.item.instances[uniqueID] or ix.item.list[uniqueID]
			if self.vars.cotzEquipmentWidth and item and x and y
				and not self:CanItemFit(x, y, item.width, item.height) then
				return false, "noFit"
			end

			return originals.Add(self, uniqueID, quantity, data, x, y, noReplication)
		end
	end
end

function PLUGIN:InitializedPlugins()
	self:InstallInventoryCompatibility()
	if SERVER then self:InstallServerCompatibility() end
	if CLIENT then self:InstallInventoryPanels() end
end

ix.util.Include("sv_plugin.lua")
ix.util.Include("sv_admin.lua")
ix.util.Include("cl_admin.lua")
ix.util.Include("cl_layout.lua")
ix.util.Include("cl_plugin.lua")
