ix.taskRewards = ix.taskRewards or {}

local OFFER_KEY = "taskRewardOffers"
local CLAIM_LINE = "taskRewardClaims"
local MAX_OFFERS = 512
local MAX_PENDING_REWARDS = 1024

local function offersFor(character)
	return table.Copy(character:GetData(OFFER_KEY, {}) or {})
end

local function saveOffers(character, offers)
	character:SetData(OFFER_KEY, offers)
end

function ix.taskRewards.CreateOffer(character, key, npc, budget, label, jobTier)
	local offers = offersFor(character)
	if key:match("^progression:") then return end
	if offers[key] then return offers[key] end
	local count = 0
	for _ in pairs(offers) do count = count + 1 end
	if count >= MAX_OFFERS and key:match("^job:") then return end
	local choices = jobTier and ix.taskRewards.BuildJobChoices(character, npc, jobTier, key)
		or ix.taskRewards.BuildChoices(character, npc, budget, key)
	if #choices == 0 then return end
	local offer = {npc = npc, label = label, choices = choices}
	offers[key] = offer
	saveOffers(character, offers)

	return offer
end

local function paySelected(character, key, offers)
	local offer = offers[key]
	if not offer or not offer.earned or not offer.selected then return false end
	local choice = offer.choices[offer.selected]
	local record = ix.progression.GetCharacterProgression(character)
	local claimLine = CLAIM_LINE
	local line = record.lines[claimLine] or {}
	line.pendingRewards = line.pendingRewards or {}
	if #line.pendingRewards + #choice.items > MAX_PENDING_REWARDS then return false end
	for _, reward in ipairs(choice.items) do
		line.pendingRewards[#line.pendingRewards + 1] =
			ix.progression.PrepareReward(character, claimLine, line, table.Copy(reward))
	end
	record.lines[claimLine] = line
	offers[key] = nil
	saveOffers(character, offers)
	ix.progression.SetCharacterProgression(character, record)
	character:Save()
	ix.progression.ClaimRewards(character, claimLine)

	return true
end

function ix.taskRewards.EarnOffer(character, key)
	local offers = offersFor(character)
	if not offers[key] then return false end
	offers[key].earned = true
	saveOffers(character, offers)
	character:Save()
	paySelected(character, key, offers)

	return true
end

function ix.taskRewards.SelectOffer(character, npc, key, index)
	local offers = offersFor(character)
	local offer = offers[key]
	if not ix.taskRewards.CanSelectOffer(character, npc, key, offer)
		or type(index) ~= "number" or index % 1 ~= 0
		or not offer.choices[index] then
		return false
	end
	offer.selected = index
	saveOffers(character, offers)
	character:Save()
	paySelected(character, key, offers)

	return true
end

function ix.taskRewards.PrepareJob(character, npc, job)
	if job.rewardKey then return job.rewardKey end
	local definition = ix.jobs.list[job.identifier]
	local serial = character:GetData("jobClaimSerial", 0) + 1
	character:SetData("jobClaimSerial", serial)
	local key = "job:" .. serial
	local offer = ix.taskRewards.CreateOffer(character, key, npc, 0,
		ix.jobs.getFormattedName(job), definition.tier or 1)
	if not offer then return false end
	job.progressionClaim = serial
	job.rewardKey = key
	job.moneyReward = ix.taskRewards.FixedMoney(definition, job.numberRec)
	job.rewardChoices = table.Copy(offer.choices)

	return key
end

function ix.taskRewards.DeliverJobItem(client, npc)
	local character = client:GetCharacter()
	local job = character:GetJobs()[npc]
	if not job or job.isCompleted then return false end
	local definition = ix.jobs.list[job.identifier]
	if not definition or not definition.requiredItem then return false end
	local item = character:GetInventory():HasItem(definition.requiredItem)
	if not item then return false end
	local remaining = job.numberRec - (job.progress or 0)
	local quantity = item.quantity and item:GetData("quantity", item.quantity) or 1
	local amount = math.min(remaining, quantity)
	if amount <= 0 then return false end
	local value = ix.taskRewards.HandInUnitValue(definition.requiredItem, item) * amount
	for _ = 1, amount do hook.Run("ix_JobTrigger", client, job.identifier) end
	local jobs = character:GetJobs()
	job = jobs[npc]
	job.deliveredValue = (job.deliveredValue or 0) + value
	job.moneyReward = ix.taskRewards.FixedMoney(definition, job.numberRec, job.deliveredValue)
	character:SetJobs(jobs)
	if item.quantity and quantity > amount then
		item:SetData("quantity", quantity - amount)
	else
		item:Remove()
	end
	character:Save()
	ix.dialogue.notifyItemLost(client, ix.item.list[definition.requiredItem].name)

	return true
end

function ix.taskRewards.RemoveJobOffer(character, job)
	if not job or not job.rewardKey then return end
	local offers = offersFor(character)
	if offers[job.rewardKey] and not offers[job.rewardKey].earned then
		offers[job.rewardKey] = nil
		saveOffers(character, offers)
	end
end

function ix.taskRewards.ClaimNext(character)
	return ix.progression.ClaimRewards(character, CLAIM_LINE)
end

local function hasClaimSpace(character, choice)
	local pending = ix.progression.GetLine(character, CLAIM_LINE).pendingRewards or {}

	return #pending + #choice.items <= MAX_PENDING_REWARDS
end

function ix.taskRewards.RedeemKit(character, npc, itemID, choiceIndex, label)
	if type(itemID) ~= "number" or itemID % 1 ~= 0 then return false end
	local item = character:GetInventory():GetItems()[tonumber(itemID)]
	if not item or not ix.taskRewards.IsTaskKit(item.uniqueID) then return false end
	local key = "kit:" .. item:GetID()
	local choices = ix.taskRewards.BuildChoices(character, npc,
		ix.taskRewards.ExpectedValue(item.uniqueID), key)
	if type(choiceIndex) ~= "number" or choiceIndex % 1 ~= 0 or not choices[choiceIndex] then return false end
	if choices[choiceIndex].label ~= label or not hasClaimSpace(character, choices[choiceIndex]) then return false end
	local offers = offersFor(character)
	-- The owned item is the consumable entitlement; retire it before inventory insertion can re-enter.
	if item:GetData("taskRewardRedeemed", false) then return false end
	item:SetData("taskRewardRedeemed", true)
	item:Remove()
	offers[key] = {npc = npc, choices = choices, selected = choiceIndex, earned = true}
	saveOffers(character, offers)
	paySelected(character, key, offers)

	return true
end

function ix.taskRewards.ExecuteBarter(character, npc, barterID, index, label)
	local barter = ix.npcbarter.barterdict[npc] and ix.npcbarter.barterdict[npc][barterID]
	if not barter or not ix.npcbarter.activebarters[barterID]
		or not ix.taskRewards.IsTaskKit(barter.barterItem[1]) then
		return false
	end
	local choices = ix.taskRewards.BarterChoices(character, npc, barterID, barter)
	if type(index) ~= "number" or index % 1 ~= 0 or not choices[index] then return false end
	if choices[index].label ~= label or not hasClaimSpace(character, choices[index]) then return false end
	if not ix.npcbarter.ConsumeItems(character:GetPlayer(), barter.reqItem[1], barter.reqItem[2] or 1) then
		return false
	end
	local serial = character:GetData("taskBarterSerial", 0) + 1
	character:SetData("taskBarterSerial", serial)
	local key = "barter:" .. serial
	local offers = offersFor(character)
	offers[key] = {npc = npc, choices = choices, selected = index, earned = true}
	saveOffers(character, offers)
	paySelected(character, key, offers)

	return true
end

function ix.taskRewards.PreviewJob(character, npc, difficulty, categories)
	if not ix.taskRewards.CanTakeDifficulty(character, difficulty) then return end
	if character:GetJobs()[npc] or type(categories) ~= "table" or #categories == 0 then return end
	local previews = table.Copy(character:GetData("taskJobPreviews", {}) or {})
	previews[npc] = previews[npc] or {}
	local preview = previews[npc][difficulty]
	if preview then return preview end
	local id = ix.jobs.getJobFromCategory(categories)
	local definition = ix.jobs.list[id]
	local count = definition.numberRec
	if type(count) == "table" then count = math.random(count[1], count[2]) end
	preview = {identifier = id, numberRec = count}
	if not ix.taskRewards.PrepareJob(character, npc, preview) then return end
	preview.supplyChoice = math.random(#preview.rewardChoices)
	previews[npc][difficulty] = preview
	character:SetData("taskJobPreviews", previews)
	character:Save()

	return preview
end

function ix.taskRewards.AcceptJob(client, npc, difficulty, choice)
	local character = client:GetCharacter()
	if not ix.taskRewards.CanTakeDifficulty(character, difficulty) then return false end
	local previews = table.Copy(character:GetData("taskJobPreviews", {}) or {})
	local preview = previews[npc] and previews[npc][difficulty]
	if not preview or character:GetJobs()[npc] then return false end
	local offer = (character:GetData("taskRewardOffers", {}) or {})[preview.rewardKey]
	if choice ~= nil and choice ~= preview.supplyChoice then return false end
	if offer then
		offer.selected = nil
		local offers = offersFor(character)
		offers[preview.rewardKey] = offer
		saveOffers(character, offers)
	end
	if not client:ixJobAdd(preview.identifier, npc, preview) then return false end
	if preview.supplyChoice then
		ix.taskRewards.SelectOffer(character, npc, preview.rewardKey, preview.supplyChoice)
	end
	-- Other difficulty previews are no longer claimable entitlements.
	for key, other in pairs(previews[npc]) do
		if key ~= difficulty then ix.taskRewards.RemoveJobOffer(character, other) end
	end
	previews[npc] = nil
	character:SetData("taskJobPreviews", previews)
	character:Save()

	return true
end

-- Task supply packages drain automatically; progression claims remain player-driven.
hook.Add("cotz/progression/reward-claimed", "cotz/jobsystem/claim-next-supply", function(character, lineID, line)
	if lineID ~= CLAIM_LINE or #line.pendingRewards == 0 then return end
	timer.Simple(0, function()
		local client = character:GetPlayer()
		if IsValid(client) and client:GetCharacter() == character then
			ix.taskRewards.ClaimNext(character)
		end
	end)
end)
