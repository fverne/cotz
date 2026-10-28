ix.progression = ix.progression or {}

local REWARD_VERSION = 5
local PREVIOUS_CASH_RATES = {[2] = 0.3, [3] = 1.375, [4] = 0.8}
local PREVIOUS_CASH_RATE = 0.3
local REWARD_ROUNDING_EPSILON = 0.000000001
local LEGACY_MONEY_FACTOR = 0.5
local LEGACY_REPUTATION_FACTOR = 2

local function prepareCredit(line, record)
	line.rewardCredit = line.rewardCredit or {reputation = 0, money = 0}
	line.rewardsPaid = line.rewardsPaid or {reputation = 0, money = 0}
	if line.rewardVersion == REWARD_VERSION then return end
	if not line.rewardVersion or line.rewardVersion < 2 then
		line.rewardCredit.money = line.rewardCredit.money * LEGACY_MONEY_FACTOR
		line.rewardCredit.reputation = line.rewardCredit.reputation * LEGACY_REPUTATION_FACTOR
	end
	local previousRate = PREVIOUS_CASH_RATES[line.rewardVersion] or PREVIOUS_CASH_RATE
	line.rewardCredit.money = line.rewardCredit.money * ix.taskRewards.ProgressionCashMultiplier() / previousRate
	local quotedMoney, contributions = 0, 0
	local function quoteContributions(saved)
		for itemID, amount in pairs(saved or {}) do
			contributions = contributions + amount
			quotedMoney = quotedMoney + ix.taskRewards.ProgressionUnitValue(itemID) * amount
		end
	end
	if line.sources then
		for stageID in pairs(line.sources) do quoteContributions((record.lines[stageID] or {}).complexData) end
	else
		quoteContributions(line.complexData)
	end
	if contributions > 0 then line.rewardCredit.money = quotedMoney end
	line.rewardVersion = REWARD_VERSION
end

local function rewardLedger(character, progressionID, record)
	local stage = ix.progression.GetLine(character, progressionID)
	local definition = ix.progression.definitions[progressionID]
	local group = definition.milestoneGroup
	if not group or not stage.segmentVersion then
		return stage
	end
	record.rewardGroups = record.rewardGroups or {}
	local line = record.rewardGroups[group] or {
		value = 0, complexData = {}, requirements = {}, selections = {}, sources = {},
	}
	if not line.sources[progressionID] then
		for itemID, amount in pairs(stage.requirements or {}) do
			line.requirements[itemID] = (line.requirements[itemID] or 0) + amount
		end
		for _, selection in ipairs(stage.selections or {}) do
			local found = false
			for _, saved in ipairs(line.selections) do
				if saved.pool == selection.pool and saved.item == selection.item then
					found = true
				end
			end
			if not found then
				line.selections[#line.selections + 1] = selection
			end
		end
		line.sources[progressionID] = true
	end
	record.rewardGroups[group] = line

	return line, group
end

function ix.progression.AccrueTurnInRewards(character, progressionID, reputation, money, itemID)
	local record = ix.progression.GetCharacterProgression(character)
	local line, group = rewardLedger(character, progressionID, record)
	prepareCredit(line, record)
	line.rewardCredit.reputation = line.rewardCredit.reputation + reputation
	line.rewardCredit.money = line.rewardCredit.money + money
	if not group then
		record.lines[progressionID] = line
	end
	ix.progression.SetCharacterProgression(character, record)
end

function ix.progression.PayCompletionRewards(character, progressionID)
	local stage = ix.progression.GetLine(character, progressionID)
	local record = ix.progression.GetCharacterProgression(character)
	local line, group = rewardLedger(character, progressionID, record)
	if not stage.completed or stage.completionRewardsPaid or not line.rewardCredit then
		return
	end
	prepareCredit(line, record)
	local final = not group or group == progressionID
	local definition = ix.progression.definitions[progressionID]
	local reputation = math.max(0,
		math.floor(line.rewardCredit.reputation + 0.5 + REWARD_ROUNDING_EPSILON) - line.rewardsPaid.reputation)
	local money = math.max(0,
		math.ceil(line.rewardCredit.money - REWARD_ROUNDING_EPSILON) - line.rewardsPaid.money)
	stage.completionRewardsPaid = true
	line.rewardsPaid.reputation = line.rewardsPaid.reputation + reputation
	line.rewardsPaid.money = line.rewardsPaid.money + money
	line.itemRewards = {}
	if not group then
		line.completionRewardsPaid = true
		stage = line
	end
	record.lines[progressionID] = stage
	ix.progression.SetCharacterProgression(character, record)
	local client = character:GetPlayer()
	client:addReputation(reputation)
	character:GiveMoney(money)
	ix.dialogue.notifyReputationReceive(client, reputation)
	ix.dialogue.notifyMoneyReceive(client, money)
	if final and definition.completionBenefits then
		ix.progression.GrantBenefits(character, progressionID, definition.completionBenefits, "completion")
	end
	if final and ix.vendorStock and ix.vendorStock.TaskRestock then
		local definition = ix.progression.definitions[progressionID]
		local vendor = ix.progression.GetNPCFromName(definition.keyNpc)
		if IsValid(vendor) then
			ix.vendorStock.TaskRestock(character, vendor, progressionID)
		end
	end
	character:Save()
end
