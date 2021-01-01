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

/*
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
*/

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

  tempJob.name = "%d pieces of hellhound meat."
  tempJob.desc = "%d pieces of hellhound meat."
  tempJob.icon = "stalker/questpaper_item.png"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_meat_hellhound"
  tempJob.numberRec = 2
  tempJob.reward = {{"kit_quest2"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 15
  tempJob.categories = {"mutantmeatmedium"}

  ix.jobs.register(tempJob, "ItemJob1_meat_hellhound")

  tempJob = nil


  local tempJob = {}

  tempJob.name = "%d pieces of human meat."
  tempJob.desc = "%d pieces of human meat."
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

  tempJob.name = "%d pieces of sprig meat."
  tempJob.desc = "%d pieces of sprig meat."
  tempJob.icon = "stalker/questpaper_item.png"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_meat_sprig"
  tempJob.numberRec = 2
  tempJob.reward = {{"kit_quest2"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 15
  tempJob.categories = {"mutantmeatmedium"}

  ix.jobs.register(tempJob, "ItemJob1_meat_sprig")

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

-----------------------------------------------------
------------- ITEM RETRIEVAL - ELECTRONICS ----------
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
  tempJob.categories = {"electronics"}

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
  tempJob.categories = {"electronics"}

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
  tempJob.categories = {"electronics"}

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
  tempJob.categories = {"electronics"}

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
  tempJob.numberRec = 4
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
end
