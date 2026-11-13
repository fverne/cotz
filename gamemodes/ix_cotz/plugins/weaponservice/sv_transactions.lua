local PLUGIN = PLUGIN

function PLUGIN:BeginWorkshopAction(client, target)
	if not self:CanUse(client, target) or client:GetCharacter().cotzWorkshopBusy then return false end
	if CurTime() < (client.cotzWorkshopNextAction or 0) then return false end
	client.cotzWorkshopNextAction = CurTime() + self.settings.actionInterval

	return true
end

function PLUGIN:QuoteWorkshop(client, target, arguments)
	client.cotzWorkshopQuote = nil
	if not self:CanUse(client, target) or CurTime() < (client.cotzWorkshopNextQuote or 0) then return end
	client.cotzWorkshopNextQuote = CurTime() + self.settings.actionInterval
	local offer = self:BuildOffer(client, target, arguments)
	if not offer or offer.blocked then return end
	if type(arguments.cost) ~= "number" or offer.cost > arguments.cost
		or offer.durability ~= arguments.durability or offer.cleanliness ~= arguments.cleanliness then return end
	client.cotzWorkshopQuote = {
		character = client:GetCharacter(), target = target, expires = CurTime() + self.settings.quoteLifetime,
		arguments = {action = offer.action, itemid = offer.item.id}, cost = offer.cost, baseCost = offer.baseCost,
		durability = offer.durability, cleanliness = offer.cleanliness,
	}
end

local function unlockPlan(plan)
	for _, step in ipairs(plan) do step.item.cotzWorkshopLocked = nil end
end

function PLUGIN:ConsumeWorkshopPlan(client, plan)
	local items = client:GetCharacter():GetInventory():GetItems()
	for _, step in ipairs(plan) do
		local item = step.item
		local quantity = item.quantity and item:GetData("quantity", item.quantity) or 1
		if items[item.id] ~= item or item.cotzWorkshopLocked or quantity ~= step.quantity
			or hook.Run("CanPlayerInteractItem", client, "WeaponWorkshop", item.id) == false then
			return false, {}
		end
	end
	for _, step in ipairs(plan) do step.item.cotzWorkshopLocked = true end
	local refunds, partials = {}, {}
	for _, step in ipairs(plan) do
		local item = step.item
		if step.take < step.quantity then
			item:SetData("quantity", step.quantity - step.take)
			partials[#partials + 1] = step
		else
			local refund = {item = item.uniqueID, data = table.Copy(item.data)}
			if not item:Remove() then
				for _, partial in ipairs(partials) do partial.item:SetData("quantity", partial.quantity) end
				unlockPlan(plan)

				return false, refunds
			end
			refunds[#refunds + 1] = refund
		end
	end
	unlockPlan(plan)

	return true, refunds
end

function PLUGIN:SaveWorkshopResult(character, message)
	self:RefreshWorkshopWeight(character)
	character:Save(function()
		character.cotzWorkshopBusy = nil
		if ix.plugin.Get("weaponservice") ~= PLUGIN then return end
		PLUGIN:NotifyWorkshop(character, message)
		PLUGIN:DeliverWorkshopItem(character)
	end)
end

function PLUGIN:ExecuteWorkshop(client, target, accepted)
	local quote = client.cotzWorkshopQuote
	client.cotzWorkshopQuote = nil
	if not accepted or not quote or not self:BeginWorkshopAction(client, target) then return false end
	local character = client:GetCharacter()
	if quote.character ~= character or quote.target ~= target or quote.expires < CurTime() then return false end
	local offer = self:BuildOffer(client, target, quote.arguments)
	if not offer or offer.blocked or offer.cost > quote.cost or offer.baseCost > quote.baseCost
		or offer.durability ~= quote.durability or offer.cleanliness ~= quote.cleanliness then return false end
	character.cotzWorkshopBusy = true
	if offer.action == "dismantle" then
		offer.plan = {{item = offer.item, take = 1, quantity = 1}}
	end
	local consumed, refunds = self:ConsumeWorkshopPlan(client, offer.plan)
	if not consumed then
		self:QueueWorkshopItems(character, refunds)
		self:SaveWorkshopResult(character, "The exchange failed. Removed ingredients are stored for return.")

		return false
	end
	if offer.action == "barrel" or offer.action == "receiver" then
		local charged = ix.progression.ChargeService(character, offer.npc, "repair", offer.baseCost, quote.cost)
		if not charged then
			-- Refund full items through acknowledged delivery; restore any partial stacks immediately.
			for _, step in ipairs(offer.plan) do
				if step.take < step.quantity then step.item:SetData("quantity", step.quantity) end
			end
			self:QueueWorkshopItems(character, refunds)
			self:SaveWorkshopResult(character, "The commission changed. Your ingredients have been returned or stored.")

			return false
		end
		self:QueueWorkshopItems(character, {{item = offer.reward}})
		self:SaveWorkshopResult(character, "Your replacement " .. offer.action .. " is ready.")
	elseif offer.action == "rebuild" then
		offer.item:SetData("durability", 100)
		if offer.item:GetData("equip", false) then
			offer.item:SetData("wear", offer.cleanliness)
			local weapon = client:GetWeapon(offer.item.class)
			if IsValid(weapon) then weapon:SetWeaponDurability(100) end
		end
		self:SaveWorkshopResult(character, "Weapon durability restored to 100%.")
	else
		local count = offer.guaranteed
		if offer.extraChance > 0 and math.Rand(0, 1) < offer.extraChance then count = count + 1 end
		local rewards = {}
		if count > 0 then rewards[1] = {item = offer.reward, data = {quantity = count}} end
		self:QueueWorkshopItems(character, rewards)
		self:SaveWorkshopResult(character, string.format("Weapon dismantled. Recovered %d weapon parts.", count))
	end

	return true
end

function PLUGIN:CollectWorkshopItems(client, target)
	if not self:BeginWorkshopAction(client, target) then return false end

	return self:DeliverWorkshopItem(client:GetCharacter())
end
