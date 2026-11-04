local PLUGIN = PLUGIN
local CONVERSION_TIMEOUT = 15

local function serviceAction(client, target, service)
	if not PLUGIN:CanInteract(client, target)
		or not PLUGIN:HasService(client:GetCharacter(), service, target:GetDisplayName()) then return false end
	local now = CurTime()
	if now < (client.cotzTownNextAction or 0) then return false end
	client.cotzTownNextAction = now + PLUGIN.settings.actionInterval

	return true
end

local function convertibleSuit(character, target, itemID, variantID)
	local inventory = character:GetInventory()
	local item = inventory:GetItems()[itemID]
	local variant = ix.item.list[variantID]
	if not item or not variant or not item.baseSuit or variant.baseSuit ~= item.baseSuit
		or item.uniqueID == variantID or item.invID ~= inventory:GetID() or item:GetData("equip", false)
		or not PLUGIN:CanChangeSuitVariant(character, variantID, target:GetDisplayName()) then return end
	for _, slots in pairs(item:GetData("attachments", item.miscSlots) or {}) do
		if type(slots) == "table" and next(slots) then return end
	end

	return item, math.max(0, math.Round(variant.price / 10))
end

local function finishConversion(operation, replacement)
	local client, target, character = operation.client, operation.target, operation.character
	local item = operation.item
	local valid = IsValid(client) and IsValid(target) and client:GetCharacter() == character
		and PLUGIN:CanInteract(client, target) and item.cotzConversion == operation
	local current, price
	if valid then current, price = convertibleSuit(character, target, operation.itemID, operation.variantID) end
	if current ~= item or not character:HasMoney(price or operation.price) then
		replacement:Remove()
		if item.cotzConversion == operation then item.cotzConversion = nil end

		return
	end
	local inventory = character:GetInventory()
	replacement:SetData("durability", item:GetData("durability", 100))
	local inserted = inventory:Add(replacement:GetID())
	if not inserted then
		replacement:Remove()
		item.cotzConversion = nil
		client:Notify("Make room in your inventory before converting the suit.")

		return
	end
	if not item:Remove() then
		replacement:Remove()
		item.cotzConversion = nil

		return
	end
	character:TakeMoney(price)
	character:Save()
	ix.dialogue.notifyMoneyLost(client, ix.currency.Get(price))
end

function PLUGIN:ConvertSuit(client, target, itemID, variantID)
	if type(itemID) ~= "number" or type(variantID) ~= "string"
		or not serviceAction(client, target, "suitVariants") then return false end
	local character = client:GetCharacter()
	local item, price = convertibleSuit(character, target, itemID, variantID)
	if not item or item.cotzConversion or not character:HasMoney(price) then return false end
	local operation = {client = client, target = target, character = character, item = item,
		itemID = itemID, variantID = variantID, price = price}
	item.cotzConversion = operation
	local data = table.Copy(item.data or {})
	data.equip = nil
	timer.Simple(CONVERSION_TIMEOUT, function()
		if item.cotzConversion == operation then item.cotzConversion = nil end
	end)
	-- Create outside the inventory, then use the synchronous existing-instance transfer contract.
	-- Neither the input nor money is consumed while the database insert is pending.
	ix.item.Instance(0, variantID, data, nil, nil, function(replacement)
		-- The bundled Instance calls OnInstanced after this callback; suits reset durability there.
		timer.Simple(0, function() finishConversion(operation, replacement) end)
	end, character:GetID(), client:SteamID64())

	return true
end

function PLUGIN:OpenTownStorage(client, target)
	if not serviceAction(client, target, "storage") then return false end
	local character = client:GetCharacter()
	if character.cotzOpeningStorage then return false end
	character.cotzOpeningStorage = true
	local function open(inventory)
		character.cotzOpeningStorage = nil
		if not IsValid(client) or not IsValid(target) or client:GetCharacter() ~= character
			or not self:CanInteract(client, target)
			or not self:HasService(character, "storage", target:GetDisplayName()) then return end
		inventory:SetOwner(character:GetID())
		inventory:SetSize(character:GetData("bankW", ix.config.Get("bankW", 2)),
			character:GetData("bankH", ix.config.Get("bankH", 2)))
		ix.storage.Open(client, inventory, {entity = target, name = "Hideout Storage",
			searchText = "Accessing stored cargo...", searchTime = ix.config.Get("containerOpenTime", 0)})
	end
	local id = character:GetData("bankID")
	if id and ix.item.inventories[id] then
		open(ix.item.inventories[id])
	elseif id then
		local sizes = {[id] = {character:GetData("bankW", ix.config.Get("bankW", 2)),
			character:GetData("bankH", ix.config.Get("bankH", 2))}}
		ix.inventory.Restore(sizes, ix.config.Get("bankW", 2), ix.config.Get("bankH", 2), open)
	else
		ix.inventory.New(character:GetID(), "bankInvType", function(inventory)
			character:SetData("bankID", inventory:GetID())
			character:Save()
			open(inventory)
		end)
	end

	return true
end
