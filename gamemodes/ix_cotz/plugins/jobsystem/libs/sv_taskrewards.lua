ix.taskRewards = ix.taskRewards or {}

local OFFER_KEY = "taskRewardOffers"
local CLAIM_LINE = "taskRewardClaims"
local MAX_OFFERS = ix.taskRewards.settings.maxOffers
local MAX_PENDING_REWARDS = ix.taskRewards.settings.maxPendingRewards
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
	local choices = jobTier and {} or ix.taskRewards.BuildChoices(character, npc, budget, key)
	local offer = {npc = npc, label = label, choices = choices, budget = budget, tier = jobTier,
		version = ix.taskRewards.SupplyCatalogueVersion()}
	offers[key] = offer
	saveOffers(character, offers)

	return offer
end

local function paySelected(character, key, offers)
	if key:match("^progression:") then return false end
	local offer = offers[key]
	if not offer or not offer.earned or not offer.selected then return false end
	local choice = offer.choices[offer.selected]
	if key:match("^bonus:") then
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
	if #line.pendingRewards + #choice.items > MAX_PENDING_REWARDS then
		character:GetPlayer():Notify("Collect stored rewards to make room for this claim, then choose it again.")
		return false
	end
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
	if choice.money and choice.money > 0 then
		character:GiveMoney(choice.money)
		ix.dialogue.notifyMoneyReceive(character:GetPlayer(), choice.money)
		if key:match("^job:") then
			local stats = table.Copy(character:GetData("leaderboardStats", {}))
			stats.taskEarnings = (stats.taskEarnings or 0) + choice.money
			character:SetData("leaderboardStats", stats)
		end
	end
	character:Save()
	ix.progression.ClaimRewards(character, claimLine)

	return true
end

function ix.taskRewards.EarnOffer(character, key)
	if key:match("^progression:") then return false end
	local offers = offersFor(character)
	if not offers[key] then return false end
	offers[key].earned = true
	saveOffers(character, offers)
	character:Save()
	if not paySelected(character, key, offers) and offers[key] and offers[key].earned then
		if key:match("^job:") then
			offers[key].retrySelected = true
		else
			offers[key].selected = nil
		end
		saveOffers(character, offers)
	end

	return true
end

local function canUseRewardNPC(client, npc, character)
	if not IsValid(client) or client:GetCharacter() ~= character then return false end
	local target = ix.progression.GetNPCFromName(npc)

	return character and client:Alive() and IsValid(target) and target:GetClass() == "ix_vendor_adv"
		and target:GetDisplayName() == npc and target:CanAccess(client)
		and client:GetPos():DistToSqr(target:GetPos()) <= ix.jobs.settings.interactionDistance ^ 2
		and ix.progression.CanUseNPC(character, npc)
end

function ix.taskRewards.RevealJobOffer(client, npc)
	local character = client:GetCharacter()
	local job = character and character:GetJobs()[npc]
	if not job or not job.isCompleted or not canUseRewardNPC(client, npc, character) then return false end
	if job.fieldTask and not ix.jobs.field.CanComplete(character, job) then return false end
	ix.taskRewards.ReconcileCharacter(character)
	local offers = offersFor(character)
	local offer = offers[job.rewardKey]
	if not offer or offer.earned then return false end
	if not offer.ready then
		offer.choices = ix.taskRewards.BuildJobChoices(character, npc, offer.budget, job.rewardKey, offer.tier)
		if #offer.choices == 0 then
			offer.choices = {{label = "Finish assignment", items = {}}}
		end
		offer.ready = true
		saveOffers(character, offers)
		character:Save()
	end

	local target = ix.progression.GetNPCFromName(npc)
	net.Start("cotz/dialogue/task-rewards-refresh")
	net.WriteEntity(target)
	net.Send(client)

	return true
end

function ix.taskRewards.SelectOffer(character, npc, key, index, label)
	if type(key) ~= "string" then return false end
	if (key:match("^job:") or key:match("^bonus:"))
		and not canUseRewardNPC(character:GetPlayer(), npc, character) then return false end
	ix.taskRewards.ReconcileCharacter(character)
	local offers = offersFor(character)
	local offer = offers[key]
	if not ix.taskRewards.CanSelectOffer(character, npc, key, offer)
		or type(index) ~= "number" or index % 1 ~= 0
		or not offer.choices[index]
		or (offer.selected and offer.selected ~= index)
		or (label ~= nil and offer.choices[index].label ~= label) then return false end
	if key:match("^job:") and not offer.earned then
		local client = character:GetPlayer()
		offer.selected = index
		saveOffers(character, offers)
		if client:ixJobComplete(npc) then return true end
		offers = offersFor(character)
		if offers[key] then offers[key].selected = nil saveOffers(character, offers) end

		return false
	end
	offer.selected = index
	saveOffers(character, offers)
	character:Save()
	if not paySelected(character, key, offers) and offers[key] and offers[key].earned then
		if key:match("^job:") then
			offers[key].retrySelected = true
		else
			offers[key].selected = nil
		end
		saveOffers(character, offers)
	end

	return true
end

function ix.taskRewards.PrepareJob(character, npc, job)
	if job.rewardKey then return job.rewardKey end
	local definition = ix.jobs.list[job.identifier]
	local serial = character:GetData("jobClaimSerial", 0) + 1
	character:SetData("jobClaimSerial", serial)
	local key = "job:" .. serial
	if definition.townProgression then
		job.progressionClaim = serial
		job.rewardKey = key
		job.supplyBudget = 0
		job.moneyReward = 0
		job.rewardChoices = {}

		return key
	end
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
	job.rewardChoices, job.supplyChoice = nil, nil

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
		local value = ix.taskRewards.ChoiceValue(offer.choices[offer.selected])
		local definition = ix.jobs.list[job.identifier]
		local budget = job.supplyBudget
		if definition and definition.requiredItem then
			budget = math.min(budget, ix.taskRewards.SupplyBudget(definition, job.numberRec))
		end
		unspent = math.max(0, math.floor(budget - value))
	end
	progress.count = (progress.count or 0) + 1
	progress.budget = (progress.budget or 0) + unspent
	if progress.count >= ix.taskRewards.BonusInterval() then
		local remainingBudget = 0
		if progress.budget > 0 then
			local key = "bonus:" .. job.progressionClaim
			local choices = ix.taskRewards.BuildBonusChoices(character, npc, progress.budget, key)
			if #choices == 0 then
				remainingBudget = progress.budget
				character:GetPlayer():Notify("Five tasks completed for " .. npc
					.. ". Bonus value retained until a themed reward is affordable and unlocked.")
			else
				local offers = offersFor(character)
				offers[key] = {npc = npc, label = "Five-task bonus", earned = true,
					budget = progress.budget, choices = choices, version = ix.taskRewards.SupplyCatalogueVersion()}
				saveOffers(character, offers)
				character:GetPlayer():Notify("Five tasks completed for " .. npc
					.. "! Choose your bonus under About work / Task rewards.")
			end
		else
			character:GetPlayer():Notify("Five tasks completed for " .. npc
				.. ". No unused reward allowance accumulated this cycle.")
		end
		progress.count, progress.budget = 0, remainingBudget
	end
	character:SetData(BONUS_KEY, state)
end

function ix.taskRewards.ReconcileCharacter(character)
	local offers = offersFor(character)
	local jobs = character:GetJobs()
	local previews = table.Copy(character:GetData("taskJobPreviews", {}) or {})
	local changed = false
	local version = ix.taskRewards.SupplyCatalogueVersion()
	local function normalize(npc, job)
		if job.rewardChoices or job.supplyChoice then
			job.rewardChoices, job.supplyChoice = nil, nil
			changed = true
		end
		local offer = offers[job.rewardKey]
		local definition = ix.jobs.list[job.identifier]
		if not offer or offer.npc ~= npc or offer.earned or not definition or definition.townProgression then return end
		if offer.version ~= version or job.supplyCatalogueVersion ~= version then
			offer.choices, offer.selected, offer.ready, offer.retrySelected = {}, nil, nil, nil
			offer.budget = ix.taskRewards.SupplyBudget(definition, job.numberRec)
			offer.tier, offer.version = definition.tier or 1, version
			job.supplyBudget, job.supplyCatalogueVersion = offer.budget, version
			changed = true
		end
	end
	for npc, job in pairs(jobs) do normalize(npc, job) end
	for npc, difficulties in pairs(previews) do
		for _, job in pairs(difficulties) do normalize(npc, job) end
	end
	for key, offer in pairs(offers) do
		if offer.earned and offer.version ~= version and (key:match("^job:") or key:match("^bonus:")) then
			local budget = offer.budget or ix.taskRewards.settings.jobMinSupplyBudget
			for _, choice in ipairs(offer.choices or {}) do
				budget = math.max(budget, ix.taskRewards.ChoiceValue(choice))
			end
			offer.budget, offer.version, offer.selected, offer.retrySelected = budget, version, nil, nil
			offer.choices = key:match("^bonus:")
				and ix.taskRewards.BuildBonusChoices(character, offer.npc, budget, key)
				or ix.taskRewards.BuildJobChoices(character, offer.npc, budget, key, offer.tier or 1)
			changed = true
		elseif offer.earned and key:match("^job:") and offer.selected and not offer.retrySelected then
			-- An offer still present after restart has not reached the durable item queue or cash payout.
			offer.retrySelected, changed = true, true
		end
	end
	if changed then
		saveOffers(character, offers)
		character:SetJobs(jobs)
		character:SetData("taskJobPreviews", previews)
		character:Save()
	end
end

function ix.taskRewards.RefreshBonuses(character)
	ix.taskRewards.ReconcileCharacter(character)
end

function ix.taskRewards.DeliverJobItem(client, npc, receiver)
	local character = client:GetCharacter()
	local job = character:GetJobs()[npc]
	if not job or job.isCompleted then return false end
	local definition = ix.jobs.list[job.identifier]
	if not definition or not definition.requiredItem then return false end
	if definition.alternateDelivery then
		local contact = receiver and ix.townNPCs.byName[receiver:GetDisplayName()]
		if not contact or not ix.townNPCs:CanInteract(client, receiver)
			or not ix.jobs.regional.ReceiverMatches(character, contact, job)
			or contact.map ~= game.GetMap() then return false end
	end
	local item, itemID = ix.jobs.regional.FindHandIn(character, job)
	if not item then return false end
	local remaining = job.numberRec - (job.progress or 0)
	local quantity = definition.wholeItems and 1 or item:GetData("quantity", item.quantity or item.ammoAmount or 1)
	if type(quantity) ~= "number" or quantity ~= quantity or quantity == math.huge then return false end
	local amount = math.floor(math.min(remaining, quantity))
	if amount <= 0 then return false end
	local value = ix.taskRewards.HandInUnitValue(itemID, item, definition.wholeItems) * amount
	if quantity > amount then
		item:SetData("quantity", quantity - amount)
	elseif item:Remove() == false then
		return false
	end
	for _ = 1, amount do hook.Run("ix_JobTrigger", client, job.identifier) end
	local jobs = character:GetJobs()
	job = jobs[npc]
	job.deliveredValue = (job.deliveredValue or 0) + value
	job.moneyReward = ix.taskRewards.FixedMoney(definition, job.numberRec, job.deliveredValue)
	character:SetJobs(jobs)
	character:Save()
	ix.dialogue.notifyItemLost(client, ix.item.list[itemID].name)
	if job.isCompleted then ix.taskRewards.RevealJobOffer(client, npc) end

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
	ix.taskRewards.ReconcileCharacter(character)
	if not ix.taskRewards.CanTakeDifficulty(character, difficulty) then return end
	if character:GetJobs()[npc] or type(categories) ~= "table" or #categories == 0 then return end
	local previews = table.Copy(character:GetData("taskJobPreviews", {}) or {})
	previews[npc] = previews[npc] or {}
	local preview = previews[npc][difficulty]
	if preview and ix.jobs.regional
		and not ix.jobs.regional.CanOffer(character, ix.jobs.list[preview.identifier]) then
		ix.taskRewards.RemoveJobOffer(character, preview)
		previews[npc][difficulty], preview = nil, nil
		character:SetData("taskJobPreviews", previews)
	end
	if preview then
		local definition = ix.jobs.list[preview.identifier]
		if definition.fieldType and not ix.jobs.field.IsAvailable(definition) then return end
		local budget = ix.taskRewards.SupplyBudget(definition, preview.numberRec)
		local offers = offersFor(character)
		local offer = offers[preview.rewardKey]
		if offer and budget ~= preview.supplyBudget then
			offer.budget, preview.supplyBudget = budget, budget
			saveOffers(character, offers)
			character:SetData("taskJobPreviews", previews)
		end

		local cash = ix.taskRewards.FixedMoney(definition, preview.numberRec)
		if preview.moneyReward ~= cash then
			preview.moneyReward = cash
			character:SetData("taskJobPreviews", previews)
			character:Save()
		end

		return preview
	end
	local id = ix.jobs.getJobFromCategory(categories, character)
	local definition = ix.jobs.list[id]
	if not definition then return end
	local count = definition.numberRec
	if type(count) == "table" then count = math.random(count[1], count[2]) end
	preview = {identifier = id, numberRec = count, difficulty = difficulty}
	if not ix.taskRewards.PrepareJob(character, npc, preview) then return end
	previews[npc][difficulty] = preview
	character:SetData("taskJobPreviews", previews)
	character:Save()

	return preview
end

function ix.taskRewards.AcceptJob(client, npc, difficulty, choice)
	local character = client:GetCharacter()
	ix.taskRewards.ReconcileCharacter(character)
	if not ix.taskRewards.CanTakeDifficulty(character, difficulty) then return false end
	local previews = table.Copy(character:GetData("taskJobPreviews", {}) or {})
	local preview = previews[npc] and previews[npc][difficulty]
	if not preview or character:GetJobs()[npc] then return false end
	if choice ~= nil then return false end
	local offer = (character:GetData("taskRewardOffers", {}) or {})[preview.rewardKey]
	if not offer or offer.earned then return false end
	if not client:ixJobAdd(preview.identifier, npc, preview) then return false end
	-- Other difficulty previews are no longer claimable entitlements.
	for key, other in pairs(previews[npc]) do
		if key ~= difficulty then ix.taskRewards.RemoveJobOffer(character, other) end
	end
	previews[npc] = nil
	character:SetData("taskJobPreviews", previews)
	character:Save()

	return true
end

-- Repeatable task supply packages drain automatically; progression item gifts are disabled.
hook.Add("cotz/progression/reward-claimed", "cotz/jobsystem/claim-next-supply", function(character, lineID, line)
	if lineID ~= CLAIM_LINE or #line.pendingRewards == 0 then return end
	timer.Simple(0, function()
		local client = character:GetPlayer()
		if IsValid(client) and client:GetCharacter() == character then
			ix.taskRewards.ClaimNext(character)
		end
	end)
end)
