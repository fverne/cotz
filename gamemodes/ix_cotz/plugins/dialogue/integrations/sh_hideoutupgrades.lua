ix.dialogue = ix.dialogue or {}

local RESPONSES = {
	ballast = {
		hideouts = "Which room are we fitting out? Name it and I'll tell you what the work takes. If yours isn't listed, arrange one at an entrance first.",
		offers = "This is what that room can still take. Materials come out of your pack and the fitting is paid here. It's done before you're back at the door.",
	},
	cleaner = {
		hideouts = "Which room. If it isn't listed, it isn't yours, or you haven't arranged it yet.",
		offers = "Those are the options. Materials and charge are listed for each. I fit what's paid for.",
	},
	ledger = {
		hideouts = "Your own room or your squad's quarters? Choose the one you mean and I'll put the costs in front of you.",
		offers = "Everything that room can still be fitted with, and what each one costs. Pick one and I'll read it back to you before anything changes hands.",
	},
}

local function hideoutPlugin()
	return ix.plugin.Get("hideouts")
end

local function currentOffers(client, target)
	local view = client.cotzHideoutUpgradeOffers
	if view and view.target == target then return view end
end

-- Hideout state lives on the server, which answers each step with a snapshot (see hideouts/cl_upgrades.lua).
function ix.dialogue.ConfigureHideoutUpgrades(dialogue, contact)
	local responses = RESPONSES[contact.id]
	if not responses then return end
	dialogue.addTopic("HideoutUpgrades", {
		statement = "I want to improve my hideout.", response = responses.hideouts, category = "service",
		IsDynamic = true, options = {"BackTopic"},
		ShouldAdd = function()
			return hideoutPlugin() ~= nil and game.GetMap() == contact.map
		end,
		preCallback = function(_, client, target)
			if SERVER then
				hideoutPlugin():SendUpgradeHideouts(client, target)
			else
				client.cotzHideoutUpgradeList = nil
			end
		end,
		GetDynamicOptions = function(_, client, target)
			local list = client.cotzHideoutUpgradeList
			if not list or list.target ~= target then return {} end
			local options = {}
			for _, hideout in ipairs(list.hideouts) do
				options[#options + 1] = {
					statement = (hideout.squad and "Squad hideout: " or "") .. hideout.name,
					topicID = "HideoutUpgrades", dyndata = {hideout = hideout.id},
				}
			end

			return options
		end,
		ResolveDynamicOption = function(_, _, _, data)
			return "HideoutUpgradeList", data
		end,
	})
	dialogue.addTopic("HideoutUpgradeList", {
		response = responses.offers, category = "service", IsDynamic = true, IsDynamicFollowup = true,
		options = {"HideoutUpgrades", "BackTopic"},
		DynamicPreCallback = function(_, client, target, data)
			local id = type(data) == "table" and data.hideout
			if type(id) ~= "string" then return end
			if SERVER then
				hideoutPlugin():SendUpgradeOffers(client, target, id)
				return
			end
			local view = currentOffers(client, target)
			if not view or view.hideout ~= id then
				client.cotzHideoutUpgradeOffers = {target = target, hideout = id, offers = {}}
			end
		end,
		GetDynamicOptions = function(_, client, target)
			local view = currentOffers(client, target)
			local options = {}
			for index, offer in ipairs(view and view.offers or {}) do
				options[#options + 1] = {
					statement = offer.label .. " — " .. offer.summary, topicID = "HideoutUpgradeList",
					dyndata = {index = index},
				}
			end

			return options
		end,
		ResolveDynamicOption = function(_, _, _, data)
			return "HideoutUpgradeConfirm", data
		end,
	})
	dialogue.addTopic("HideoutUpgradeConfirm", {
		category = "service", IsDynamic = true, IsDynamicFollowup = true, options = {"BackTopic"},
		DynamicPreCallback = function(topic, client, target, data)
			if SERVER then return end
			local view = currentOffers(client, target)
			local index = type(data) == "table" and data.index
			local offer = view and view.offers[index]
			client.cotzHideoutUpgradeChoice = offer and index or nil
			topic.response = offer and offer.label .. "\n" .. offer.description
				or "That upgrade is no longer listed. Choose it again."
		end,
		GetDynamicOptions = function(_, client, target)
			local view = currentOffers(client, target)
			local index = client.cotzHideoutUpgradeChoice
			local offer = view and index and view.offers[index]
			local options = {}
			if offer and offer.payable then
				options[#options + 1] = {
					statement = "Pay " .. offer.summary .. " and fit it.", topicID = "HideoutUpgradeConfirm",
					dyndata = {accepted = true, index = index, revision = view.revision},
				}
			end
			if offer and offer.redeemable then
				options[#options + 1] = {
					statement = "Fit it using the crate I'm carrying.", topicID = "HideoutUpgradeConfirm",
					dyndata = {accepted = true, crate = true, index = index, revision = view.revision},
				}
			end
			options[#options + 1] = {
				statement = "Show me the other upgrades.", topicID = "HideoutUpgradeConfirm",
				dyndata = {accepted = false},
			}

			return options
		end,
		ResolveDynamicOption = function(_, client, target, data)
			if SERVER then
				if type(data) == "table" and data.accepted == true then
					local started, reason = hideoutPlugin():ExecuteUpgrade(client, target, data)
					if not started and reason then client:Notify(reason) end
				end
				return
			end
			local view = currentOffers(client, target)

			return "HideoutUpgradeList", {hideout = view and view.hideout}
		end,
	})
	for _, id in ipairs({"GREETING", "BackTopic"}) do
		local root = dialogue.tree[id]
		if root and root.options then
			local present = false
			for _, option in ipairs(root.options) do
				if option == "HideoutUpgrades" then present = true break end
			end
			if not present then root.options[#root.options + 1] = "HideoutUpgrades" end
			root.options = ix.dialogue.OrderOptions(root.options, true)
		end
	end
end
