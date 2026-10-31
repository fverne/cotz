ix.dialogue = ix.dialogue or {}

local function allowAction(client, target)
	if not SERVER or not ix.townNPCs:CanInteract(client, target) then return false end
	local now = CurTime()
	if now < (client.cotzTownNextAction or 0) then return false end
	client.cotzTownNextAction = now + ix.townNPCs.settings.actionInterval

	return true
end

local function configureWork(dialogue, contact)
	dialogue.addTopic("AboutWorkTopic", {
		statement = contact.dialogue.workPrompt,
		response = contact.job.description,
		options = {"BackTopic"},
		IsDynamic = true,
		preCallback = function(self, client, target)
			if CLIENT then
				local job = client:GetCharacter():GetJobs()[target:GetDisplayName()]
				self.response = job and ix.jobs.getFormattedDesc(job) or contact.dialogue.work
			end
		end,
		GetDynamicOptions = function(_, client, target)
			local job = client:GetCharacter():GetJobs()[target:GetDisplayName()]
			if not job then return {} end
			local options = {}
			if job.isCompleted then
				options[1] = {statement = "Complete the assignment.", topicID = "TownJobAction",
					dyndata = {action = "complete", claim = job.progressionClaim}}
			elseif ix.jobs.isItemJob(job.identifier) then
				options[1] = {statement = "Hand over the requested items.", topicID = "TownJobAction",
					dyndata = {action = "deliver", claim = job.progressionClaim}}
			end

			return options
		end,
	})
	dialogue.addTopic("TownJobAction", {
		ResolveDynamicOption = function(_, client, target, data)
			if type(data) == "table" and allowAction(client, target) then
				local job = client:GetCharacter():GetJobs()[target:GetDisplayName()]
				if job and data.claim == job.progressionClaim then
					if data.action == "complete" then
						client:ixJobComplete(target:GetDisplayName())
					elseif data.action == "deliver" then
						ix.taskRewards.DeliverJobItem(client, target:GetDisplayName())
					end
				end
			end

			return "BackTopic"
		end,
	})
	if contact.job.kind ~= "arena" then
		dialogue.addTopic("GetTaskByDifficulty", {
			statement = contact.dialogue.offerPrompt,
			options = {"BackTopic"},
			ShouldAdd = function(_, client, target) return not client:ixHasJobFromNPC(target:GetDisplayName()) end,
		})

	end

end

local function configureProgression(dialogue, contact)
	dialogue.addTopic("TownProgression", {
		statement = contact.dialogue.progressionPrompt,
		response = contact.dialogue.progression,
		IsDynamic = true,
		options = {"BackTopic"},
		GetDynamicOptions = function(_, client, target)
			local options = {}
			for _, id in ipairs(ix.progression.GetActiveProgressions(client:GetCharacter(), target:GetDisplayName())) do
				options[#options + 1] = {statement = ix.progression.definitions[id].name,
					topicID = "TownProgression", dyndata = {identifier = id}}
			end

			return options
		end,
		ResolveDynamicOption = function(_, client, target, data)
			return "TownView", data
		end,
	})
	dialogue.addTopic("TownView", {
		options = {"TownProgression", "BackTopic"},
		IsDynamic = true,
		IsDynamicFollowup = true,
		DynamicPreCallback = function(self, client, target, data)
			if not CLIENT or type(data) ~= "table" then return end
			local definition = ix.progression.definitions[data.identifier]
			if not definition or definition.keyNpc ~= target:GetDisplayName() then return end
			self.current = data.identifier
			self.response = ix.progression.DescribeTask(definition, definition.keyNpc,
				ix.progression.GetLine(client:GetCharacter(), data.identifier), client:GetCharacter())
		end,
		GetDynamicOptions = function(self, client, target)
			local id = self.current
			local definition = ix.progression.definitions[id]
			if not definition or definition.keyNpc ~= target:GetDisplayName() then return {} end
			local options = ix.progression.GetDeliveryOptions(client:GetCharacter(), id)
			for _, option in ipairs(options) do option.topicID = "TownHandIn" end
			if definition.townCommission and ix.progression.IsActive(client:GetCharacter(), id)
				and not client:ixHasJobFromNPC(target:GetDisplayName()) then
				options[#options + 1] = {statement = "Accept this field commission.", topicID = "TownCommission",
					dyndata = {identifier = id}}
			end

			return options
		end,
	})
	dialogue.addTopic("TownHandIn", {
		options = {"TownProgression", "BackTopic"},
		IsDynamicFollowup = true,
		DynamicPreCallback = ix.dialogue.ProgressionTurnIn,
		ResolveDynamicOption = function(_, client, target, data) return "TownHandIn", data end,
	})
	dialogue.addTopic("TownCommission", {
		ResolveDynamicOption = function(_, client, target, data)
			if type(data) == "table" and allowAction(client, target) then
				local definition = ix.progression.definitions[data.identifier]
				if definition and definition.keyNpc == target:GetDisplayName() and definition.townCommission
					and definition.progMap == game.GetMap()
					and ix.progression.IsActive(client:GetCharacter(), data.identifier) then
					local job = ix.jobs.list[definition.townCommission]
					if ix.jobs.field.IsAvailable(job) then
						if not client:ixJobAdd(definition.townCommission, target:GetDisplayName()) then
							client:Notify("Finish or abandon your current assignment with this contact first.")
						end
					else
						client:Notify("No configured field sites are available for that region yet.")
					end
				end
			end

			return "BackTopic"
		end,
	})

end

function ix.dialogue.ConfigureTownContact(dialogue, contact)
	assert(dialogue.townContact == contact.id, "Town conversation is bound to the wrong contact")
	local greeting = dialogue.tree.GREETING
	local originalResponse = greeting.response
	local finalID = ix.townNPCs:StepID(contact.id, contact.progression[#contact.progression].id)
	greeting.preCallback = function(self, client, target)
		self.response = originalResponse
		if SERVER then target:SetNetVar("possibleJobs", contact.categories) end
		if CLIENT and contact.dialogue.completedGreeting
			and ix.progression.IsCompleted(client:GetCharacter(), finalID) then
			self.response = contact.dialogue.completedGreeting
		end
	end
	configureWork(dialogue, contact)
	configureProgression(dialogue, contact)
	ix.dialogue.ConfigureTaskRewards(dialogue)
end
