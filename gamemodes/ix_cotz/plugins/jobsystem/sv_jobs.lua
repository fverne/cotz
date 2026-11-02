local playerMeta = FindMetaTable("Player")

function playerMeta:ixJobRemove(npcidentifier)
	local character = self:GetCharacter()
	if not character then return end
	if character:GetData("lastTaskAbandon", 0) >= os.time() then
		self:Notify("You can't abandon another task so soon!")
		return
	end
	local jobs = character:GetJobs()
	local job = jobs[npcidentifier]
	if not job then return end
	local definition = ix.jobs.list[job.identifier]
	if definition and definition.OnTaskAbandon then definition.OnTaskAbandon(self) end
	ix.taskRewards.RemoveJobOffer(character, job)
	if job.fieldTask then ix.jobs.field.Cleanup(character, job) end
	jobs[npcidentifier] = nil
	character:SetJobs(jobs)
	local cooldown = ix.config.Get("taskAbandonCooldown", ix.jobs.settings.abandonCooldown)
	character:SetData("lastTaskAbandon", os.time() + cooldown)
	character:Save()
end

function playerMeta:ixJobEvaluate(trigger)
	local character = self:GetCharacter()
	if not character then return end
	local jobs = character:GetJobs()
	local changed = false
	for _, job in pairs(jobs) do
		if not job.fieldTask and not job.isCompleted
			and (job.listenTrigger == trigger or job.identifier == trigger) then
			job.progress = math.min((job.progress or 0) + 1, job.numberRec)
			job.isCompleted = job.progress >= job.numberRec
			changed = true
			if job.isCompleted then netstream.Start(self, "ix_COTZPlayPDASound", 2) end
		end
	end
	if changed then character:SetJobs(jobs) end
end

function playerMeta:ixJobComplete(npcidentifier)
	local character = self:GetCharacter()
	if not character then return false end
	local jobs = character:GetJobs()
	local job = jobs[npcidentifier]
	local definition = job and ix.jobs.list[job.identifier]
	if not definition then return end
	if not job or not job.isCompleted then return end
	if job.fieldTask and not ix.jobs.field.CanComplete(character, job) then return end
	local claimed = character:GetData("jobClaimsPaid", {})
	if claimed[npcidentifier] and claimed[npcidentifier] >= job.progressionClaim then return end
	claimed[npcidentifier] = job.progressionClaim
	if job.fieldTask then ix.jobs.field.Cleanup(character, job) end
	character:SetData("jobClaimsPaid", claimed)
	ix.jobs.RecordLeaderboardTask(character, definition)
	jobs[npcidentifier] = nil
	character:SetJobs(jobs)
	if ix.townNPCs and ix.townNPCs.installed then
		ix.townNPCs:JobCompleted(self, npcidentifier, job.identifier)
	end
	character:Save()
	if not definition.townProgression then
		ix.taskRewards.RecordCompletion(character, npcidentifier, job)
		ix.taskRewards.EarnOffer(character, job.rewardKey)
		self:addReputation(definition.repReward)
		ix.dialogue.notifyReputationReceive(self, definition.repReward)
		character:GiveMoney(job.moneyReward)
		local stats = table.Copy(character:GetData("leaderboardStats", {}))
		stats.taskEarnings = (stats.taskEarnings or 0) + job.moneyReward
		character:SetData("leaderboardStats", stats)
		ix.dialogue.notifyMoneyReceive(self, job.moneyReward)
	end
	hook.Run("ix_OnJobComplete", self, npcidentifier, job.identifier)
	local vendor = ix.progression.GetNPCFromName(npcidentifier)
	if not definition.townProgression and ix.vendorStock and ix.vendorStock.TaskRestock and IsValid(vendor) then
		ix.vendorStock.TaskRestock(character, vendor, job.identifier, job.progressionClaim)
	end
	if definition.OnTaskComplete then definition.OnTaskComplete(self) end
	netstream.Start(self, "ix_COTZPlayPDASound", 1)
	character:Save()
end

function playerMeta:ixJobAdd(identifier, npcidentifier, preview)
	local character = self:GetCharacter()
	if not character then return false end
	local jobs = character:GetJobs()
	local definition = ix.jobs.list[identifier]
	if jobs[npcidentifier] or not definition then return false end
	if ix.townNPCs and ix.townNPCs.installed
		and not ix.townNPCs:CanAcceptJob(character, npcidentifier, definition) then return false end
	if definition.CanAcceptTask and not definition.CanAcceptTask(self) then return false end
	local job = preview and table.Copy(preview) or {}
	job.identifier = identifier
	if not job.numberRec then
		local count = definition.numberRec
		job.numberRec = type(count) == "table" and math.random(count[1], count[2]) or count
	end
	job.listenTrigger = definition.listenTrigger or identifier
	job.progress = 0
	job.isCompleted = false
	if not ix.taskRewards.PrepareJob(character, npcidentifier, job) then return false end
	if definition.fieldType and not ix.jobs.field.Assign(character, npcidentifier, job) then
		self:Notify("No usable field task locations are available for this assignment.")
		return false
	end
	jobs[npcidentifier] = job
	character:SetJobs(jobs)
	ix.taskRewards.SelectOffer(character, npcidentifier, job.rewardKey, job.supplyChoice or 1)
	character:Save()
	if definition.OnTaskGet then definition.OnTaskGet(self) end
	netstream.Start(self, "ix_COTZPlayPDASound", 2)

	return true
end

-- Keep this callback in the original dispatcher stage for existing trigger consumers.
hook.Add("ix_JobTrigger", "JobProgress", function(client, trigger)
	if IsValid(client) and client:GetCharacter() then client:ixJobEvaluate(trigger) end
end)
