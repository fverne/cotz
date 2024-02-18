--[[
  --TestJob
  local tempJob = {}

  tempJob.name = "Say sneed %d times."                  --Name that will be shown in dialogue when selecting tasks
  tempJob.desc = "I need you to sneed %d times for me." --Description of task, will be shown to the player when deciding to take quest or not
  tempJob.icon = "propic/event/loot"          --Icon, unused?
  tempJob.tier = 1                                      --Tier, unused?
  tempJob.listenTrigger = "chatSayTest"                 --trigger word to listen for in the ix_JobTrigger hook, see sh_listeners
  tempJob.numberRec = 5                                 --integer amount of times the listenTrigger must be run through the ix_JobTrigger hook
  tempJob.reward = {{"tokarev"}}                     --table of item ids for rewarding the player with
  tempJob.rewardCount = 1                               --how many items should the player get
  tempJob.repReward = 80                                --how much reputation should be awarded for completion
  tempJob.categories = {"mutantkilleasy"}               --table of category identifiers, used for when npc gets tasks
  tempJob.OnTaskGet = function(client)                  --function to run when task is given
  tempJob.CanAcceptTask = function(client)              --function to run before task is given
  tempJob.OnTaskAbandon = function(client)              --function to run when task is abandoned
  tempJob.OnTaskComplete = function(client)             --function to run when task is handed in
  tempJob.moneyReward = {2000,4000} OR 3000             --for adding money to the player, can technically be done through itemreward as well

  ix.jobs.register(tempJob, "TestJob")                  --If item delivery quest, the final part of the quest identifier should read "_<uniqueid>" for proper operation

]]--



do

  --Scan 1 areas
  local tempJob = {}

  tempJob.name = "Scan 1 areas."
  tempJob.desc = "1 areas."
  tempJob.icon = "propic/event/area"
  tempJob.tier = 1
  tempJob.listenTrigger = "scanAreaEasyComplete"
  tempJob.numberRec = 1
  tempJob.reward = {{"kit_ammo_med"}}
  tempJob.rewardCount = 1
  tempJob.repReward = 35
  tempJob.moneyReward = { 4000, 6000 }
  tempJob.categories = {"scanarea"}
  tempJob.CanAcceptTask = function(client) 
    local char = client:GetCharacter()
    if(char)then
      local inv = char:GetInventory()
      if(inv)then
        if inv:Add("gasanalyzer", 1, { ["npoints"] = 1, ["finishedtrigger"] = "scanAreaEasyComplete", ["map"] = game.GetMap()} ) then
          ix.dialogue.notifyItemGet(client, ix.item.list["gasanalyzer"].name)
          return true
        else
          client:Notify("Not enough space in inventory! Retake the task.")
        end
      end
    end
  end
  tempJob.OnTaskComplete = function(client) 
    local char = client:GetCharacter()
    if(char)then
      local inv = char:GetInventory()
      if(inv)then
        for k,v in pairs(inv:GetItems()) do
          if v.uniqueID == "gasanalyzer" then
            -- Check that everything matches
            if ((v:GetData("npoints", -1) == 1) and (v:GetData("finishedtrigger", "error") == "scanAreaEasyComplete") and v:GetData("finished", false)) then
              v:Remove()
              ix.dialogue.notifyItemLost(client, ix.item.list["gasanalyzer"].name)
              break
            end
          end
        end
      end
    end
  end
  tempJob.OnTaskAbandon = function(client) 
    local char = client:GetCharacter()
    if(char)then
      local inv = char:GetInventory()
      if(inv)then
        for k,v in pairs(inv:GetItems()) do
          if v.uniqueID == "gasanalyzer" then
            v:Remove()
            break
          end
        end
      end
    end
  end

  ix.jobs.register(tempJob, "scanAreaEasy1")

  tempJob = nil

  --Scan 1 areas
  local tempJob = {}

  tempJob.name = "Scan 1 areas."
  tempJob.desc = "1 areas."
  tempJob.icon = "propic/event/area"
  tempJob.tier = 1
  tempJob.listenTrigger = "scanAreaEasyComplete"
  tempJob.numberRec = 1
  tempJob.reward = {{"kit_ammo_m_low"}}
  tempJob.rewardCount = 1
  tempJob.repReward = 35
  tempJob.moneyReward = { 4000, 6000 }
  tempJob.categories = {"scanarea"}
  tempJob.CanAcceptTask = function(client) 
    local char = client:GetCharacter()
    if(char)then
      local inv = char:GetInventory()
      if(inv)then
        if inv:Add("gasanalyzer", 1, { ["npoints"] = 1, ["finishedtrigger"] = "scanAreaEasyComplete", ["map"] = game.GetMap()} ) then
          ix.dialogue.notifyItemGet(client, ix.item.list["gasanalyzer"].name)
          return true
        else
          client:Notify("Not enough space in inventory! Retake the task.")
        end
      end
    end
  end
  tempJob.OnTaskComplete = function(client) 
    local char = client:GetCharacter()
    if(char)then
      local inv = char:GetInventory()
      if(inv)then
        for k,v in pairs(inv:GetItems()) do
          if v.uniqueID == "gasanalyzer" then
            -- Check that everything matches
            if ((v:GetData("npoints", -1) == 1) and (v:GetData("finishedtrigger", "error") == "scanAreaEasyComplete") and v:GetData("finished", false)) then
              v:Remove()
              ix.dialogue.notifyItemLost(client, ix.item.list["gasanalyzer"].name)
              break
            end
          end
        end
      end
    end
  end
  tempJob.OnTaskAbandon = function(client) 
    local char = client:GetCharacter()
    if(char)then
      local inv = char:GetInventory()
      if(inv)then
        for k,v in pairs(inv:GetItems()) do
          if v.uniqueID == "gasanalyzer" then
            v:Remove()
            break
          end
        end
      end
    end
  end

  ix.jobs.register(tempJob, "scanAreaEasy2")

  tempJob = nil

  --Scan 2 areas
  local tempJob = {}

  tempJob.name = "Scan 2 areas."
  tempJob.desc = "2 areas."
  tempJob.icon = "propic/event/area"
  tempJob.tier = 2
  tempJob.listenTrigger = "scanAreaMedComplete"
  tempJob.numberRec = 1
  tempJob.reward = {{"kit_ammo_rare"}}
  tempJob.rewardCount = 1
  tempJob.repReward = 50
  tempJob.moneyReward = { 7000, 9000 }
  tempJob.categories = {"scanarea"}
  tempJob.CanAcceptTask = function(client) 
    local char = client:GetCharacter()
    if(char)then
      local inv = char:GetInventory()
      if(inv)then
        if inv:Add("gasanalyzer", 1, { ["npoints"] = 2, ["finishedtrigger"] = "scanAreaMedComplete", ["map"] = game.GetMap()} ) then
          ix.dialogue.notifyItemGet(client, ix.item.list["gasanalyzer"].name)
          return true
        else
          client:Notify("Not enough space in inventory! Retake the task.")
        end
      end
    end
  end
  tempJob.OnTaskComplete = function(client) 
    local char = client:GetCharacter()
    if(char)then
      local inv = char:GetInventory()
      if(inv)then
        for k,v in pairs(inv:GetItems()) do
          if v.uniqueID == "gasanalyzer" then
            -- Check that everything matches
            if ((v:GetData("npoints", -1) == 2) and (v:GetData("finishedtrigger", "error") == "scanAreaMedComplete") and v:GetData("finished", false)) then
              v:Remove()
              ix.dialogue.notifyItemLost(client, ix.item.list["gasanalyzer"].name)
              break
            end
          end
        end
      end
    end
  end
  tempJob.OnTaskAbandon = function(client) 
    local char = client:GetCharacter()
    if(char)then
      local inv = char:GetInventory()
      if(inv)then
        for k,v in pairs(inv:GetItems()) do
          if v.uniqueID == "gasanalyzer" then
            v:Remove()
            break
          end
        end
      end
    end
  end

  ix.jobs.register(tempJob, "scanAreaMed1")

  tempJob = nil

  --Scan 2 areas
  local tempJob = {}

  tempJob.name = "Scan 2 areas."
  tempJob.desc = "2 areas."
  tempJob.icon = "propic/event/area"
  tempJob.tier = 2
  tempJob.listenTrigger = "scanAreaMedComplete"
  tempJob.numberRec = 1
  tempJob.reward = {{"kit_aid_high"}}
  tempJob.rewardCount = 1
  tempJob.repReward = 50
  tempJob.moneyReward = { 7000, 9000 }
  tempJob.categories = {"scanarea"}
  tempJob.CanAcceptTask = function(client) 
    local char = client:GetCharacter()
    if(char)then
      local inv = char:GetInventory()
      if(inv)then
        if inv:Add("gasanalyzer", 1, { ["npoints"] = 2, ["finishedtrigger"] = "scanAreaMedComplete", ["map"] = game.GetMap()} ) then
          ix.dialogue.notifyItemGet(client, ix.item.list["gasanalyzer"].name)
          return true
        else
          client:Notify("Not enough space in inventory! Retake the task.")
        end
      end
    end
  end
  tempJob.OnTaskComplete = function(client) 
    local char = client:GetCharacter()
    if(char)then
      local inv = char:GetInventory()
      if(inv)then
        for k,v in pairs(inv:GetItems()) do
          if v.uniqueID == "gasanalyzer" then
            -- Check that everything matches
            if ((v:GetData("npoints", -1) == 2) and (v:GetData("finishedtrigger", "error") == "scanAreaMedComplete") and v:GetData("finished", false)) then
              v:Remove()
              ix.dialogue.notifyItemLost(client, ix.item.list["gasanalyzer"].name)
              break
            end
          end
        end
      end
    end
  end
  tempJob.OnTaskAbandon = function(client) 
    local char = client:GetCharacter()
    if(char)then
      local inv = char:GetInventory()
      if(inv)then
        for k,v in pairs(inv:GetItems()) do
          if v.uniqueID == "gasanalyzer" then
            v:Remove()
            break
          end
        end
      end
    end
  end

  ix.jobs.register(tempJob, "scanAreaMed2")

  tempJob = nil

  --Scan 4 areas
  local tempJob = {}

  tempJob.name = "Scan 4 areas."
  tempJob.desc = "4 areas."
  tempJob.icon = "propic/event/area"
  tempJob.tier = 3
  tempJob.listenTrigger = "scanAreaHighComplete"
  tempJob.numberRec = 1
  tempJob.reward = {{"kit_mixed_high"}}
  tempJob.rewardCount = 1
  tempJob.repReward = 75
  tempJob.moneyReward = { 10000, 15000 }
  tempJob.categories = {"scanarea"}
  tempJob.CanAcceptTask = function(client) 
    local char = client:GetCharacter()
    if(char)then
      local inv = char:GetInventory()
      if(inv)then
        if inv:Add("gasanalyzer", 1, { ["npoints"] = 4, ["finishedtrigger"] = "scanAreaHighComplete", ["map"] = game.GetMap()} ) then
          ix.dialogue.notifyItemGet(client, ix.item.list["gasanalyzer"].name)
          return true
        else
          client:Notify("Not enough space in inventory! Retake the task.")
        end
      end
    end
  end
  tempJob.OnTaskComplete = function(client) 
    local char = client:GetCharacter()
    if(char)then
      local inv = char:GetInventory()
      if(inv)then
        for k,v in pairs(inv:GetItems()) do
          if v.uniqueID == "gasanalyzer" then
            -- Check that everything matches
            if ((v:GetData("npoints", -1) == 4) and (v:GetData("finishedtrigger", "error") == "scanAreaHighComplete") and v:GetData("finished", false)) then
              v:Remove()
              ix.dialogue.notifyItemLost(client, ix.item.list["gasanalyzer"].name)
              break
            end
          end
        end
      end
    end
  end
  tempJob.OnTaskAbandon = function(client) 
    local char = client:GetCharacter()
    if(char)then
      local inv = char:GetInventory()
      if(inv)then
        for k,v in pairs(inv:GetItems()) do
          if v.uniqueID == "gasanalyzer" then
            v:Remove()
            break
          end
        end
      end
    end
  end

  ix.jobs.register(tempJob, "scanAreaHigh1")

  tempJob = nil

  --Scan 4 areas
  local tempJob = {}

  tempJob.name = "Scan 4 areas."
  tempJob.desc = "4 areas."
  tempJob.icon = "propic/event/area"
  tempJob.tier = 3
  tempJob.listenTrigger = "scanAreaHighComplete"
  tempJob.numberRec = 1
  tempJob.reward = {{"kit_ammo_m_rare"}}
  tempJob.rewardCount = 1
  tempJob.repReward = 75
  tempJob.moneyReward = { 10000, 15000 }
  tempJob.categories = {"scanarea"}
  tempJob.CanAcceptTask = function(client) 
    local char = client:GetCharacter()
    if(char)then
      local inv = char:GetInventory()
      if(inv)then
        if inv:Add("gasanalyzer", 1, { ["npoints"] = 4, ["finishedtrigger"] = "scanAreaHighComplete", ["map"] = game.GetMap()} ) then
          ix.dialogue.notifyItemGet(client, ix.item.list["gasanalyzer"].name)
          return true
        else
          client:Notify("Not enough space in inventory! Retake the task.")
        end
      end
    end
  end
  tempJob.OnTaskComplete = function(client) 
    local char = client:GetCharacter()
    if(char)then
      local inv = char:GetInventory()
      if(inv)then
        for k,v in pairs(inv:GetItems()) do
          if v.uniqueID == "gasanalyzer" then
            -- Check that everything matches
            if ((v:GetData("npoints", -1) == 4) and (v:GetData("finishedtrigger", "error") == "scanAreaHighComplete") and v:GetData("finished", false)) then
              v:Remove()
              ix.dialogue.notifyItemLost(client, ix.item.list["gasanalyzer"].name)
              break
            end
          end
        end
      end
    end
  end
  tempJob.OnTaskAbandon = function(client) 
    local char = client:GetCharacter()
    if(char)then
      local inv = char:GetInventory()
      if(inv)then
        for k,v in pairs(inv:GetItems()) do
          if v.uniqueID == "gasanalyzer" then
            v:Remove()
            break
          end
        end
      end
    end
  end

  ix.jobs.register(tempJob, "scanAreaHigh2")

  tempJob = nil

  --Extract data from 2 PCs
  local tempJob = {}

  tempJob.name = "Extract data from 2 PCs."
  tempJob.desc = "2 PCs."
  tempJob.icon = "propic/event/area"
  tempJob.tier = 1
  tempJob.listenTrigger = "dataExtractEasy"
  tempJob.numberRec = 1
  tempJob.reward = {{"kit_ammo_med"}}
  tempJob.rewardCount = 1
  tempJob.repReward = 20
  tempJob.moneyReward = { 2500, 4500 }
  tempJob.categories = {"dataextract"}
  tempJob.CanAcceptTask = function(client) 
    local char = client:GetCharacter()
    if(char)then
      local inv = char:GetInventory()
      if(inv)then
        if inv:Add("dataextractor", 1, { ["ntypes"] = 2, ["finishedtrigger"] = "dataExtractEasy"} ) then
          ix.dialogue.notifyItemGet(client, ix.item.list["dataextractor"].name)
          return true
        else
          client:Notify("Not enough space in inventory! Retake the task.")
        end
      end
    end
  end
  tempJob.OnTaskComplete = function(client) 
    local char = client:GetCharacter()
    if(char)then
      local inv = char:GetInventory()
      if(inv)then
        for k,v in pairs(inv:GetItems()) do
          if v.uniqueID == "dataextractor" then
            -- Check that everything matches
            if ((v:GetData("ntypes", -1) == 2) and (v:GetData("finishedtrigger", "error") == "dataExtractEasy") and v:GetData("finished", false)) then
              v:Remove()
              ix.dialogue.notifyItemLost(client, ix.item.list["dataextractor"].name)
              break
            end
          end
        end
      end
    end
  end
  tempJob.OnTaskAbandon = function(client) 
    local char = client:GetCharacter()
    if(char)then
      local inv = char:GetInventory()
      if(inv)then
        for k,v in pairs(inv:GetItems()) do
          if v.uniqueID == "dataextractor" then
            v:Remove()
            break
          end
        end
      end
    end
  end

  ix.jobs.register(tempJob, "dataExtractEasy")

  tempJob = nil

  --Extract data from 3 PCs
  local tempJob = {}

  tempJob.name = "Extract data from 3 PCs."
  tempJob.desc = "3 PCs."
  tempJob.icon = "propic/event/area"
  tempJob.tier = 1
  tempJob.listenTrigger = "dataExtractMedium"
  tempJob.numberRec = 1
  tempJob.reward = {{"kit_aid_high"}}
  tempJob.rewardCount = 1
  tempJob.repReward = 35
  tempJob.moneyReward = { 4000, 6000 }
  tempJob.categories = {"dataextract"}
  tempJob.CanAcceptTask = function(client) 
    local char = client:GetCharacter()
    if(char)then
      local inv = char:GetInventory()
      if(inv)then
        if inv:Add("dataextractor", 1, { ["ntypes"] = 3, ["finishedtrigger"] = "dataExtractMedium"} ) then
          ix.dialogue.notifyItemGet(client, ix.item.list["dataextractor"].name)
          return true
        else
          client:Notify("Not enough space in inventory! Retake the task.")
        end
      end
    end
  end
  tempJob.OnTaskComplete = function(client) 
    local char = client:GetCharacter()
    if(char)then
      local inv = char:GetInventory()
      if(inv)then
        for k,v in pairs(inv:GetItems()) do
          if v.uniqueID == "dataextractor" then
            -- Check that everything matches
            if ((v:GetData("ntypes", -1) == 3) and (v:GetData("finishedtrigger", "error") == "dataExtractMedium") and v:GetData("finished", false)) then
              v:Remove()
              ix.dialogue.notifyItemLost(client, ix.item.list["dataextractor"].name)
              break
            end
          end
        end
      end
    end
  end
  tempJob.OnTaskAbandon = function(client) 
    local char = client:GetCharacter()
    if(char)then
      local inv = char:GetInventory()
      if(inv)then
        for k,v in pairs(inv:GetItems()) do
          if v.uniqueID == "dataextractor" then
            v:Remove()
            break
          end
        end
      end
    end
  end

  ix.jobs.register(tempJob, "dataExtractMedium")

  tempJob = nil

  --Extract data from 5 PCs
  local tempJob = {}

  tempJob.name = "Extract data from 5 PCs."
  tempJob.desc = "5 PCs."
  tempJob.icon = "propic/event/area"
  tempJob.tier = 1
  tempJob.listenTrigger = "dataExtractHard"
  tempJob.numberRec = 1
  tempJob.reward = {{"kit_aid_large"}}
  tempJob.rewardCount = 1
  tempJob.repReward = 50
  tempJob.moneyReward = { 8500, 11500 }
  tempJob.categories = {"dataextract"}
  tempJob.CanAcceptTask = function(client) 
    local char = client:GetCharacter()
    if(char)then
      local inv = char:GetInventory()
      if(inv)then 
        if inv:Add("dataextractor", 1, { ["ntypes"] = 5, ["finishedtrigger"] = "dataExtractHard"} ) then
          ix.dialogue.notifyItemGet(client, ix.item.list["dataextractor"].name)
          return true
        else
          client:Notify("Not enough space in inventory! Retake the task.")
        end
      end
    end
  end
  tempJob.OnTaskComplete = function(client) 
    local char = client:GetCharacter()
    if(char)then
      local inv = char:GetInventory()
      if(inv)then
        for k,v in pairs(inv:GetItems()) do
          if v.uniqueID == "dataextractor" then
            -- Check that everything matches
            if ((v:GetData("ntypes", -1) == 5) and (v:GetData("finishedtrigger", "error") == "dataExtractHard") and v:GetData("finished", false)) then
              v:Remove()
              ix.dialogue.notifyItemLost(client, ix.item.list["dataextractor"].name)
              break
            end
          end
        end
      end
    end
  end
  tempJob.OnTaskAbandon = function(client) 
    local char = client:GetCharacter()
    if(char)then
      local inv = char:GetInventory()
      if(inv)then
        for k,v in pairs(inv:GetItems()) do
          if v.uniqueID == "dataextractor" then
            v:Remove()
            break
          end
        end
      end
    end
  end

  ix.jobs.register(tempJob, "dataExtractHard")

  tempJob = nil



  local tempJob = {}

  tempJob.name = "Stash package."
  tempJob.desc = "Package."
  tempJob.icon = "propic/event/area"
  tempJob.tier = 1
  tempJob.listenTrigger = "stashPackageNpc"
  tempJob.numberRec = 1
  tempJob.reward = {}
  tempJob.rewardCount = 0
  tempJob.repReward = 30
  tempJob.moneyReward = { 4500, 5500 }
  tempJob.categories = {"stashpackagenpc_easy"}
  tempJob.CanAcceptTask = function(client) 
    local char = client:GetCharacter()
    if(char)then
      local inv = char:GetInventory()
      if(inv)then
        if inv:Add("stashpackage", 1, { ["finishedtrigger"] = "stashPackageNpc", ["map"] = game.GetMap()} ) then
          ix.dialogue.notifyItemGet(client, ix.item.list["stashpackage"].name)
          return true
        else
          client:Notify("Not enough space in inventory! Retake the task.")
        end
      end
    end
  end
  tempJob.OnTaskComplete = function(client) 
  end
  tempJob.OnTaskAbandon = function(client) 
    local char = client:GetCharacter()
    if(char)then
      local inv = char:GetInventory()
      if(inv)then
        for k,v in pairs(inv:GetItems()) do
          if v.uniqueID == "stashpackage" then
            v:Remove()
            break
          end
        end
      end
    end
  end

  ix.jobs.register(tempJob, "stashPackageNpc_easy")

  tempJob = nil


  local tempJob = {}

  tempJob.name = "Stash heavy package."
  tempJob.desc = "Package."
  tempJob.icon = "propic/event/area"
  tempJob.tier = 1
  tempJob.listenTrigger = "stashPackageNpc_heavy"
  tempJob.numberRec = 1
  tempJob.reward = {}
  tempJob.rewardCount = 0
  tempJob.repReward = 40
  tempJob.moneyReward = { 11500, 12500 }
  tempJob.categories = {"stashpackagenpc_medium"}
  tempJob.CanAcceptTask = function(client) 
    local char = client:GetCharacter()
    if(char)then
      local inv = char:GetInventory()
      if(inv)then
        if inv:Add("stashpackage_heavy", 1, { ["finishedtrigger"] = "stashPackageNpc_heavy", ["map"] = game.GetMap()} ) then
          ix.dialogue.notifyItemGet(client, ix.item.list["stashpackage_heavy"].name)
          return true
        else
          client:Notify("Not enough space in inventory! Retake the task.")          
        end
      end
    end
  end
  tempJob.OnTaskComplete = function(client) 
  end
  tempJob.OnTaskAbandon = function(client) 
    local char = client:GetCharacter()
    if(char)then
      local inv = char:GetInventory()
      if(inv)then
        for k,v in pairs(inv:GetItems()) do
          if v.uniqueID == "stashpackage_heavy" then
            v:Remove()
            break
          end
        end
      end
    end
  end

  ix.jobs.register(tempJob, "stashPackageNpc_medium")

  tempJob = nil



  local tempJob = {}

  tempJob.name = "Stash very heavy package."
  tempJob.desc = "Package."
  tempJob.icon = "propic/event/area"
  tempJob.tier = 1
  tempJob.listenTrigger = "stashPackageNpc_vheavy"
  tempJob.numberRec = 1
  tempJob.reward = {}
  tempJob.rewardCount = 0
  tempJob.repReward = 50
  tempJob.moneyReward = { 18500, 19500 }
  tempJob.categories = {"stashpackagenpc_hard"}
  tempJob.CanAcceptTask = function(client) 
    local char = client:GetCharacter()
    if(char)then
      local inv = char:GetInventory()
      if(inv)then
        if inv:Add("stashpackage_veryheavy", 1, { ["finishedtrigger"] = "stashPackageNpc_vheavy", ["map"] = game.GetMap()} ) then
          ix.dialogue.notifyItemGet(client, ix.item.list["stashpackage_veryheavy"].name)
          return true
        else
          client:Notify("Not enough space in inventory! Retake the task.")
        end
      end
    end
  end
  tempJob.OnTaskComplete = function(client) 
  end
  tempJob.OnTaskAbandon = function(client) 
    local char = client:GetCharacter()
    if(char)then
      local inv = char:GetInventory()
      if(inv)then
        for k,v in pairs(inv:GetItems()) do
          if v.uniqueID == "stashpackage_veryheavy" then
            v:Remove()
            break
          end
        end
      end
    end
  end

  ix.jobs.register(tempJob, "stashPackageNpc_hard")

  tempJob = nil

end

