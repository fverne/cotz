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
		ShouldAdd = function(_, client, target)
			return client:ixHasJobFromNPC(target:GetDisplayName())
		end,
		response = contact.job.description,
		options = {"BackTopic"},
		IsDynamic = true,
		preCallback = function(self, client, target)
			if CLIENT then
				local job = client:GetCharacter():GetJobs()[target:GetDisplayName()]
				self.response = job and ix.jobs.GetDialogueDescription(job, contact.name) or contact.dialogue.work
			end
		end,
		GetDynamicOptions = function(_, client, target)
			local job = client:GetCharacter():GetJobs()[target:GetDisplayName()]
			if not job then return {} end
			local options = {}
			if job.isCompleted then
				options[1] = {statement = "Complete the assignment.", topicID = "TownJobAction",
					dyndata = {action = "complete", claim = job.progressionClaim}}
			elseif ix.jobs.regional.FindHandIn(client:GetCharacter(), job)
				and not ix.jobs.list[job.identifier].alternateDelivery then
				options[1] = {statement = "Hand over the requested items.", topicID = "TownJobAction",
					dyndata = {action = "deliver", claim = job.progressionClaim}}
			end
			if job.photoKind then
				options[#options + 1] = {statement = "Collect or restore the loan camera.", topicID = "TownJobAction",
					dyndata = {action = "camera", claim = job.progressionClaim}}
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
					elseif data.action == "camera" and job.photoKind then
						ix.jobs.regional.ReconcileCamera(client)
					end
				end
			end

			return "BackTopic"
		end,
	})
	if contact.job.kind ~= "arena" and contact.job.kind ~= "none" then
		dialogue.addTopic("GetTaskByDifficulty", {
			statement = contact.dialogue.offerPrompt,
			response = contact.dialogue.work,
			options = {"BackTopic"},
			ShouldAdd = function(_, client, target) return not client:ixHasJobFromNPC(target:GetDisplayName()) end,
		})
	else
		for _, id in ipairs({"GREETING", "BackTopic"}) do
			local root = dialogue.tree[id]
			for index = #(root and root.options or {}), 1, -1 do
				if root.options[index] == "GetTaskByDifficulty" then table.remove(root.options, index) end
			end
		end
		if dialogue.tree.GetTaskByDifficulty then
			dialogue.tree.GetTaskByDifficulty.ShouldAdd = function() return false end
		end
	end

end

local function configureProgression(dialogue, contact)
	dialogue.addTopic("TownProgression", {
		statement = contact.dialogue.progressionPrompt,
		response = contact.dialogue.progression,
		preCallback = function(_, client, target)
			if not SERVER or not ix.townNPCs:CanInteract(client, target)
				or target:GetDisplayName() ~= contact.name then return end
			if CurTime() < (client.cotzTownDiscoveryNext or 0) then return end
			client.cotzTownDiscoveryNext = CurTime() + ix.townNPCs.settings.actionInterval
			ix.progression.DiscoverTopics(client:GetCharacter(), contact.name)
		end,
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
			self.response = definition.briefing
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
						client:Notify("There is nowhere suitable for that work in the region just now.")
					end
				end
			end

			return "BackTopic"
		end,
	})

end

local function configureDeliveries(dialogue, contact)
	for _, id in ipairs({"GREETING", "BackTopic"}) do
		local options = dialogue.tree[id].options
		options[#options + 1] = "TownDeliveries"
	end
	dialogue.addTopic("TownDeliveries", {
		statement = "I have a delivery for you.",
		response = contact.dialogue.delivery or "Let me see what you've brought.",
		options = {"BackTopic"},
		IsDynamic = true,
		ShouldAdd = function(_, client)
			for _, job in pairs(client:GetCharacter():GetJobs()) do
				if ix.jobs.regional and ix.jobs.regional.CanDeliver(client:GetCharacter(), contact, job) then
					return true
				end
			end

			return false
		end,
		GetDynamicOptions = function(_, client)
			local options = {}
			for npc, job in SortedPairs(client:GetCharacter():GetJobs()) do
				if ix.jobs.regional and ix.jobs.regional.ReceiverMatches(client:GetCharacter(), contact, job)
					and ix.jobs.regional.FindHandIn(client:GetCharacter(), job) then
					options[#options + 1] = {statement = "Hand over items on behalf of " .. npc .. ".",
						topicID = "TownDeliveries", dyndata = {npc = npc, claim = job.rewardKey, valuable = true}}
				end
				local state = job.fieldTask
				if state and state.recipient == contact.name and state.stage == "carrying"
					and ix.jobs.field.FindCargo(client:GetCharacter(), job) then
					options[#options + 1] = {statement = "Hand over " .. (state.cargoName or "the cargo") .. ".",
						topicID = "TownDeliveries", dyndata = {npc = npc, claim = job.rewardKey}}
				end
			end

			return options
		end,
		ResolveDynamicOption = function(_, client, target, data)
			if type(data) == "table" and type(data.npc) == "string" and type(data.claim) == "string"
				and allowAction(client, target) then
				local job = client:GetCharacter():GetJobs()[data.npc]
				if data.valuable and job and job.rewardKey == data.claim then
					ix.taskRewards.DeliverJobItem(client, data.npc, target)
				else
					ix.jobs.field.DeliverToContact(client, target, data.npc, data.claim)
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
	local finalStep = contact.progression[#contact.progression]
	local finalID = finalStep and ix.townNPCs:StepID(contact.id, finalStep.id)
	greeting.preCallback = function(self, client, target)
		self.response = originalResponse
		if SERVER then target:SetNetVar("possibleJobs", contact.categories) end
		if CLIENT and finalID and contact.dialogue.completedGreeting
			and ix.townNPCs:IsContactCompleted(client:GetCharacter(), contact) then
			self.response = contact.dialogue.completedGreeting
		end
	end
	configureWork(dialogue, contact)
	if finalID then configureProgression(dialogue, contact) end
	configureDeliveries(dialogue, contact)
	ix.dialogue.ConfigureTownServices(dialogue, contact)
	ix.dialogue.ConfigureTaskRewards(dialogue)
	ix.dialogue.ConfigureCustomization(dialogue)
end
