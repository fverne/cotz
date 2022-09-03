ix.dialogue = ix.dialogue or {}
ix.dialogue.list = ix.dialogue.list or {}

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
					options = data.options or {},
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
	topic.options = options or {}

	dialogue.tree[topicID] = topic
end

function ix.dialogue.getTopic(id, topicID)
	local dialogue = ix.dialogue.list[id]
	if not dialogue then return end

	return dialogue.tree[topicID]
end

hook.Add("DoPluginIncludes", "ixDialogueLib", function(path)
	ix.dialogue.LoadFromDir(path.."/dialogue")
end)

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
