--[[
  --TestJob
  local tempJob = {}

  tempJob.name = "Say sneed %d times."                  --Name that will be shown in dialogue when selecting tasks
  tempJob.desc = "I need you to sneed %d times for me." --Description of task, will be shown to the player when deciding to take quest or not
  tempJob.icon = "stalker/questpaper_item.png"          --Icon, unused?
  tempJob.tier = 1                                      --Tier, unused?
  tempJob.listenTrigger = "chatSayTest"                 --trigger word to listen for in the ix_JobTrigger hook, see sh_listeners
  tempJob.numberRec = 5                                 --integer amount of times the listenTrigger must be run through the ix_JobTrigger hook
  tempJob.reward = {{"kit_quest1"}}                     --table of item ids for rewarding the player with
  tempJob.rewardCount = 1                               --how many items should the player get
  tempJob.repReward = 80                                --how much reputation should be awarded for completion
  tempJob.categories = {"mutantkilleasy"}               --table of category identifiers, used for when npc gets tasks

  ix.jobs.register(tempJob, "TestJob")                  --If item delivery quest, the final part of the quest identifier should read "_<uniqueid>" for proper operation

  candidates for adding:
  tempJob.moneyReward = {2000,4000} OR 3000             --for adding money to the player, can technically be done through itemreward as well

]]--



do
------------------------------------------------
------------- ITEM RETRIEVAL - MEAT ------------
------------------------------------------------

  local tempJob = {}

  tempJob.name = "%d pieces of blind dog meat."
  tempJob.desc = "%d pieces of blind dog meat."
  tempJob.icon = "stalker/questpaper_item.png"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_meat_blinddog"
  tempJob.numberRec = 4
  tempJob.reward = {{"kit_quest1"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 15
  tempJob.categories = {"mutantmeateasy"}

  ix.jobs.register(tempJob, "ItemJob1_meat_blinddog")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "%d pieces of blind dog meat."
  tempJob.desc = "%d pieces of blind dog meat."
  tempJob.icon = "stalker/questpaper_item.png"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_meat_blinddog"
  tempJob.numberRec = 8
  tempJob.reward = {{"kit_quest1"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 15
  tempJob.categories = {"mutantmeateasy"}

  ix.jobs.register(tempJob, "ItemJob2_meat_blinddog")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "%d pieces of bloodsucker meat."
  tempJob.desc = "%d pieces of bloodsucker meat."
  tempJob.icon = "stalker/questpaper_item.png"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_meat_bloodsucker"
  tempJob.numberRec = 2
  tempJob.reward = {{"kit_quest2"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 15
  tempJob.categories = {"mutantmeatmedium"}

  ix.jobs.register(tempJob, "ItemJob1_meat_bloodsucker")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "%d pieces of bloodsucker meat."
  tempJob.desc = "%d pieces of bloodsucker meat."
  tempJob.icon = "stalker/questpaper_item.png"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_meat_bloodsucker"
  tempJob.numberRec = 4
  tempJob.reward = {{"kit_quest2"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 15
  tempJob.categories = {"mutantmeatmedium"}

  ix.jobs.register(tempJob, "ItemJob2_meat_bloodsucker")

  tempJob = nil


  local tempJob = {}

  tempJob.name = "%d pieces of boar meat."
  tempJob.desc = "%d pieces of boar meat."
  tempJob.icon = "stalker/questpaper_item.png"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_meat_boar"
  tempJob.numberRec = 2
  tempJob.reward = {{"kit_quest1"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 15
  tempJob.categories = {"mutantmeateasy"}

  ix.jobs.register(tempJob, "ItemJob1_meat_boar")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "%d pieces of boar meat."
  tempJob.desc = "%d pieces of boar meat."
  tempJob.icon = "stalker/questpaper_item.png"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_meat_boar"
  tempJob.numberRec = 5
  tempJob.reward = {{"kit_quest1"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 15
  tempJob.categories = {"mutantmeateasy"}

  ix.jobs.register(tempJob, "ItemJob2_meat_boar")

  tempJob = nil

--[[
  local tempJob = {}

  tempJob.name = "%d pieces of burer meat."
  tempJob.desc = "%d pieces of burer meat."
  tempJob.icon = "stalker/questpaper_item.png"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_meat_burer"
  tempJob.numberRec = 2
  tempJob.reward = {{"kit_quest1"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 15
  tempJob.categories = {"mutantmeatmedium"}

  ix.jobs.register(tempJob, "ItemJob1_meat_burer")

  tempJob = nil
]]--

  local tempJob = {}

  tempJob.name = "%d pieces of cat meat."
  tempJob.desc = "%d pieces of cat meat."
  tempJob.icon = "stalker/questpaper_item.png"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_meat_cat"
  tempJob.numberRec = 2
  tempJob.reward = {{"kit_quest1"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 15
  tempJob.categories = {"mutantmeateasy"}

  ix.jobs.register(tempJob, "ItemJob1_meat_cat")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "%d pieces of cat meat."
  tempJob.desc = "%d pieces of cat meat."
  tempJob.icon = "stalker/questpaper_item.png"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_meat_cat"
  tempJob.numberRec = 2
  tempJob.reward = {{"kit_quest1"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 15
  tempJob.categories = {"mutantmeateasy"}

  ix.jobs.register(tempJob, "ItemJob2_meat_cat")

  tempJob = nil
    --needs chimera

  local tempJob = {}

  tempJob.name = "%d pieces of flesh meat."
  tempJob.desc = "%d pieces of flesh meat."
  tempJob.icon = "stalker/questpaper_item.png"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_meat_flesh"
  tempJob.numberRec = 3
  tempJob.reward = {{"kit_quest1"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 15
  tempJob.categories = {"mutantmeateasy"}

  ix.jobs.register(tempJob, "ItemJob1_meat_flesh")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "%d pieces of flesh meat."
  tempJob.desc = "%d pieces of flesh meat."
  tempJob.icon = "stalker/questpaper_item.png"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_meat_flesh"
  tempJob.numberRec = 6
  tempJob.reward = {{"kit_quest1"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 15
  tempJob.categories = {"mutantmeateasy"}

  ix.jobs.register(tempJob, "ItemJob2_meat_flesh")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "%d pieces of hellhound meat."
  tempJob.desc = "%d pieces of hellhound meat."
  tempJob.icon = "stalker/questpaper_item.png"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_meat_hellhound"
  tempJob.numberRec = 1
  tempJob.reward = {{"kit_quest2"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 15
  tempJob.categories = {"mutantmeatmedium"}

  ix.jobs.register(tempJob, "ItemJob1_meat_hellhound")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "%d pieces of hellhound meat."
  tempJob.desc = "%d pieces of hellhound meat."
  tempJob.icon = "stalker/questpaper_item.png"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_meat_hellhound"
  tempJob.numberRec = 3
  tempJob.reward = {{"kit_quest2"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 15
  tempJob.categories = {"mutantmeatmedium"}

  ix.jobs.register(tempJob, "ItemJob2_meat_hellhound")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "%d pieces of decomposing meat."
  tempJob.desc = "%d pieces of decomposing meat."
  tempJob.icon = "stalker/questpaper_item.png"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_meat_human"
  tempJob.numberRec = 4
  tempJob.reward = {{"kit_quest2"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 15
  tempJob.categories = {"mutantmeatmedium"}

  ix.jobs.register(tempJob, "ItemJob1_meat_human")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "%d pieces of decomposing meat."
  tempJob.desc = "%d pieces of decomposing meat."
  tempJob.icon = "stalker/questpaper_item.png"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_meat_human"
  tempJob.numberRec = 8
  tempJob.reward = {{"kit_quest2"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 15
  tempJob.categories = {"mutantmeatmedium"}

  ix.jobs.register(tempJob, "ItemJob2_meat_human")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "%d pieces of pseudodog meat."
  tempJob.desc = "%d pieces of pseudodog meat."
  tempJob.icon = "stalker/questpaper_item.png"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_meat_pseudodog"
  tempJob.numberRec = 2
  tempJob.reward = {{"kit_quest1"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 15
  tempJob.categories = {"mutantmeateasy"}

  ix.jobs.register(tempJob, "ItemJob1_meat_pseudodog")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "%d pieces of pseudodog meat."
  tempJob.desc = "%d pieces of pseudodog meat."
  tempJob.icon = "stalker/questpaper_item.png"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_meat_pseudodog"
  tempJob.numberRec = 4
  tempJob.reward = {{"kit_quest1"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 15
  tempJob.categories = {"mutantmeateasy"}

  ix.jobs.register(tempJob, "ItemJob2_meat_pseudodog")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "%d pieces of sprig meat."
  tempJob.desc = "%d pieces of sprig meat."
  tempJob.icon = "stalker/questpaper_item.png"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_meat_sprig"
  tempJob.numberRec = 1
  tempJob.reward = {{"kit_quest2"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 15
  tempJob.categories = {"mutantmeatmedium"}

  ix.jobs.register(tempJob, "ItemJob1_meat_sprig")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "%d pieces of sprig meat."
  tempJob.desc = "%d pieces of sprig meat."
  tempJob.icon = "stalker/questpaper_item.png"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_meat_sprig"
  tempJob.numberRec = 3
  tempJob.reward = {{"kit_quest2"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 15
  tempJob.categories = {"mutantmeatmedium"}

  ix.jobs.register(tempJob, "ItemJob2_meat_sprig")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "%d snork hands."
  tempJob.desc = "%d snork hands."
  tempJob.icon = "stalker/questpaper_item.png"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_meat_snork"
  tempJob.numberRec = 1
  tempJob.reward = {{"kit_quest2"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 15
  tempJob.categories = {"mutantmeatmedium"}

  ix.jobs.register(tempJob, "ItemJob1_meat_snork")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "%d snork hands."
  tempJob.desc = "%d snork hands."
  tempJob.icon = "stalker/questpaper_item.png"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_meat_snork"
  tempJob.numberRec = 3
  tempJob.reward = {{"kit_quest2"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 15
  tempJob.categories = {"mutantmeatmedium"}

  ix.jobs.register(tempJob, "ItemJob2_meat_snork")

  tempJob = nil


  local tempJob = {}

  tempJob.name = "%d pieces of tushkano meat."
  tempJob.desc = "%d pieces of tushkano meat."
  tempJob.icon = "stalker/questpaper_item.png"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_meat_tushkano"
  tempJob.numberRec = 4
  tempJob.reward = {{"kit_quest1"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 15
  tempJob.categories = {"mutantmeateasy"}

  ix.jobs.register(tempJob, "ItemJob1_meat_tushkano")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "%d pieces of tushkano meat."
  tempJob.desc = "%d pieces of tushkano meat."
  tempJob.icon = "stalker/questpaper_item.png"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_meat_tushkano"
  tempJob.numberRec = 8
  tempJob.reward = {{"kit_quest1"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 15
  tempJob.categories = {"mutantmeateasy"}

  ix.jobs.register(tempJob, "ItemJob2_meat_tushkano")

  tempJob = nil


-----------------------------------------------------
-----------------------------------------------------
------------- ITEM RETRIEVAL - ELECTRONICS ----------
-----------------------------------------------------
-----------------------------------------------------



  local tempJob = {}

  tempJob.name = "%d SSD."
  tempJob.desc = "%d SSD."
  tempJob.icon = "stalker/questpaper_item.png"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_value_pcpart_ssd"
  tempJob.numberRec = 1
  tempJob.reward = {{"kit_quest1"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 15
  tempJob.categories = {"electronics", "information"}

  ix.jobs.register(tempJob, "ItemJob1_value_pcpart_ssd")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "%d SSDs."
  tempJob.desc = "%d SSDs."
  tempJob.icon = "stalker/questpaper_item.png"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_value_pcpart_ssd"
  tempJob.numberRec = 2
  tempJob.reward = {{"kit_quest1"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 15
  tempJob.categories = {"electronics", "information"}

  ix.jobs.register(tempJob, "ItemJob2_value_pcpart_ssd")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "%d HDD."
  tempJob.desc = "%d HDD."
  tempJob.icon = "stalker/questpaper_item.png"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_value_pcpart_hdd"
  tempJob.numberRec = 1
  tempJob.reward = {{"kit_quest1"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 15
  tempJob.categories = {"electronics", "information"}

  ix.jobs.register(tempJob, "ItemJob1_value_pcpart_hdd")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "%d HDDs."
  tempJob.desc = "%d HDDs."
  tempJob.icon = "stalker/questpaper_item.png"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_value_pcpart_hdd"
  tempJob.numberRec = 2
  tempJob.reward = {{"kit_quest1"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 15
  tempJob.categories = {"electronics", "information"}

  ix.jobs.register(tempJob, "ItemJob2_value_pcpart_hdd")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "%d PSU."
  tempJob.desc = "%d PSU."
  tempJob.icon = "stalker/questpaper_item.png"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_value_pcpart_psu"
  tempJob.numberRec = 1
  tempJob.reward = {{"kit_quest1"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 15
  tempJob.categories = {"electronics"}

  ix.jobs.register(tempJob, "ItemJob1_value_pcpart_psu")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "%d PSUs."
  tempJob.desc = "%d PSUs."
  tempJob.icon = "stalker/questpaper_item.png"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_value_pcpart_psu"
  tempJob.numberRec = 2
  tempJob.reward = {{"kit_quest1"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 15
  tempJob.categories = {"electronics"}

  ix.jobs.register(tempJob, "ItemJob2_value_pcpart_psu")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "%d LCD Panel."
  tempJob.desc = "%d LCD Panel."
  tempJob.icon = "stalker/questpaper_item.png"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_value_pcpart_lcd"
  tempJob.numberRec = 1
  tempJob.reward = {{"kit_quest1"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 15
  tempJob.categories = {"electronics"}

  ix.jobs.register(tempJob, "ItemJob1_value_pcpart_lcd")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "%d LCD Panels."
  tempJob.desc = "%d LCD Panels."
  tempJob.icon = "stalker/questpaper_item.png"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_value_pcpart_lcd"
  tempJob.numberRec = 2
  tempJob.reward = {{"kit_quest1"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 15
  tempJob.categories = {"electronics"}

  ix.jobs.register(tempJob, "ItemJob2_value_pcpart_lcd")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "%d GPU."
  tempJob.desc = "%d GPU."
  tempJob.icon = "stalker/questpaper_item.png"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_value_pcpart_gpu"
  tempJob.numberRec = 1
  tempJob.reward = {{"kit_quest1"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 15
  tempJob.categories = {"electronics"}

  ix.jobs.register(tempJob, "ItemJob1_value_pcpart_gpu")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "%d GPUs."
  tempJob.desc = "%d GPUs."
  tempJob.icon = "stalker/questpaper_item.png"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_value_pcpart_gpu"
  tempJob.numberRec = 2
  tempJob.reward = {{"kit_quest1"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 15
  tempJob.categories = {"electronics"}

  ix.jobs.register(tempJob, "ItemJob2_value_pcpart_gpu")

  tempJob = nil


  local tempJob = {}

  tempJob.name = "%d FPGAs."
  tempJob.desc = "%d FPGAs."
  tempJob.icon = "stalker/questpaper_item.png"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_value_pcpart_fpga"
  tempJob.numberRec = 1
  tempJob.reward = {{"kit_quest1"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 15
  tempJob.categories = {"electronics"}

  ix.jobs.register(tempJob, "ItemJob1_value_pcpart_fpga")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "%d FPGAs."
  tempJob.desc = "%d FPGAs."
  tempJob.icon = "stalker/questpaper_item.png"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_value_pcpart_fpga"
  tempJob.numberRec = 2
  tempJob.reward = {{"kit_quest1"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 15
  tempJob.categories = {"electronics"}

  ix.jobs.register(tempJob, "ItemJob2_value_pcpart_fpga")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "%d Powerbank."
  tempJob.desc = "%d Powerbank."
  tempJob.icon = "stalker/questpaper_item.png"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_value_powerbank"
  tempJob.numberRec = 1
  tempJob.reward = {{"kit_quest1"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 15
  tempJob.categories = {"electronics"}

  ix.jobs.register(tempJob, "ItemJob1_value_powerbank")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "%d Powerbanks."
  tempJob.desc = "%d Powerbanks."
  tempJob.icon = "stalker/questpaper_item.png"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_value_powerbank"
  tempJob.numberRec = 2
  tempJob.reward = {{"kit_quest1"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 15
  tempJob.categories = {"electronics"}

  ix.jobs.register(tempJob, "ItemJob2_value_powerbank")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "%d Wireless Transmitter Module."
  tempJob.desc = "%d Wireless Transmitter Module."
  tempJob.icon = "stalker/questpaper_item.png"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_value_wirelesstrans"
  tempJob.numberRec = 1
  tempJob.reward = {{"kit_quest1"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 15
  tempJob.categories = {"electronics"}

  ix.jobs.register(tempJob, "ItemJob1_value_wirelesstrans")

  tempJob = nil


  local tempJob = {}

  tempJob.name = "%d Wireless Transmitter Modules."
  tempJob.desc = "%d Wireless Transmitter Modules."
  tempJob.icon = "stalker/questpaper_item.png"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_value_wirelesstrans"
  tempJob.numberRec = 2
  tempJob.reward = {{"kit_quest1"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 15
  tempJob.categories = {"electronics"}

  ix.jobs.register(tempJob, "ItemJob2_value_wirelesstrans")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "%d Capacitors."
  tempJob.desc = "%d Capacitors."
  tempJob.icon = "stalker/questpaper_item.png"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_value_capacitors"
  tempJob.numberRec = 2
  tempJob.reward = {{"kit_quest1"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 15
  tempJob.categories = {"electronics"}

  ix.jobs.register(tempJob, "ItemJob1_value_capacitors")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "%d Capacitors."
  tempJob.desc = "%d Capacitors."
  tempJob.icon = "stalker/questpaper_item.png"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_value_capacitors"
  tempJob.numberRec = 10
  tempJob.reward = {{"kit_quest1"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 15
  tempJob.categories = {"electronics"}

  ix.jobs.register(tempJob, "ItemJob2_value_capacitors")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "%d Electric Tape."
  tempJob.desc = "%d Electric Tape."
  tempJob.icon = "stalker/questpaper_item.png"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_value_tape_electric"
  tempJob.numberRec = 1
  tempJob.reward = {{"kit_quest1"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 15
  tempJob.categories = {"electronics"}

  ix.jobs.register(tempJob, "ItemJob1_value_tape_electric")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "%d Electric Tapes."
  tempJob.desc = "%d Electric Tapes."
  tempJob.icon = "stalker/questpaper_item.png"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_value_tape_electric"
  tempJob.numberRec = 2
  tempJob.reward = {{"kit_quest1"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 15
  tempJob.categories = {"electronics"}

  ix.jobs.register(tempJob, "ItemJob2_value_tape_electric")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "%d Electrical Wire."
  tempJob.desc = "%d Electrical Wire."
  tempJob.icon = "stalker/questpaper_item.png"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_value_wire_light"
  tempJob.numberRec = 1
  tempJob.reward = {{"kit_quest1"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 15
  tempJob.categories = {"electronics"}

  ix.jobs.register(tempJob, "ItemJob1_value_wire_light")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "%d Electrical Wires."
  tempJob.desc = "%d Electrical Wires."
  tempJob.icon = "stalker/questpaper_item.png"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_value_wire_light"
  tempJob.numberRec = 2
  tempJob.reward = {{"kit_quest1"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 15
  tempJob.categories = {"electronics"}

  ix.jobs.register(tempJob, "ItemJob2_value_wire_light")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "%d 1.5 Volt Batteries."
  tempJob.desc = "%d 1.5 Volt Batteries."
  tempJob.icon = "stalker/questpaper_item.png"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_value_battery"
  tempJob.numberRec = 3
  tempJob.reward = {{"kit_quest1"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 15
  tempJob.categories = {"electronics"}

  ix.jobs.register(tempJob, "ItemJob1_value_battery")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "%d 1.5 Volt Batteries."
  tempJob.desc = "%d 1.5 Volt Batteries."
  tempJob.icon = "stalker/questpaper_item.png"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_value_battery"
  tempJob.numberRec = 20
  tempJob.reward = {{"kit_quest1"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 15
  tempJob.categories = {"electronics"}

  ix.jobs.register(tempJob, "ItemJob2_value_battery")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "%d 9 Volt Batteries."
  tempJob.desc = "%d 9 Volt Batteries."
  tempJob.icon = "stalker/questpaper_item.png"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_value_9vbattery"
  tempJob.numberRec = 3
  tempJob.reward = {{"kit_quest1"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 15
  tempJob.categories = {"electronics"}

  ix.jobs.register(tempJob, "ItemJob1_value_9vbattery")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "%d 9 Volt Batteries."
  tempJob.desc = "%d 9 Volt Batteries."
  tempJob.icon = "stalker/questpaper_item.png"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_value_9vbattery"
  tempJob.numberRec = 20
  tempJob.reward = {{"kit_quest2"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 15
  tempJob.categories = {"electronics"}

  ix.jobs.register(tempJob, "ItemJob2_value_9vbattery")

  tempJob = nil

-----------------------------------------------------
-----------------------------------------------------
-------- ITEM RETRIEVAL - GUNS/REPAIRING  -----------
-----------------------------------------------------
-----------------------------------------------------

  local tempJob = {}

  tempJob.name = "%d Household Glue."
  tempJob.desc = "%d Household Glue."
  tempJob.icon = "stalker/questpaper_item.png"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_value_glue_1"
  tempJob.numberRec = 1
  tempJob.reward = {{"kit_quest1"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 15
  tempJob.categories = {"repair"}

  ix.jobs.register(tempJob, "ItemJob1_value_glue_1")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "%d Household Glue."
  tempJob.desc = "%d Household Glue."
  tempJob.icon = "stalker/questpaper_item.png"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_value_glue_1"
  tempJob.numberRec = 2
  tempJob.reward = {{"kit_quest2"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 20
  tempJob.categories = {"repair"}

  ix.jobs.register(tempJob, "ItemJob2_value_glue_1")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "%d Superglue."
  tempJob.desc = "%d Superglue."
  tempJob.icon = "stalker/questpaper_item.png"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_value_glue_2"
  tempJob.numberRec = 1
  tempJob.reward = {{"kit_quest1"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 15
  tempJob.categories = {"repair"}

  ix.jobs.register(tempJob, "ItemJob1_value_glue_2")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "%d Superglue."
  tempJob.desc = "%d Superglue."
  tempJob.icon = "stalker/questpaper_item.png"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_value_glue_2"
  tempJob.numberRec = 2
  tempJob.reward = {{"kit_quest2"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 20
  tempJob.categories = {"repair"}

  ix.jobs.register(tempJob, "ItemJob2_value_glue_2")

  tempJob = nil


  local tempJob = {}

  tempJob.name = "%d Texture Glue."
  tempJob.desc = "%d Texture Glue."
  tempJob.icon = "stalker/questpaper_item.png"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_value_glue_3"
  tempJob.numberRec = 1
  tempJob.reward = {{"kit_quest1"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 15
  tempJob.categories = {"repair"}

  ix.jobs.register(tempJob, "ItemJob1_value_glue_3")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "%d Texture Glue."
  tempJob.desc = "%d Texture Glue."
  tempJob.icon = "stalker/questpaper_item.png"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_value_glue_3"
  tempJob.numberRec = 2
  tempJob.reward = {{"kit_quest2"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 20
  tempJob.categories = {"repair"}

  ix.jobs.register(tempJob, "ItemJob2_value_glue_3")

  tempJob = nil


  local tempJob = {}

  tempJob.name = "%d Universal Glue."
  tempJob.desc = "%d Universal Glue."
  tempJob.icon = "stalker/questpaper_item.png"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_value_glue_4"
  tempJob.numberRec = 1
  tempJob.reward = {{"kit_quest1"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 15
  tempJob.categories = {"repair"}

  ix.jobs.register(tempJob, "ItemJob1_value_glue_4")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "%d Universal Glue."
  tempJob.desc = "%d Universal Glue."
  tempJob.icon = "stalker/questpaper_item.png"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_value_glue_4"
  tempJob.numberRec = 2
  tempJob.reward = {{"kit_quest2"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 20
  tempJob.categories = {"repair"}

  ix.jobs.register(tempJob, "ItemJob2_value_glue_4")

  tempJob = nil


  local tempJob = {}

  tempJob.name = "%d Military-Grade Weapon Cleaner."
  tempJob.desc = "%d Military-Grade Weapon Cleaner."
  tempJob.icon = "stalker/questpaper_item.png"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_value_guncleaner"
  tempJob.numberRec = 1
  tempJob.reward = {{"kit_quest1"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 15
  tempJob.categories = {"repair"}

  ix.jobs.register(tempJob, "ItemJob1_value_guncleaner")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "%d Military-Grade Weapon Cleaner."
  tempJob.desc = "%d Military-Grade Weapon Cleaner."
  tempJob.icon = "stalker/questpaper_item.png"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_value_guncleaner"
  tempJob.numberRec = 2
  tempJob.reward = {{"kit_quest2"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 20
  tempJob.categories = {"repair"}

  ix.jobs.register(tempJob, "ItemJob2_value_guncleaner")

  tempJob = nil


  local tempJob = {}

  tempJob.name = "%d Civilian-Grade Gun Oil."
  tempJob.desc = "%d Civilian-Grade Gun Oil."
  tempJob.icon = "stalker/questpaper_item.png"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_value_gunoil"
  tempJob.numberRec = 1
  tempJob.reward = {{"kit_quest1"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 15
  tempJob.categories = {"repair"}

  ix.jobs.register(tempJob, "ItemJob1_value_gunoil")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "%d Civilian-Grade Gun Oil."
  tempJob.desc = "%d Civilian-Grade Gun Oil."
  tempJob.icon = "stalker/questpaper_item.png"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_value_gunoil"
  tempJob.numberRec = 2
  tempJob.reward = {{"kit_quest2"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 20
  tempJob.categories = {"repair"}

  ix.jobs.register(tempJob, "ItemJob2_value_gunoil")

  tempJob = nil


  local tempJob = {}

  tempJob.name = "%d Weapon Lubricant Spray."
  tempJob.desc = "%d Weapon Lubricant Spray."
  tempJob.icon = "stalker/questpaper_item.png"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_value_gunspray"
  tempJob.numberRec = 1
  tempJob.reward = {{"kit_quest1"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 15
  tempJob.categories = {"repair"}

  ix.jobs.register(tempJob, "ItemJob1_value_gunspray")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "%d Weapon Lubricant Spray."
  tempJob.desc = "%d Weapon Lubricant Spray."
  tempJob.icon = "stalker/questpaper_item.png"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_value_gunspray"
  tempJob.numberRec = 2
  tempJob.reward = {{"kit_quest2"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 20
  tempJob.categories = {"repair"}

  ix.jobs.register(tempJob, "ItemJob2_value_gunspray")

  tempJob = nil


  local tempJob = {}

  tempJob.name = "%d Firearm Lubricant."
  tempJob.desc = "%d Firearm Lubricant."
  tempJob.icon = "stalker/questpaper_item.png"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_value_lubricant"
  tempJob.numberRec = 1
  tempJob.reward = {{"kit_quest1"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 15
  tempJob.categories = {"repair"}

  ix.jobs.register(tempJob, "ItemJob1_value_lubricant")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "%d Firearm Lubricant."
  tempJob.desc = "%d Firearm Lubricant."
  tempJob.icon = "stalker/questpaper_item.png"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_value_lubricant"
  tempJob.numberRec = 2
  tempJob.reward = {{"kit_quest2"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 20
  tempJob.categories = {"repair"}

  ix.jobs.register(tempJob, "ItemJob2_value_lubricant")

  tempJob = nil  

-----------------------------------------------------
-----------------------------------------------------
-------- ITEM RETRIEVAL - MECHANICAL/TOWN -----------
-----------------------------------------------------
-----------------------------------------------------

  local tempJob = {}

  tempJob.name = "%d Bolts."
  tempJob.desc = "%d Bolts."
  tempJob.icon = "stalker/questpaper_item.png"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_value_bolts"
  tempJob.numberRec = 4
  tempJob.reward = {{"kit_quest1"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 15
  tempJob.categories = {"mechanical", "town"}

  ix.jobs.register(tempJob, "ItemJob1_value_bolts")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "%d Bolts."
  tempJob.desc = "%d Bolts."
  tempJob.icon = "stalker/questpaper_item.png"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_value_bolts"
  tempJob.numberRec = 20
  tempJob.reward = {{"kit_quest2"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 20
  tempJob.categories = {"mechanical", "town"}

  ix.jobs.register(tempJob, "ItemJob2_value_bolts")

  tempJob = nil


  local tempJob = {}

  tempJob.name = "%d Nuts."
  tempJob.desc = "%d Nuts."
  tempJob.icon = "stalker/questpaper_item.png"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_value_nuts"
  tempJob.numberRec = 4
  tempJob.reward = {{"kit_quest1"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 15
  tempJob.categories = {"mechanical", "town"}

  ix.jobs.register(tempJob, "ItemJob1_value_nuts")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "%d Nuts."
  tempJob.desc = "%d Nuts."
  tempJob.icon = "stalker/questpaper_item.png"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_value_nuts"
  tempJob.numberRec = 20
  tempJob.reward = {{"kit_quest2"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 20
  tempJob.categories = {"mechanical", "town"}

  ix.jobs.register(tempJob, "ItemJob2_value_nuts")

  tempJob = nil


  local tempJob = {}

  tempJob.name = "%d Propane Tank."
  tempJob.desc = "%d Propane Tank."
  tempJob.icon = "stalker/questpaper_item.png"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_value_propanetank"
  tempJob.numberRec = 1
  tempJob.reward = {{"kit_quest1"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 15
  tempJob.categories = {"mechanical", "town"}

  ix.jobs.register(tempJob, "ItemJob1_value_propanetank")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "%d Propane Tanks."
  tempJob.desc = "%d Propane Tanks."
  tempJob.icon = "stalker/questpaper_item.png"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_value_propanetank"
  tempJob.numberRec = 2
  tempJob.reward = {{"kit_quest2"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 20
  tempJob.categories = {"mechanical", "town"}

  ix.jobs.register(tempJob, "ItemJob2_value_propanetank")

  tempJob = nil


  local tempJob = {}

  tempJob.name = "%d Gasoline Can."
  tempJob.desc = "%d Gasoline Can."
  tempJob.icon = "stalker/questpaper_item.png"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_value_gasoline"
  tempJob.numberRec = 1
  tempJob.reward = {{"kit_quest1"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 15
  tempJob.categories = {"mechanical", "town"}

  ix.jobs.register(tempJob, "ItemJob1_value_gasoline")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "%d Gasoline Cans."
  tempJob.desc = "%d Gasoline Cans."
  tempJob.icon = "stalker/questpaper_item.png"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_value_gasoline"
  tempJob.numberRec = 2
  tempJob.reward = {{"kit_quest2"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 20
  tempJob.categories = {"mechanical", "town"}

  ix.jobs.register(tempJob, "ItemJob2_value_gasoline")

  tempJob = nil


  local tempJob = {}

  tempJob.name = "%d Kerosene Can."
  tempJob.desc = "%d Kerosene Can."
  tempJob.icon = "stalker/questpaper_item.png"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_value_kerosene"
  tempJob.numberRec = 1
  tempJob.reward = {{"kit_quest1"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 15
  tempJob.categories = {"mechanical", "town"}

  ix.jobs.register(tempJob, "ItemJob1_value_kerosene")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "%d Kerosene Cans."
  tempJob.desc = "%d Kerosene Cans."
  tempJob.icon = "stalker/questpaper_item.png"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_value_kerosene"
  tempJob.numberRec = 2
  tempJob.reward = {{"kit_quest2"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 20
  tempJob.categories = {"mechanical", "town"}

  ix.jobs.register(tempJob, "ItemJob2_value_kerosene")

  tempJob = nil


  local tempJob = {}

  tempJob.name = "%d Diesel Motor Conditioner."
  tempJob.desc = "%d Diesel Motor Conditioner."
  tempJob.icon = "stalker/questpaper_item.png"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_value_motorclean"
  tempJob.numberRec = 1
  tempJob.reward = {{"kit_quest1"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 15
  tempJob.categories = {"mechanical", "town"}

  ix.jobs.register(tempJob, "ItemJob1_value_motorclean")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "%d Diesel Motor Conditioners."
  tempJob.desc = "%d Diesel Motor Conditioners."
  tempJob.icon = "stalker/questpaper_item.png"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_value_motorclean"
  tempJob.numberRec = 2
  tempJob.reward = {{"kit_quest2"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 20
  tempJob.categories = {"mechanical", "town"}

  ix.jobs.register(tempJob, "ItemJob2_value_motorclean")

  tempJob = nil


  local tempJob = {}

  tempJob.name = "%d Spark Plugs."
  tempJob.desc = "%d Spark Plugs."
  tempJob.icon = "stalker/questpaper_item.png"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_value_sparkplug"
  tempJob.numberRec = 2
  tempJob.reward = {{"kit_quest1"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 15
  tempJob.categories = {"mechanical", "town"}

  ix.jobs.register(tempJob, "ItemJob1_value_sparkplug")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "%d Spark Plugs."
  tempJob.desc = "%d Spark Plugs."
  tempJob.icon = "stalker/questpaper_item.png"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_value_sparkplug"
  tempJob.numberRec = 5
  tempJob.reward = {{"kit_quest2"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 20
  tempJob.categories = {"mechanical", "town"}

  ix.jobs.register(tempJob, "ItemJob2_value_sparkplug")

  tempJob = nil


  local tempJob = {}

  tempJob.name = "%d Light Bulb."
  tempJob.desc = "%d Light Bulb."
  tempJob.icon = "stalker/questpaper_item.png"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_value_lightbulb"
  tempJob.numberRec = 1
  tempJob.reward = {{"kit_quest1"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 15
  tempJob.categories = {"town"}

  ix.jobs.register(tempJob, "ItemJob1_value_lightbulb")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "%d Light Bulbs."
  tempJob.desc = "%d Light Bulbs."
  tempJob.icon = "stalker/questpaper_item.png"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_value_lightbulb"
  tempJob.numberRec = 2
  tempJob.reward = {{"kit_quest2"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 20
  tempJob.categories = {"town"}

  ix.jobs.register(tempJob, "ItemJob2_value_lightbulb")

  tempJob = nil


  local tempJob = {}

  tempJob.name = "%d Car Battery."
  tempJob.desc = "%d Car Battery."
  tempJob.icon = "stalker/questpaper_item.png"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_value_carbattery"
  tempJob.numberRec = 1
  tempJob.reward = {{"kit_quest1"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 15
  tempJob.categories = {"mechanical", "town"}

  ix.jobs.register(tempJob, "ItemJob1_value_carbattery")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "%d Car Batteries."
  tempJob.desc = "%d Car Batteries."
  tempJob.icon = "stalker/questpaper_item.png"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_value_carbattery"
  tempJob.numberRec = 2
  tempJob.reward = {{"kit_quest2"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 20
  tempJob.categories = {"mechanical", "town"}

  ix.jobs.register(tempJob, "ItemJob2_value_carbattery")

  tempJob = nil


  local tempJob = {}

  tempJob.name = "%d Duct Tape."
  tempJob.desc = "%d Duct Tape."
  tempJob.icon = "stalker/questpaper_item.png"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_value_tape_duct"
  tempJob.numberRec = 1
  tempJob.reward = {{"kit_quest1"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 15
  tempJob.categories = {"mechanical", "town"}

  ix.jobs.register(tempJob, "ItemJob1_value_tape_duct")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "%d Duct Tapes."
  tempJob.desc = "%d Duct Tapes."
  tempJob.icon = "stalker/questpaper_item.png"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_value_tape_duct"
  tempJob.numberRec = 2
  tempJob.reward = {{"kit_quest2"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 20
  tempJob.categories = {"mechanical", "town"}

  ix.jobs.register(tempJob, "ItemJob2_value_tape_duct")

  tempJob = nil


  local tempJob = {}

  tempJob.name = "%d Military-Grade Adhesive Tape."
  tempJob.desc = "%d Military-Grade Adhesive Tape."
  tempJob.icon = "stalker/questpaper_item.png"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_value_tape_heavy"
  tempJob.numberRec = 1
  tempJob.reward = {{"kit_quest1"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 15
  tempJob.categories = {"mechanical", "town"}

  ix.jobs.register(tempJob, "ItemJob1_value_tape_heavy")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "%d Military-Grade Adhesive Tape."
  tempJob.desc = "%d Military-Grade Adhesive Tape."
  tempJob.icon = "stalker/questpaper_item.png"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_value_tape_heavy"
  tempJob.numberRec = 2
  tempJob.reward = {{"kit_quest2"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 20
  tempJob.categories = {"mechanical", "town"}

  ix.jobs.register(tempJob, "ItemJob2_value_tape_heavy")

  tempJob = nil


  local tempJob = {}

  tempJob.name = "%d Diesel Engine."
  tempJob.desc = "%d Diesel Engine."
  tempJob.icon = "stalker/questpaper_item.png"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_value_engine"
  tempJob.numberRec = 1
  tempJob.reward = {{"kit_quest1"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 15
  tempJob.categories = {"mechanical", "town"}

  ix.jobs.register(tempJob, "ItemJob1_value_engine")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "%d Diesel Engines."
  tempJob.desc = "%d Diesel Engines."
  tempJob.icon = "stalker/questpaper_item.png"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_value_engine"
  tempJob.numberRec = 2
  tempJob.reward = {{"kit_quest2"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 20
  tempJob.categories = {"mechanical", "town"}

  ix.jobs.register(tempJob, "ItemJob2_value_engine")

  tempJob = nil


  local tempJob = {}

  tempJob.name = "%d Water Filter."
  tempJob.desc = "%d Water Filter."
  tempJob.icon = "stalker/questpaper_item.png"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_value_waterfilter"
  tempJob.numberRec = 1
  tempJob.reward = {{"kit_quest1"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 15
  tempJob.categories = {"town"}

  ix.jobs.register(tempJob, "ItemJob1_value_waterfilter")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "%d Water Filters."
  tempJob.desc = "%d Water Filters."
  tempJob.icon = "stalker/questpaper_item.png"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_value_waterfilter"
  tempJob.numberRec = 2
  tempJob.reward = {{"kit_quest2"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 20
  tempJob.categories = {"town"}

  ix.jobs.register(tempJob, "ItemJob2_value_waterfilter")

  tempJob = nil


  local tempJob = {}

  tempJob.name = "%d Pack of Nails."
  tempJob.desc = "%d Pack of Nails."
  tempJob.icon = "stalker/questpaper_item.png"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_value_nails"
  tempJob.numberRec = 1
  tempJob.reward = {{"kit_quest1"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 15
  tempJob.categories = {"mechanical", "town"}

  ix.jobs.register(tempJob, "ItemJob1_value_nails")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "%d Packs of Nails."
  tempJob.desc = "%d Packs of Nails."
  tempJob.icon = "stalker/questpaper_item.png"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_value_nails"
  tempJob.numberRec = 2
  tempJob.reward = {{"kit_quest2"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 20
  tempJob.categories = {"mechanical", "town"}

  ix.jobs.register(tempJob, "ItemJob2_value_nails")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "%d Copper Wire."
  tempJob.desc = "%d Copper Wire."
  tempJob.icon = "stalker/questpaper_item.png"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_value_wire_copper"
  tempJob.numberRec = 1
  tempJob.reward = {{"kit_quest1"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 15
  tempJob.categories = {"mechanical", "town", "electronics"}

  ix.jobs.register(tempJob, "ItemJob1_value_wire_copper")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "%d Copper Wire."
  tempJob.desc = "%d Copper Wire."
  tempJob.icon = "stalker/questpaper_item.png"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_value_wire_copper"
  tempJob.numberRec = 2
  tempJob.reward = {{"kit_quest2"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 20
  tempJob.categories = {"mechanical", "town", "electronics"}

  ix.jobs.register(tempJob, "ItemJob2_value_wire_copper")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "%d Heavy Duty Cabling."
  tempJob.desc = "%d Heavy Duty Cabling."
  tempJob.icon = "stalker/questpaper_item.png"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_value_wire_heavy"
  tempJob.numberRec = 1
  tempJob.reward = {{"kit_quest1"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 15
  tempJob.categories = {"mechanical", "town"}

  ix.jobs.register(tempJob, "ItemJob1_value_wire_heavy")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "%d Heavy Duty Cabling."
  tempJob.desc = "%d Heavy Duty Cabling."
  tempJob.icon = "stalker/questpaper_item.png"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_value_wire_heavy"
  tempJob.numberRec = 2
  tempJob.reward = {{"kit_quest2"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 20
  tempJob.categories = {"mechanical", "town"}

  ix.jobs.register(tempJob, "ItemJob2_value_wire_heavy")

  tempJob = nil


  local tempJob = {}

  tempJob.name = "%d Plastic Hose."
  tempJob.desc = "%d Plastic Hose."
  tempJob.icon = "stalker/questpaper_item.png"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_value_hose"
  tempJob.numberRec = 1
  tempJob.reward = {{"kit_quest1"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 15
  tempJob.categories = {"town"}

  ix.jobs.register(tempJob, "ItemJob1_value_hose")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "%d Plastic Hoses."
  tempJob.desc = "%d Plastic Hoses."
  tempJob.icon = "stalker/questpaper_item.png"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_value_hose"
  tempJob.numberRec = 2
  tempJob.reward = {{"kit_quest2"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 20
  tempJob.categories = {"town"}

  ix.jobs.register(tempJob, "ItemJob2_value_hose")

  tempJob = nil


  local tempJob = {}

  tempJob.name = "%d Paracord."
  tempJob.desc = "%d Paracord."
  tempJob.icon = "stalker/questpaper_item.png"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_value_paracord"
  tempJob.numberRec = 1
  tempJob.reward = {{"kit_quest1"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 15
  tempJob.categories = {"town"}

  ix.jobs.register(tempJob, "ItemJob1_value_paracord")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "%d Paracord."
  tempJob.desc = "%d Paracord."
  tempJob.icon = "stalker/questpaper_item.png"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_value_paracord"
  tempJob.numberRec = 2
  tempJob.reward = {{"kit_quest2"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 20
  tempJob.categories = {"town"}

  ix.jobs.register(tempJob, "ItemJob2_value_paracord")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "%d Alkaline Booster."
  tempJob.desc = "%d Alkaline Booster."
  tempJob.icon = "stalker/questpaper_item.png"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_value_detergent"
  tempJob.numberRec = 1
  tempJob.reward = {{"kit_quest1"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 15
  tempJob.categories = {"town"}

  ix.jobs.register(tempJob, "ItemJob1_value_detergent")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "%d Alkaline Booster."
  tempJob.desc = "%d Alkaline Booster."
  tempJob.icon = "stalker/questpaper_item.png"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_value_detergent"
  tempJob.numberRec = 2
  tempJob.reward = {{"kit_quest2"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 20
  tempJob.categories = {"town"}

  ix.jobs.register(tempJob, "ItemJob2_value_detergent")

  tempJob = nil


  local tempJob = {}

  tempJob.name = "%d Toothpaste."
  tempJob.desc = "%d Toothpaste."
  tempJob.icon = "stalker/questpaper_item.png"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_value_toothpaste"
  tempJob.numberRec = 1
  tempJob.reward = {{"kit_quest1"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 15
  tempJob.categories = {"town"}

  ix.jobs.register(tempJob, "ItemJob1_value_toothpaste")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "%d Toothpaste."
  tempJob.desc = "%d Toothpaste."
  tempJob.icon = "stalker/questpaper_item.png"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_value_toothpaste"
  tempJob.numberRec = 2
  tempJob.reward = {{"kit_quest2"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 20
  tempJob.categories = {"town"}

  ix.jobs.register(tempJob, "ItemJob2_value_toothpaste")

  tempJob = nil


  local tempJob = {}

  tempJob.name = "%d Toilet Paper."
  tempJob.desc = "%d Toilet Paper."
  tempJob.icon = "stalker/questpaper_item.png"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_value_toiletpaper"
  tempJob.numberRec = 1
  tempJob.reward = {{"kit_quest1"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 15
  tempJob.categories = {"town"}

  ix.jobs.register(tempJob, "ItemJob1_value_toiletpaper")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "%d Toilet Papers."
  tempJob.desc = "%d Toilet Papers."
  tempJob.icon = "stalker/questpaper_item.png"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_value_toiletpaper"
  tempJob.numberRec = 2
  tempJob.reward = {{"kit_quest2"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 20
  tempJob.categories = {"town"}

  ix.jobs.register(tempJob, "ItemJob2_value_toiletpaper")

  tempJob = nil



-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------
-------- ITEM RETRIEVAL - RICHES (Single Item, as they are rare) --------------------
-------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------

  local tempJob = {}

  tempJob.name = "%d Cat Statuette."
  tempJob.desc = "%d Cat Statuette."
  tempJob.icon = "stalker/questpaper_item.png"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_value_statue_cat"
  tempJob.numberRec = 1
  tempJob.reward = {{"kit_quest2"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 25
  tempJob.categories = {"riches"}

  ix.jobs.register(tempJob, "ItemJob1_value_statue_cat")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "%d Horse Statuette."
  tempJob.desc = "%d Horse Statuette."
  tempJob.icon = "stalker/questpaper_item.png"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_value_statue_horse"
  tempJob.numberRec = 1
  tempJob.reward = {{"kit_quest2"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 25
  tempJob.categories = {"riches"}

  ix.jobs.register(tempJob, "ItemJob1_value_statue_horse")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "%d Lion Statuette."
  tempJob.desc = "%d Lion Statuette."
  tempJob.icon = "stalker/questpaper_item.png"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_value_statue_lion"
  tempJob.numberRec = 1
  tempJob.reward = {{"kit_quest2"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 25
  tempJob.categories = {"riches"}

  ix.jobs.register(tempJob, "ItemJob1_value_statue_lion")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "%d Watch."
  tempJob.desc = "%d Watch."
  tempJob.icon = "stalker/questpaper_item.png"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_value_watch"
  tempJob.numberRec = 1
  tempJob.reward = {{"kit_quest2"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 25
  tempJob.categories = {"riches"}

  ix.jobs.register(tempJob, "ItemJob1_value_watch")

  tempJob = nil


  local tempJob = {}

  tempJob.name = "%d Gold Chain."
  tempJob.desc = "%d Gold Chain."
  tempJob.icon = "stalker/questpaper_item.png"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_value_goldchain"
  tempJob.numberRec = 1
  tempJob.reward = {{"kit_quest2"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 45
  tempJob.categories = {"riches"}

  ix.jobs.register(tempJob, "ItemJob1_value_goldchain")

  tempJob = nil


  local tempJob = {}

  tempJob.name = "%d Old Smartphone (Broken)."
  tempJob.desc = "%d Old Smartphone (Broken)."
  tempJob.icon = "stalker/questpaper_item.png"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_value_phone_old"
  tempJob.numberRec = 1
  tempJob.reward = {{"kit_quest1"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 25
  tempJob.categories = {"information"}

  ix.jobs.register(tempJob, "ItemJob1_value_phone_old")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "%d New Smartphone (Broken)."
  tempJob.desc = "%d New Smartphone (Broken)."
  tempJob.icon = "stalker/questpaper_item.png"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_value_phone_new"
  tempJob.numberRec = 1
  tempJob.reward = {{"kit_quest2"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 35
  tempJob.categories = {"information"}

  ix.jobs.register(tempJob, "ItemJob1_value_phone_new")

  tempJob = nil


  local tempJob = {}

  tempJob.name = "%d Empty Noteblock."
  tempJob.desc = "%d Empty Noteblock."
  tempJob.icon = "stalker/questpaper_item.png"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_value_documents_1"
  tempJob.numberRec = 1
  tempJob.reward = {{"kit_quest2"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 35
  tempJob.categories = {"information"}

  ix.jobs.register(tempJob, "ItemJob1_value_documents_1")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "%d Trading Ledger."
  tempJob.desc = "%d Trading Ledger."
  tempJob.icon = "stalker/questpaper_item.png"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_value_documents_2"
  tempJob.numberRec = 1
  tempJob.reward = {{"kit_quest2"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 35
  tempJob.categories = {"information"}

  ix.jobs.register(tempJob, "ItemJob1_value_documents_2")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "%d Scientist Curriculum Vitae."
  tempJob.desc = "%d Scientist Curriculum Vitae."
  tempJob.icon = "stalker/questpaper_item.png"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_value_documents_3"
  tempJob.numberRec = 1
  tempJob.reward = {{"kit_quest2"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 35
  tempJob.categories = {"information"}

  ix.jobs.register(tempJob, "ItemJob1_value_documents_3")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "%d Scribbled Scientific Notes."
  tempJob.desc = "%d Scribbled Scientific Notes."
  tempJob.icon = "stalker/questpaper_item.png"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_value_documents_4"
  tempJob.numberRec = 1
  tempJob.reward = {{"kit_quest2"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 35
  tempJob.categories = {"information"}

  ix.jobs.register(tempJob, "ItemJob1_value_documents_4")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "%d Handdrawn Anomaly Map."
  tempJob.desc = "%d Handdrawn Anomaly Map."
  tempJob.icon = "stalker/questpaper_item.png"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_value_documents_5"
  tempJob.numberRec = 1
  tempJob.reward = {{"kit_quest2"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 35
  tempJob.categories = {"information"}

  ix.jobs.register(tempJob, "ItemJob1_value_documents_5")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "%d Pump Station Checklist."
  tempJob.desc = "%d Pump Station Checklist."
  tempJob.icon = "stalker/questpaper_item.png"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_value_documents_6"
  tempJob.numberRec = 1
  tempJob.reward = {{"kit_quest2"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 35
  tempJob.categories = {"information"}

  ix.jobs.register(tempJob, "ItemJob1_value_documents_6")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "%d Firearm Assembly Illustration."
  tempJob.desc = "%d Firearm Assembly Illustration."
  tempJob.icon = "stalker/questpaper_item.png"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_value_documents_7"
  tempJob.numberRec = 1
  tempJob.reward = {{"kit_quest2"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 35
  tempJob.categories = {"information"}

  ix.jobs.register(tempJob, "ItemJob1_value_documents_7")

  tempJob = nil

    local tempJob = {}

  tempJob.name = "%d Unreadable Torn Note."
  tempJob.desc = "%d Unreadable Torn Note."
  tempJob.icon = "stalker/questpaper_item.png"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_value_documents_8"
  tempJob.numberRec = 1
  tempJob.reward = {{"kit_quest2"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 35
  tempJob.categories = {"information"}

  ix.jobs.register(tempJob, "ItemJob1_value_documents_8")

  tempJob = nil

    local tempJob = {}

  tempJob.name = "%d Swamps Research Documents."
  tempJob.desc = "%d Swamps Research Documents."
  tempJob.icon = "stalker/questpaper_item.png"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_value_documents_9"
  tempJob.numberRec = 1
  tempJob.reward = {{"kit_quest2"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 35
  tempJob.categories = {"information"}

  ix.jobs.register(tempJob, "ItemJob1_value_documents_9")

  tempJob = nil


    local tempJob = {}

  tempJob.name = "%d Anomalous Material Report."
  tempJob.desc = "%d Anomalous Material Report."
  tempJob.icon = "stalker/questpaper_item.png"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_value_documents_10"
  tempJob.numberRec = 1
  tempJob.reward = {{"kit_quest2"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 35
  tempJob.categories = {"information"}

  ix.jobs.register(tempJob, "ItemJob1_value_documents_10")

  tempJob = nil

    local tempJob = {}

  tempJob.name = "%d Artifact Research Ledger."
  tempJob.desc = "%d Artifact Research Ledger."
  tempJob.icon = "stalker/questpaper_item.png"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_value_documents_11"
  tempJob.numberRec = 1
  tempJob.reward = {{"kit_quest2"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 35
  tempJob.categories = {"information"}

  ix.jobs.register(tempJob, "ItemJob1_value_documents_11")

  tempJob = nil

    local tempJob = {}

  tempJob.name = "%d Soviet Manual of Arms."
  tempJob.desc = "%d Soviet Manual of Arms."
  tempJob.icon = "stalker/questpaper_item.png"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_value_documents_12"
  tempJob.numberRec = 1
  tempJob.reward = {{"kit_quest2"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 35
  tempJob.categories = {"information"}

  ix.jobs.register(tempJob, "ItemJob1_value_documents_12")

  tempJob = nil

    local tempJob = {}

  tempJob.name = "%d Manufacture of Gear Wheels."
  tempJob.desc = "%d Manufacture of Gear Wheels."
  tempJob.icon = "stalker/questpaper_item.png"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_value_documents_13"
  tempJob.numberRec = 1
  tempJob.reward = {{"kit_quest2"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 35
  tempJob.categories = {"information"}

  ix.jobs.register(tempJob, "ItemJob1_value_documents_13")

  tempJob = nil

    local tempJob = {}

  tempJob.name = "%d Kevlar Sewing Manual."
  tempJob.desc = "%d Kevlar Sewing Manual."
  tempJob.icon = "stalker/questpaper_item.png"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_value_documents_14"
  tempJob.numberRec = 1
  tempJob.reward = {{"kit_quest2"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 35
  tempJob.categories = {"information"}

  ix.jobs.register(tempJob, "ItemJob1_value_documents_14")

  tempJob = nil
end
