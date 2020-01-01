ix.quest = ix.quest or {}
ix.quest.list = ix.quest.list or {}

local MAX_ALLOWED_QUESTS = 3

function ix.quest.register(queststruct,identifier)
  if ix.quest.isStructValid(queststruct) then
    ix.quest.list[identifier] = queststruct
  else
    print("ERROR IN QUEST DEFINITION")
  end
end

--[[
  QUEST STRUCT should contain

  name -- Name of the quest - string
  icon -- icon to display - Material
  desc -- Description of the quest, can contain format characters - string
  tier -- Tier of the quest, based on reputation tiers - number
  listenTrigger -- Name of the trigger to listen for - string
  numberRec -- Required number of times the trigger needs to be heard. If table a random number is selected. - number/table
  reward -- Item to give the player upon completion. If this is a table a random item from the table is selected, supports data - string/table
  rewardCount -- How many times we should try to give the player an item. If table a random number is selected. - number/table
  repReward -- How much rep to give a player from quest completion - number/table

  EXAMPLE

  local tempQuest = {}

  tempQuest.name = "Kill %d mutants."
  tempQuest.desc = "Kill %d %s."
  tempQuest.tier = 1
  tempQuest.listenTrigger = "mutantKilled"
  tempQuest.numberRec = {5,10}
  tempQuest.reward = {{"makarov", {["durability"] = 15}},{"9x19"}}
  tempQuest.rewardCount = {1,3}
  tempQuest.repReward = 200

  ix.quest.register(tempquest)

  ACTIVE QUEST STRUCT should contain
  
  listenTrigger
  numberRec
  progress
  isCompleted
  
--]]

function ix.quest.isStructValid(queststruct)
  if (!queststruct.name or type(queststruct.name) != "string") then return false end
  if (!queststruct.listenTrigger or type(queststruct.listenTrigger) != "string") then return false end
  if !queststruct.numberRec then return false end
  if !queststruct.reward then return false end
  if !queststruct.icon then queststruct.icon = Material("path/to/defaulticon.png") end

  return true
end

function ix.quest.getFormattedName(identifier, activequest)
  return string.format(ix.quest.list[identifier].name,activequest.numberRec)
end

function ix.quest.getFormattedDesc(identifier, activequest)
  return string.format(ix.quest.list[identifier].desc,activequest.numberRec)
end

function ix.quest.isItemQuest(questname)
  local underscorepos = string.find(questname, "_")
  if underscorepos then
    return string.sub(questname, underscorepos + 1)
  else
    return false
  end
end

hook.Add("ix_QuestTrigger", "QuestProgress", function(client, triggerstring)
  client:ixQuestEvaluate(triggerstring)
end)

if SERVER then
  local playerMeta = FindMetaTable("Player")

  function playerMeta:ixQuestEvaluate(trigger)
    --print("Evaluating quest with ID: "..trigger)

    --Check if player has quest
    local curQuests = self:GetCharacter():GetData("quests", {})
    for k,v in pairs(curQuests) do
      if v.listenTrigger == trigger then

        --Progress quest for player OR mark as completed
        local curProgress = curQuests[k].progress
        local curMax = curQuests[k].numberRec

        if (curProgress < curMax and !curQuests.isCompleted) then
          curQuests[k].progress = curQuests[k].progress + 1
          if curProgress+1 == curMax then
            curQuests[k].isCompleted = true
          end
        else
          curQuests[k].isCompleted = true
        end
      end
    end
  end

  function playerMeta:ixQuestComplete(identifier)
    --print("Completing quest with ID: "..identifier)

    if self:ixQuestHas(identifier) then

      curQuests = self:GetCharacter():GetData("quests", {})
      --Check if quest is marked as complete
      if curQuests[identifier].isCompleted then
        --Check rewards & rewardcount

        local rewCount = 0
        if type(ix.quest.list[identifier].rewardCount) == "table" then
          rewCount = math.random(ix.quest.list[identifier].rewardCount[1],ix.quest.list[identifier].rewardCount[2])
        else 
          rewCount = ix.quest.list[identifier].rewardCount
        end

        for i = 1, rewCount do
          local reward
          if type(ix.quest.list[identifier].reward) == "table" then
            reward = table.Random(ix.quest.list[identifier].reward)
          else 
            reward = ix.quest.list[identifier].reward
          end

          --Give player items
          if (self:GetCharacter() and !self:GetCharacter():GetInventory():Add(reward[1], 1, reward[2] or {})) then
            ix.item.Spawn(reward[1], self:GetItemDropPos(), nil, AngleRand(), reward[2] or {})
          end
        end

          --Give player rep
          if self:GetCharacter() then
            self:addReputation(ix.quest.list[identifier].repReward)
          end

          --Remove quest from player
          curQuests[identifier] = nil

          self:GetCharacter():SetData("quests", curQuests)

          --Add new random quest according to tier
          self:ixQuestGetNew()
      end
    end
  end

  function playerMeta:ixQuestAdd(identifier)
    --print("Adding quest with ID: "..identifier)
    curQuests = self:GetCharacter():GetData("quests", {})

    --Check if under max allowed quests
    if #curQuests < MAX_ALLOWED_QUESTS then
      --Check if player already has a quest of this type
      if curQuests[identifier] then return false end
      --Evaluate quest parameters | numberRec, listenTrigger, progress=0, isCompleted=false |
      temp = {}

      if type(ix.quest.list[identifier].numberRec) == "table" then
        temp.numberRec = math.random(ix.quest.list[identifier].numberRec[1],ix.quest.list[identifier].numberRec[2])
      else
        temp.numberRec = ix.quest.list[identifier].numberRec
      end

      temp.listenTrigger = ix.quest.list[identifier].listenTrigger

      temp.progress = 0

      temp.isCompleted = false

      curQuests[identifier] = temp
    else
      return false
    end
  end

  function playerMeta:ixQuestHas(identifier)
    curQuests = self:GetCharacter():GetData("quests", {})

    if curQuests[identifier] then
      return true
    else 
      return false
    end
  end

  function playerMeta:ixQuestGetTier()
  	--hardcoded tier limits X
  	local curRep = self:getReputation()

  	if curRep < 50 then return 1
  	elseif curRep < 765 then return 2
  	elseif curRep < 1943 then return 3
  	elseif curRep < 9338 then return 4
  	elseif curRep >= 9338 then return 5
  	else return 0 end
  end

  function playerMeta:ixQuestGetNew()
  	local v,k = table.Random(ix.quest.list)

  	while(self:ixQuestHas(k) or self:ixQuestGetTier()<v.tier) do
  		v,k = table.Random(ix.quest.list)
  	end

    self:ixQuestAdd(k)
  end
end