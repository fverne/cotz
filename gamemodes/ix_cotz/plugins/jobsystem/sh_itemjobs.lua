--[[
  --TestJob
  local tempJob = {}

  tempJob.name = "Hand over Say sneed %d times."                  --Name that will be shown in dialogue when selecting tasks
  tempJob.desc = "I need you to sneed %d times for me." --Description of task, will be shown to the player when deciding to take quest or not
  tempJob.icon = "propic/event/loot"          --Icon, unused?
  tempJob.tier = 1                                      --Tier, unused?
  tempJob.listenTrigger = "chatSayTest"                 --trigger word to listen for in the ix_JobTrigger hook, see sh_listeners
  tempJob.numberRec = 5                                 --integer amount of times the listenTrigger must be run through the ix_JobTrigger hook
  tempJob.reward = {{"tokarev"}}                     --table of item ids for rewarding the player with
  tempJob.rewardCount = 1                               --how many items should the player get
  tempJob.repReward = 80                                --how much reputation should be awarded for completion
  tempJob.categories = {"mutantkilleasy"}               --table of category identifiers, used for when npc gets tasks
  tempJob.moneyReward = {2000,4000} OR 3000             --for adding money to the player, can technically be done through itemreward as well

  ix.jobs.register(tempJob, "TestJob")                  --If item delivery quest, the final part of the quest identifier should read "_<uniqueid>" for proper operation

]]--



do
------------------------------------------------
------------- ITEM RETRIEVAL - MEAT ------------
------------------------------------------------

  local tempJob = {}

  tempJob.name = "Hand over %d pieces of blind dog meat."
  tempJob.desc = "%d pieces of blind dog meat."
  tempJob.icon = "propic/event/loot"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_meat_blinddog"
  tempJob.numberRec = 4
  tempJob.reward = {{"762x25", { ["quantity"] = 25 }}, {"22lr", { ["quantity"] = 35 }}, {"9x18", { ["quantity"] = 25 }}, {"9x19", { ["quantity"] = 25 }}, {"45acp", { ["quantity"] = 25 }}}
  tempJob.rewardCount = 1
  tempJob.repReward = 5
  tempJob.moneyReward = {175, 325}
  tempJob.categories = {"mutantmeateasy"}

  ix.jobs.register(tempJob, "ItemJob1_meat_blinddog")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "Hand over %d pieces of blind dog meat."
  tempJob.desc = "%d pieces of blind dog meat."
  tempJob.icon = "propic/event/loot"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_meat_blinddog"
  tempJob.numberRec = 8
  tempJob.reward = {{"762x25"}, {"22lr"}, {"9x18"}, {"9x19"}, {"45acp"}}
  tempJob.rewardCount = 1
  tempJob.repReward = 10
  tempJob.moneyReward = {275, 425}
  tempJob.categories = {"mutantmeateasy"}

  ix.jobs.register(tempJob, "ItemJob2_meat_blinddog")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "Hand over %d pieces of bloodsucker meat."
  tempJob.desc = "%d pieces of bloodsucker meat."
  tempJob.icon = "propic/event/loot"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_meat_bloodsucker"
  tempJob.numberRec = 2
  tempJob.reward = {{"762x25"}, {"22lr"}, {"9x18"}, {"9x19"}, {"45acp"}}
  tempJob.rewardCount = 1
  tempJob.repReward = 35
  tempJob.moneyReward = {400, 500}
  tempJob.categories = {"mutantmeatmedium"}

  ix.jobs.register(tempJob, "ItemJob1_meat_bloodsucker")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "Hand over %d pieces of bloodsucker meat."
  tempJob.desc = "%d pieces of bloodsucker meat."
  tempJob.icon = "propic/event/loot"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_meat_bloodsucker"
  tempJob.numberRec = 4
  tempJob.reward = {{"762x25"}, {"22lr"}, {"9x18"}, {"9x19"}, {"45acp"}}
  tempJob.rewardCount = 2
  tempJob.repReward = 55
  tempJob.moneyReward = {800, 950}
  tempJob.categories = {"mutantmeatmedium"}

  ix.jobs.register(tempJob, "ItemJob2_meat_bloodsucker")

  tempJob = nil


  local tempJob = {}

  tempJob.name = "Hand over %d pieces of boar meat."
  tempJob.desc = "%d pieces of boar meat."
  tempJob.icon = "propic/event/loot"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_meat_boar"
  tempJob.numberRec = 2
  tempJob.reward = {{"762x25", { ["quantity"] = 25 }}, {"22lr", { ["quantity"] = 35 }}, {"9x18", { ["quantity"] = 25 }}, {"9x19", { ["quantity"] = 25 }}, {"45acp", { ["quantity"] = 25 }}}
  tempJob.rewardCount = 1
  tempJob.repReward = 5
  tempJob.moneyReward = {175, 275}
  tempJob.categories = {"mutantmeateasy"}

  ix.jobs.register(tempJob, "ItemJob1_meat_boar")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "Hand over %d pieces of boar meat."
  tempJob.desc = "%d pieces of boar meat."
  tempJob.icon = "propic/event/loot"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_meat_boar"
  tempJob.numberRec = 5
  tempJob.reward = {{"762x25"}, {"22lr"}, {"9x18"}, {"9x19"}, {"45acp"}}
  tempJob.rewardCount = 1
  tempJob.repReward = 15
  tempJob.moneyReward = {325, 425}
  tempJob.categories = {"mutantmeateasy"}

  ix.jobs.register(tempJob, "ItemJob2_meat_boar")

  tempJob = nil

--[[
  local tempJob = {}

  tempJob.name = "Hand over %d pieces of burer meat."
  tempJob.desc = "%d pieces of burer meat."
  tempJob.icon = "propic/event/loot"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_meat_burer"
  tempJob.numberRec = 2
  tempJob.reward = {{"tokarev"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 15
  tempJob.categories = {"mutantmeatmedium"}

  ix.jobs.register(tempJob, "ItemJob1_meat_burer")

  tempJob = nil
]]--

  local tempJob = {}

  tempJob.name = "Hand over %d pieces of cat meat."
  tempJob.desc = "%d pieces of cat meat."
  tempJob.icon = "propic/event/loot"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_meat_cat"
  tempJob.numberRec = 2
  tempJob.reward = {{"762x25", { ["quantity"] = 25 }}, {"22lr", { ["quantity"] = 35 }}, {"9x18", { ["quantity"] = 25 }}, {"9x19", { ["quantity"] = 25 }}, {"45acp", { ["quantity"] = 25 }}}
  tempJob.rewardCount = 2
  tempJob.repReward = 9
  tempJob.moneyReward = {450, 550}
  tempJob.categories = {"mutantmeateasy"}

  ix.jobs.register(tempJob, "ItemJob1_meat_cat")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "Hand over %d pieces of cat meat."
  tempJob.desc = "%d pieces of cat meat."
  tempJob.icon = "propic/event/loot"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_meat_cat"
  tempJob.numberRec = 4
  tempJob.reward = {{"762x25", { ["quantity"] = 25 }}, {"22lr", { ["quantity"] = 35 }}, {"9x18", { ["quantity"] = 25 }}, {"9x19", { ["quantity"] = 25 }}, {"45acp", { ["quantity"] = 25 }}}
  tempJob.rewardCount = 3
  tempJob.repReward = 20
  tempJob.moneyReward = {650, 800}
  tempJob.categories = {"mutantmeateasy"}

  ix.jobs.register(tempJob, "ItemJob2_meat_cat")

  tempJob = nil
    --needs chimera

  local tempJob = {}

  tempJob.name = "Hand over %d pieces of flesh meat."
  tempJob.desc = "%d pieces of flesh meat."
  tempJob.icon = "propic/event/loot"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_meat_flesh"
  tempJob.numberRec = 3
  tempJob.reward = {{"762x25", { ["quantity"] = 25 }}, {"22lr", { ["quantity"] = 35 }}, {"9x18", { ["quantity"] = 25 }}, {"9x19", { ["quantity"] = 25 }}, {"45acp", { ["quantity"] = 25 }}}
  tempJob.rewardCount = 1
  tempJob.repReward = 6
  tempJob.moneyReward = {75, 200}
  tempJob.categories = {"mutantmeateasy"}

  ix.jobs.register(tempJob, "ItemJob1_meat_flesh")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "Hand over %d pieces of flesh meat."
  tempJob.desc = "%d pieces of flesh meat."
  tempJob.icon = "propic/event/loot"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_meat_flesh"
  tempJob.numberRec = 6
  tempJob.reward = {{"762x25", { ["quantity"] = 25 }}, {"22lr", { ["quantity"] = 35 }}, {"9x18", { ["quantity"] = 25 }}, {"9x19", { ["quantity"] = 25 }}, {"45acp", { ["quantity"] = 25 }}}
  tempJob.rewardCount = 1
  tempJob.repReward = 14
  tempJob.moneyReward = {175, 250}
  tempJob.categories = {"mutantmeateasy"}

  ix.jobs.register(tempJob, "ItemJob2_meat_flesh")

  tempJob = nil


-- Currently commented out as hellhound meat is unobtainable at the moment
--[[
  local tempJob = {}

  tempJob.name = "Hand over %d pieces of hellhound meat."
  tempJob.desc = "%d pieces of hellhound meat."
  tempJob.icon = "propic/event/loot"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_meat_hellhound"
  tempJob.numberRec = 1
  tempJob.reward = {{"m1911"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 15
  tempJob.categories = {"mutantmeatmedium"}

  ix.jobs.register(tempJob, "ItemJob1_meat_hellhound")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "Hand over %d pieces of hellhound meat."
  tempJob.desc = "%d pieces of hellhound meat."
  tempJob.icon = "propic/event/loot"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_meat_hellhound"
  tempJob.numberRec = 3
  tempJob.reward = {{"m1911"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 15
  tempJob.categories = {"mutantmeatmedium"}

  ix.jobs.register(tempJob, "ItemJob2_meat_hellhound")

  tempJob = nil
]]

  local tempJob = {}

  tempJob.name = "Hand over %d pieces of decomposing meat."
  tempJob.desc = "%d pieces of decomposing meat."
  tempJob.icon = "propic/event/loot"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_meat_human"
  tempJob.numberRec = 4
  tempJob.reward = {{"762x25", { ["quantity"] = 25 }}, {"22lr", { ["quantity"] = 35 }}, {"9x18", { ["quantity"] = 25 }}, {"9x19", { ["quantity"] = 25 }}, {"45acp", { ["quantity"] = 25 }}}
  tempJob.rewardCount = 2
  tempJob.repReward = 3
  tempJob.moneyReward = {250, 500}
  tempJob.categories = {"mutantmeatmedium"}

  ix.jobs.register(tempJob, "ItemJob1_meat_human")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "Hand over %d pieces of decomposing meat."
  tempJob.desc = "%d pieces of decomposing meat."
  tempJob.icon = "propic/event/loot"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_meat_human"
  tempJob.numberRec = 8
  tempJob.reward = {{"762x25", { ["quantity"] = 25 }}, {"22lr", { ["quantity"] = 35 }}, {"9x18", { ["quantity"] = 25 }}, {"9x19", { ["quantity"] = 25 }}, {"45acp", { ["quantity"] = 25 }}}
  tempJob.rewardCount = 4
  tempJob.repReward = 7
  tempJob.moneyReward = {400, 600}
  tempJob.categories = {"mutantmeatmedium"}

  ix.jobs.register(tempJob, "ItemJob2_meat_human")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "Hand over %d pieces of pseudodog meat."
  tempJob.desc = "%d pieces of pseudodog meat."
  tempJob.icon = "propic/event/loot"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_meat_pseudodog"
  tempJob.numberRec = 2
  tempJob.reward = {{"toz34short", {["durability"] = 50}}, {"toz34", {["durability"] = 50}}}
  tempJob.rewardCount = 1
  tempJob.repReward = 4
  tempJob.moneyReward = {400, 600}
  tempJob.categories = {"mutantmeateasy"}

  ix.jobs.register(tempJob, "ItemJob1_meat_pseudodog")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "Hand over %d pieces of pseudodog meat."
  tempJob.desc = "%d pieces of pseudodog meat."
  tempJob.icon = "propic/event/loot"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_meat_pseudodog"
  tempJob.numberRec = 5
  tempJob.reward = {{"toz34short", {["durability"] = 50}}, {"toz34", {["durability"] = 50}}}
  tempJob.rewardCount = 1
  tempJob.repReward = 10
  tempJob.moneyReward = {500, 650}
  tempJob.categories = {"mutantmeateasy"}

  ix.jobs.register(tempJob, "ItemJob2_meat_pseudodog")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "Hand over %d pieces of sprig meat."
  tempJob.desc = "%d pieces of sprig meat."
  tempJob.icon = "propic/event/loot"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_meat_sprig"
  tempJob.numberRec = 1
  tempJob.reward = {{"kit_mixed_low"}}
  tempJob.rewardCount = 1
  tempJob.repReward = 10
  tempJob.moneyReward = {375, 500}
  tempJob.categories = {"mutantmeatmedium"}

  ix.jobs.register(tempJob, "ItemJob1_meat_sprig")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "Hand over %d pieces of sprig meat."
  tempJob.desc = "%d pieces of sprig meat."
  tempJob.icon = "propic/event/loot"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_meat_sprig"
  tempJob.numberRec = 3
  tempJob.reward = {{"kit_mixed_med"}}
  tempJob.rewardCount = 1
  tempJob.repReward = 22
  tempJob.moneyReward = {450, 600}
  tempJob.categories = {"mutantmeatmedium"}

  ix.jobs.register(tempJob, "ItemJob2_meat_sprig")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "Hand over %d snork hands."
  tempJob.desc = "%d snork hands."
  tempJob.icon = "propic/event/loot"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_meat_snork"
  tempJob.numberRec = 2
  tempJob.reward = {{"kit_aid_low"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 11
  tempJob.moneyReward = {150, 300}
  tempJob.categories = {"mutantmeatmedium"}

  ix.jobs.register(tempJob, "ItemJob1_meat_snork")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "Hand over %d snork hands."
  tempJob.desc = "%d snork hands."
  tempJob.icon = "propic/event/loot"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_meat_snork"
  tempJob.numberRec = 3
  tempJob.reward = {{"kit_mixed_m_low"}}
  tempJob.rewardCount = 1
  tempJob.repReward = 20
  tempJob.moneyReward = {150, 300}
  tempJob.categories = {"mutantmeatmedium"}

  ix.jobs.register(tempJob, "ItemJob2_meat_snork")

  tempJob = nil


  local tempJob = {}

  tempJob.name = "Hand over %d pieces of tushkano meat."
  tempJob.desc = "%d pieces of tushkano meat."
  tempJob.icon = "propic/event/loot"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_meat_tushkano"
  tempJob.numberRec = 4
  tempJob.rewardCount = 0
  tempJob.repReward = 1
  tempJob.moneyReward = {50, 150}
  tempJob.categories = {"mutantmeateasy"}

  ix.jobs.register(tempJob, "ItemJob1_meat_tushkano")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "Hand over %d pieces of tushkano meat."
  tempJob.desc = "%d pieces of tushkano meat."
  tempJob.icon = "propic/event/loot"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_meat_tushkano"
  tempJob.numberRec = 8
  tempJob.rewardCount = 0
  tempJob.repReward = 7
  tempJob.moneyReward = {150, 300}
  tempJob.categories = {"mutantmeateasy"}

  ix.jobs.register(tempJob, "ItemJob2_meat_tushkano")

  tempJob = nil


-----------------------------------------------------
-----------------------------------------------------
------------- ITEM RETRIEVAL - ELECTRONICS ----------
-----------------------------------------------------
-----------------------------------------------------

-- mixed kits

  local tempJob = {}

  tempJob.name = "Hand over %d SSD."
  tempJob.desc = "%d SSD."
  tempJob.icon = "propic/event/loot"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_value_pcpart_ssd"
  tempJob.numberRec = 1
  tempJob.reward = {{"kit_mixed_low"}}
  tempJob.rewardCount = 1
  tempJob.repReward = 9
  tempJob.moneyReward = {800, 1800}
  tempJob.categories = {"electronics", "information"}

  ix.jobs.register(tempJob, "ItemJob1_value_pcpart_ssd")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "Hand over %d SSDs."
  tempJob.desc = "%d SSDs."
  tempJob.icon = "propic/event/loot"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_value_pcpart_ssd"
  tempJob.numberRec = 2
  tempJob.reward = {{"kit_mixed_med"}}
  tempJob.rewardCount = 1
  tempJob.repReward = 21
  tempJob.moneyReward = {1600, 2800}
  tempJob.categories = {"electronics", "information"}

  ix.jobs.register(tempJob, "ItemJob2_value_pcpart_ssd")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "Hand over %d HDD."
  tempJob.desc = "%d HDD."
  tempJob.icon = "propic/event/loot"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_value_pcpart_hdd"
  tempJob.numberRec = 1
  tempJob.reward = {{"kit_mixed_low"}}
  tempJob.rewardCount = 1
  tempJob.repReward = 6
  tempJob.moneyReward = {600, 1200}
  tempJob.categories = {"electronics", "information"}

  ix.jobs.register(tempJob, "ItemJob1_value_pcpart_hdd")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "Hand over %d HDDs."
  tempJob.desc = "%d HDDs."
  tempJob.icon = "propic/event/loot"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_value_pcpart_hdd"
  tempJob.numberRec = 2
  tempJob.reward = {{"kit_mixed_low"}}
  tempJob.rewardCount = 2
  tempJob.repReward = 17
  tempJob.moneyReward = {800, 1400}
  tempJob.categories = {"electronics", "information"}

  ix.jobs.register(tempJob, "ItemJob2_value_pcpart_hdd")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "Hand over %d PSU."
  tempJob.desc = "%d PSU."
  tempJob.icon = "propic/event/loot"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_value_pcpart_psu"
  tempJob.numberRec = 1
  tempJob.reward = {{"kit_mixed_low"}}
  tempJob.rewardCount = 1
  tempJob.repReward = 10
  tempJob.moneyReward = {400, 900}
  tempJob.categories = {"electronics"}

  ix.jobs.register(tempJob, "ItemJob1_value_pcpart_psu")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "Hand over %d PSUs."
  tempJob.desc = "%d PSUs."
  tempJob.icon = "propic/event/loot"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_value_pcpart_psu"
  tempJob.numberRec = 2
  tempJob.reward = {{"kit_mixed_low"}}
  tempJob.rewardCount = 1
  tempJob.repReward = 23
  tempJob.moneyReward = {900, 1400}
  tempJob.categories = {"electronics"}

  ix.jobs.register(tempJob, "ItemJob2_value_pcpart_psu")

  tempJob = nil

--[[
  local tempJob = {}

  tempJob.name = "Hand over %d LCD Panel."
  tempJob.desc = "%d LCD Panel."
  tempJob.icon = "propic/event/loot"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_value_pcpart_lcd"
  tempJob.numberRec = 1
  tempJob.reward = {{"kit_mixed_low"}}
  tempJob.rewardCount = 1
  tempJob.repReward = 10
  tempJob.moneyReward = {900, 1100}
  tempJob.categories = {"electronics"}

  ix.jobs.register(tempJob, "ItemJob1_value_pcpart_lcd")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "Hand over %d LCD Panels."
  tempJob.desc = "%d LCD Panels."
  tempJob.icon = "propic/event/loot"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_value_pcpart_lcd"
  tempJob.numberRec = 2
  tempJob.reward = {{"kit_mixed_med"}}
  tempJob.rewardCount = 1
  tempJob.repReward = 21
  tempJob.moneyReward = {1300, 1400}
  tempJob.categories = {"electronics"}

  ix.jobs.register(tempJob, "ItemJob2_value_pcpart_lcd")

  tempJob = nil
  ]]--

  local tempJob = {}

  tempJob.name = "Hand over %d GPU."
  tempJob.desc = "%d GPU."
  tempJob.icon = "propic/event/loot"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_value_pcpart_gpu"
  tempJob.numberRec = 1
  tempJob.reward = {{"kit_mixed_high"}}
  tempJob.rewardCount = 1
  tempJob.repReward = 21
  tempJob.moneyReward = {2300, 2400}
  tempJob.categories = {"electronics"}

  ix.jobs.register(tempJob, "ItemJob1_value_pcpart_gpu")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "Hand over %d GPUs."
  tempJob.desc = "%d GPUs."
  tempJob.icon = "propic/event/loot"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_value_pcpart_gpu"
  tempJob.numberRec = 2
  tempJob.reward = {{"kit_mixed_high"}}
  tempJob.rewardCount = 1
  tempJob.repReward = 45
  tempJob.moneyReward = {5300, 6400}
  tempJob.categories = {"electronics"}

  ix.jobs.register(tempJob, "ItemJob2_value_pcpart_gpu")

  tempJob = nil


  local tempJob = {}

  tempJob.name = "Hand over %d FPGAs."
  tempJob.desc = "%d FPGAs."
  tempJob.icon = "propic/event/loot"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_value_pcpart_fpga"
  tempJob.numberRec = 1
  tempJob.reward = {{"kit_mixed_med"}}
  tempJob.rewardCount = 1
  tempJob.repReward = 12
  tempJob.moneyReward = {900, 2100}
  tempJob.categories = {"electronics"}

  ix.jobs.register(tempJob, "ItemJob1_value_pcpart_fpga")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "Hand over %d FPGAs."
  tempJob.desc = "%d FPGAs."
  tempJob.icon = "propic/event/loot"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_value_pcpart_fpga"
  tempJob.numberRec = 2
  tempJob.reward = {{"kit_mixed_med"}, {"kit_mixed_med"}, 0}
  tempJob.rewardCount = 2
  tempJob.repReward = 29
  tempJob.moneyReward = {900, 2100}
  tempJob.categories = {"electronics"}

  ix.jobs.register(tempJob, "ItemJob2_value_pcpart_fpga")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "Hand over %d Powerbank."
  tempJob.desc = "%d Powerbank."
  tempJob.icon = "propic/event/loot"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_value_powerbank"
  tempJob.numberRec = 1
  tempJob.reward = {{"kit_mixed_low"}}
  tempJob.rewardCount = 1
  tempJob.repReward = 10
  tempJob.moneyReward = {500, 800}
  tempJob.categories = {"electronics"}

  ix.jobs.register(tempJob, "ItemJob1_value_powerbank")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "Hand over %d Powerbanks."
  tempJob.desc = "%d Powerbanks."
  tempJob.icon = "propic/event/loot"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_value_powerbank"
  tempJob.numberRec = 2
  tempJob.reward = {{"kit_mixed_low"}}
  tempJob.rewardCount = 1
  tempJob.repReward = 22
  tempJob.moneyReward = {1500, 1800}
  tempJob.categories = {"electronics"}

  ix.jobs.register(tempJob, "ItemJob2_value_powerbank")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "Hand over %d Wireless Transmitter Module."
  tempJob.desc = "%d Wireless Transmitter Module."
  tempJob.icon = "propic/event/loot"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_value_wirelesstrans"
  tempJob.numberRec = 1
  tempJob.reward = {{"kit_mixed_low"}}
  tempJob.rewardCount = 1
  tempJob.repReward = 30
  tempJob.moneyReward = {2000, 3500}
  tempJob.categories = {"electronics"}

  ix.jobs.register(tempJob, "ItemJob1_value_wirelesstrans")

  tempJob = nil


  local tempJob = {}

  tempJob.name = "Hand over %d Wireless Transmitter Modules."
  tempJob.desc = "%d Wireless Transmitter Modules."
  tempJob.icon = "propic/event/loot"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_value_wirelesstrans"
  tempJob.numberRec = 2
  tempJob.reward = {{"kit_mixed_med"}}
  tempJob.rewardCount = 1
  tempJob.repReward = 45
  tempJob.moneyReward = {5000, 8500}
  tempJob.categories = {"electronics"}

  ix.jobs.register(tempJob, "ItemJob2_value_wirelesstrans")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "Hand over %d Capacitors."
  tempJob.desc = "%d Capacitors."
  tempJob.icon = "propic/event/loot"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_value_capacitors"
  tempJob.numberRec = 2
  tempJob.reward = {{"kit_mixed_low"}}
  tempJob.rewardCount = 1
  tempJob.repReward = 5
  tempJob.moneyReward = {250, 750}
  tempJob.categories = {"electronics"}

  ix.jobs.register(tempJob, "ItemJob1_value_capacitors")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "Hand over %d Capacitors."
  tempJob.desc = "%d Capacitors."
  tempJob.icon = "propic/event/loot"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_value_capacitors"
  tempJob.numberRec = 10
  tempJob.reward = {{"kit_mixed_low"}}
  tempJob.rewardCount = 1
  tempJob.repReward = 5
  tempJob.moneyReward = {2000, 2300}
  tempJob.categories = {"electronics"}

  ix.jobs.register(tempJob, "ItemJob2_value_capacitors")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "Hand over %d Electric Tape."
  tempJob.desc = "%d Electric Tape."
  tempJob.icon = "propic/event/loot"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_value_tape_electric"
  tempJob.numberRec = 1
  tempJob.reward = {{"kit_mixed_low"}}
  tempJob.rewardCount = 1
  tempJob.repReward = 1
  tempJob.moneyReward = {250, 750}
  tempJob.categories = {"electronics"}

  ix.jobs.register(tempJob, "ItemJob1_value_tape_electric")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "Hand over %d Electric Tapes."
  tempJob.desc = "%d Electric Tapes."
  tempJob.icon = "propic/event/loot"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_value_tape_electric"
  tempJob.numberRec = 2
  tempJob.reward = {{"kit_mixed_low"}}
  tempJob.rewardCount = 1
  tempJob.repReward = 6
  tempJob.moneyReward = {500, 1000}
  tempJob.categories = {"electronics"}

  ix.jobs.register(tempJob, "ItemJob2_value_tape_electric")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "Hand over %d Electrical Wire."
  tempJob.desc = "%d Electrical Wire."
  tempJob.icon = "propic/event/loot"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_value_wire_light"
  tempJob.numberRec = 1
  tempJob.reward = {{"kit_mixed_low"}}
  tempJob.rewardCount = 1
  tempJob.repReward = 1
  tempJob.moneyReward = {350, 460}
  tempJob.categories = {"electronics"}

  ix.jobs.register(tempJob, "ItemJob1_value_wire_light")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "Hand over %d Electrical Wires."
  tempJob.desc = "%d Electrical Wires."
  tempJob.icon = "propic/event/loot"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_value_wire_light"
  tempJob.numberRec = 2
  tempJob.reward = {{"kit_mixed_low"}}
  tempJob.rewardCount = 1
  tempJob.repReward = 3
  tempJob.moneyReward = {750, 960}
  tempJob.categories = {"electronics"}

  ix.jobs.register(tempJob, "ItemJob2_value_wire_light")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "Hand over %d 1.5 Volt Batteries."
  tempJob.desc = "%d 1.5 Volt Batteries."
  tempJob.icon = "propic/event/loot"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_value_battery"
  tempJob.numberRec = 3
  tempJob.reward = {{"kit_mixed_low"}}
  tempJob.rewardCount = 1
  tempJob.repReward = 2
  tempJob.moneyReward = {400, 600}
  tempJob.categories = {"electronics"}

  ix.jobs.register(tempJob, "ItemJob1_value_battery")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "Hand over %d 1.5 Volt Batteries."
  tempJob.desc = "%d 1.5 Volt Batteries."
  tempJob.icon = "propic/event/loot"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_value_battery"
  tempJob.numberRec = 20
  tempJob.reward = {{"kit_mixed_high"}}
  tempJob.rewardCount = 1
  tempJob.repReward = 12
  tempJob.moneyReward = {2000, 3500}
  tempJob.categories = {"electronics"}

  ix.jobs.register(tempJob, "ItemJob2_value_battery")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "Hand over %d 9 Volt Batteries."
  tempJob.desc = "%d 9 Volt Batteries."
  tempJob.icon = "propic/event/loot"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_value_9vbattery"
  tempJob.numberRec = 2
  tempJob.reward = {{"kit_mixed_low"}}
  tempJob.rewardCount = 1
  tempJob.repReward = 3
  tempJob.moneyReward = {500, 700}
  tempJob.categories = {"electronics"}

  ix.jobs.register(tempJob, "ItemJob1_value_9vbattery")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "Hand over %d 9 Volt Batteries."
  tempJob.desc = "%d 9 Volt Batteries."
  tempJob.icon = "propic/event/loot"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_value_9vbattery"
  tempJob.numberRec = 4
  tempJob.reward = {{"kit_mixed_low"}}
  tempJob.rewardCount = 1
  tempJob.repReward = 8
  tempJob.moneyReward = {960, 1200}
  tempJob.categories = {"electronics"}

  ix.jobs.register(tempJob, "ItemJob2_value_9vbattery")

  tempJob = nil

-----------------------------------------------------
-----------------------------------------------------
-------- ITEM RETRIEVAL - GUNS/REPAIRING  -----------
-----------------------------------------------------
-----------------------------------------------------

  local tempJob = {}

  tempJob.name = "Hand over %d Household Glue."
  tempJob.desc = "%d Household Glue."
  tempJob.icon = "propic/event/loot"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_value_glue_1"
  tempJob.numberRec = 1
  tempJob.reward = {{"kit_mixed_low"}}
  tempJob.rewardCount = 1
  tempJob.repReward = 2
  tempJob.moneyReward = {330, 480}
  tempJob.categories = {"repair"}

  ix.jobs.register(tempJob, "ItemJob1_value_glue_1")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "Hand over %d Household Glue."
  tempJob.desc = "%d Household Glue."
  tempJob.icon = "propic/event/loot"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_value_glue_1"
  tempJob.numberRec = 2
  tempJob.reward = {{"kit_mixed_low"}, {"kit_ammo_low"}}
  tempJob.rewardCount = 1
  tempJob.repReward = 5
  tempJob.moneyReward = {500, 900}
  tempJob.categories = {"repair"}

  ix.jobs.register(tempJob, "ItemJob2_value_glue_1")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "Hand over %d Superglue."
  tempJob.desc = "%d Superglue."
  tempJob.icon = "propic/event/loot"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_value_glue_2"
  tempJob.numberRec = 1
  tempJob.reward = {{"kit_ammo_low"}}
  tempJob.rewardCount = 1
  tempJob.repReward = 3
  tempJob.moneyReward = {350, 600}
  tempJob.categories = {"repair"}

  ix.jobs.register(tempJob, "ItemJob1_value_glue_2")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "Hand over %d Superglue."
  tempJob.desc = "%d Superglue."
  tempJob.icon = "propic/event/loot"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_value_glue_2"
  tempJob.numberRec = 2
  tempJob.reward = {{"kit_mixed_low"}, {"kit_ammo_low"}}
  tempJob.rewardCount = 1
  tempJob.repReward = 12
  tempJob.moneyReward = {500, 960}
  tempJob.categories = {"repair"}

  ix.jobs.register(tempJob, "ItemJob2_value_glue_2")

  tempJob = nil


  local tempJob = {}

  tempJob.name = "Hand over %d Texture Glue."
  tempJob.desc = "%d Texture Glue."
  tempJob.icon = "propic/event/loot"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_value_glue_3"
  tempJob.numberRec = 1
  tempJob.reward = {{"kit_mixed_low"}}
  tempJob.rewardCount = 1
  tempJob.repReward = 5
  tempJob.moneyReward = {360, 750}
  tempJob.categories = {"repair"}

  ix.jobs.register(tempJob, "ItemJob1_value_glue_3")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "Hand over %d Texture Glue."
  tempJob.desc = "%d Texture Glue."
  tempJob.icon = "propic/event/loot"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_value_glue_3"
  tempJob.numberRec = 2
  tempJob.reward = {{"kit_mixed_low"}}
  tempJob.rewardCount = 1
  tempJob.repReward = 9
  tempJob.moneyReward = {400, 780}
  tempJob.categories = {"repair"}

  ix.jobs.register(tempJob, "ItemJob2_value_glue_3")

  tempJob = nil


  local tempJob = {}

  tempJob.name = "Hand over %d Universal Glue."
  tempJob.desc = "%d Universal Glue."
  tempJob.icon = "propic/event/loot"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_value_glue_4"
  tempJob.numberRec = 1
  tempJob.reward = {{"kit_aid_low"}, {"kit_ammo_low"}}
  tempJob.rewardCount = 1
  tempJob.repReward = 7
  tempJob.moneyReward = {300, 450}
  tempJob.categories = {"repair"}

  ix.jobs.register(tempJob, "ItemJob1_value_glue_4")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "Hand over %d Universal Glue."
  tempJob.desc = "%d Universal Glue."
  tempJob.icon = "propic/event/loot"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_value_glue_4"
  tempJob.numberRec = 2
  tempJob.reward = {{"kit_aid_low"}, {"kit_ammo_low"}, 0}
  tempJob.rewardCount = 2
  tempJob.repReward = 12
  tempJob.moneyReward = {300, 450}
  tempJob.categories = {"repair"}

  ix.jobs.register(tempJob, "ItemJob2_value_glue_4")

  tempJob = nil


  local tempJob = {}

  tempJob.name = "Hand over %d Military-Grade Weapon Cleaner."
  tempJob.desc = "%d Military-Grade Weapon Cleaner."
  tempJob.icon = "propic/event/loot"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_value_guncleaner"
  tempJob.numberRec = 1
  tempJob.reward = {{"kit_aid_low"}, {"kit_ammo_low"}}
  tempJob.rewardCount = 1
  tempJob.repReward = 10
  tempJob.moneyReward = {300, 450}
  tempJob.categories = {"repair"}

  ix.jobs.register(tempJob, "ItemJob1_value_guncleaner")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "Hand over %d Military-Grade Weapon Cleaner."
  tempJob.desc = "%d Military-Grade Weapon Cleaner."
  tempJob.icon = "propic/event/loot"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_value_guncleaner"
  tempJob.numberRec = 2
  tempJob.reward = {{"kit_aid_high"}, {"kit_ammo_low"}}
  tempJob.rewardCount = 2
  tempJob.repReward = 21
  tempJob.moneyReward = {550, 870}
  tempJob.categories = {"repair"}

  ix.jobs.register(tempJob, "ItemJob2_value_guncleaner")

  tempJob = nil


  local tempJob = {}

  tempJob.name = "Hand over %d Civilian-Grade Gun Oil."
  tempJob.desc = "%d Civilian-Grade Gun Oil."
  tempJob.icon = "propic/event/loot"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_value_gunoil"
  tempJob.numberRec = 1
  tempJob.reward = {{"kit_aid_high"}, {"kit_ammo_med"}}
  tempJob.rewardCount = 1
  tempJob.repReward = 6
  tempJob.moneyReward = {500, 850}
  tempJob.categories = {"repair"}

  ix.jobs.register(tempJob, "ItemJob1_value_gunoil")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "Hand over %d Civilian-Grade Gun Oil."
  tempJob.desc = "%d Civilian-Grade Gun Oil."
  tempJob.icon = "propic/event/loot"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_value_gunoil"
  tempJob.numberRec = 2
  tempJob.reward = {{"kit_aid_low"}, {"kit_ammo_med"}}
  tempJob.rewardCount = 1
  tempJob.repReward = 13
  tempJob.moneyReward = {500, 850}
  tempJob.categories = {"repair"}

  ix.jobs.register(tempJob, "ItemJob2_value_gunoil")

  tempJob = nil


  local tempJob = {}

  tempJob.name = "Hand over %d Weapon Lubricant Spray."
  tempJob.desc = "%d Weapon Lubricant Spray."
  tempJob.icon = "propic/event/loot"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_value_gunspray"
  tempJob.numberRec = 1
  tempJob.reward = {{"kit_aid_low"}, {"kit_ammo_med"}}
  tempJob.rewardCount = 1
  tempJob.repReward = 8
  tempJob.moneyReward = {500, 850}
  tempJob.categories = {"repair"}

  ix.jobs.register(tempJob, "ItemJob1_value_gunspray")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "Hand over %d Weapon Lubricant Spray."
  tempJob.desc = "%d Weapon Lubricant Spray."
  tempJob.icon = "propic/event/loot"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_value_gunspray"
  tempJob.numberRec = 2
  tempJob.reward = {{"kit_aid_low"}, {"kit_ammo_rare"}}
  tempJob.rewardCount = 2
  tempJob.repReward = 17
  tempJob.moneyReward = {500, 850}
  tempJob.categories = {"repair"}

  ix.jobs.register(tempJob, "ItemJob2_value_gunspray")

  tempJob = nil


  local tempJob = {}

  tempJob.name = "Hand over %d Firearm Lubricant."
  tempJob.desc = "%d Firearm Lubricant."
  tempJob.icon = "propic/event/loot"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_value_lubricant"
  tempJob.numberRec = 1
  tempJob.reward = {{"kit_ammo_m_low"}, {"kit_ammo_rare"}}
  tempJob.rewardCount = 1
  tempJob.repReward = 5
  tempJob.moneyReward = {500, 850}
  tempJob.categories = {"repair"}

  ix.jobs.register(tempJob, "ItemJob1_value_lubricant")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "Hand over %d Firearm Lubricant."
  tempJob.desc = "%d Firearm Lubricant."
  tempJob.icon = "propic/event/loot"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_value_lubricant"
  tempJob.numberRec = 2
  tempJob.reward = {{"kit_ammo_m_low"}}
  tempJob.rewardCount = 1
  tempJob.repReward = 11
  tempJob.moneyReward = {300, 450}
  tempJob.categories = {"repair"}

  ix.jobs.register(tempJob, "ItemJob2_value_lubricant")

  tempJob = nil

-----------------------------------------------------
-----------------------------------------------------
-------- ITEM RETRIEVAL - MECHANICAL/TOWN -----------
-----------------------------------------------------
-----------------------------------------------------

-- Mixed kits

  local tempJob = {}

  tempJob.name = "Hand over %d Bolts."
  tempJob.desc = "%d Bolts."
  tempJob.icon = "propic/event/loot"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_value_bolts"
  tempJob.numberRec = 4
  tempJob.reward = {{"762x25", { ["quantity"] = 15 }}, {"22lr", { ["quantity"] = 20 }}, {"9x18", { ["quantity"] = 15 }}, {"9x19", { ["quantity"] = 12 }}, {"45acp", { ["quantity"] = 10 }}}
  tempJob.rewardCount = 1
  tempJob.repReward = 2
  tempJob.moneyReward = {100, 150}
  tempJob.categories = {"mechanical", "town"}

  ix.jobs.register(tempJob, "ItemJob1_value_bolts")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "Hand over %d Bolts."
  tempJob.desc = "%d Bolts."
  tempJob.icon = "propic/event/loot"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_value_bolts"
  tempJob.numberRec = 20
  tempJob.reward = {{"762x25"}, {"22lr"}, {"9x18"}, {"9x19"}, {"45acp"}}
  tempJob.rewardCount = {1,2}
  tempJob.repReward = 12
  tempJob.moneyReward = {500, 700}
  tempJob.categories = {"mechanical", "town"}

  ix.jobs.register(tempJob, "ItemJob2_value_bolts")

  tempJob = nil


  local tempJob = {}

  tempJob.name = "Hand over %d Nuts."
  tempJob.desc = "%d Nuts."
  tempJob.icon = "propic/event/loot"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_value_nuts"
  tempJob.numberRec = 4
  tempJob.reward = {{"762x25", { ["quantity"] = 15 }}, {"22lr", { ["quantity"] = 20 }}, {"9x18", { ["quantity"] = 15 }}, {"9x19", { ["quantity"] = 12 }}, {"45acp", { ["quantity"] = 10 }}}
  tempJob.rewardCount = 1
  tempJob.repReward = 2
  tempJob.moneyReward = {120, 170}
  tempJob.categories = {"mechanical", "town"}

  ix.jobs.register(tempJob, "ItemJob1_value_nuts")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "Hand over %d Nuts."
  tempJob.desc = "%d Nuts."
  tempJob.icon = "propic/event/loot"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_value_nuts"
  tempJob.numberRec = 20
  tempJob.reward = {{"762x25"}, {"22lr"}, {"9x18"}, {"9x19"}, {"45acp"}}
  tempJob.rewardCount = {1,2}
  tempJob.repReward = 12
  tempJob.moneyReward = {600, 650}
  tempJob.categories = {"mechanical", "town"}

  ix.jobs.register(tempJob, "ItemJob2_value_nuts")

  tempJob = nil


  local tempJob = {}

  tempJob.name = "Hand over %d Propane Tank."
  tempJob.desc = "%d Propane Tank."
  tempJob.icon = "propic/event/loot"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_value_propanetank"
  tempJob.numberRec = 1
  tempJob.reward = {{"12gauge"}}
  tempJob.rewardCount = 1
  tempJob.repReward = 8
  tempJob.moneyReward = {800, 1000}
  tempJob.categories = {"mechanical", "town"}

  ix.jobs.register(tempJob, "ItemJob1_value_propanetank")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "Hand over %d Propane Tanks."
  tempJob.desc = "%d Propane Tanks."
  tempJob.icon = "propic/event/loot"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_value_propanetank"
  tempJob.numberRec = 2
  tempJob.reward = {{"12gauge"}, {"12gaugesg"}, {"12gaugetr"}}
  tempJob.rewardCount = {1,2}
  tempJob.repReward = 20
  tempJob.moneyReward = {1000, 1200}
  tempJob.categories = {"mechanical", "town"}

  ix.jobs.register(tempJob, "ItemJob2_value_propanetank")

  tempJob = nil


  local tempJob = {}

  tempJob.name = "Hand over %d Gasoline Can."
  tempJob.desc = "%d Gasoline Can."
  tempJob.icon = "propic/event/loot"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_value_gasoline"
  tempJob.numberRec = 1
  tempJob.reward = {{"762x39", { ["quantity"] = 30 }}}
  tempJob.rewardCount = 1
  tempJob.repReward = 20
  tempJob.moneyReward = {600, 900}
  tempJob.categories = {"mechanical", "town"}

  ix.jobs.register(tempJob, "ItemJob1_value_gasoline")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "Hand over %d Gasoline Cans."
  tempJob.desc = "%d Gasoline Cans."
  tempJob.icon = "propic/event/loot"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_value_gasoline"
  tempJob.numberRec = 2
  tempJob.reward = {{"762x39", { ["quantity"] = 40 }}}
  tempJob.rewardCount = 2
  tempJob.repReward = 25
  tempJob.moneyReward = {1500, 1600}
  tempJob.categories = {"mechanical", "town"}

  ix.jobs.register(tempJob, "ItemJob2_value_gasoline")

  tempJob = nil


  local tempJob = {}

  tempJob.name = "Hand over %d Kerosene Can."
  tempJob.desc = "%d Kerosene Can."
  tempJob.icon = "propic/event/loot"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_value_kerosene"
  tempJob.numberRec = 1
  tempJob.reward = {{"762x54", { ["quantity"] = 20 }}}
  tempJob.rewardCount = 1
  tempJob.repReward = 15
  tempJob.moneyReward = {1200, 2500}
  tempJob.categories = {"mechanical", "town"}

  ix.jobs.register(tempJob, "ItemJob1_value_kerosene")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "Hand over %d Kerosene Cans."
  tempJob.desc = "%d Kerosene Cans."
  tempJob.icon = "propic/event/loot"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_value_kerosene"
  tempJob.numberRec = 2
  tempJob.reward = {{"762x54"}}
  tempJob.rewardCount = 1
  tempJob.repReward = 20
  tempJob.moneyReward = {2000, 2500}
  tempJob.categories = {"mechanical", "town"}

  ix.jobs.register(tempJob, "ItemJob2_value_kerosene")

  tempJob = nil


  local tempJob = {}

  tempJob.name = "Hand over %d Diesel Motor Conditioner."
  tempJob.desc = "%d Diesel Motor Conditioner."
  tempJob.icon = "propic/event/loot"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_value_motorclean"
  tempJob.numberRec = 1
  tempJob.reward = {{"45acp"}, {"45acpap"}, {"45acphp"}}
  tempJob.rewardCount = 1
  tempJob.repReward = 8
  tempJob.moneyReward = {600, 880}
  tempJob.categories = {"mechanical", "town"}

  ix.jobs.register(tempJob, "ItemJob1_value_motorclean")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "Hand over %d Diesel Motor Conditioners."
  tempJob.desc = "%d Diesel Motor Conditioners."
  tempJob.icon = "propic/event/loot"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_value_motorclean"
  tempJob.numberRec = 2
  tempJob.reward = {{"45acp"}, {"45acpap"}, {"45acphp"}}
  tempJob.rewardCount = 2
  tempJob.repReward = 15
  tempJob.moneyReward = {1000, 1350}
  tempJob.categories = {"mechanical", "town"}

  ix.jobs.register(tempJob, "ItemJob2_value_motorclean")

  tempJob = nil


  local tempJob = {}

  tempJob.name = "Hand over %d Spark Plugs."
  tempJob.desc = "%d Spark Plugs."
  tempJob.icon = "propic/event/loot"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_value_sparkplug"
  tempJob.numberRec = 2
  tempJob.reward = {{"9x19hp", { ["quantity"] = 30 }}}
  tempJob.rewardCount = 1
  tempJob.repReward = 3
  tempJob.moneyReward = {200, 400}
  tempJob.categories = {"mechanical", "town"}

  ix.jobs.register(tempJob, "ItemJob1_value_sparkplug")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "Hand over %d Spark Plugs."
  tempJob.desc = "%d Spark Plugs."
  tempJob.icon = "propic/event/loot"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_value_sparkplug"
  tempJob.numberRec = 5
  tempJob.reward = {{"9x19hp", { ["quantity"] = 30 }}}
  tempJob.rewardCount = 2
  tempJob.repReward = 9
  tempJob.moneyReward = {300, 600}
  tempJob.categories = {"mechanical", "town"}

  ix.jobs.register(tempJob, "ItemJob2_value_sparkplug")

  tempJob = nil


  local tempJob = {}

  tempJob.name = "Hand over %d Light Bulb."
  tempJob.desc = "%d Light Bulb."
  tempJob.icon = "propic/event/loot"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_value_lightbulb"
  tempJob.numberRec = 1
  tempJob.reward = {{"762x25", { ["quantity"] = 15 }}, {"22lr", { ["quantity"] = 20 }}, {"9x18", { ["quantity"] = 15 }}, {"9x19", { ["quantity"] = 12 }}, {"45acp", { ["quantity"] = 10 }}}
  tempJob.rewardCount = 1
  tempJob.repReward = 2
  tempJob.moneyReward = {150, 200}
  tempJob.categories = {"town"}

  ix.jobs.register(tempJob, "ItemJob1_value_lightbulb")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "Hand over %d Light Bulbs."
  tempJob.desc = "%d Light Bulbs."
  tempJob.icon = "propic/event/loot"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_value_lightbulb"
  tempJob.numberRec = 2
  tempJob.reward = {{"762x25", { ["quantity"] = 15 }}, {"22lr", { ["quantity"] = 20 }}, {"9x18", { ["quantity"] = 15 }}, {"9x19", { ["quantity"] = 12 }}, {"45acp", { ["quantity"] = 10 }}}
  tempJob.rewardCount = 2
  tempJob.repReward = 5
  tempJob.moneyReward = {150, 400}
  tempJob.categories = {"town"}

  ix.jobs.register(tempJob, "ItemJob2_value_lightbulb")

  tempJob = nil


  local tempJob = {}

  tempJob.name = "Hand over %d Car Battery."
  tempJob.desc = "%d Car Battery."
  tempJob.icon = "propic/event/loot"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_value_carbattery"
  tempJob.numberRec = 1
  tempJob.reward = {{"kit_mixed_m_low"}}
  tempJob.rewardCount = 1
  tempJob.repReward = 15
  tempJob.moneyReward = {1500, 2200}
  tempJob.categories = {"mechanical", "town"}

  ix.jobs.register(tempJob, "ItemJob1_value_carbattery")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "Hand over %d Car Batteries."
  tempJob.desc = "%d Car Batteries."
  tempJob.icon = "propic/event/loot"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_value_carbattery"
  tempJob.numberRec = 2
  tempJob.reward = {{"kit_mixed_high"}}
  tempJob.rewardCount = 1
  tempJob.repReward = 20
  tempJob.moneyReward = {1900, 2400}
  tempJob.categories = {"mechanical", "town"}

  ix.jobs.register(tempJob, "ItemJob2_value_carbattery")

  tempJob = nil


  local tempJob = {}

  tempJob.name = "Hand over %d Duct Tape."
  tempJob.desc = "%d Duct Tape."
  tempJob.icon = "propic/event/loot"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_value_tape_duct"
  tempJob.numberRec = 1
  tempJob.reward = {{"762x25", { ["quantity"] = 15 }}, {"22lr", { ["quantity"] = 20 }}, {"9x18", { ["quantity"] = 15 }}, {"9x19", { ["quantity"] = 12 }}, {"45acp", { ["quantity"] = 10 }}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 1
  tempJob.moneyReward = {300, 450}
  tempJob.categories = {"mechanical", "town"}

  ix.jobs.register(tempJob, "ItemJob1_value_tape_duct")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "Hand over %d Duct Tapes."
  tempJob.desc = "%d Duct Tapes."
  tempJob.icon = "propic/event/loot"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_value_tape_duct"
  tempJob.numberRec = 2
  tempJob.reward = {{"kit_ammo_low"}}
  tempJob.rewardCount = 1
  tempJob.repReward = 3
  tempJob.moneyReward = {450, 700}
  tempJob.categories = {"mechanical", "town"}

  ix.jobs.register(tempJob, "ItemJob2_value_tape_duct")

  tempJob = nil


  local tempJob = {}

  tempJob.name = "Hand over %d Military-Grade Adhesive Tape."
  tempJob.desc = "%d Military-Grade Adhesive Tape."
  tempJob.icon = "propic/event/loot"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_value_tape_heavy"
  tempJob.numberRec = 1
  tempJob.reward = {{"338lapua", { ["quantity"] = 15 }}, {"9x21", { ["quantity"] = 30 }}, {"57x28", { ["quantity"] = 30 }}}
  tempJob.rewardCount = 1
  tempJob.repReward = 7
  tempJob.moneyReward = {500, 800}
  tempJob.categories = {"mechanical", "town"}

  ix.jobs.register(tempJob, "ItemJob1_value_tape_heavy")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "Hand over %d Military-Grade Adhesive Tape."
  tempJob.desc = "%d Military-Grade Adhesive Tape."
  tempJob.icon = "propic/event/loot"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_value_tape_heavy"
  tempJob.numberRec = 2
  tempJob.reward = {{"kit_ammo_m_rare"}}
  tempJob.rewardCount = 1
  tempJob.repReward = 12
  tempJob.moneyReward = {700, 950}
  tempJob.categories = {"mechanical", "town"}

  ix.jobs.register(tempJob, "ItemJob2_value_tape_heavy")

  tempJob = nil


  local tempJob = {}

  tempJob.name = "Hand over %d Diesel Engine."
  tempJob.desc = "%d Diesel Engine."
  tempJob.icon = "propic/event/loot"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_value_engine"
  tempJob.numberRec = 1
  tempJob.reward = {{"44magnum"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 12
  tempJob.moneyReward = {500, 800}
  tempJob.categories = {"mechanical", "town"}

  ix.jobs.register(tempJob, "ItemJob1_value_engine")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "Hand over %d Diesel Engines."
  tempJob.desc = "%d Diesel Engines."
  tempJob.icon = "propic/event/loot"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_value_engine"
  tempJob.numberRec = 2
  tempJob.reward = {{"44magnum"}, {"44magnumap"}, {"44magnumhp"}}
  tempJob.rewardCount = 2
  tempJob.repReward = 20
  tempJob.moneyReward = {500, 800}
  tempJob.categories = {"mechanical", "town"}

  ix.jobs.register(tempJob, "ItemJob2_value_engine")

  tempJob = nil


  local tempJob = {}

  tempJob.name = "Hand over %d Water Filter."
  tempJob.desc = "%d Water Filter."
  tempJob.icon = "propic/event/loot"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_value_waterfilter"
  tempJob.numberRec = 1
  tempJob.reward = {{"hidestash_1"}}
  tempJob.rewardCount = 1
  tempJob.repReward = 10
  tempJob.moneyReward = {1500, 1700}
  tempJob.categories = {"town"}

  ix.jobs.register(tempJob, "ItemJob1_value_waterfilter")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "Hand over %d Water Filters."
  tempJob.desc = "%d Water Filters."
  tempJob.icon = "propic/event/loot"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_value_waterfilter"
  tempJob.numberRec = 2
  tempJob.reward = {{"hidestash_2"}}
  tempJob.rewardCount = 1
  tempJob.repReward = 20
  tempJob.moneyReward = {1800, 1900}
  tempJob.categories = {"town"}

  ix.jobs.register(tempJob, "ItemJob2_value_waterfilter")

  tempJob = nil


  local tempJob = {}

  tempJob.name = "Hand over %d Pack of Nails."
  tempJob.desc = "%d Pack of Nails."
  tempJob.icon = "propic/event/loot"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_value_nails"
  tempJob.numberRec = 1
  tempJob.reward = {{"762x25", { ["quantity"] = 15 }}, {"22lr", { ["quantity"] = 20 }}, {"9x18", { ["quantity"] = 15 }}, {"9x19", { ["quantity"] = 12 }}, {"45acp", { ["quantity"] = 10 }}}
  tempJob.rewardCount = 1
  tempJob.repReward = 6
  tempJob.moneyReward = {200, 800}
  tempJob.categories = {"mechanical", "town"}

  ix.jobs.register(tempJob, "ItemJob1_value_nails")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "Hand over %d Packs of Nails."
  tempJob.desc = "%d Packs of Nails."
  tempJob.icon = "propic/event/loot"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_value_nails"
  tempJob.numberRec = 2
  tempJob.reward = {{"762x25", { ["quantity"] = 30 }}, {"22lr", { ["quantity"] = 40 }}, {"9x18", { ["quantity"] = 30 }}, {"9x19", { ["quantity"] = 24 }}, {"45acp", { ["quantity"] = 20 }}}
  tempJob.rewardCount = 1
  tempJob.repReward = 14
  tempJob.moneyReward = {600, 800}
  tempJob.categories = {"mechanical", "town"}

  ix.jobs.register(tempJob, "ItemJob2_value_nails")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "Hand over %d Copper Wire."
  tempJob.desc = "%d Copper Wire."
  tempJob.icon = "propic/event/loot"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_value_wire_copper"
  tempJob.numberRec = 1
  tempJob.reward = {{"762x25"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 4
  tempJob.moneyReward = {800, 1200}
  tempJob.categories = {"mechanical", "town", "electronics"}

  ix.jobs.register(tempJob, "ItemJob1_value_wire_copper")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "Hand over %d Copper Wire."
  tempJob.desc = "%d Copper Wire."
  tempJob.icon = "propic/event/loot"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_value_wire_copper"
  tempJob.numberRec = 2
  tempJob.reward = {{"c96", { ["durability"] = 70 }}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 9
  tempJob.moneyReward = {1100, 1300}
  tempJob.categories = {"mechanical", "town", "electronics"}

  ix.jobs.register(tempJob, "ItemJob2_value_wire_copper")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "Hand over %d Heavy Duty Cabling."
  tempJob.desc = "%d Heavy Duty Cabling."
  tempJob.icon = "propic/event/loot"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_value_wire_heavy"
  tempJob.numberRec = 1
  tempJob.reward = {{"9x19hp"}}
  tempJob.rewardCount = 1
  tempJob.repReward = 10
  tempJob.moneyReward = {300, 650}
  tempJob.categories = {"mechanical", "town"}

  ix.jobs.register(tempJob, "ItemJob1_value_wire_heavy")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "Hand over %d Heavy Duty Cabling."
  tempJob.desc = "%d Heavy Duty Cabling."
  tempJob.icon = "propic/event/loot"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_value_wire_heavy"
  tempJob.numberRec = 2
  tempJob.reward = {{"p99", { ["durability"] = 70 }}}
  tempJob.rewardCount = 1
  tempJob.repReward = 15
  tempJob.moneyReward = {405, 800}
  tempJob.categories = {"mechanical", "town"}

  ix.jobs.register(tempJob, "ItemJob2_value_wire_heavy")

  tempJob = nil


  local tempJob = {}

  tempJob.name = "Hand over %d Plastic Hose."
  tempJob.desc = "%d Plastic Hose."
  tempJob.icon = "propic/event/loot"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_value_hose"
  tempJob.numberRec = 1
  tempJob.reward = {{"357magnum", { ["quantity"] = 24 }}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 6
  tempJob.moneyReward = {250, 360}
  tempJob.categories = {"town"}

  ix.jobs.register(tempJob, "ItemJob1_value_hose")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "Hand over %d Plastic Hoses."
  tempJob.desc = "%d Plastic Hoses."
  tempJob.icon = "propic/event/loot"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_value_hose"
  tempJob.numberRec = 2
  tempJob.reward = {{"swr8", { ["durability"] = 65 }}}
  tempJob.rewardCount = 1
  tempJob.repReward = 14
  tempJob.moneyReward = {360, 450}
  tempJob.categories = {"town"}

  ix.jobs.register(tempJob, "ItemJob2_value_hose")

  tempJob = nil


  local tempJob = {}

  tempJob.name = "Hand over %d Paracord."
  tempJob.desc = "%d Paracord."
  tempJob.icon = "propic/event/loot"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_value_paracord"
  tempJob.numberRec = 1
  tempJob.reward = {{"binoculars_2"}}
  tempJob.rewardCount = 1
  tempJob.repReward = 8
  tempJob.moneyReward = {760, 1100}
  tempJob.categories = {"town"}

  ix.jobs.register(tempJob, "ItemJob1_value_paracord")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "Hand over %d Paracord."
  tempJob.desc = "%d Paracord."
  tempJob.icon = "propic/event/loot"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_value_paracord"
  tempJob.numberRec = 2
  tempJob.reward = {{"22lr"}}
  tempJob.rewardCount = 1
  tempJob.repReward = 15
  tempJob.moneyReward = {500, 790}
  tempJob.categories = {"town"}

  ix.jobs.register(tempJob, "ItemJob2_value_paracord")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "Hand over %d Alkaline Booster."
  tempJob.desc = "%d Alkaline Booster."
  tempJob.icon = "propic/event/loot"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_value_detergent"
  tempJob.numberRec = 1
  tempJob.reward = {{"kit_mixed_low"}}
  tempJob.rewardCount = 1
  tempJob.repReward = 6
  tempJob.moneyReward = {600, 900}
  tempJob.categories = {"town"}

  ix.jobs.register(tempJob, "ItemJob1_value_detergent")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "Hand over %d Alkaline Booster."
  tempJob.desc = "%d Alkaline Booster."
  tempJob.icon = "propic/event/loot"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_value_detergent"
  tempJob.numberRec = 2
  tempJob.reward = {{"kit_mixed_low"}}
  tempJob.rewardCount = 2
  tempJob.repReward = 15
  tempJob.moneyReward = {600, 900}
  tempJob.categories = {"town"}

  ix.jobs.register(tempJob, "ItemJob2_value_detergent")

  tempJob = nil


  local tempJob = {}

  tempJob.name = "Hand over %d Toothpaste."
  tempJob.desc = "%d Toothpaste."
  tempJob.icon = "propic/event/loot"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_value_toothpaste"
  tempJob.numberRec = 1
  tempJob.reward = {{"9x19", { ["quantity"] = 15 }}}
  tempJob.rewardCount = 1
  tempJob.repReward = 2
  tempJob.moneyReward = {100, 200}
  tempJob.categories = {"town"}

  ix.jobs.register(tempJob, "ItemJob1_value_toothpaste")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "Hand over %d Toothpaste."
  tempJob.desc = "%d Toothpaste."
  tempJob.icon = "propic/event/loot"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_value_toothpaste"
  tempJob.numberRec = 2
  tempJob.reward = {{"kit_ammo_low"}}
  tempJob.rewardCount = 1
  tempJob.repReward = 5
  tempJob.moneyReward = {200, 500}
  tempJob.categories = {"town"}

  ix.jobs.register(tempJob, "ItemJob2_value_toothpaste")

  tempJob = nil


  local tempJob = {}

  tempJob.name = "Hand over %d Toilet Paper."
  tempJob.desc = "%d Toilet Paper."
  tempJob.icon = "propic/event/loot"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_value_toiletpaper"
  tempJob.numberRec = 1
  tempJob.reward = {{"kit_aid_low"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 2
  tempJob.moneyReward = {100, 150}
  tempJob.categories = {"town"}

  ix.jobs.register(tempJob, "ItemJob1_value_toiletpaper")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "Hand over %d Toilet Papers."
  tempJob.desc = "%d Toilet Papers."
  tempJob.icon = "propic/event/loot"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_value_toiletpaper"
  tempJob.numberRec = 2
  tempJob.reward = {{"value_statue_horse"}}
  tempJob.rewardCount = 1
  tempJob.repReward = 4
  tempJob.moneyReward = {125, 450}
  tempJob.categories = {"town"}

  ix.jobs.register(tempJob, "ItemJob2_value_toiletpaper")

  tempJob = nil



-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------
-------- ITEM RETRIEVAL - RICHES (Single Item, as they are rare) --------------------
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------

-- Lots of money, generic valuables

  local tempJob = {}

  tempJob.name = "Hand over %d Cat Statuette."
  tempJob.desc = "%d Cat Statuette."
  tempJob.icon = "propic/event/loot"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_value_statue_cat"
  tempJob.numberRec = 1
  tempJob.reward = {{"kit_mixed_high"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 25
  tempJob.moneyReward = {600, 900}
  tempJob.categories = {"riches"}

  ix.jobs.register(tempJob, "ItemJob1_value_statue_cat")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "Hand over %d Horse Statuette."
  tempJob.desc = "%d Horse Statuette."
  tempJob.icon = "propic/event/loot"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_value_statue_horse"
  tempJob.numberRec = 1
  tempJob.reward = {{"kit_mixed_high"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 25
  tempJob.moneyReward = {1000, 2200}
  tempJob.categories = {"riches"}

  ix.jobs.register(tempJob, "ItemJob1_value_statue_horse")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "Hand over %d Lion Statuette."
  tempJob.desc = "%d Lion Statuette."
  tempJob.icon = "propic/event/loot"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_value_statue_lion"
  tempJob.numberRec = 1
  tempJob.reward = {{"kit_mixed_high"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 25
  tempJob.moneyReward = {960, 1200}
  tempJob.categories = {"riches"}

  ix.jobs.register(tempJob, "ItemJob1_value_statue_lion")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "Hand over %d Watch."
  tempJob.desc = "%d Watch."
  tempJob.icon = "propic/event/loot"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_value_watch"
  tempJob.numberRec = 1
  tempJob.reward = {{"kit_mixed_high"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 25
  tempJob.moneyReward = {2500, 3600}
  tempJob.categories = {"riches"}

  ix.jobs.register(tempJob, "ItemJob1_value_watch")

  tempJob = nil


  local tempJob = {}

  tempJob.name = "Hand over %d Gold Chain."
  tempJob.desc = "%d Gold Chain."
  tempJob.icon = "propic/event/loot"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_value_goldchain"
  tempJob.numberRec = 1
  tempJob.reward = {{"kit_mixed_high"}}
  tempJob.rewardCount = 2
  tempJob.repReward = 45
  tempJob.moneyReward = {3000, 4800}
  tempJob.categories = {"riches"}

  ix.jobs.register(tempJob, "ItemJob1_value_goldchain")

  tempJob = nil


  local tempJob = {}

  tempJob.name = "Hand over %d Old Smartphone (Broken)."
  tempJob.desc = "%d Old Smartphone (Broken)."
  tempJob.icon = "propic/event/loot"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_value_phone_old"
  tempJob.numberRec = 1
  tempJob.reward = {{"kit_mixed_high"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 25
  tempJob.moneyReward = {1250, 1800}
  tempJob.categories = {"information"}

  ix.jobs.register(tempJob, "ItemJob1_value_phone_old")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "Hand over %d New Smartphone (Broken)."
  tempJob.desc = "%d New Smartphone (Broken)."
  tempJob.icon = "propic/event/loot"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_value_phone_new"
  tempJob.numberRec = 1
  tempJob.reward = {{"kit_mixed_high"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 35
  tempJob.moneyReward = {3000, 6000}
  tempJob.categories = {"information"}

  ix.jobs.register(tempJob, "ItemJob1_value_phone_new")

  tempJob = nil


  local tempJob = {}

  tempJob.name = "Hand over %d Empty Noteblock."
  tempJob.desc = "%d Empty Noteblock."
  tempJob.icon = "propic/event/loot"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_value_documents_1"
  tempJob.numberRec = 1
  tempJob.reward = {{"kit_mixed_high"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 35
  tempJob.moneyReward = {200, 400}
  tempJob.categories = {"information"}

  ix.jobs.register(tempJob, "ItemJob1_value_documents_1")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "Hand over %d Trading Ledger."
  tempJob.desc = "%d Trading Ledger."
  tempJob.icon = "propic/event/loot"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_value_documents_2"
  tempJob.numberRec = 1
  tempJob.reward = {{"sr3m", { ["durability"] = 70 }}}
  tempJob.rewardCount = 1
  tempJob.repReward = 35
  tempJob.moneyReward = {500, 1500}
  tempJob.categories = {"information"}

  ix.jobs.register(tempJob, "ItemJob1_value_documents_2")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "Hand over %d Scientist Curriculum Vitae."
  tempJob.desc = "%d Scientist Curriculum Vitae."
  tempJob.icon = "propic/event/loot"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_value_documents_3"
  tempJob.numberRec = 1
  tempJob.reward = {{"taurusjudge", { ["durability"] = 70 }}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 35
  tempJob.moneyReward = {500, 1500}
  tempJob.categories = {"information"}

  ix.jobs.register(tempJob, "ItemJob1_value_documents_3")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "Hand over %d Scribbled Scientific Notes."
  tempJob.desc = "%d Scribbled Scientific Notes."
  tempJob.icon = "propic/event/loot"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_value_documents_4"
  tempJob.numberRec = 1
  tempJob.reward = {{"mp153", { ["durability"] = 70 }}}
  tempJob.rewardCount = 1
  tempJob.repReward = 35
  tempJob.moneyReward = {500, 1500}
  tempJob.categories = {"information"}

  ix.jobs.register(tempJob, "ItemJob1_value_documents_4")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "Hand over %d Handdrawn Anomaly Map."
  tempJob.desc = "%d Handdrawn Anomaly Map."
  tempJob.icon = "propic/event/loot"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_value_documents_5"
  tempJob.numberRec = 1
  tempJob.reward = {{"pp1901vityaz", { ["durability"] = 70 }}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 35
  tempJob.moneyReward = {500, 1500}
  tempJob.categories = {"information"}

  ix.jobs.register(tempJob, "ItemJob1_value_documents_5")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "Hand over %d Pump Station Checklist."
  tempJob.desc = "%d Pump Station Checklist."
  tempJob.icon = "propic/event/loot"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_value_documents_6"
  tempJob.numberRec = 1
  tempJob.reward = {{"kit_mixed_high"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 35
  tempJob.moneyReward = {500, 1500}
  tempJob.categories = {"information"}

  ix.jobs.register(tempJob, "ItemJob1_value_documents_6")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "Hand over %d Firearm Assembly Illustration."
  tempJob.desc = "%d Firearm Assembly Illustration."
  tempJob.icon = "propic/event/loot"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_value_documents_7"
  tempJob.numberRec = 1
  tempJob.reward = {{"c96carbine", { ["durability"] = 70 }}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 35
  tempJob.moneyReward = {500, 1500}
  tempJob.categories = {"information"}

  ix.jobs.register(tempJob, "ItemJob1_value_documents_7")

  tempJob = nil

    local tempJob = {}

  tempJob.name = "Hand over %d Unreadable Torn Note."
  tempJob.desc = "%d Unreadable Torn Note."
  tempJob.icon = "propic/event/loot"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_value_documents_8"
  tempJob.numberRec = 1
  tempJob.reward = {{"kit_mixed_high"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 35
  tempJob.moneyReward = {500, 1500}
  tempJob.categories = {"information"}

  ix.jobs.register(tempJob, "ItemJob1_value_documents_8")

  tempJob = nil

    local tempJob = {}

  tempJob.name = "Hand over %d Swamps Research Documents."
  tempJob.desc = "%d Swamps Research Documents."
  tempJob.icon = "propic/event/loot"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_value_documents_9"
  tempJob.numberRec = 1
  tempJob.reward = {{"kit_mixed_high"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 35
  tempJob.moneyReward = {500, 1500}
  tempJob.categories = {"information"}

  ix.jobs.register(tempJob, "ItemJob1_value_documents_9")

  tempJob = nil


    local tempJob = {}

  tempJob.name = "Hand over %d Anomalous Material Report."
  tempJob.desc = "%d Anomalous Material Report."
  tempJob.icon = "propic/event/loot"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_value_documents_10"
  tempJob.numberRec = 1
  tempJob.reward = {{"kit_mixed_high"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 35
  tempJob.moneyReward = {500, 1500}
  tempJob.categories = {"information"}

  ix.jobs.register(tempJob, "ItemJob1_value_documents_10")

  tempJob = nil

    local tempJob = {}

  tempJob.name = "Hand over %d Artifact Research Ledger."
  tempJob.desc = "%d Artifact Research Ledger."
  tempJob.icon = "propic/event/loot"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_value_documents_11"
  tempJob.numberRec = 1
  tempJob.reward = {{"mateba", { ["durability"] = 70 }}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 35
  tempJob.moneyReward = {500, 1500}
  tempJob.categories = {"information"}

  ix.jobs.register(tempJob, "ItemJob1_value_documents_11")

  tempJob = nil

    local tempJob = {}

  tempJob.name = "Hand over %d Soviet Manual of Arms."
  tempJob.desc = "%d Soviet Manual of Arms."
  tempJob.icon = "propic/event/loot"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_value_documents_12"
  tempJob.numberRec = 1
  tempJob.reward = {{"kit_mixed_high"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 35
  tempJob.moneyReward = {500, 1500}
  tempJob.categories = {"information"}

  ix.jobs.register(tempJob, "ItemJob1_value_documents_12")

  tempJob = nil

    local tempJob = {}

  tempJob.name = "Hand over %d Manufacture of Gear Wheels."
  tempJob.desc = "%d Manufacture of Gear Wheels."
  tempJob.icon = "propic/event/loot"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_value_documents_13"
  tempJob.numberRec = 1
  tempJob.reward = {{"pp2000", { ["durability"] = 70 }}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 35
  tempJob.moneyReward = {500, 1500}
  tempJob.categories = {"information"}

  ix.jobs.register(tempJob, "ItemJob1_value_documents_13")

  tempJob = nil

    local tempJob = {}

  tempJob.name = "Hand over %d Kevlar Sewing Manual."
  tempJob.desc = "%d Kevlar Sewing Manual."
  tempJob.icon = "propic/event/loot"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_value_documents_14"
  tempJob.numberRec = 1
  tempJob.reward = {{"kit_mixed_high"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 35
  tempJob.moneyReward = {500, 1500}
  tempJob.categories = {"information"}

  ix.jobs.register(tempJob, "ItemJob1_value_documents_14")

  tempJob = nil
end
