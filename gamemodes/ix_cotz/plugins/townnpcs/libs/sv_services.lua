local PLUGIN = PLUGIN
local CONVERSION_TIMEOUT = 15
local AMMO_CREDIT_KEY = "townAmmoExchangeRounds"
local CLAIM_LINE = "taskRewardClaims"

-- Collects the stacks that can pay for one input; banked credit from an interrupted exchange counts first.
local function gatherInput(inventory, credits, input)
	local balance = credits[input.item] or 0
	local stacks, available = {}, balance
	for _, item in pairs(inventory:GetItems(true)) do
		if item.uniqueID == input.item and not item:GetData("equip", false) then
			local quantity = item:GetData("quantity", item.ammoAmount)
			if type(quantity) == "number" and quantity > 0 and quantity % 1 == 0 then
				stacks[#stacks + 1] = {item = item, quantity = quantity}
				available = available + quantity
			end
		end
	end
	table.sort(stacks, function(first, second) return first.item:GetID() < second.item:GetID() end)

	return {item = input.item, required = ix.item.list[input.item].ammoAmount * input.boxes,
		balance = balance, available = available, stacks = stacks}
end

local function debitInput(character, credits, payment)
	for _, stack in ipairs(payment.stacks) do
		if payment.balance >= payment.required then break end
		local consumed = math.min(payment.required - payment.balance, stack.quantity)
		if consumed == stack.quantity then
			if not stack.item:Remove() then return false end
		else
			stack.item:SetData("quantity", stack.quantity - consumed)
		end
		-- Save acknowledged debits so a failed later removal can be retried without losing earlier inputs.
		payment.balance = payment.balance + consumed
		credits[payment.item] = payment.balance
		character:SetData(AMMO_CREDIT_KEY, credits)
		character:Save()
	end

	return true
end

local function hasPendingRoom(character)
	local line = ix.progression.GetCharacterProgression(character).lines[CLAIM_LINE] or {}

	return #(line.pendingRewards or {}) < ix.taskRewards.settings.maxPendingRewards
end

local function exchangeAmmunition(character, exchange)
	local inventory = character:GetInventory()
	local credits = table.Copy(character:GetData(AMMO_CREDIT_KEY, {}))
	local payments = {}
	for _, input in ipairs(exchange.inputs) do
		local payment = gatherInput(inventory, credits, input)
		if payment.available < payment.required then return false end
		payments[#payments + 1] = payment
	end
	if not hasPendingRoom(character) then return false end
	for _, payment in ipairs(payments) do
		if not debitInput(character, credits, payment) then return false end
	end
	if not hasPendingRoom(character) then return false end
	local record = ix.progression.GetCharacterProgression(character)
	local line = record.lines[CLAIM_LINE] or {}
	line.pendingRewards = line.pendingRewards or {}
	for _, payment in ipairs(payments) do credits[payment.item] = payment.balance - payment.required end
	local reward = {item = exchange.output, quantity = ix.item.list[exchange.output].ammoAmount}
	line.pendingRewards[#line.pendingRewards + 1] = ix.progression.PrepareReward(character, CLAIM_LINE, line, reward)
	record.lines[CLAIM_LINE] = line
	character:SetData(AMMO_CREDIT_KEY, credits)
	ix.progression.SetCharacterProgression(character, record)
	character:Save()
	if not ix.progression.ClaimRewards(character, CLAIM_LINE) then
		character:GetPlayer():Notify("Make room, then collect your ammunition from stored rewards.")
	end

	return true
end

function PLUGIN:ExchangeAmmo(client, target, output)
	if type(output) ~= "string" or not self:CanInteract(client, target) then return false end
	local character = client:GetCharacter()
	local exchange = (self.ammoExchanges or {})[output]
	if not exchange or exchange.npc ~= target:GetDisplayName()
		or not ix.progression.IsCompleted(character, exchange.id) or character.cotzExchangingAmmo then return false end
	local now = CurTime()
	if now < (client.cotzTownNextAction or 0) then return false end
	client.cotzTownNextAction = now + self.settings.actionInterval
	character.cotzExchangingAmmo = true
	local exchanged = exchangeAmmunition(character, exchange)
	character.cotzExchangingAmmo = nil

	return exchanged
end

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
	ix.economyStats.Record(character, "conversionSpent", price)
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
	local personal = ix.plugin.Get("personalstorage")
	if not personal then return false end
	local character = client:GetCharacter()
	if character.cotzOpeningStorage then return false end
	character.cotzOpeningStorage = true
	personal:GetPersonalInventory(character, function(inventory)
		character.cotzOpeningStorage = nil
		if not IsValid(client) or not IsValid(target) or client:GetCharacter() ~= character
			or not self:CanInteract(client, target)
			or not self:HasService(character, "storage", target:GetDisplayName()) then return end
		personal:OpenPersonalInventory(client, inventory, target)
	end)

	return true
end
