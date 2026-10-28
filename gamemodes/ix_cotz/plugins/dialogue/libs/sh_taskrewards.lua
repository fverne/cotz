ix.dialogue = ix.dialogue or {}

local REWARD_DATA_KEY = "taskRewardOffers"
local CLAIM_LINE = "taskRewardClaims"
local INTERACTION_DISTANCE = 192
local ACTION_INTERVAL = 0.15
local SHOW_TASK_SUPPLIES = false

if SERVER then
	util.AddNetworkString("cotz/dialogue/task-offer")
	util.AddNetworkString("cotz/dialogue/task-list")
	util.AddNetworkString("cotz/dialogue/task-rewards-refresh")
else
	net.Receive("cotz/dialogue/task-list", function()
		local target = net.ReadEntity()
		local options = {}
		for index = 1, net.ReadUInt(2) do
			local difficulty, label = net.ReadString(), net.ReadString()
			options[index] = {statement = label, topicID = "GetTaskByDifficulty",
				dyndata = {difficulty = difficulty}}
		end
		LocalPlayer().cotzTaskList = {target = target, options = options}
		local panel = ix.gui.dialogue
		if IsValid(panel) and panel.target == target and panel.currentTopicID == "GetTaskByDifficulty" then
			panel.options:Clear()
			local topic = panel.tree.GetTaskByDifficulty
			panel:prepareDynamicOptions(topic.GetDynamicOptions(topic, LocalPlayer(), target), topic.options)
		end
	end)

	net.Receive("cotz/dialogue/task-offer", function()
		local target = net.ReadEntity()
		local data = {difficulty = net.ReadString(), description = net.ReadString(), choices = {}}
		for index = 1, net.ReadUInt(2) do data.choices[index] = {label = net.ReadString()} end
		local panel = ix.gui.dialogue
		if IsValid(panel) and panel.target == target and panel.tree.ConfirmSupplyTask then
			panel:startTopic("ConfirmSupplyTask", data)
		end
	end)
	net.Receive("cotz/dialogue/task-rewards-refresh", function()
		local target = net.ReadEntity()
		local panel = ix.gui.dialogue
		if IsValid(panel) and panel.target == target and panel.tree.TaskRewardChoices then
			panel:startTopic("TaskRewardChoices")
		end
	end)
end

local function canChoose(client, target)
	local character = client:GetCharacter()

	local allowed = character and IsValid(target) and target:GetClass() == "ix_vendor_adv"
		and target:CanAccess(client)
		and client:GetPos():DistToSqr(target:GetPos()) <= INTERACTION_DISTANCE * INTERACTION_DISTANCE
		and ix.progression.CanUseNPC(character, target:GetDisplayName())
	if not allowed then return false end
	local now = CurTime()
	if now < (client.cotzTaskRewardNext or 0) then return false end
	client.cotzTaskRewardNext = now + ACTION_INTERVAL

	return true
end

local function offerOptions(character, npc)
	local options = {}
	for key, offer in pairs(character:GetData(REWARD_DATA_KEY, {})) do
		if key:match("^job:") and ix.taskRewards.CanSelectOffer(character, npc, key, offer) then
			for index, choice in ipairs(offer.choices) do
				options[#options + 1] = {
					statement = offer.label .. (offer.earned and " — claim: " or " — reserve: ")
						.. (offer.selected == index and "[Selected] " or "") .. choice.label,
					topicID = "TaskRewardChoices",
					dyndata = {kind = "offer", key = key, choice = index},
				}
			end
		end
	end

	return options
end

local function kitOptions(character, npc, options)
	for id, item in pairs(character:GetInventory():GetItems()) do
		if ix.taskRewards.IsTaskKit(item.uniqueID) and not item:GetData("taskRewardRedeemed", false) then
			local choices = ix.taskRewards.BuildChoices(character, npc,
				ix.taskRewards.ExpectedValue(item.uniqueID), "kit:" .. id)
			for index, choice in ipairs(choices) do
				options[#options + 1] = {
					statement = "Redeem " .. item:GetName() .. ": " .. choice.label,
					topicID = "TaskRewardChoices",
					dyndata = {kind = "kit", item = id, choice = index, label = choice.label},
				}
			end
		end
	end
end

local function barterOptions(character, npc, options)
	for id, barter in pairs(ix.npcbarter and ix.npcbarter.barterdict[npc] or {}) do
		local reward = barter.barterItem
		if ix.npcbarter.activebarters[id] and ix.taskRewards.IsTaskKit(reward[1]) then
			local choices = ix.taskRewards.BarterChoices(character, npc, id, barter)
			for index, choice in ipairs(choices) do
				options[#options + 1] = {
					statement = "Barter " .. (barter.reqItem[2] or 1) .. "x "
						.. ix.item.list[barter.reqItem[1]].name .. " for " .. choice.label,
					topicID = "TaskRewardChoices",
					dyndata = {kind = "barter", key = id, choice = index, label = choice.label},
				}
			end
		end
	end
end

local function configureJobPreview(dialogue)
	local topic = dialogue.tree.GetTaskByDifficulty
	if not topic then return end
	topic.IsDynamic = true
	topic.response = "Here is the work I have available, with the payment and supplies for each task."
	topic.options = {"BackTopic"}
	topic.preCallback = function(self, client, target)
		if CLIENT then
			client.cotzTaskList = nil

			return
		end
		if not canChoose(client, target) then return end
		local character = client:GetCharacter()
		local categories = target:GetNetVar("possibleJobs", {})
		local rows = {}
		for _, difficulty in ipairs({"easy", "medium", "hard"}) do
			local pool = categories[difficulty]
			if type(pool) == "table" and #pool > 0 then
				local preview = ix.taskRewards.PreviewJob(character, target:GetDisplayName(), difficulty, pool)
				if preview then
					local definition = ix.jobs.list[preview.identifier]
					local offer = character:GetData(REWARD_DATA_KEY, {})[preview.rewardKey]
					local supply = offer and offer.choices[preview.supplyChoice]
					local label = string.format(definition.name, preview.numberRec)
						.. " — " .. preview.moneyReward .. " rubles"
					if supply then label = label .. "; supplies: " .. supply.label end
					rows[#rows + 1] = {difficulty = difficulty, label = label}
				end
			end
		end
		net.Start("cotz/dialogue/task-list")
		net.WriteEntity(target)
		net.WriteUInt(#rows, 2)
		for _, row in ipairs(rows) do
			net.WriteString(row.difficulty)
			net.WriteString(row.label)
		end
		net.Send(client)
	end
	topic.GetDynamicOptions = function(_, client, target)
		local list = client.cotzTaskList
		if client:GetCharacter():GetJobs()[target:GetDisplayName()] or not list or list.target ~= target then
			return {}
		end

		local options = {}
		for _, option in ipairs(list.options) do
			if ix.taskRewards.CanTakeDifficulty(client:GetCharacter(), option.dyndata.difficulty) then
				options[#options + 1] = option
			end
		end

		return options
	end
	topic.ResolveDynamicOption = function(_, client, target, data)
		if SERVER and canChoose(client, target) and type(data) == "table" then
			local difficulty = data.difficulty
			local categories = target:GetNetVar("possibleJobs", {})[difficulty]
			if type(difficulty) ~= "string" or type(categories) ~= "table" then return "BackTopic" end
			local preview = ix.taskRewards.PreviewJob(client:GetCharacter(), target:GetDisplayName(),
				difficulty, categories)
			if preview then
				local definition = ix.jobs.list[preview.identifier]

				local description = string.format(definition.desc, preview.numberRec) .. "\nPayment: " .. preview.moneyReward
					.. " rubles."
				if definition.requiredItem then
					description = description .. " Better-quality hand-ins can increase this payment."
				end
				local offer = client:GetCharacter():GetData(REWARD_DATA_KEY, {})[preview.rewardKey]
				local supply = offer and offer.choices[preview.supplyChoice]
				if supply then description = description .. "\nSupplies: " .. supply.label end
				local choices = supply and {supply} or {}
				net.Start("cotz/dialogue/task-offer")
				net.WriteEntity(target)
				net.WriteString(difficulty)
				net.WriteString(description)
				net.WriteUInt(#choices, 2)
				for _, choice in ipairs(choices) do net.WriteString(choice.label) end
				net.Send(client)
			end
		end

		return "BackTopic"
	end
	dialogue.addTopic("ConfirmSupplyTask", {
		statement = "", response = "", IsDynamic = true, IsDynamicFollowup = true,
		DynamicPreCallback = function(self, client, _, data)
			if CLIENT and type(data) == "table" then
				client.cotzTaskPreview = data
				self.response = data.description
			end
		end,
		GetDynamicOptions = function(_, client)
			local preview = client.cotzTaskPreview or {}
			local options = {}
			for _, choice in ipairs(preview.choices or {}) do
				options[#options + 1] = {statement = "Accept — " .. choice.label,
					topicID = "ConfirmSupplyTask", dyndata = {difficulty = preview.difficulty}}
			end
			if #options == 0 then
				options[1] = {statement = "Accept task", topicID = "ConfirmSupplyTask",
					dyndata = {difficulty = preview.difficulty}}
			end
			options[#options + 1] = {statement = "I'll pass.", topicID = "BackTopic"}

			return options
		end,
		ResolveDynamicOption = function(_, client, target, data)
			if SERVER and canChoose(client, target) and type(data) == "table" then
				ix.taskRewards.AcceptJob(client, target:GetDisplayName(), data.difficulty, data.choice)
			end

			return "BackTopic"
		end,
	})
end

function ix.dialogue.ConfigureTaskRewards(dialogue)
	if not dialogue.tree.GREETING then return end
	configureJobPreview(dialogue)
	local workTopic = dialogue.tree.AboutWorkTopic
	dialogue.addTopic("TaskRewardChoices", {
		statement = "Choose or claim task supplies.",
		ShouldAdd = function() return SHOW_TASK_SUPPLIES end,
		response = "Reserve your repeatable task reward before finishing, or claim earned job supplies here. "
			.. "Existing task kits can be exchanged without an upgrade fee. "
			.. "Make space in your inventory, then claim any remaining supplies.",
		IsDynamic = true,
		options = {"BackTopic"},
		GetDynamicOptions = function(_, client, target)
			if not ix.taskRewards then return {} end
			local character = client:GetCharacter()
			local options = offerOptions(character, target:GetDisplayName())
			kitOptions(character, target:GetDisplayName(), options)
			barterOptions(character, target:GetDisplayName(), options)
			local line = ix.progression.GetLine(character, CLAIM_LINE)
			if line.pendingRewards and #line.pendingRewards > 0 then
				options[#options + 1] = {
					statement = "Claim next supply (" .. #line.pendingRewards .. " remaining)",
					topicID = "TaskRewardChoices", dyndata = {kind = "claim"},
				}
			end
			table.sort(options, function(first, second) return first.statement < second.statement end)

			return options
		end,
		ResolveDynamicOption = function(_, client, target, data)
			if SERVER and type(data) == "table" and canChoose(client, target) then
				local character = client:GetCharacter()
				if data.kind == "offer" and type(data.key) == "string" and data.key:match("^job:") then
					ix.taskRewards.SelectOffer(character, target:GetDisplayName(), data.key, data.choice)
				elseif data.kind == "kit" then
					ix.taskRewards.RedeemKit(character, target:GetDisplayName(), data.item, data.choice, data.label)
				elseif data.kind == "barter" then
					ix.taskRewards.ExecuteBarter(character, target:GetDisplayName(), data.key, data.choice, data.label)
				elseif data.kind == "claim" then
					ix.taskRewards.ClaimNext(character)
				end
				net.Start("cotz/dialogue/task-rewards-refresh")
				net.WriteEntity(target)
				net.Send(client)
			end

			return "TaskRewardChoices"
		end,
	})
	for _, id in ipairs({"GREETING", "BackTopic", "AboutWorkTopic"}) do
		local topic = dialogue.tree[id]
		if topic then
			local options = {}
			for _, option in ipairs(topic.options or {}) do
				if option ~= "TaskRewardChoices" then options[#options + 1] = option end
			end
			if (workTopic and id == "AboutWorkTopic") or (not workTopic and id ~= "AboutWorkTopic") then
				options[#options + 1] = "TaskRewardChoices"
			end
			topic.options = ix.dialogue.OrderOptions(options, id == "GREETING" or id == "BackTopic")
		end
	end
	if workTopic and SHOW_TASK_SUPPLIES then
		local previousShouldAdd = workTopic.ShouldAdd
		workTopic.ShouldAdd = function(self, client, target)
			if not previousShouldAdd or previousShouldAdd(self, client, target) then return true end
			local character = client:GetCharacter()
			local npc = target:GetDisplayName()
			local options = offerOptions(character, npc)
			kitOptions(character, npc, options)
			barterOptions(character, npc, options)
			local pending = ix.progression.GetLine(character, CLAIM_LINE).pendingRewards

			return #options > 0 or (pending and #pending > 0) or false
		end
	end
end
