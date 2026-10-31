ix.jobs = ix.jobs or {}
ix.jobs.list = ix.jobs.list or {}

ix.jobs.jobsbycategory = ix.jobs.jobsbycategory or {}

--[[
  JOB STRUCT should contain

  name -- Name of the job - string
  icon -- icon to display - Material
  desc -- Description of the job, can contain format characters - string
  tier -- Tier of the job, based on reputation tiers - number
  listenTrigger -- Name of the trigger to listen for - string
  numberRec -- Required number of times the trigger needs to be heard. If table a random number is selected. - number/table
  reward -- Supply budget; half carries into cash. Supplies use contact profiles and tier instead.
  repReward -- How much rep to give a player from quest completion - number/table

  EXAMPLE

  local tempJob = {}

  tempJob.name = "Kill %d mutants."
  tempJob.desc = "Kill %d %s."
  tempJob.tier = 1
  tempJob.listenTrigger = "mutantKilled"
  tempJob.numberRec = {5,10}
  tempJob.reward = {{"makarov", {["durability"] = 15}},{"9x19"}}
  tempJob.repReward = 200

  ix.jobs.register(tempJob)

  ACTIVE JOB STRUCT should contain
  
  identifier
  listenTrigger
  numberRec
  progress
  isCompleted
  
--]]

function ix.jobs.isStructValid(jobstruct)
  if (!jobstruct.name or type(jobstruct.name) != "string") then return false end
  -- if (!jobstruct.listenTrigger or type(jobstruct.listenTrigger) != "string") then return false end -- not needed for item jobs
  if !jobstruct.numberRec then return false end
  if !jobstruct.icon then jobstruct.icon = Material("path/to/defaulticon.png") end

  return true
end

function ix.jobs.getFormattedName(activejob)
  return string.format(ix.jobs.list[activejob.identifier].name,activejob.numberRec)
end

function ix.jobs.getFormattedDesc(activejob)
	local text = string.format(ix.jobs.list[activejob.identifier].desc, activejob.numberRec)
	if activejob.rewardChoices then
		local selected = activejob.rewardChoices[activejob.supplyChoice or 0]
		local supplies = selected and selected.label or ix.taskRewards.Summary({choices = activejob.rewardChoices})
		text = text .. "\n\nReward: " .. supplies
			.. "\n\nPayment: " .. activejob.moneyReward .. " rubles."
		if ix.jobs.list[activejob.identifier].requiredItem then
			text = text .. " Better-quality hand-ins can increase this payment."
		end
	end

	return text
end

function ix.jobs.getFormattedNameInactive(identifier)
  local n = 0
  if istable(ix.jobs.list[identifier].numberRec) then
    n = ix.jobs.list[identifier].numberRec[1]
  else
    n = ix.jobs.list[identifier].numberRec
  end
  return string.format(ix.jobs.list[identifier].name,n)
end

function ix.jobs.getFormattedDescInactive(identifier)
  local n = 0
  if istable(ix.jobs.list[identifier].numberRec) then
    n = ix.jobs.list[identifier].numberRec[1]
  else
    n = ix.jobs.list[identifier].numberRec
  end
  return string.format(ix.jobs.list[identifier].desc,n)
end

function ix.jobs.isItemJob(jobname)
  if ix.jobs.list[jobname].requiredItem then
    return ix.jobs.list[jobname].requiredItem
  else
    return false
  end
end

function ix.jobs.getJobFromTier(tier)
  local v, k = table.Random(ix.jobs.list)
  local n = 0

  while (v.tier != tier or n == 20) do
    v, k = table.Random(ix.jobs.list)
    n = n+1
  end

  return k
end

function ix.jobs.getJobFromCategory(categories)
	if not istable(categories) then categories = {categories} end
	local pools = {}
	for _, category in ipairs(categories) do
		local available = {}
		for _, id in ipairs(ix.jobs.jobsbycategory[category] or {}) do
			local definition = ix.jobs.list[id]
			if definition and (not definition.fieldType or ix.jobs.field.IsAvailable(definition)) then
				available[#available + 1] = id
			end
		end
		if #available > 0 then pools[#pools + 1] = available end
	end
	if #pools == 0 then return end
	local pool = pools[math.random(#pools)]

	return pool[math.random(#pool)]
end

local playerMeta = FindMetaTable("Player")
function playerMeta:ixHasJobFromNPC(npcidentifier)
  local curJobs = self:GetCharacter():GetJobs()

  if curJobs[npcidentifier] then
    return true
  else 
    return false
  end
end

hook.Add("ix_JobTrigger", "JobProgress", function(client, triggerstring)
  client:ixJobEvaluate(triggerstring)
end)

if SERVER then
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
		if definition.OnTaskAbandon then definition.OnTaskAbandon(self) end
		ix.taskRewards.RemoveJobOffer(character, job)
		if job.fieldTask then ix.jobs.field.Cleanup(character, job) end
		jobs[npcidentifier] = nil
		character:SetJobs(jobs)
		character:SetData("lastTaskAbandon", os.time() + ix.config.Get("taskAbandonCooldown", 3600))
		character:Save()
	end

  function playerMeta:ixJobEvaluate(trigger)
    --print("Evaluating quest with ID: "..trigger)

    --Check if player has quest
    local curJobs = self:GetCharacter():GetJobs()
    for k,v in pairs(curJobs) do
      if not v.fieldTask and (v.listenTrigger == trigger or v.identifier == trigger) then

        --Progress quest for player OR mark as completed
        local curProgress = curJobs[k].progress
        local curMax = curJobs[k].numberRec

        if (curProgress < curMax and !curJobs[k].isCompleted) then
          curJobs[k].progress = curJobs[k].progress + 1
          if curProgress+1 == curMax then
            curJobs[k].isCompleted = true
            netstream.Start(self, "ix_COTZPlayPDASound", 2)
          end
        elseif (curProgress == curMax) then
          curJobs[k].isCompleted = true
        end
      end
    end

    self:GetCharacter():SetJobs(curJobs)
  end

	function playerMeta:ixJobComplete(npcidentifier)
		local character = self:GetCharacter()
		local jobs = character:GetJobs()
		local job = jobs[npcidentifier]
		if not job or not job.isCompleted then return end
		if job.fieldTask and not ix.jobs.field.CanComplete(character, job) then return end
		local claimed = character:GetData("jobClaimsPaid", {})
		if claimed[npcidentifier] and claimed[npcidentifier] >= job.progressionClaim then return end
		claimed[npcidentifier] = job.progressionClaim
		if job.fieldTask then ix.jobs.field.Cleanup(character, job) end
		character:SetData("jobClaimsPaid", claimed)
		jobs[npcidentifier] = nil
		character:SetJobs(jobs)
		if ix.townNPCs and ix.townNPCs.installed then
			ix.townNPCs:JobCompleted(self, npcidentifier, job.identifier)
		end
		character:Save()
		local definition = ix.jobs.list[job.identifier]
		if not definition.townProgression then
			ix.taskRewards.RecordCompletion(character, npcidentifier, job)
			ix.taskRewards.EarnOffer(character, job.rewardKey)
			self:addReputation(definition.repReward)
			ix.dialogue.notifyReputationReceive(self, definition.repReward)
			character:GiveMoney(job.moneyReward)
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
end
