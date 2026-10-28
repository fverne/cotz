ix.progression = ix.progression or {}

local REWARD_ROUNDING_EPSILON = 0.000000001

local function prepareCredit(line)
	line.rewardCredit = line.rewardCredit or {reputation = 0, money = 0}
	line.rewardsPaid = line.rewardsPaid or {reputation = 0, money = 0}
end

local function rewardLedger(character, progressionID, record)
	local group = ix.progression.definitions[progressionID].milestoneGroup
	if not group then
		return ix.progression.GetLine(character, progressionID)
	end
	record.rewardGroups = record.rewardGroups or {}
	local line = record.rewardGroups[group] or {}
	record.rewardGroups[group] = line

	return line, group
end

function ix.progression.AccrueTurnInRewards(character, progressionID, reputation, money, itemID)
	local record = ix.progression.GetCharacterProgression(character)
	local line, group = rewardLedger(character, progressionID, record)
	prepareCredit(line)
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
	prepareCredit(line)
	local final = not group or group == progressionID
	local definition = ix.progression.definitions[progressionID]
	local reputation = math.max(0,
		math.floor(line.rewardCredit.reputation + 0.5 + REWARD_ROUNDING_EPSILON) - line.rewardsPaid.reputation)
	local money = math.max(0,
		math.ceil(line.rewardCredit.money - REWARD_ROUNDING_EPSILON) - line.rewardsPaid.money)
	stage.completionRewardsPaid = true
	line.rewardsPaid.reputation = line.rewardsPaid.reputation + reputation
	line.rewardsPaid.money = line.rewardsPaid.money + money
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
