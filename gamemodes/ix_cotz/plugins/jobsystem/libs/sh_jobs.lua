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
  reward -- Legacy output value; half carries into cash. Supplies use contact profiles and tier instead.
  rewardCount -- Legacy metadata; each selected job supply is one inventory item.
  repReward -- How much rep to give a player from quest completion - number/table

  EXAMPLE

  local tempJob = {}

  tempJob.name = "Kill %d mutants."
  tempJob.desc = "Kill %d %s."
  tempJob.tier = 1
  tempJob.listenTrigger = "mutantKilled"
  tempJob.numberRec = {5,10}
  tempJob.reward = {{"makarov", {["durability"] = 15}},{"9x19"}}
  tempJob.rewardCount = {1,3}
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
		text = text .. "\nSupplies: " .. ix.taskRewards.Summary({choices = activejob.rewardChoices})
			.. "\nPayment: " .. activejob.moneyReward .. " rubles."
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
  if (!istable(categories)) then categories = {categories} end

  local randomcat = categories[ math.random( #categories ) ]

  return ix.jobs.jobsbycategory[randomcat][ math.random( #ix.jobs.jobsbycategory[randomcat] ) ]
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

  -- Remove job with no reward given
  function playerMeta:ixJobRemove(npcidentifier)
    if self:GetCharacter():GetData("lastTaskAbandon", 0) < os.time() then
      curJobs = self:GetCharacter():GetJobs()

      local identifier = curJobs[npcidentifier].identifier
      if(ix.jobs.list[identifier].OnTaskAbandon)then
        ix.jobs.list[identifier].OnTaskAbandon(self)
      end

      ix.taskRewards.RemoveJobOffer(self:GetCharacter(), curJobs[npcidentifier])
      curJobs[npcidentifier] = nil
  
      self:GetCharacter():SetJobs(curJobs)

      self:GetCharacter():SetData("lastTaskAbandon", os.time() + ix.config.Get("taskAbandonCooldown", 3600))
    else
      self:Notify("You can't abandon another task so soon!")
    end
  end

  function playerMeta:ixJobEvaluate(trigger)
    --print("Evaluating quest with ID: "..trigger)

    --Check if player has quest
    local curJobs = self:GetCharacter():GetJobs()
    for k,v in pairs(curJobs) do
      if v.listenTrigger == trigger or v.identifier == trigger then

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
		if not ix.taskRewards.PrepareJob(character, npcidentifier, job) then
			self:Notify("Claim your pending task supplies before finishing another task.")

			return
		end
		local claimed = character:GetData("jobClaimsPaid", {})
		if claimed[npcidentifier] and claimed[npcidentifier] >= job.progressionClaim then return end
		claimed[npcidentifier] = job.progressionClaim
		character:SetData("jobClaimsPaid", claimed)
		jobs[npcidentifier] = nil
		character:SetJobs(jobs)
		character:Save()
		local definition = ix.jobs.list[job.identifier]
		ix.taskRewards.EarnOffer(character, job.rewardKey)
		self:addReputation(definition.repReward)
		ix.dialogue.notifyReputationReceive(self, definition.repReward)
		character:GiveMoney(job.moneyReward)
		ix.dialogue.notifyMoneyReceive(self, job.moneyReward)
		hook.Run("ix_OnJobComplete", self, npcidentifier, job.identifier)
		local vendor = ix.progression.GetNPCFromName(npcidentifier)
		if ix.vendorStock and ix.vendorStock.TaskRestock and IsValid(vendor) then
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
		jobs[npcidentifier] = job
		character:SetJobs(jobs)
		character:Save()
		if definition.OnTaskGet then definition.OnTaskGet(self) end
		netstream.Start(self, "ix_COTZPlayPDASound", 2)

		return true
	end
end
