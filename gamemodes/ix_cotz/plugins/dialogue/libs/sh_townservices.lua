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

local function addConversions(dialogue)
	dialogue.addTopic("ChangeSuitVariant", {
		statement = "Can you change my suit to another variant?",
		response = "Take it off and remove the attachments first. I'll show you which changes are available.",
		IsDynamic = true, options = {"BackTopic"},
		ShouldAdd = function(_, client, target) return serviceVisible(client, target, "suitVariants") end,
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
					client:Notify("Check the suit, its attachments, your unlocks and the conversion fee.")
				end
			end

			return "BackTopic"
		end,
	})
end

function ix.dialogue.ConfigureTownServices(dialogue, contact)
	local topic
	if contact.id == "ballast" then addStorage(dialogue) topic = "StorageTopic" end
	if contact.id == "vesper" then addConversions(dialogue) topic = "ChangeSuitVariant" end
	if not topic then return end
	for _, root in ipairs({"GREETING", "BackTopic"}) do
		local options = dialogue.tree[root].options
		options[#options + 1] = topic
	end
end
