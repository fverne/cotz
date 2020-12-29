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
/*
  --TestJob
  local tempJob = {}

  tempJob.name = "Say sneed %d times."
  tempJob.desc = "I need you to sneed %d times for me."
  tempJob.icon = "stalker/questpaper_item.png"
  tempJob.tier = 1
  tempJob.listenTrigger = "chatSayTest"
  tempJob.numberRec = 5
  tempJob.reward = {{"kit_quest1"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 80

  ix.jobs.register(tempJob, "TestJob")

  tempJob = nil
*/

/*
  --item return Job
  local tempJob = {}

  tempJob.name = "%d makarovs."
  tempJob.desc = "xD."
  tempJob.icon = "stalker/questpaper_item.png"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_makarov"
  tempJob.numberRec = {1,1}
  tempJob.reward = {{"kit_quest1"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 15

  ix.jobs.register(tempJob, "ItemJob_makarov")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "%d lead pipes."
  tempJob.desc = "xD."
  tempJob.icon = "stalker/questpaper_item.png"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_leadpipe"
  tempJob.numberRec = {1,1}
  tempJob.reward = {{"kit_quest1"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 15

  ix.jobs.register(tempJob, "ItemJob_leadpipe")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "%d crowbars."
  tempJob.desc = "xD."
  tempJob.icon = "stalker/questpaper_item.png"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_crowbar"
  tempJob.numberRec = {1,1}
  tempJob.reward = {{"kit_quest1"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 15

  ix.jobs.register(tempJob, "ItemJob_crowbar")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "%d bats."
  tempJob.desc = "xD."
  tempJob.icon = "stalker/questpaper_item.png"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_bat"
  tempJob.numberRec = {1,1}
  tempJob.reward = {{"kit_quest1"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 15

  ix.jobs.register(tempJob, "ItemJob_bat")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "%d fire axes."
  tempJob.desc = "xD."
  tempJob.icon = "stalker/questpaper_item.png"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_fireaxe"
  tempJob.numberRec = {1,1}
  tempJob.reward = {{"kit_quest1"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 15

  ix.jobs.register(tempJob, "ItemJob_fireaxe")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "%d anomaly maps."
  tempJob.desc = "xD."
  tempJob.icon = "stalker/questpaper_item.png"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_documents0"
  tempJob.numberRec = {1,1}
  tempJob.reward = {{"kit_quest1"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 15

  ix.jobs.register(tempJob, "ItemJob_documents0")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "%d military maps."
  tempJob.desc = "xD."
  tempJob.icon = "stalker/questpaper_item.png"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_documents1"
  tempJob.numberRec = {1,1}
  tempJob.reward = {{"kit_quest2"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 15

  ix.jobs.register(tempJob, "ItemJob_documents1")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "%d Anomaly Research Documents (simple)."
  tempJob.desc = "xD."
  tempJob.icon = "stalker/questpaper_item.png"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_documents2"
  tempJob.numberRec = {1,1}
  tempJob.reward = {{"kit_quest3"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 15

  ix.jobs.register(tempJob, "ItemJob_documents2")

  tempJob = nil

 local tempJob = {}

  tempJob.name = "%d Beretta 92s."
  tempJob.desc = "xD."
  tempJob.icon = "stalker/questpaper_item.png"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_beretta92"
  tempJob.numberRec = {1,1}
  tempJob.reward = {{"kit_quest1"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 15

  ix.jobs.register(tempJob, "ItemJob_beretta92")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "%d Browning Highpowers."
  tempJob.desc = "xD."
  tempJob.icon = "stalker/questpaper_item.png"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_brhp"
  tempJob.numberRec = {1,1}
  tempJob.reward = {{"kit_quest1"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 15

  ix.jobs.register(tempJob, "ItemJob_brhp")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "%d Tokarevs."
  tempJob.desc = "xD."
  tempJob.icon = "stalker/questpaper_item.png"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_tokarev"
  tempJob.numberRec = {1,1}
  tempJob.reward = {{"kit_quest1"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 15

  ix.jobs.register(tempJob, "ItemJob_tokarev")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "%d CZ-52s."
  tempJob.desc = "xD."
  tempJob.icon = "stalker/questpaper_item.png"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_cz52"
  tempJob.numberRec = {1,1}
  tempJob.reward = {{"kit_quest1"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 15

  ix.jobs.register(tempJob, "ItemJob_cz52")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "%d P99s."
  tempJob.desc = "xD."
  tempJob.icon = "stalker/questpaper_item.png"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_p99"
  tempJob.numberRec = {1,1}
  tempJob.reward = {{"kit_quest1"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 15

  ix.jobs.register(tempJob, "ItemJob_p99")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "%d Fort 12s."
  tempJob.desc = "xD."
  tempJob.icon = "stalker/questpaper_item.png"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_fort12"
  tempJob.numberRec = {1,1}
  tempJob.reward = {{"kit_quest1"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 15

  ix.jobs.register(tempJob, "ItemJob_fort12")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "%d Glock 17s."
  tempJob.desc = "xD."
  tempJob.icon = "stalker/questpaper_item.png"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_glock17"
  tempJob.numberRec = {1,1}
  tempJob.reward = {{"kit_quest1"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 15

  ix.jobs.register(tempJob, "ItemJob_glock17")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "%d Ruger MK3s."
  tempJob.desc = "xD."
  tempJob.icon = "stalker/questpaper_item.png"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_rugermk3"
  tempJob.numberRec = {1,1}
  tempJob.reward = {{"kit_quest1"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 15

  ix.jobs.register(tempJob, "ItemJob_rugermk3")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "%d Black Flashdrives."
  tempJob.desc = "xD."
  tempJob.icon = "stalker/questpaper_item.png"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_flashdriveblack"
  tempJob.numberRec = {1,1}
  tempJob.reward = {{"kit_quest2"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 15

  ix.jobs.register(tempJob, "ItemJob_flashdriveblack")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "%d Blue Flashdrives."
  tempJob.desc = "xD."
  tempJob.icon = "stalker/questpaper_item.png"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_flashdriveblue"
  tempJob.numberRec = {1,1}
  tempJob.reward = {{"kit_quest2"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 15

  ix.jobs.register(tempJob, "ItemJob_flashdriveblue")

  tempJob = nil*/

  local tempJob = {}

  tempJob.name = "%d Personal Belongings."
  tempJob.desc = "xD."
  tempJob.icon = "stalker/questpaper_item.png"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_documents4"
  tempJob.numberRec = {1,1}
  tempJob.reward = {{"kit_quest1"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 15

  ix.jobs.register(tempJob, "ItemJob_documents4")

  tempJob = nil

  /*local tempJob = {}

  tempJob.name = "%d Traders Journals."
  tempJob.desc = "xD."
  tempJob.icon = "stalker/questpaper_item.png"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_documents8"
  tempJob.numberRec = {1,1}
  tempJob.reward = {{"kit_quest1"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 15

  ix.jobs.register(tempJob, "ItemJob_documents8")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "%d Ecologists Journals."
  tempJob.desc = "xD."
  tempJob.icon = "stalker/questpaper_item.png"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_documents8"
  tempJob.numberRec = {1,1}
  tempJob.reward = {{"kit_quest1"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 15

  ix.jobs.register(tempJob, "ItemJob_documents9")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "%d GPS Mapping Devices."
  tempJob.desc = "xD."
  tempJob.icon = "stalker/questpaper_item.png"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_gpsmappingdevice"
  tempJob.numberRec = {1,1}
  tempJob.reward = {{"kit_quest1"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 15

  ix.jobs.register(tempJob, "ItemJob_gpsmappingdevice")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "%d GPS Tracking Devices."
  tempJob.desc = "xD."
  tempJob.icon = "stalker/questpaper_item.png"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_gpstrackingdevice"
  tempJob.numberRec = {1,1}
  tempJob.reward = {{"kit_quest1"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 15

  ix.jobs.register(tempJob, "ItemJob_gpstrackingdevice")

  tempJob = nil
*/

  --random amount of mutants
  local tempJob = {}

  tempJob.name = "%d mutants."
  tempJob.desc = "%d mutants."
  tempJob.icon = "stalker/questpaper_mutant.png"
  tempJob.tier = 1
  tempJob.listenTrigger = "mutantKilled"
  tempJob.numberRec = 12
  tempJob.reward = {{"kit_quest1"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 15
  tempJob.categories = {"mutantkillgroupeasy"}

  ix.jobs.register(tempJob, "killMutantsLow")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "%d mutants."
  tempJob.desc = "%d mutants."
  tempJob.icon = "stalker/questpaper_mutant.png"
  tempJob.tier = 2
  tempJob.listenTrigger = "mutantKilled"
  tempJob.numberRec = 24
  tempJob.reward = {{"kit_quest2"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 20
  tempJob.categories = {"mutantkillgroupeasy"}

  ix.jobs.register(tempJob, "killMutantsMid")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "%d mutants."
  tempJob.desc = "%d mutants."
  tempJob.icon = "stalker/questpaper_mutant.png"
  tempJob.tier = 2
  tempJob.listenTrigger = "mutantKilled"
  tempJob.numberRec = 40
  tempJob.reward = {{"kit_quest3"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 20
  tempJob.categories = {"mutantkillgroupeasy"}

  ix.jobs.register(tempJob, "killMutantsHigh")

  tempJob = nil


  -- Humanoid Mutants
  local tempJob = {}

  tempJob.name = "%d humanoid mutants."
  tempJob.desc = "%d humanoid mutants."
  tempJob.icon = "stalker/questpaper_mutant.png"
  tempJob.tier = 2
  tempJob.listenTrigger = "groupHumanoidKilled"
  tempJob.numberRec = 5
  tempJob.reward = {{"kit_quest1"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 15
  tempJob.categories = {"mutantkillgroupeasy"}

  ix.jobs.register(tempJob, "killHumanoidsLow")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "%d humanoid mutants."
  tempJob.desc = "%d humanoid mutants."
  tempJob.icon = "stalker/questpaper_mutant.png"
  tempJob.tier = 2
  tempJob.listenTrigger = "groupHumanoidKilled"
  tempJob.numberRec = 9
  tempJob.reward = {{"kit_quest2"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 20
  tempJob.categories = {"mutantkillgroupeasy"}

  ix.jobs.register(tempJob, "killHumanoidsMid")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "%d humanoid mutants."
  tempJob.desc = "%d humanoid mutants."
  tempJob.icon = "stalker/questpaper_mutant.png"
  tempJob.tier = 2
  tempJob.listenTrigger = "groupHumanoidKilled"
  tempJob.numberRec = 15
  tempJob.reward = {{"kit_quest3"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 25
  tempJob.categories = {"mutantkillgroupeasy"}

  ix.jobs.register(tempJob, "killHumanoidsHigh")

  tempJob = nil

  -- Predator Mutants
  local tempJob = {}

  tempJob.name = "%d predator mutants."
  tempJob.desc = "%d predator mutants."
  tempJob.icon = "stalker/questpaper_mutant.png"
  tempJob.tier = 2
  tempJob.listenTrigger = "groupPredatorKilled"
  tempJob.numberRec = 2
  tempJob.reward = {{"kit_quest1"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 20
  tempJob.categories = {"mutantkillgroupmedium"}

  ix.jobs.register(tempJob, "killPredatorsLow")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "%d predator mutants."
  tempJob.desc = "%d predator mutants."
  tempJob.icon = "stalker/questpaper_mutant.png"
  tempJob.tier = 2
  tempJob.listenTrigger = "groupPredatorKilled"
  tempJob.numberRec = 4
  tempJob.reward = {{"kit_quest2"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 25
  tempJob.categories = {"mutantkillgroupmedium"}

  ix.jobs.register(tempJob, "killPredatorsMid")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "%d predator mutants."
  tempJob.desc = "%d predator mutants."
  tempJob.icon = "stalker/questpaper_mutant.png"
  tempJob.tier = 2
  tempJob.listenTrigger = "groupPredatorKilled"
  tempJob.numberRec = 6
  tempJob.reward = {{"kit_quest3"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 30
  tempJob.categories = {"mutantkillgroupmedium"}

  ix.jobs.register(tempJob, "killPredatorsHigh")

  tempJob = nil


  -- Canine Mutants
  local tempJob = {}

  tempJob.name = "%d canine mutants."
  tempJob.desc = "%d canine mutants."
  tempJob.icon = "stalker/questpaper_mutant.png"
  tempJob.tier = 2
  tempJob.listenTrigger = "groupCanineKilled"
  tempJob.numberRec = 5
  tempJob.reward = {{"kit_quest1"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 15
  tempJob.categories = {"mutantkillgroupeasy"}

  ix.jobs.register(tempJob, "killCaninesLow")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "%d canine mutants."
  tempJob.desc = "%d canine mutants."
  tempJob.icon = "stalker/questpaper_mutant.png"
  tempJob.tier = 2
  tempJob.listenTrigger = "groupCanineKilled"
  tempJob.numberRec = 9
  tempJob.reward = {{"kit_quest2"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 20
  tempJob.categories = {"mutantkillgroupeasy"}

  ix.jobs.register(tempJob, "killCaninesMid")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "%d canine mutants."
  tempJob.desc = "%d canine mutants."
  tempJob.icon = "stalker/questpaper_mutant.png"
  tempJob.tier = 2
  tempJob.listenTrigger = "groupCanineKilled"
  tempJob.numberRec = 13
  tempJob.reward = {{"kit_quest3"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 25
  tempJob.categories = {"mutantkillgroupeasy"}

  ix.jobs.register(tempJob, "killCaninesHigh")

  tempJob = nil

  -- Meat Mutants
  local tempJob = {}

  tempJob.name = "%d meat mutants."
  tempJob.desc = "%d meat mutants."
  tempJob.icon = "stalker/questpaper_mutant.png"
  tempJob.tier = 2
  tempJob.listenTrigger = "groupMeatKilled"
  tempJob.numberRec = 4
  tempJob.reward = {{"kit_quest1"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 15
  tempJob.categories = {"mutantkillgroupeasy"}

  ix.jobs.register(tempJob, "killMeatsLow")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "%d meat mutants."
  tempJob.desc = "%d meat mutants."
  tempJob.icon = "stalker/questpaper_mutant.png"
  tempJob.tier = 2
  tempJob.listenTrigger = "groupMeatKilled"
  tempJob.numberRec = 8
  tempJob.reward = {{"kit_quest2"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 20
  tempJob.categories = {"mutantkillgroupeasy"}

  ix.jobs.register(tempJob, "killMeatsMid")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "%d meat mutants."
  tempJob.desc = "%d meat mutants."
  tempJob.icon = "stalker/questpaper_mutant.png"
  tempJob.tier = 2
  tempJob.listenTrigger = "groupMeatKilled"
  tempJob.numberRec = 14
  tempJob.reward = {{"kit_quest3"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 25
  tempJob.categories = {"mutantkillgroupeasy"}

  ix.jobs.register(tempJob, "killMeatsHigh")

  tempJob = nil

  -- Psychic Mutants
  local tempJob = {}

  tempJob.name = "%d psychic mutants."
  tempJob.desc = "%d psychic mutants."
  tempJob.icon = "stalker/questpaper_mutant.png"
  tempJob.tier = 2
  tempJob.listenTrigger = "groupPsyKilled"
  tempJob.numberRec = 2
  tempJob.reward = {{"kit_quest2"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 20
  tempJob.categories = {"mutantkillgroupmedium"}

  ix.jobs.register(tempJob, "killPsyLow")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "%d psychic mutants."
  tempJob.desc = "%d psychic mutants."
  tempJob.icon = "stalker/questpaper_mutant.png"
  tempJob.tier = 2
  tempJob.listenTrigger = "groupPsyKilled"
  tempJob.numberRec = 4
  tempJob.reward = {{"kit_quest2"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 30
  tempJob.categories = {"mutantkillgroupmedium"}

  ix.jobs.register(tempJob, "killPsyMid")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "%d psychic mutants."
  tempJob.desc = "%d psychic mutants."
  tempJob.icon = "stalker/questpaper_mutant.png"
  tempJob.tier = 2
  tempJob.listenTrigger = "groupPsyKilled"
  tempJob.numberRec = 6
  tempJob.reward = {{"kit_quest3"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 40
  tempJob.categories = {"mutantkillgroupmedium"}

  ix.jobs.register(tempJob, "killPsyHigh")

  tempJob = nil

--rodents

  local tempJob = {}

  tempJob.name = "%d rodents."
  tempJob.desc = "%d rodents."
  tempJob.icon = "stalker/questpaper_mutant.png"
  tempJob.tier = 1
  tempJob.listenTrigger = "rodentKilled"
  tempJob.numberRec = 4
  tempJob.reward = {{"kit_quest1"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 10
  tempJob.categories = {"mutantkilleasy"}

  ix.jobs.register(tempJob, "killRodentsLow")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "%d rodents."
  tempJob.desc = "%d rodents."
  tempJob.icon = "stalker/questpaper_mutant.png"
  tempJob.tier = 1
  tempJob.listenTrigger = "rodentKilled"
  tempJob.numberRec = 8
  tempJob.reward = {{"kit_quest2"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 15
  tempJob.categories = {"mutantkilleasy"}

  ix.jobs.register(tempJob, "killRodentsMid")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "%d rodents."
  tempJob.desc = "%d rodents."
  tempJob.icon = "stalker/questpaper_mutant.png"
  tempJob.tier = 1
  tempJob.listenTrigger = "rodentKilled"
  tempJob.numberRec = 13
  tempJob.reward = {{"kit_quest3"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 20
  tempJob.categories = {"mutantkilleasy"}

  ix.jobs.register(tempJob, "killRodentsHigh")

  tempJob = nil

-- Zombies

  local tempJob = {}

  tempJob.name = "%d zombies."
  tempJob.desc = "%d zombies."
  tempJob.icon = "stalker/questpaper_mutant.png"
  tempJob.tier = 2
  tempJob.listenTrigger = "zombieKilled"
  tempJob.numberRec = 3
  tempJob.reward = {{"kit_quest1"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 10
  tempJob.categories = {"mutantkilleasy"}

  ix.jobs.register(tempJob, "killZombiesLow")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "%d zombies."
  tempJob.desc = "%d zombies."
  tempJob.icon = "stalker/questpaper_mutant.png"
  tempJob.tier = 2
  tempJob.listenTrigger = "zombieKilled"
  tempJob.numberRec = 7
  tempJob.reward = {{"kit_quest2"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 15
  tempJob.categories = {"mutantkilleasy"}

  ix.jobs.register(tempJob, "killZombiesMid")

  tempJob = nil    

  local tempJob = {}

  tempJob.name = "%d zombies."
  tempJob.desc = "%d zombies."
  tempJob.icon = "stalker/questpaper_mutant.png"
  tempJob.tier = 2
  tempJob.listenTrigger = "zombieKilled"
  tempJob.numberRec = 12
  tempJob.reward = {{"kit_quest3"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 20
  tempJob.categories = {"mutantkilleasy"}

  ix.jobs.register(tempJob, "killZombiesHigh")

  tempJob = nil   

-- Cats

  local tempJob = {}

  tempJob.name = "%d cats."
  tempJob.desc = "%d cats."
  tempJob.icon = "stalker/questpaper_mutant.png"
  tempJob.tier = 1
  tempJob.listenTrigger = "catKilled"
  tempJob.numberRec = 1
  tempJob.reward = {{"kit_quest1"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 10
  tempJob.categories = {"mutantkilleasy"}

  ix.jobs.register(tempJob, "killCatsLow")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "%d cats."
  tempJob.desc = "%d cats."
  tempJob.icon = "stalker/questpaper_mutant.png"
  tempJob.tier = 2
  tempJob.listenTrigger = "catKilled"
  tempJob.numberRec = 2
  tempJob.reward = {{"kit_quest2"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 15
  tempJob.categories = {"mutantkilleasy"}

  ix.jobs.register(tempJob, "killCatsMid")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "%d cats."
  tempJob.desc = "%d cats."
  tempJob.icon = "stalker/questpaper_mutant.png"
  tempJob.tier = 2
  tempJob.listenTrigger = "catKilled"
  tempJob.numberRec = 4
  tempJob.reward = {{"kit_quest3"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 20
  tempJob.categories = {"mutantkilleasy"}

  ix.jobs.register(tempJob, "killCatsHigh")

  tempJob = nil

-- bloodsuckers

  local tempJob = {}

  tempJob.name = "%d bloodsuckers."
  tempJob.desc = "%d bloodsuckers."
  tempJob.icon = "stalker/questpaper_mutant.png"
  tempJob.tier = 2
  tempJob.listenTrigger = "bloodsuckerKilled"
  tempJob.numberRec = 1
  tempJob.reward = {{"kit_quest2"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 10
  tempJob.categories = {"mutantkillmedium"}

  ix.jobs.register(tempJob, "killBloodsuckersLow")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "%d bloodsuckers."
  tempJob.desc = "%d bloodsuckers."
  tempJob.icon = "stalker/questpaper_mutant.png"
  tempJob.tier = 2
  tempJob.listenTrigger = "bloodsuckerKilled"
  tempJob.numberRec = 2
  tempJob.reward = {{"kit_quest2"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 15
  tempJob.categories = {"mutantkillmedium"}

  ix.jobs.register(tempJob, "killBloodsuckersMid")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "%d bloodsuckers."
  tempJob.desc = "%d bloodsuckers."
  tempJob.icon = "stalker/questpaper_mutant.png"
  tempJob.tier = 2
  tempJob.listenTrigger = "bloodsuckerKilled"
  tempJob.numberRec = 4
  tempJob.reward = {{"kit_quest3"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 20
  tempJob.categories = {"mutantkillmedium"}

  ix.jobs.register(tempJob, "killBloodsuckersHigh")

  tempJob = nil

-- boars

  local tempJob = {}

  tempJob.name = "%d boars."
  tempJob.desc = "%d boars."
  tempJob.icon = "stalker/questpaper_mutant.png"
  tempJob.tier = 1
  tempJob.listenTrigger = "boarKilled"
  tempJob.numberRec = 1
  tempJob.reward = {{"kit_quest1"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 10
  tempJob.categories = {"mutantkilleasy"}

  ix.jobs.register(tempJob, "killBoarsLow")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "%d boars."
  tempJob.desc = "%d boars."
  tempJob.icon = "stalker/questpaper_mutant.png"
  tempJob.tier = 1
  tempJob.listenTrigger = "boarKilled"
  tempJob.numberRec = 3
  tempJob.reward = {{"kit_quest2"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 15
  tempJob.categories = {"mutantkilleasy"}

  ix.jobs.register(tempJob, "killBoarsMid")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "%d boars."
  tempJob.desc = "%d boars."
  tempJob.icon = "stalker/questpaper_mutant.png"
  tempJob.tier = 1
  tempJob.listenTrigger = "boarKilled"
  tempJob.numberRec = 6
  tempJob.reward = {{"kit_quest3"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 20
  tempJob.categories = {"mutantkilleasy"}

  ix.jobs.register(tempJob, "killBoarsHigh")

  tempJob = nil

/*
-- Burers
  local tempJob = {}

  tempJob.name = "%d burers."
  tempJob.desc = "%d burers."
  tempJob.icon = "stalker/questpaper_mutant.png"
  tempJob.tier = 3
  tempJob.listenTrigger = "burerKilled"
  tempJob.numberRec = {1,1}
  tempJob.reward = {{"kit_quest1"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 15
  tempJob.categories = {"mutantkillhard"}

  ix.jobs.register(tempJob, "killBurersLow")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "%d burers."
  tempJob.desc = "%d burers."
  tempJob.icon = "stalker/questpaper_mutant.png"
  tempJob.tier = 3
  tempJob.listenTrigger = "burerKilled"
  tempJob.numberRec = {2,3}
  tempJob.reward = {{"kit_quest1"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 20
  tempJob.categories = {"mutantkillhard"}

  ix.jobs.register(tempJob, "killBurersHigh")

  tempJob = nil
*/
/*
-- Chimeras
  local tempJob = {}

  tempJob.name = "%d chimeras."
  tempJob.desc = "%d chimeras."
  tempJob.icon = "stalker/questpaper_mutant.png"
  tempJob.tier = 3
  tempJob.listenTrigger = "chimeraKilled"
  tempJob.numberRec = {1,1}
  tempJob.reward = {{"kit_quest1"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 15
  tempJob.categories = {"mutantkillhard"}

  ix.jobs.register(tempJob, "killChimerasLow")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "%d chimeras."
  tempJob.desc = "%d chimeras."
  tempJob.icon = "stalker/questpaper_mutant.png"
  tempJob.tier = 4
  tempJob.listenTrigger = "chimeraKilled"
  tempJob.numberRec = {2,3}
  tempJob.reward = {{"kit_quest1"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 20
  tempJob.categories = {"mutantkillhard"}

  ix.jobs.register(tempJob, "killChimerasHigh")

  tempJob = nil

-- Controllers

  local tempJob = {}

  tempJob.name = "%d controllers."
  tempJob.desc = "%d controllers."
  tempJob.icon = "stalker/questpaper_mutant.png"
  tempJob.tier = 2
  tempJob.listenTrigger = "controllerKilled"
  tempJob.numberRec = {1,1}
  tempJob.reward = {{"kit_quest1"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 15
  tempJob.categories = {"mutantkillhard"}

  ix.jobs.register(tempJob, "killControllersLow")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "%d controllers."
  tempJob.desc = "%d controllers."
  tempJob.icon = "stalker/questpaper_mutant.png"
  tempJob.tier = 3
  tempJob.listenTrigger = "controllerKilled"
  tempJob.numberRec = {2,3}
  tempJob.reward = {{"kit_quest1"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 20

  ix.jobs.register(tempJob, "killControllersHigh")
*/
-- dogs

  local tempJob = {}

  tempJob.name = "%d blind dogs."
  tempJob.desc = "%d blind dogs."
  tempJob.icon = "stalker/questpaper_mutant.png"
  tempJob.tier = 1
  tempJob.listenTrigger = "blinddogKilled"
  tempJob.numberRec = 2
  tempJob.reward = {{"kit_quest1"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 10
  tempJob.categories = {"mutantkilleasy"}

  ix.jobs.register(tempJob, "killDogsLow")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "%d blind dogs."
  tempJob.desc = "%d blind dogs."
  tempJob.icon = "stalker/questpaper_mutant.png"
  tempJob.tier = 1
  tempJob.listenTrigger = "blinddogKilled"
  tempJob.numberRec = 5
  tempJob.reward = {{"kit_quest2"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 15
  tempJob.categories = {"mutantkilleasy"}

  ix.jobs.register(tempJob, "killDogsMid")

  tempJob = nil 

  local tempJob = {}

  tempJob.name = "%d blind dogs."
  tempJob.desc = "%d blind dogs."
  tempJob.icon = "stalker/questpaper_mutant.png"
  tempJob.tier = 1
  tempJob.listenTrigger = "blinddogKilled"
  tempJob.numberRec = 8
  tempJob.reward = {{"kit_quest3"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 20
  tempJob.categories = {"mutantkilleasy"}

  ix.jobs.register(tempJob, "killDogsHigh")

  tempJob = nil  

--fleshes

  local tempJob = {}

  tempJob.name = "%d fleshes."
  tempJob.desc = "%d fleshes."
  tempJob.icon = "stalker/questpaper_mutant.png"
  tempJob.tier = 1
  tempJob.listenTrigger = "fleshKilled"
  tempJob.numberRec = 2
  tempJob.reward = {{"kit_quest1"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 10
  tempJob.categories = {"mutantkilleasy"}

  ix.jobs.register(tempJob, "killFleshesLow")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "%d fleshes."
  tempJob.desc = "%d fleshes."
  tempJob.icon = "stalker/questpaper_mutant.png"
  tempJob.tier = 1
  tempJob.listenTrigger = "fleshKilled"
  tempJob.numberRec = 5
  tempJob.reward = {{"kit_quest2"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 15
  tempJob.categories = {"mutantkilleasy"}

  ix.jobs.register(tempJob, "killFleshesMid")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "%d fleshes."
  tempJob.desc = "%d fleshes."
  tempJob.icon = "stalker/questpaper_mutant.png"
  tempJob.tier = 1
  tempJob.listenTrigger = "fleshKilled"
  tempJob.numberRec = 10
  tempJob.reward = {{"kit_quest2"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 20
  tempJob.categories = {"mutantkilleasy"}

  ix.jobs.register(tempJob, "killFleshesHigh")

  tempJob = nil

-- pseudodogs

  local tempJob = {}

  tempJob.name = "%d pseudodogs."
  tempJob.desc = "%d pseudodogs."
  tempJob.icon = "stalker/questpaper_mutant.png"
  tempJob.tier = 1
  tempJob.listenTrigger = "pseudodogKilled"
  tempJob.numberRec = 1
  tempJob.reward = {{"kit_quest1"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 10
  tempJob.categories = {"mutantkilleasy"}

  ix.jobs.register(tempJob, "killPseudodogsLow")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "%d pseudodogs."
  tempJob.desc = "%d pseudodogs."
  tempJob.icon = "stalker/questpaper_mutant.png"
  tempJob.tier = 2
  tempJob.listenTrigger = "pseudodogKilled"
  tempJob.numberRec = 2
  tempJob.reward = {{"kit_quest2"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 15
  tempJob.categories = {"mutantkilleasy"}

  ix.jobs.register(tempJob, "killPseudodogsMid")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "%d pseudodogs."
  tempJob.desc = "%d pseudodogs."
  tempJob.icon = "stalker/questpaper_mutant.png"
  tempJob.tier = 2
  tempJob.listenTrigger = "pseudodogKilled"
  tempJob.numberRec = 3
  tempJob.reward = {{"kit_quest3"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 20
  tempJob.categories = {"mutantkilleasy"}

  ix.jobs.register(tempJob, "killPseudodogsHigh")

  tempJob = nil


  local tempJob = {}

  tempJob.name = "%d snorks."
  tempJob.desc = "%d snorks."
  tempJob.icon = "stalker/questpaper_mutant.png"
  tempJob.tier = 2
  tempJob.listenTrigger = "snorkKilled"
  tempJob.numberRec = 1
  tempJob.reward = {{"kit_quest1"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 20
  tempJob.categories = {"mutantkillmedium"}

  ix.jobs.register(tempJob, "killSnorksLow")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "%d snorks."
  tempJob.desc = "%d snorks."
  tempJob.icon = "stalker/questpaper_mutant.png"
  tempJob.tier = 2
  tempJob.listenTrigger = "snorkKilled"
  tempJob.numberRec = 2
  tempJob.reward = {{"kit_quest2"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 25
  tempJob.categories = {"mutantkillmedium"}

  ix.jobs.register(tempJob, "killSnorksMid")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "%d snorks."
  tempJob.desc = "%d snorks."
  tempJob.icon = "stalker/questpaper_mutant.png"
  tempJob.tier = 2
  tempJob.listenTrigger = "snorkKilled"
  tempJob.numberRec = 4
  tempJob.reward = {{"kit_quest3"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 30
  tempJob.categories = {"mutantkillmedium"}

  ix.jobs.register(tempJob, "killSnorksHigh")

  tempJob = nil

-- psydogs
/*
  local tempJob = {}

  tempJob.name = "%d psydogs."
  tempJob.desc = "%d psydogs."
  tempJob.icon = "stalker/questpaper_mutant.png"
  tempJob.tier = 2
  tempJob.listenTrigger = "psydogKilled"
  tempJob.numberRec = {1,1}
  tempJob.reward = {{"kit_quest1"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 15

  ix.jobs.register(tempJob, "killPsydogsLow")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "%d psydogs."
  tempJob.desc = "%d psydogs."
  tempJob.icon = "stalker/questpaper_mutant.png"
  tempJob.tier = 3
  tempJob.listenTrigger = "psydogKilled"
  tempJob.numberRec = {2,3}
  tempJob.reward = {{"kit_quest1"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 20

  ix.jobs.register(tempJob, "killPsydogsLow")

  tempJob = nil

-- Pseudogiants

  local tempJob = {}

  tempJob.name = "%d pseudogiants."
  tempJob.desc = "%d pseudogiants."
  tempJob.icon = "stalker/questpaper_mutant.png"
  tempJob.tier = 3
  tempJob.listenTrigger = "pseudogiantKilled"
  tempJob.numberRec = {1,2}
  tempJob.reward = {{"kit_quest1"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 15

  ix.jobs.register(tempJob, "killPseudogiantsLow")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "%d pseudogiants."
  tempJob.desc = "%d pseudogiants."
  tempJob.icon = "stalker/questpaper_mutant.png"
  tempJob.tier = 4
  tempJob.listenTrigger = "pseudogiantKilled"
  tempJob.numberRec = {2,3}
  tempJob.reward = {{"kit_quest1"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 20

  ix.jobs.register(tempJob, "killPseudogiantsHigh")

  tempJob = nil
*/

  local tempJob = {}

  tempJob.name = "%d izloms."
  tempJob.desc = "%d izloms."
  tempJob.icon = "stalker/questpaper_mutant.png"
  tempJob.tier = 1
  tempJob.listenTrigger = "izlomKilled"
  tempJob.numberRec = 1
  tempJob.reward = {{"kit_quest1"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 20
  tempJob.categories = {"mutantkillmedium"}

  ix.jobs.register(tempJob, "killIzlomsLow")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "%d spiders."
  tempJob.desc = "%d spiders."
  tempJob.icon = "stalker/questpaper_mutant.png"
  tempJob.tier = 1
  tempJob.listenTrigger = "spiderKilled"
  tempJob.numberRec = 1
  tempJob.reward = {{"kit_quest1"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 20
  tempJob.categories = {"mutantkillmedium"}

  ix.jobs.register(tempJob, "killSpidersLow")

  tempJob = nil


  local tempJob = {}

  tempJob.name = "%d spiders."
  tempJob.desc = "%d spiders."
  tempJob.icon = "stalker/questpaper_mutant.png"
  tempJob.tier = 1
  tempJob.listenTrigger = "spiderKilled"
  tempJob.numberRec = 2
  tempJob.reward = {{"kit_quest2"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 25
  tempJob.categories = {"mutantkillmedium"}

  ix.jobs.register(tempJob, "killSpidersMid")

  tempJob = nil


  local tempJob = {}

  tempJob.name = "%d spiders."
  tempJob.desc = "%d spiders."
  tempJob.icon = "stalker/questpaper_mutant.png"
  tempJob.tier = 1
  tempJob.listenTrigger = "spiderKilled"
  tempJob.numberRec = 3
  tempJob.reward = {{"kit_quest3"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 30
  tempJob.categories = {"mutantkillmedium"}

  ix.jobs.register(tempJob, "killSpidersHigh")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "%d tarks."
  tempJob.desc = "%d tarks."
  tempJob.icon = "stalker/questpaper_mutant.png"
  tempJob.tier = 1
  tempJob.listenTrigger = "tarkKilled"
  tempJob.numberRec = 1
  tempJob.reward = {{"kit_quest1"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 15
  tempJob.categories = {"mutantkilleasy"}

  ix.jobs.register(tempJob, "killTarksLow")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "%d tarks."
  tempJob.desc = "%d tarks."
  tempJob.icon = "stalker/questpaper_mutant.png"
  tempJob.tier = 1
  tempJob.listenTrigger = "tarkKilled"
  tempJob.numberRec = 2
  tempJob.reward = {{"kit_quest1"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 20
  tempJob.categories = {"mutantkilleasy"}

  ix.jobs.register(tempJob, "killTarksMid")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "%d tarks."
  tempJob.desc = "%d tarks."
  tempJob.icon = "stalker/questpaper_mutant.png"
  tempJob.tier = 1
  tempJob.listenTrigger = "tarkKilled"
  tempJob.numberRec = 4
  tempJob.reward = {{"kit_quest1"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 25
  tempJob.categories = {"mutantkilleasy"}

  ix.jobs.register(tempJob, "killTarksHigh")

  tempJob = nil




---------------------------------------
-------------ITEM RETRIEVAL------------
---------------------------------------

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

  ix.jobs.register(tempJob, "ItemJob_meat_blinddog")

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

  ix.jobs.register(tempJob, "ItemJob_meat_bloodsucker")

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

  ix.jobs.register(tempJob, "ItemJob_meat_boar")

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

  ix.jobs.register(tempJob, "ItemJob_meat_burer")

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

  ix.jobs.register(tempJob, "ItemJob_meat_cat")

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

  ix.jobs.register(tempJob, "ItemJob_meat_flesh")

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

  ix.jobs.register(tempJob, "ItemJob_meat_hellhound")

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

  ix.jobs.register(tempJob, "ItemJob_meat_human")

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

  ix.jobs.register(tempJob, "ItemJob_meat_pseudodog")

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

  ix.jobs.register(tempJob, "ItemJob_meat_sprig")

  tempJob = nil


  local tempJob = {}

  tempJob.name = "%d pieces of tushkano meat."
  tempJob.desc = "%d pieces of tushkano meat."
  tempJob.icon = "stalker/questpaper_item.png"
  tempJob.tier = 1
  tempJob.listenTrigger = "itemDeliver_meat_tushkano"
  tempJob.numberRec = 2
  tempJob.reward = {{"kit_quest1"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 15
  tempJob.categories = {"mutantmeateasy"}

  ix.jobs.register(tempJob, "ItemJob_meat_tushkano")

  tempJob = nil

end
