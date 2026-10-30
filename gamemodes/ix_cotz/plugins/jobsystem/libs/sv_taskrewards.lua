ix.taskRewards = ix.taskRewards or {}

local OFFER_KEY = "taskRewardOffers"
local CLAIM_LINE = "taskRewardClaims"
local MAX_OFFERS = 512
local MAX_PENDING_REWARDS = 1024
local BONUS_KEY = "taskCompletionBonus"

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
	local choices = jobTier and ix.taskRewards.BuildJobChoices(character, npc, budget, key)
		or ix.taskRewards.BuildChoices(character, npc, budget, key)
	if #choices == 0 then choices = {{label = "No supplies available", items = {}}} end
	local offer = {npc = npc, label = label, choices = choices}
	offers[key] = offer
	saveOffers(character, offers)

	return offer
end

local function paySelected(character, key, offers)
	local offer = offers[key]
	if not offer or not offer.earned or not offer.selected then return false end
	local choice = offer.choices[offer.selected]
	if key:match("^bonus:") then
		if choice.money then return false end
		for _, reward in ipairs(choice.items) do
			if reward.item == "bagrubles" then return false end
		end
	end
	for _, service in ipairs(choice.services or {}) do
		if ix.progression.ServiceCreditCapacity(character, service.npc, service.service) < service.amount then
			character:GetPlayer():Notify("Repair credit is full. Choose another bonus reward or spend credit first.")

			return false
		end
	end
	local record = ix.progression.GetCharacterProgression(character)
	local claimLine = CLAIM_LINE
	local line = record.lines[claimLine] or {}
	line.pendingRewards = line.pendingRewards or {}
	if #line.pendingRewards + #choice.items > MAX_PENDING_REWARDS then return false end
	for _, service in ipairs(choice.services or {}) do
		if not ix.progression.AddServiceCredit(character, service.npc, service.service, service.amount) then
			return false
		end
	end
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

function ix.taskRewards.SelectOffer(character, npc, key, index, label)
	local offers = offersFor(character)
	local offer = offers[key]
	if offer and key:match("^bonus:") and offer.npc == npc then
		offer.choices = ix.taskRewards.BuildBonusChoices(character, npc, offer.budget, key)
		offer.selected = nil
		saveOffers(character, offers)
	end
	if not ix.taskRewards.CanSelectOffer(character, npc, key, offer)
		or type(index) ~= "number" or index % 1 ~= 0
		or not offer.choices[index]
		or (label ~= nil and offer.choices[index].label ~= label) then
		return false
	end
	offer.selected = index
	if key:match("^job:") and not offer.earned then
		local jobs = character:GetJobs()
		if jobs[npc] and jobs[npc].rewardKey == key then
			jobs[npc].supplyChoice = index
			character:SetJobs(jobs)
		end
	end
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
	local budget = ix.taskRewards.SupplyBudget(definition, job.numberRec)
	local tier = definition.tier or 1
	local offer = ix.taskRewards.CreateOffer(character, key, npc, budget,
		ix.jobs.getFormattedName(job), tier)
	if not offer then return false end
	job.progressionClaim = serial
	job.rewardKey = key
	job.supplyBudget = budget
	job.supplyCatalogueVersion = ix.taskRewards.SupplyCatalogueVersion()
	job.moneyReward = ix.taskRewards.FixedMoney(definition, job.numberRec)
	job.rewardChoices = table.Copy(offer.choices)

	return key
end

function ix.taskRewards.RecordCompletion(character, npc, job)
	local state = table.Copy(character:GetData(BONUS_KEY, {}) or {})
	state.claims = state.claims or {}
	if not state.traders then
		state.traders = {}
		for trader in pairs(state.claims) do
			state.traders[trader] = ix.taskRewards.TraderBonusProgress(character, trader)
		end
		state.count, state.budget = nil, nil
	end
	local progress = state.traders[npc] or {}
	state.traders[npc] = progress
	if (state.claims[npc] or 0) >= job.progressionClaim then return end
	state.claims[npc] = job.progressionClaim
	local unspent = 0
	local offer = offersFor(character)[job.rewardKey]
	if job.supplyBudget and offer and offer.selected then
		local value = 0
		for _, reward in ipairs(offer.choices[offer.selected].items) do
			value = value + ix.taskRewards.ExpectedValue(reward.item, reward.data)
		end
		unspent = math.max(0, math.floor(job.supplyBudget - value))
	end
	progress.count = (progress.count or 0) + 1
	progress.budget = (progress.budget or 0) + unspent
	if progress.count >= ix.taskRewards.BonusInterval() then
		if progress.budget > 0 then
			local key = "bonus:" .. job.progressionClaim
			local offers = offersFor(character)
			offers[key] = {npc = npc, label = "Five-task bonus", earned = true, budget = progress.budget,
				choices = ix.taskRewards.BuildBonusChoices(character, npc, progress.budget, key)}
			saveOffers(character, offers)
			character:GetPlayer():Notify("Five tasks completed for " .. npc
				.. "! Choose your bonus under About work / Task rewards.")
		else
			character:GetPlayer():Notify("Five tasks completed for " .. npc
				.. ". No unused supply allowance accumulated this cycle.")
		end
		progress.count, progress.budget = 0, 0
	end
	character:SetData(BONUS_KEY, state)
end

function ix.taskRewards.RefreshBonuses(character, npc)
	local offers = offersFor(character)
	for key, offer in pairs(offers) do
		if key:match("^bonus:") and offer.npc == npc then
			offer.selected = nil
			offer.choices = ix.taskRewards.BuildBonusChoices(character, npc, offer.budget, key)
		end
	end
	saveOffers(character, offers)
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
	if preview then
		local definition = ix.jobs.list[preview.identifier]
		if definition.fieldType and not ix.jobs.field.IsAvailable(definition) then return end
		local budget = ix.taskRewards.SupplyBudget(definition, preview.numberRec)
		local offers = offersFor(character)
		local offer = offers[preview.rewardKey]
		local needsUpdate = budget > (preview.supplyBudget or 0) or preview.supplyDifficulty ~= nil
			or preview.supplyCatalogueVersion ~= ix.taskRewards.SupplyCatalogueVersion()
		if needsUpdate and offer and not offer.earned then
			local choices = ix.taskRewards.BuildJobChoices(character, npc, budget, preview.rewardKey)
			if #choices > 0 then
				offer.choices = choices
				preview.supplyBudget = budget
				preview.supplyCatalogueVersion = ix.taskRewards.SupplyCatalogueVersion()
				preview.supplyDifficulty = nil
				preview.difficulty = difficulty
				preview.rewardChoices = table.Copy(choices)
				preview.supplyChoice = math.min(preview.supplyChoice or 1, #choices)
				saveOffers(character, offers)
				character:SetData("taskJobPreviews", previews)
				character:Save()
			end
		end

		local cash = ix.taskRewards.FixedMoney(definition, preview.numberRec)
		if preview.moneyReward ~= cash then
			preview.moneyReward = cash
			character:SetData("taskJobPreviews", previews)
			character:Save()
		end

		return preview
	end
	local id = ix.jobs.getJobFromCategory(categories)
	local definition = ix.jobs.list[id]
	if not definition then return end
	local count = definition.numberRec
	if type(count) == "table" then count = math.random(count[1], count[2]) end
	preview = {identifier = id, numberRec = count, difficulty = difficulty}
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
	choice = choice or preview.supplyChoice
	if not offer or not offer.choices[choice] then return false end
	if offer then
		offer.selected = nil
		local offers = offersFor(character)
		offers[preview.rewardKey] = offer
		saveOffers(character, offers)
	end
	if not client:ixJobAdd(preview.identifier, npc, preview) then return false end
	if choice then
		ix.taskRewards.SelectOffer(character, npc, preview.rewardKey, choice)
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
