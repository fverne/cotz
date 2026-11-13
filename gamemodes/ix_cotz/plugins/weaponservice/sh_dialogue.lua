local PLUGIN = PLUGIN
local MENU_ACTIONS = {
	WorkshopComponents = {"Obtain replacement components.", {"barrel", "receiver"}},
	WorkshopRebuild = {"Rebuild a weapon to full durability.", {"rebuild"}},
	WorkshopDismantle = {"Dismantle a weapon for parts.", {"dismantle"}},
}

local function addWorkshopOption(plugin, options, client, target, item, action, topicID)
	local data = {itemid = item.id, action = action}
	local offer = plugin:BuildOffer(client, target, data)
	if not offer then return end
	data.cost, data.durability, data.cleanliness = offer.cost, offer.durability, offer.cleanliness
	local name = offer.reward and ix.item.list[offer.reward].name or item.name
	if action == "dismantle" then name = item.name .. " -> " .. name end
	local statement = string.format("%s [#%d, %.1f%% durability]", name, item.id, offer.durability)
	options[#options + 1] = {statement = statement, topicID = topicID, dyndata = data}
end

function PLUGIN:WorkshopOptions(client, target, topicID)
	local character = client:GetCharacter()
	if not character or not self:CanUse(client, target) then return {} end
	local options, seen = {}, {}
	local items = {}
	for _, item in pairs(character:GetInventory():GetItems()) do
		if self.catalogue[item.uniqueID] then items[#items + 1] = item end
	end
	table.sort(items, function(first, second)
		if first.name == second.name then return first.id < second.id end

		return first.name < second.name
	end)
	for _, item in ipairs(items) do
		if topicID ~= "WorkshopComponents" or not seen[item.uniqueID] then
			seen[item.uniqueID] = true
			for _, action in ipairs(MENU_ACTIONS[topicID][2]) do
				addWorkshopOption(self, options, client, target, item, action, topicID)
			end
		end
	end

	return options
end

function PLUGIN:ConfigureDialogue(dialogue)
	dialogue.addTopic("WeaponWorkshop", {
		statement = "Weapon workshop.", category = "service",
		options = {"WorkshopComponents", "WorkshopRebuild", "WorkshopDismantle", "WorkshopCollect", "BackTopic"},
		ShouldAdd = function(_, client, target) return PLUGIN:CanUse(client, target) end,
	})
	for topicID, entry in pairs(MENU_ACTIONS) do
		local menuID = topicID
		dialogue.addTopic(menuID, {
			statement = entry[1], category = "service", IsDynamic = true, options = {"WeaponWorkshop", "BackTopic"},
			GetDynamicOptions = function(_, client, target) return PLUGIN:WorkshopOptions(client, target, menuID) end,
			ResolveDynamicOption = function(_, _, _, data) return "WorkshopConfirm", data end,
		})
	end
	dialogue.addTopic("WorkshopConfirm", {
		category = "service", IsDynamic = true, IsDynamicFollowup = true, options = {"WeaponWorkshop", "BackTopic"},
		DynamicPreCallback = function(topic, client, target, data)
			if SERVER then
				PLUGIN:QuoteWorkshop(client, target, data)
			else
				client.cotzWorkshopPreview = type(data) == "table" and table.Copy(data) or nil
				local offer = PLUGIN:BuildOffer(client, target, data)
				topic.response = offer and PLUGIN:DescribeOffer(client:GetCharacter(), offer)
					or "That weapon is no longer available. Request a fresh quote."
			end
		end,
		GetDynamicOptions = function(_, client, target)
			local offer = PLUGIN:BuildOffer(client, target, client.cotzWorkshopPreview)
			if not offer or offer.blocked then return {} end
			local statement = offer.action == "dismantle" and "Dismantle this weapon permanently."
				or offer.action == "rebuild" and "Fit both components and rebuild this weapon."
				or "Exchange the ingredients and commission for this component."

			return {{statement = statement, topicID = "WorkshopConfirm", dyndata = {accepted = true}}}
		end,
		ResolveDynamicOption = function(_, client, target, data)
			if SERVER then
				local accepted = type(data) == "table" and data.accepted == true
				if not PLUGIN:ExecuteWorkshop(client, target, accepted) then
					client:Notify("The workshop action could not be completed. Request a fresh quote.")
				end
			end

			return "BackTopic"
		end,
	})
	dialogue.addTopic("WorkshopCollect", {
		statement = "Collect stored workshop items.", category = "service", quickAction = true,
		ShouldAdd = function(_, client, target)
			return PLUGIN:CanUse(client, target) and #PLUGIN:Pending(client:GetCharacter()) > 0
		end,
		postCallback = function(_, client, target)
			if SERVER then PLUGIN:CollectWorkshopItems(client, target) end
		end,
	})
	for _, rootID in ipairs({"GREETING", "BackTopic"}) do
		local root = dialogue.tree[rootID]
		if root and not table.HasValue(root.options, "WeaponWorkshop") then
			root.options[#root.options + 1] = "WeaponWorkshop"
			root.options = ix.dialogue.OrderOptions(root.options, true)
		end
	end
end
