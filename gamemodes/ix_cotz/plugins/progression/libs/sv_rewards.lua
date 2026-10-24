ix.progression = ix.progression or {}

local REWARD_VERSION = 2
local REWARD_ROUNDING_EPSILON = 0.000000001
local LEGACY_MONEY_FACTOR = 0.5
local LEGACY_REPUTATION_FACTOR = 2
local ITEM_REWARD_QUANTITY_FACTOR = 0.5

local function prepareCredit(line)
	line.rewardCredit = line.rewardCredit or { reputation = 0, money = 0 }
	line.rewardsPaid = line.rewardsPaid or { reputation = 0, money = 0 }
	if line.rewardVersion ~= REWARD_VERSION then
		line.rewardCredit.money = line.rewardCredit.money * LEGACY_MONEY_FACTOR
		line.rewardCredit.reputation = line.rewardCredit.reputation * LEGACY_REPUTATION_FACTOR
		line.rewardVersion = REWARD_VERSION
	end
end

local function initializeItemCredit(line)
	if line.moneyByItem then
		return
	end
	line.moneyByItem = {}
	-- Older partial tasks have no per-item value ledger; quote their saved contributions.
	for itemID, amount in pairs(line.complexData) do
		local quote = setmetatable({
			GetData = function(_, key, default)
				if key == "quantity" then
					return amount
				end

				return default
			end,
		}, { __index = ix.item.list[itemID] })
		local _, money = ix.util.GetValueFromProgressionTurnin(quote, amount)
		line.moneyByItem[itemID] = money
	end
end

function ix.progression.AccrueTurnInRewards(character, progressionID, reputation, money, itemID)
	local record = ix.progression.GetCharacterProgression(character)
	local line = ix.progression.GetLine(character, progressionID)
	prepareCredit(line)
	initializeItemCredit(line)
	line.rewardCredit.reputation = line.rewardCredit.reputation + reputation
	line.rewardCredit.money = line.rewardCredit.money + money
	line.moneyByItem[itemID] = (line.moneyByItem[itemID] or 0) + money
	record.lines[progressionID] = line
	ix.progression.SetCharacterProgression(character, record)
end

local function rollItemRewards(line)
	local groups, bonusMoney = {}, 0
	for _, selection in ipairs(line.selections or {}) do
		local candidates = {}
		local pool = ix.progression.itemPools[selection.pool]
		for _, candidate in ipairs(pool.candidates) do
			if candidate.item ~= selection.item then
				candidates[#candidates + 1] = candidate.item
			end
		end
		if #candidates > 0 then
			local quantity = math.max(1, math.floor(line.requirements[selection.item] * ITEM_REWARD_QUANTITY_FACTOR))
			groups[#groups + 1] = { candidates = candidates, quantity = quantity }
		else
			bonusMoney = bonusMoney + (line.moneyByItem[selection.item] or 0)
		end
	end
	if #groups == 0 then
		return {}, bonusMoney
	end
	local group = groups[math.random(1, #groups)]
	local itemID = group.candidates[math.random(1, #group.candidates)]

	return { { item = itemID, quantity = group.quantity } }, bonusMoney
end

local function giveItemReward(character, client, reward)
	local item = ix.item.list[reward.item]
	local data = { quantity = reward.quantity }
	if not character:GetInventory():Add(reward.item, 1, data) then
		ix.item.Spawn(reward.item, client:GetItemDropPos(), nil, nil, data)
		client:Notify("No space in your inventory! Your progression reward has been dropped.")
	end
	ix.dialogue.notifyItemGet(client, item.name)
end

function ix.progression.PayCompletionRewards(character, progressionID)
	local line = ix.progression.GetLine(character, progressionID)
	if not line.completed or line.completionRewardsPaid or not line.rewardCredit then
		return
	end
	prepareCredit(line)
	initializeItemCredit(line)
	local bonusMoney
	line.itemRewards, bonusMoney = rollItemRewards(line)
	local reputation = math.max(0,
		math.floor(line.rewardCredit.reputation + 0.5 + REWARD_ROUNDING_EPSILON) - line.rewardsPaid.reputation)
	local money = math.max(0,
		math.floor(line.rewardCredit.money + bonusMoney + 0.5 + REWARD_ROUNDING_EPSILON) - line.rewardsPaid.money)
	-- Commit before calling inventory or notification hooks so re-entry cannot pay twice.
	line.completionRewardsPaid = true
	line.rewardsPaid.reputation = line.rewardsPaid.reputation + reputation
	line.rewardsPaid.money = line.rewardsPaid.money + money
	local record = ix.progression.GetCharacterProgression(character)
	record.lines[progressionID] = line
	ix.progression.SetCharacterProgression(character, record)
	local client = character:GetPlayer()
	client:addReputation(reputation)
	character:GiveMoney(money)
	ix.dialogue.notifyReputationReceive(client, reputation)
	ix.dialogue.notifyMoneyReceive(client, money)
	for _, reward in ipairs(line.itemRewards) do
		giveItemReward(character, client, reward)
	end
	character:Save()
end
