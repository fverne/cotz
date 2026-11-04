local PLUGIN = PLUGIN

util.AddNetworkString("cotz/equipment/admin-list")
util.AddNetworkString("cotz/equipment/admin-take")

function PLUGIN:SendAdminInventory(client, character)
	local items = character:GetInventory():GetItems(true)
	net.Start("cotz/equipment/admin-list")
		net.WriteUInt(character:GetID(), 32)
		net.WriteString(character:GetName())
		net.WriteUInt(table.Count(items), 16)
		for _, item in pairs(items) do
			net.WriteUInt(item.id, 32)
			net.WriteString(item:GetName())
			net.WriteBool(item:GetData("equip", false))
		end
	net.Send(client)
end

ix.command.Add("CharTakeInventory", {
	description = "View a character's inventory and take items into your own backpack.",
	adminOnly = true,
	arguments = {ix.type.character},
	OnRun = function(self, client, character)
		if not client:GetCharacter() or character == client:GetCharacter() then
			return "Choose another active character."
		end
		if not IsValid(character:GetPlayer()) or character:GetPlayer():GetCharacter() ~= character then
			return "The target must be playing that character."
		end
		PLUGIN:SendAdminInventory(client, character)
	end,
})

function PLUGIN:TakeAdminItem(client, characterID, itemID)
	if not ix.command.HasAccess(client, "CharTakeInventory") then return end
	local character = client:GetCharacter()
	local target = ix.char.loaded[characterID]
	local owner = target and target:GetPlayer()
	if not character or target == character or not IsValid(owner) or owner:GetCharacter() ~= target then return end
	local inventory = target:GetInventory()
	local item = inventory:GetItemByID(itemID, true)
	if not item or item.invID ~= inventory:GetID() or ix.item.instances[itemID] ~= item then return end
	if self:GetPending(owner) then client:Notify("Wait for the target's equipment action to finish.") return end
	local destination = character:GetInventory()
	local x, y = destination:FindEmptySlot(item.width, item.height, true)
	if not x then client:Notify("There is no room in your backpack.") return end
	if item:GetData("equip") then
		if not item.functions.EquipUn then client:Notify("This item must be unequipped by its owner.") return end
		ix.item.PerformInventoryAction(owner, "EquipUn", item.id, inventory:GetID())
		client:Notify("Unequip requested. Click Take again after the equipment action finishes.")
		self:SendAdminInventory(client, target)
		return
	end
	if self:IsEquipmentCell(item.gridX) then
		client:Notify("The target must return this inactive item to their backpack first.")
		return
	end
	local success, reason = item:Transfer(destination:GetID(), x, y, client)
	if not success then client:NotifyLocalized(reason or "notAllowed") return end
	client:Notify("Took " .. item:GetName() .. " from " .. target:GetName() .. ".")
	owner:Notify(client:Name() .. " took " .. item:GetName() .. " from your inventory.")
	self:QueueRefresh(inventory)
	self:QueueRefresh(destination)
	self:SendAdminInventory(client, target)
end

net.Receive("cotz/equipment/admin-take", function(_, client)
	if (client.cotzAdminTakeNext or 0) > CurTime() then return end
	client.cotzAdminTakeNext = CurTime() + 0.5
	PLUGIN:TakeAdminItem(client, net.ReadUInt(32), net.ReadUInt(32))
end)
