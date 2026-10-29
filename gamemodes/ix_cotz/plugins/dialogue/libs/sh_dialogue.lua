ix.dialogue = ix.dialogue or {}
ix.dialogue.list = ix.dialogue.list or {}

local MENU_ORDER = {
	TradeTopic = 10,
	StartBarter = 20,
	HealTopic = 30,
	RepairItems = 35,
	StorageTopic = 40,
	PaintSuit = 45,
	ChangeSuitVariant = 46,
	PDAAvatarTopic = 47,
	NicknameTopic = 48,
	WishTopic = 49,
	JoinArena = 50,
	AboutWorkTopic = 60,
	GetTask = 65,
	GetTaskByDifficulty = 65,
	AboutProgression = 70,
	TaskRewardChoices = 75,
	TutorialTopic = 80,
	Introduction = 90,
	BackgroundTopic = 90,
	InterestTopic = 95,
	BackTopic = 900,
	GOODBYE = 1000,
}

function ix.dialogue.OrderOptions(options, mainMenu)
	local indexed = {}
	for index, option in ipairs(options or {}) do
		local id = type(option) == "table" and option.topicID or option
		local rank = 0
		if mainMenu then
			rank = MENU_ORDER[id] or 200
		elseif id == "GOODBYE" or id == "BackTopic" then
			rank = MENU_ORDER[id]
		end
		indexed[#indexed + 1] = {option = option, rank = rank, index = index}
	end
	table.sort(indexed, function(first, second)
		if first.rank == second.rank then
			return first.index < second.index
		end

		return first.rank < second.rank
	end)
	local result = {}
	for _, entry in ipairs(indexed) do
		result[#result + 1] = entry.option
	end

	return result
end

function ix.dialogue.LoadFromDir(directory)
	for k, v in ipairs(file.Find(directory.."/*.lua", "LUA")) do
		local niceName = v:sub(4, -5)

		DIALOGUE = ix.dialogue.list[niceName] or {}
			if (PLUGIN) then
				DIALOGUE.plugin = PLUGIN.uniqueID
			end

			DIALOGUE.tree = {}
			DIALOGUE.addTopic = function(topicID, data)
				local topicData = {
					statement = data.statement or "",
					response = data.response or "",
					preCallback = data.preCallback,
					postCallback = data.postCallback,
					options = ix.dialogue.OrderOptions(data.options, topicID == "GREETING" or topicID == "BackTopic"),
					IsDynamic = data.IsDynamic or false,
					GetDynamicOptions = data.GetDynamicOptions,
					ResolveDynamicOption = data.ResolveDynamicOption,
					IsDynamicFollowup = data.IsDynamicFollowup or false,
					DynamicPreCallback = data.DynamicPreCallback,
					ShouldAdd = data.ShouldAdd or function() return true end
				}

				DIALOGUE.tree[topicID] = topicData
			end

			ix.util.Include(directory.."/"..v)

			if ix.dialogue.ConfigureTaskRewards then ix.dialogue.ConfigureTaskRewards(DIALOGUE) end

			DIALOGUE.name = DIALOGUE.name or "Unknown"


			ix.dialogue.list[niceName] = DIALOGUE
		DIALOGUE = nil
	end
end

function ix.dialogue.addTopic(id, topicID, statement, response, preCallback, postCallback, options)
	local dialogue = ix.dialogue.list[id]
	if not dialogue then return end

	local topic = {}
	topic.statement = statement or ""
	topic.response = response or ""
	topic.preCallback = preCallback
	topic.postCallback = postCallback
	topic.options = ix.dialogue.OrderOptions(options, topicID == "GREETING" or topicID == "BackTopic")

	dialogue.tree[topicID] = topic
end

function ix.dialogue.getTopic(id, topicID)
	local dialogue = ix.dialogue.list[id]
	if not dialogue then return end

	return dialogue.tree[topicID]
end

-- Reward topics must be available before DoPluginIncludes registers NPC conversations.
ix.util.Include("ix_cotz/plugins/jobsystem/integrations/sh_dialogue.lua")

hook.Add("DoPluginIncludes", "ixDialogueLib", function(path)
	ix.dialogue.LoadFromDir(path.."/dialogue")
end)

function ix.dialogue.ProgressionTurnIn(topic, client, target, data)
	if CLIENT then
		topic.waitForProgressionResponse = true

		return
	end
	if not istable(data) then
		return
	end
	local accepted, response = ix.progression.TurnIn(client, target, data.progid, data.itemid)
	if not accepted then
		response = "I couldn't accept that delivery. Check what this task still needs and what you're carrying."
	end
	net.Start("cotz/dialogue/progression-response")
	net.WriteEntity(target)
	net.WriteString(response)
	net.Send(client)
end

if SERVER then

function ix.dialogue.notify(client, type, text)
	net.Start("ixDialogueNotify")
	net.WriteUInt(type, 4)
	net.WriteString(text)
	net.Send(client)
end

function ix.dialogue.notifyItemGet(client, text)
	ix.dialogue.notify(client, 0, text)
end
function ix.dialogue.notifyItemLost(client, text)
	ix.dialogue.notify(client, 1, text)
end
function ix.dialogue.notifyTaskGet(client, text)
	ix.dialogue.notify(client, 2, text)
end
function ix.dialogue.notifyTaskComplete(client, text)
	ix.dialogue.notify(client, 3, text)
end
function ix.dialogue.notifyMoneyReceive(client, text)
	ix.dialogue.notify(client, 4, text)
end
function ix.dialogue.notifyMoneyLost(client, text)
	ix.dialogue.notify(client, 5, text)
end
function ix.dialogue.notifyReputationReceive(client, text)
	ix.dialogue.notify(client, 6, text)
end
function ix.dialogue.notifyReputationLost(client, text)
	ix.dialogue.notify(client, 7, text)
end

end
