ix.dialogue = ix.dialogue or {}

local function serviceVisible(client, target, service)
	return ix.townNPCs:HasService(client:GetCharacter(), service, target:GetDisplayName())
end

local function addStorage(dialogue)
	dialogue.addTopic("StorageTopic", {
		statement = "Can I use your storage?",
		response = "Tell me what you're leaving. I have room for a careful load.",
		IsDynamic = true,
		options = {"BackTopic"},
		ShouldAdd = function(_, client, target) return serviceVisible(client, target, "storage") end,
		GetDynamicOptions = function(_, client, target) return ix.progression.GetStorageOptions(client, target) end,
		ResolveDynamicOption = function(_, client, target, data)
			return ix.progression.ResolveServiceOffer(client, target, "storage", data)
		end,
	})
	dialogue.addTopic("OpenStorage", {
		response = "Here. Check the load before you take it out.",
		options = {"BackTopic"},
		postCallback = function(_, client, target)
			if SERVER then ix.townNPCs:OpenTownStorage(client, target) end
		end,
	})
	dialogue.addTopic("ConfirmStorageUpgrade", {
		response = "", IsDynamic = true, IsDynamicFollowup = true,
		DynamicPreCallback = function(self, client, target, data)
			ix.progression.ConfirmService(self, client, target, "storage", data)
		end,
		GetDynamicOptions = function()
			return {
				{statement = "Pay for the extra space.", topicID = "ConfirmStorageUpgrade", dyndata = {accepted = true}},
				{statement = "Leave it as it is.", topicID = "ConfirmStorageUpgrade", dyndata = {accepted = false}},
			}
		end,
		ResolveDynamicOption = function(_, client, target, data)
			if SERVER then
				ix.progression.ExecuteService(client, target, "storage", type(data) == "table" and data.accepted == true)
			end

			return "BackTopic"
		end,
	})
	dialogue.addTopic("NotEnoughMoneyStorage", {response = "Come back when you can cover the extra space.",
		options = {"BackTopic"}})
end

local function appendVariants(options, character, target, item, id)
	if not item.baseSuit or item:GetData("equip", false) then return end
	for variantID, variant in pairs(ix.item.list) do
		if variant.baseSuit == item.baseSuit and variantID ~= item.uniqueID
			and ix.townNPCs:CanChangeSuitVariant(character, variantID, target:GetDisplayName()) then
			options[#options + 1] = {statement = item:GetName() .. " to " .. variant.name .. " - "
				.. ix.currency.Get(math.Round(variant.price / 10)), topicID = "ChangeSuitVariant",
				dyndata = {item = id, variant = variantID}}
		end
	end
end

local function hasSuitConversions(client, target)
	local character = client:GetCharacter()
	local npc = target:GetDisplayName()
	if not serviceVisible(client, target, "suitVariants") then return false end
	for id in pairs(ix.townNPCs.variantUnlocks or {}) do
		if ix.townNPCs:CanChangeSuitVariant(character, id, npc) then return true end
	end
	for id in pairs(ix.townNPCs.variantBaseGates or {}) do
		if ix.townNPCs:CanChangeSuitVariant(character, id, npc) then return true end
	end

	return false
end

local function addConversions(dialogue)
	dialogue.addTopic("ChangeSuitVariant", {
		statement = "Can you change my suit to another variant?",
		response = "Take it off and remove the attachments first. I'll show you which changes are available.",
		IsDynamic = true, options = {"BackTopic"},
		ShouldAdd = function(_, client, target) return hasSuitConversions(client, target) end,
		GetDynamicOptions = function(_, client, target)
			local options = {}
			local character = client:GetCharacter()
			for id, item in pairs(character:GetInventory():GetItems()) do
				appendVariants(options, character, target, item, id)
			end
			table.sort(options, function(first, second) return first.statement < second.statement end)

			return options
		end,
		ResolveDynamicOption = function(_, client, target, data)
			if SERVER and type(data) == "table" then
				if not ix.townNPCs:ConvertSuit(client, target, data.item, data.variant) then
					client:Notify("Take off the suit and remove its attachments. Check that I can make that variant and that you can cover the fee.")
				end
			end

			return "BackTopic"
		end,
	})
end

local function addHideoutBarter(dialogue)
	dialogue.addTopic("HideoutBarter", {
		statement = "Can I arrange a hideout or buy improvements?",
		response = "",
		options = {"BackTopic"},
		ShouldAdd = function() return ix.plugin.Get("hideouts") ~= nil end,
		postCallback = function(_, client, target)
			local hideouts = ix.plugin.Get("hideouts")
			if SERVER and hideouts then hideouts:OpenPersonalBarter(client, target, 1) end
		end,
	})
	if not dialogue.tree.StartBarter then
		dialogue.addTopic("StartBarter", {
			statement = "What can we barter?", response = "", options = {"BackTopic"},
		})
	end
	local options = dialogue.tree.StartBarter.options
	options[#options + 1] = "HideoutBarter"
	for _, root in ipairs({"GREETING", "BackTopic"}) do
		local found
		for _, id in ipairs(dialogue.tree[root].options) do if id == "StartBarter" then found = true end end
		if not found then table.insert(dialogue.tree[root].options, "StartBarter") end
	end
end

function ix.dialogue.ConfigureTownServices(dialogue, contact)
	if contact.id == "brass" or contact.id == "carbon" then
		dialogue.addTopic("AmmoExchange", {
			statement = "Can we exchange ammunition?", response = "", IsDynamic = true,
			ShouldAdd = function(_, client, target)
				return #ix.townNPCs:GetAmmoExchanges(client:GetCharacter(), target:GetDisplayName()) > 0
			end,
			options = {"BackTopic"},
			GetDynamicOptions = function(_, client, target)
				local options = {}
				local credits = client:GetCharacter():GetData("townAmmoExchangeRounds", {})
				for _, exchange in ipairs(ix.townNPCs:GetAmmoExchanges(client:GetCharacter(), target:GetDisplayName())) do
					local credit = credits[exchange.input] or 0
					options[#options + 1] = {
						statement = string.format("%d boxes of %s for one box of %s", exchange.boxes,
							ix.item.list[exchange.input].name, ix.item.list[exchange.output].name)
							.. (credit > 0 and " (" .. credit .. " rounds already handed in)" or ""),
						topicID = "AmmoExchange", dyndata = {output = exchange.output},
					}
				end

				return options
			end,
			ResolveDynamicOption = function(_, client, target, data)
				if SERVER and type(data) == "table" then ix.townNPCs:ExchangeAmmo(client, target, data.output) end

				return "AmmoExchange"
			end,
		})
		if not dialogue.tree.StartBarter then
			dialogue.addTopic("StartBarter", {
				statement = "What can we barter?", options = {"BackTopic"},
			})
		end
		table.insert(dialogue.tree.StartBarter.options, 1, "AmmoExchange")
		for _, root in ipairs({"GREETING", "BackTopic"}) do
			local options = dialogue.tree[root].options
			options[#options + 1] = "StartBarter"
		end
	end
	if contact.id == "ballast" or contact.id == "cleaner" or contact.id == "ledger" then addHideoutBarter(dialogue) end
	local topic
	if contact.id == "suture" then addConversions(dialogue) topic = "ChangeSuitVariant" end
	if not topic then return end
	for _, root in ipairs({"GREETING", "BackTopic"}) do
		local options = dialogue.tree[root].options
		options[#options + 1] = topic
	end
end
