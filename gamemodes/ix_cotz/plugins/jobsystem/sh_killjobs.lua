--[[
  --TestJob
  local tempJob = {}

  tempJob.name = "Kill Say sneed %d times."                  --Name that will be shown in dialogue when selecting tasks
  tempJob.desc = "I need you to sneed %d times for me." --Description of task, will be shown to the player when deciding to take quest or not
  tempJob.icon = "stalker/questpaper_item.png"          --Icon, unused?
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
  --random amount of mutants
  local tempJob = {}

  tempJob.name = "Kill %d mutants."
  tempJob.desc = "%d mutants."
  tempJob.icon = "propic/event/mutanthunt"
  tempJob.tier = 1
  tempJob.listenTrigger = "mutantKilled"
  tempJob.numberRec = 12
  tempJob.reward = {{"762x25", { ["quantity"] = 25 }}, {"22lr", { ["quantity"] = 35 }}, {"9x18", { ["quantity"] = 25 }}, {"9x19", { ["quantity"] = 25 }}, {"45acp", { ["quantity"] = 25 }}}
  tempJob.rewardCount = 2
  tempJob.repReward = 12
  tempJob.moneyReward = {750, 1100}
  tempJob.categories = {"mutantkillgroupeasy"}

  ix.jobs.register(tempJob, "killMutantsLow")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "Kill %d mutants."
  tempJob.desc = "%d mutants."
  tempJob.icon = "propic/event/mutanthunt"
  tempJob.tier = 2
  tempJob.listenTrigger = "mutantKilled"
  tempJob.numberRec = 24
  tempJob.reward = {{"skorpion", {["durability"] = 60}}, "kit_ammo_m_low"}
  tempJob.rewardCount = 1
  tempJob.repReward = 21
  tempJob.moneyReward = {1250, 1650}
  tempJob.categories = {"mutantkillgroupeasy"}

  ix.jobs.register(tempJob, "killMutantsMid")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "Kill %d mutants."
  tempJob.desc = "%d mutants."
  tempJob.icon = "propic/event/mutanthunt"
  tempJob.tier = 2
  tempJob.listenTrigger = "mutantKilled"
  tempJob.numberRec = 40
  tempJob.reward = {{"mp153", {["durability"] = 60}}, "kit_ammo_med"}
  tempJob.rewardCount = 1
  tempJob.repReward = 34
  tempJob.moneyReward = {2500, 2900}
  tempJob.categories = {"mutantkillgroupeasy"}

  ix.jobs.register(tempJob, "killMutantsHigh")

  tempJob = nil


  -- Humanoid Mutants
  local tempJob = {}

  tempJob.name = "Kill %d humanoid mutants."
  tempJob.desc = "%d humanoid mutants."
  tempJob.icon = "propic/event/mutanthunt"
  tempJob.tier = 2
  tempJob.listenTrigger = "groupHumanoidKilled"
  tempJob.numberRec = 5
  tempJob.reward = {{"kit_ammo_low"}}
  tempJob.rewardCount = 1
  tempJob.repReward = 10
  tempJob.moneyReward = {400, 600}
  tempJob.categories = {"mutantkillgroupeasy"}

  ix.jobs.register(tempJob, "killHumanoidsLow")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "Kill %d humanoid mutants."
  tempJob.desc = "%d humanoid mutants."
  tempJob.icon = "propic/event/mutanthunt"
  tempJob.tier = 2
  tempJob.listenTrigger = "groupHumanoidKilled"
  tempJob.numberRec = 9
  tempJob.reward = {{"kit_ammo_low"}}
  tempJob.rewardCount = 1
  tempJob.repReward = 13
  tempJob.moneyReward = {600, 800}
  tempJob.categories = {"mutantkillgroupeasy"}

  ix.jobs.register(tempJob, "killHumanoidsMid")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "Kill %d humanoid mutants."
  tempJob.desc = "%d humanoid mutants."
  tempJob.icon = "propic/event/mutanthunt"
  tempJob.tier = 2
  tempJob.listenTrigger = "groupHumanoidKilled"
  tempJob.numberRec = 15
  tempJob.reward = {{"kit_ammo_med"}}
  tempJob.rewardCount = 1
  tempJob.repReward = 21
  tempJob.moneyReward = {900, 1300}
  tempJob.categories = {"mutantkillgroupeasy"}

  ix.jobs.register(tempJob, "killHumanoidsHigh")

  tempJob = nil

  -- Predator Mutants
  local tempJob = {}

  tempJob.name = "Kill %d predator mutants."
  tempJob.desc = "%d predator mutants."
  tempJob.icon = "propic/event/mutanthunt"
  tempJob.tier = 2
  tempJob.listenTrigger = "groupPredatorKilled"
  tempJob.numberRec = 2
  tempJob.reward = {{"kit_ammo_low"}, 0}
  tempJob.rewardCount = 1
  tempJob.repReward = 8
  tempJob.moneyReward = {500, 600}
  tempJob.categories = {"mutantkillgroupmedium"}

  ix.jobs.register(tempJob, "killPredatorsLow")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "Kill %d predator mutants."
  tempJob.desc = "%d predator mutants."
  tempJob.icon = "propic/event/mutanthunt"
  tempJob.tier = 2
  tempJob.listenTrigger = "groupPredatorKilled"
  tempJob.numberRec = 4
  tempJob.reward = {{"kit_ammo_low"}, 0}
  tempJob.rewardCount = 2
  tempJob.repReward = 12
  tempJob.moneyReward = {800, 1000}
  tempJob.categories = {"mutantkillgroupmedium"}

  ix.jobs.register(tempJob, "killPredatorsMid")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "Kill %d predator mutants."
  tempJob.desc = "%d predator mutants."
  tempJob.icon = "propic/event/mutanthunt"
  tempJob.tier = 2
  tempJob.listenTrigger = "groupPredatorKilled"
  tempJob.numberRec = 6
  tempJob.reward = {{"kit_ammo_low"}, {"kit_ammo_low"}, 0}
  tempJob.rewardCount = 2
  tempJob.repReward = 18
  tempJob.moneyReward = {1200, 1400}
  tempJob.categories = {"mutantkillgroupmedium"}

  ix.jobs.register(tempJob, "killPredatorsHigh")

  tempJob = nil


  -- Canine Mutants
  local tempJob = {}

  tempJob.name = "Kill %d canine mutants."
  tempJob.desc = "%d canine mutants."
  tempJob.icon = "propic/event/mutanthunt"
  tempJob.tier = 2
  tempJob.listenTrigger = "groupCanineKilled"
  tempJob.numberRec = 5
  tempJob.reward = {{"kit_ammo_low"}, {"kit_ammo_low"}, 0}
  tempJob.rewardCount = 1
  tempJob.repReward = 7
  tempJob.moneyReward = {350, 460}
  tempJob.categories = {"mutantkillgroupeasy"}

  ix.jobs.register(tempJob, "killCaninesLow")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "Kill %d canine mutants."
  tempJob.desc = "%d canine mutants."
  tempJob.icon = "propic/event/mutanthunt"
  tempJob.tier = 2
  tempJob.listenTrigger = "groupCanineKilled"
  tempJob.numberRec = 9
  tempJob.reward = {{"kit_ammo_low"}, {"kit_ammo_low"}, 0}
  tempJob.rewardCount = 1
  tempJob.repReward = 15
  tempJob.moneyReward = {600, 800}
  tempJob.categories = {"mutantkillgroupeasy"}

  ix.jobs.register(tempJob, "killCaninesMid")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "Kill %d canine mutants."
  tempJob.desc = "%d canine mutants."
  tempJob.icon = "propic/event/mutanthunt"
  tempJob.tier = 2
  tempJob.listenTrigger = "groupCanineKilled"
  tempJob.numberRec = 13
  tempJob.reward = {{"kit_ammo_low"}, {"kit_ammo_low"}, 0}
  tempJob.rewardCount = 2
  tempJob.repReward = 20
  tempJob.moneyReward = {700, 1000}
  tempJob.categories = {"mutantkillgroupeasy"}

  ix.jobs.register(tempJob, "killCaninesHigh")

  tempJob = nil

  -- Meat Mutants
  local tempJob = {}

  tempJob.name = "Kill %d meat mutants."
  tempJob.desc = "%d meat mutants."
  tempJob.icon = "propic/event/mutanthunt"
  tempJob.tier = 2
  tempJob.listenTrigger = "groupMeatKilled"
  tempJob.numberRec = 4
  tempJob.reward = {{"kit_ammo_low"}, 0}
  tempJob.rewardCount = 1
  tempJob.repReward = 5
  tempJob.moneyReward = {150, 250}
  tempJob.categories = {"mutantkillgroupeasy"}

  ix.jobs.register(tempJob, "killMeatsLow")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "Kill %d meat mutants."
  tempJob.desc = "%d meat mutants."
  tempJob.icon = "propic/event/mutanthunt"
  tempJob.tier = 2
  tempJob.listenTrigger = "groupMeatKilled"
  tempJob.numberRec = 8
  tempJob.reward = {{"kit_ammo_low"}, 0}
  tempJob.rewardCount = 1
  tempJob.repReward = 10
  tempJob.moneyReward = {190, 370}
  tempJob.categories = {"mutantkillgroupeasy"}

  ix.jobs.register(tempJob, "killMeatsMid")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "Kill %d meat mutants."
  tempJob.desc = "%d meat mutants."
  tempJob.icon = "propic/event/mutanthunt"
  tempJob.tier = 2
  tempJob.listenTrigger = "groupMeatKilled"
  tempJob.numberRec = 14
  tempJob.reward = {{"kit_ammo_low"}, 0}
  tempJob.rewardCount = 2
  tempJob.repReward = 15
  tempJob.moneyReward = {470, 770}
  tempJob.categories = {"mutantkillgroupeasy"}

  ix.jobs.register(tempJob, "killMeatsHigh")

  tempJob = nil

  -- Psychic Mutants
  local tempJob = {}

  tempJob.name = "Kill %d psychic mutants."
  tempJob.desc = "%d psychic mutants."
  tempJob.icon = "propic/event/mutanthunt"
  tempJob.tier = 2
  tempJob.listenTrigger = "groupPsyKilled"
  tempJob.numberRec = 2
  tempJob.reward = {{"kit_ammo_rare"}, 0}
  tempJob.rewardCount = 1
  tempJob.repReward = 50
  tempJob.moneyReward = {2000, 4000}
  tempJob.categories = {"mutantkillgroupmedium"}

  ix.jobs.register(tempJob, "killPsyLow")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "Kill %d psychic mutants."
  tempJob.desc = "%d psychic mutants."
  tempJob.icon = "propic/event/mutanthunt"
  tempJob.tier = 2
  tempJob.listenTrigger = "groupPsyKilled"
  tempJob.numberRec = 4
  tempJob.reward = {{"kit_ammo_rare"}, 0}
  tempJob.rewardCount = 1
  tempJob.repReward = 75
  tempJob.moneyReward = {3000, 6000}
  tempJob.categories = {"mutantkillgroupmedium"}

  ix.jobs.register(tempJob, "killPsyMid")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "Kill %d psychic mutants."
  tempJob.desc = "%d psychic mutants."
  tempJob.icon = "propic/event/mutanthunt"
  tempJob.tier = 2
  tempJob.listenTrigger = "groupPsyKilled"
  tempJob.numberRec = 6
  tempJob.reward = {{"kit_ammo_rare"}, 0}
  tempJob.rewardCount = 2
  tempJob.repReward = 120
  tempJob.moneyReward = {4000, 7000}
  tempJob.categories = {"mutantkillgroupmedium"}

  ix.jobs.register(tempJob, "killPsyHigh")

  tempJob = nil

--rodents

  local tempJob = {}

  tempJob.name = "Kill %d rodents."
  tempJob.desc = "%d rodents."
  tempJob.icon = "vgui/icons/tushkandead.png"
  tempJob.tier = 1
  tempJob.listenTrigger = "rodentKilled"
  tempJob.numberRec = 4
  tempJob.reward = {{"kit_ammo_low"}}
  tempJob.rewardCount = 1
  tempJob.repReward = 2
  tempJob.moneyReward = {120, 180}
  tempJob.categories = {"mutantkilleasy"}

  ix.jobs.register(tempJob, "killRodentsLow")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "Kill %d rodents."
  tempJob.desc = "%d rodents."
  tempJob.icon = "vgui/icons/tushkandead.png"
  tempJob.tier = 1
  tempJob.listenTrigger = "rodentKilled"
  tempJob.numberRec = 8
  tempJob.reward = {{"kit_ammo_low"}}
  tempJob.rewardCount = 1
  tempJob.repReward = 6
  tempJob.moneyReward = {260, 420}
  tempJob.categories = {"mutantkilleasy"}

  ix.jobs.register(tempJob, "killRodentsMid")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "Kill %d rodents."
  tempJob.desc = "%d rodents."
  tempJob.icon = "vgui/icons/tushkandead.png"
  tempJob.tier = 1
  tempJob.listenTrigger = "rodentKilled"
  tempJob.numberRec = 13
  tempJob.reward = {{"kit_ammo_low"}}
  tempJob.rewardCount = 1
  tempJob.repReward = 9
  tempJob.moneyReward = {320, 490}
  tempJob.categories = {"mutantkilleasy"}

  ix.jobs.register(tempJob, "killRodentsHigh")

  tempJob = nil

--rodents

  local tempJob = {}

  tempJob.name = "Kill %d hellhounds."
  tempJob.desc = "%d hellhounds."
  tempJob.icon = "vgui/icons/dogdead.png"
  tempJob.tier = 2
  tempJob.listenTrigger = "hellhoundKilled"
  tempJob.numberRec = 2
  tempJob.reward = {{"kit_ammo_low"}, {"kit_ammo_med"}}
  tempJob.rewardCount = 1
  tempJob.repReward = 9
  tempJob.moneyReward = {900, 1500}
  tempJob.categories = {"mutantkilleasy"}

  ix.jobs.register(tempJob, "killHellhoundsLow")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "Kill %d rodents."
  tempJob.desc = "%d rodents."
  tempJob.icon = "vgui/icons/dogdead.png"
  tempJob.tier = 2
  tempJob.listenTrigger = "hellhoundKilled"
  tempJob.numberRec = 4
  tempJob.reward = {{"kit_ammo_low"}, {"kit_ammo_med"}}
  tempJob.rewardCount = 2
  tempJob.repReward = 17
  tempJob.moneyReward = {1200, 1800}
  tempJob.categories = {"mutantkillmid"}

  ix.jobs.register(tempJob, "killHellhoundsHigh")

  tempJob = nil

-- Zombies

  local tempJob = {}

  tempJob.name = "Kill %d zombies."
  tempJob.desc = "%d zombies."
  tempJob.icon = "vgui/icons/face_42.png"
  tempJob.tier = 2
  tempJob.listenTrigger = "zombieKilled"
  tempJob.numberRec = 3
  tempJob.reward = {{"762x25", { ["quantity"] = 25 }}, {"22lr", { ["quantity"] = 35 }}, {"9x18", { ["quantity"] = 25 }}, {"9x19", { ["quantity"] = 25 }}, {"45acp", { ["quantity"] = 25 }}}
  tempJob.rewardCount = 1
  tempJob.repReward = 5
  tempJob.moneyReward = {320, 490}
  tempJob.categories = {"mutantkilleasy"}

  ix.jobs.register(tempJob, "killZombiesLow")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "Kill %d zombies."
  tempJob.desc = "%d zombies."
  tempJob.icon = "vgui/icons/face_42.png"
  tempJob.tier = 2
  tempJob.listenTrigger = "zombieKilled"
  tempJob.numberRec = 7
  tempJob.reward = {{"762x25", { ["quantity"] = 25 }}, {"22lr", { ["quantity"] = 35 }}, {"9x18", { ["quantity"] = 25 }}, {"9x19", { ["quantity"] = 25 }}, {"45acp", { ["quantity"] = 25 }}}
  tempJob.rewardCount = 2
  tempJob.repReward = 8
  tempJob.moneyReward = {480, 600}
  tempJob.categories = {"mutantkilleasy"}

  ix.jobs.register(tempJob, "killZombiesMid")

  tempJob = nil    

  local tempJob = {}

  tempJob.name = "Kill %d zombies."
  tempJob.desc = "%d zombies."
  tempJob.icon = "vgui/icons/face_42.png"
  tempJob.tier = 2
  tempJob.listenTrigger = "zombieKilled"
  tempJob.numberRec = 12
  tempJob.reward = {{"762x25"}, {"22lr"}, {"9x18"}, {"9x19"}, {"45acp"}}
  tempJob.rewardCount = 1
  tempJob.repReward = 12
  tempJob.moneyReward = {550, 700}
  tempJob.categories = {"mutantkilleasy"}

  ix.jobs.register(tempJob, "killZombiesHigh")

  tempJob = nil   

-- Cats

  local tempJob = {}

  tempJob.name = "Kill %d cats."
  tempJob.desc = "%d cats."
  tempJob.icon = "propic/event/mutanthunt"
  tempJob.tier = 1
  tempJob.listenTrigger = "catKilled"
  tempJob.numberRec = 1
  tempJob.reward = {{"762x25", { ["quantity"] = 25 }}, {"22lr", { ["quantity"] = 35 }}, {"9x18", { ["quantity"] = 25 }}, {"9x19", { ["quantity"] = 25 }}, {"45acp", { ["quantity"] = 25 }}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 8
  tempJob.moneyReward = {600, 900}
  tempJob.categories = {"mutantkilleasy"}

  ix.jobs.register(tempJob, "killCatsLow")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "Kill %d cats."
  tempJob.desc = "%d cats."
  tempJob.icon = "propic/event/mutanthunt"
  tempJob.tier = 2
  tempJob.listenTrigger = "catKilled"
  tempJob.numberRec = 2
  tempJob.reward = {{"762x25", { ["quantity"] = 25 }}, {"22lr", { ["quantity"] = 35 }}, {"9x18", { ["quantity"] = 25 }}, {"9x19", { ["quantity"] = 25 }}, {"45acp", { ["quantity"] = 25 }}}
  tempJob.rewardCount = {1,2}
  tempJob.repReward = 12
  tempJob.moneyReward = {850, 1150}
  tempJob.categories = {"mutantkilleasy"}

  ix.jobs.register(tempJob, "killCatsMid")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "Kill %d cats."
  tempJob.desc = "%d cats."
  tempJob.icon = "propic/event/mutanthunt"
  tempJob.tier = 2
  tempJob.listenTrigger = "catKilled"
  tempJob.numberRec = 4
  tempJob.reward = {{"762x25", { ["quantity"] = 25 }}, {"22lr", { ["quantity"] = 35 }}, {"9x18", { ["quantity"] = 25 }}, {"9x19", { ["quantity"] = 25 }}, {"45acp", { ["quantity"] = 25 }}}
  tempJob.rewardCount = {2,3}
  tempJob.repReward = 16
  tempJob.moneyReward = {1000, 1400}
  tempJob.categories = {"mutantkilleasy"}

  ix.jobs.register(tempJob, "killCatsHigh")

  tempJob = nil

-- bloodsuckers

  local tempJob = {}

  tempJob.name = "Kill %d bloodsuckers."
  tempJob.desc = "%d bloodsuckers."
  tempJob.icon = "vgui/icons/sosdead.png"
  tempJob.tier = 2
  tempJob.listenTrigger = "bloodsuckerKilled"
  tempJob.numberRec = 1
  tempJob.reward = {{"kit_ammo_high"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 12
  tempJob.moneyReward = {1200, 1400}
  tempJob.categories = {"mutantkillmedium"}

  ix.jobs.register(tempJob, "killBloodsuckersLow")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "Kill %d bloodsuckers."
  tempJob.desc = "%d bloodsuckers."
  tempJob.icon = "vgui/icons/sosdead.png"
  tempJob.tier = 2
  tempJob.listenTrigger = "bloodsuckerKilled"
  tempJob.numberRec = 2
  tempJob.reward = {{"kit_ammo_high"}}
  tempJob.rewardCount = {1,2}
  tempJob.repReward = 18
  tempJob.moneyReward = {1300, 1690}
  tempJob.categories = {"mutantkillmedium"}

  ix.jobs.register(tempJob, "killBloodsuckersMid")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "Kill %d bloodsuckers."
  tempJob.desc = "%d bloodsuckers."
  tempJob.icon = "vgui/icons/sosdead.png"
  tempJob.tier = 2
  tempJob.listenTrigger = "bloodsuckerKilled"
  tempJob.numberRec = 4
  tempJob.reward = {{"kit_ammo_high"}}
  tempJob.rewardCount = 2
  tempJob.repReward = 25
  tempJob.moneyReward = {1550, 1890}
  tempJob.categories = {"mutantkillmedium"}

  ix.jobs.register(tempJob, "killBloodsuckersHigh")

  tempJob = nil

-- boars

  local tempJob = {}

  tempJob.name = "Kill %d boars."
  tempJob.desc = "%d boars."
  tempJob.icon = "vgui/icons/kabandead.png"
  tempJob.tier = 1
  tempJob.listenTrigger = "boarKilled"
  tempJob.numberRec = 1
  tempJob.reward = {{"kit_aid_low"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 3
  tempJob.moneyReward = {200, 300}
  tempJob.categories = {"mutantkilleasy"}

  ix.jobs.register(tempJob, "killBoarsLow")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "Kill %d boars."
  tempJob.desc = "%d boars."
  tempJob.icon = "vgui/icons/kabandead.png"
  tempJob.tier = 1
  tempJob.listenTrigger = "boarKilled"
  tempJob.numberRec = 3
  tempJob.reward = {{"kit_ammo_med"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 5
  tempJob.moneyReward = {350, 500}
  tempJob.categories = {"mutantkilleasy"}

  ix.jobs.register(tempJob, "killBoarsMid")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "Kill %d boars."
  tempJob.desc = "%d boars."
  tempJob.icon = "vgui/icons/kabandead.png"
  tempJob.tier = 1
  tempJob.listenTrigger = "boarKilled"
  tempJob.numberRec = 6
  tempJob.reward = {{"kit_aid_high"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 9
  tempJob.moneyReward = {450, 700}
  tempJob.categories = {"mutantkilleasy"}

  ix.jobs.register(tempJob, "killBoarsHigh")

  tempJob = nil


-- Burers
  local tempJob = {}

  tempJob.name = "Kill %d burers."
  tempJob.desc = "%d burers."
  tempJob.icon = "propic/event/mutanthunt"
  tempJob.tier = 3
  tempJob.listenTrigger = "burerKilled"
  tempJob.numberRec = 1
  tempJob.reward = {{"kit_mixed_high"}}
  tempJob.rewardCount = 1
  tempJob.repReward = 35
  tempJob.moneyReward = {2500, 5000}
  tempJob.categories = {"mutantkillhard"}

  ix.jobs.register(tempJob, "killBurersLow")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "Kill %d burers."
  tempJob.desc = "%d burers."
  tempJob.icon = "propic/event/mutanthunt"
  tempJob.tier = 3
  tempJob.listenTrigger = "burerKilled"
  tempJob.numberRec = 3
  tempJob.reward = {{"kit_ammo_rare"}, {"kit_mixed_high"}}
  tempJob.rewardCount = 2
  tempJob.repReward = 75
  tempJob.moneyReward = {6000, 8500}
  tempJob.categories = {"mutantkillhard"}

  ix.jobs.register(tempJob, "killBurersHigh")

  tempJob = nil


-- Chimeras
  local tempJob = {}

  tempJob.name = "Kill %d chimeras."
  tempJob.desc = "%d chimeras."
  tempJob.icon = "propic/event/mutanthunt"
  tempJob.tier = 3
  tempJob.listenTrigger = "chimeraKilled"
  tempJob.numberRec = 1
  tempJob.reward = {{"kit_mixed_high"}}
  tempJob.rewardCount = 1
  tempJob.repReward = 45
  tempJob.moneyReward = {5000, 8500}
  tempJob.categories = {"mutantkillhard"}

  ix.jobs.register(tempJob, "killChimerasLow")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "Kill %d chimeras."
  tempJob.desc = "%d chimeras."
  tempJob.icon = "propic/event/mutanthunt"
  tempJob.tier = 4
  tempJob.listenTrigger = "chimeraKilled"
  tempJob.numberRec = 3
  tempJob.reward = {{"kit_ammo_high"}, {"kit_mixed_high"}}
  tempJob.rewardCount = 2
  tempJob.repReward = 70
  tempJob.moneyReward = {12000, 16500}
  tempJob.categories = {"mutantkillhard"}

  ix.jobs.register(tempJob, "killChimerasHigh")

  tempJob = nil

-- ElectroChimeras
  local tempJob = {}

  tempJob.name = "Kill %d electro-chimeras."
  tempJob.desc = "%d electro-chimeras."
  tempJob.icon = "propic/event/mutanthunt"
  tempJob.tier = 3
  tempJob.listenTrigger = "electrochimeraKilled"
  tempJob.numberRec = 1
  tempJob.reward = {{"kit_mixed_high"}}
  tempJob.rewardCount = 2
  tempJob.repReward = 79
  tempJob.moneyReward = {8000, 11000}
  tempJob.categories = {"mutantkillinsane"}

  ix.jobs.register(tempJob, "killChimerasLow")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "Kill %d electro-chimeras."
  tempJob.desc = "%d electro-chimeras."
  tempJob.icon = "propic/event/mutanthunt"
  tempJob.tier = 4
  tempJob.listenTrigger = "electrochimeraKilled"
  tempJob.numberRec = 2
  tempJob.reward = {{"kit_ammo_high"}, {"kit_mixed_high"}}
  tempJob.rewardCount = 3
  tempJob.repReward = 120
  tempJob.moneyReward = {15500, 19600}
  tempJob.categories = {"mutantkillinsane"}

  ix.jobs.register(tempJob, "killChimerasHigh")

  tempJob = nil

-- Bear
  local tempJob = {}

  tempJob.name = "Kill %d bears."
  tempJob.desc = "%d bears."
  tempJob.icon = "propic/event/mutanthunt"
  tempJob.tier = 3
  tempJob.listenTrigger = "bearKilled"
  tempJob.numberRec = 1
  tempJob.reward = {{"kit_mixed_high"}}
  tempJob.rewardCount = 1
  tempJob.repReward = 30
  tempJob.moneyReward = {3500, 6500}
  tempJob.categories = {"mutantkillhard"}

  ix.jobs.register(tempJob, "killBearLow")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "Kill %d bears."
  tempJob.desc = "%d bears."
  tempJob.icon = "propic/event/mutanthunt"
  tempJob.tier = 4
  tempJob.listenTrigger = "bearKilled"
  tempJob.numberRec = 3
  tempJob.reward = {{"kit_ammo_med"}, {"kit_mixed_high"}}
  tempJob.rewardCount = 1
  tempJob.repReward = 55
  tempJob.moneyReward = {7000, 12000}
  tempJob.categories = {"mutantkillhard"}

  ix.jobs.register(tempJob, "killBearHigh")

  tempJob = nil

-- Controllers

  local tempJob = {}

  tempJob.name = "Kill %d controllers."
  tempJob.desc = "%d controllers."
  tempJob.icon = "propic/event/mutanthunt"
  tempJob.tier = 2
  tempJob.listenTrigger = "controllerKilled"
  tempJob.numberRec = 2
  tempJob.reward = {{"kit_ammo_high"}, {"kit_mixed_high"}}
  tempJob.rewardCount = 1
  tempJob.repReward = 40
  tempJob.moneyReward = {10000, 14400}
  tempJob.categories = {"mutantkillmedium"}

  ix.jobs.register(tempJob, "killControllersLow")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "Kill %d controllers."
  tempJob.desc = "%d controllers."
  tempJob.icon = "propic/event/mutanthunt"
  tempJob.tier = 3
  tempJob.listenTrigger = "controllerKilled"
  tempJob.numberRec = {3,5}
  tempJob.reward = {{"kit_ammo_rare"}, {"kit_mixed_high"}, {"kit_ammo_high"}}
  tempJob.rewardCount = 3
  tempJob.moneyReward = {14000, 18500}
  tempJob.repReward = 95
  tempJob.categories = {"mutantkillhard"}

  ix.jobs.register(tempJob, "killControllersHigh")

-- dogs

  local tempJob = {}

  tempJob.name = "Kill %d blind dogs."
  tempJob.desc = "%d blind dogs."
  tempJob.icon = "vgui/icons/dogdead.png"
  tempJob.tier = 1
  tempJob.listenTrigger = "blinddogKilled"
  tempJob.numberRec = 3
  tempJob.reward = {{"762x25", { ["quantity"] = 25 }}, {"22lr", { ["quantity"] = 35 }}, {"9x18", { ["quantity"] = 25 }}, {"9x19", { ["quantity"] = 25 }}, {"45acp", { ["quantity"] = 25 }}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 4
  tempJob.moneyReward = {300, 490}
  tempJob.categories = {"mutantkilleasy"}

  ix.jobs.register(tempJob, "killDogsLow")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "Kill %d blind dogs."
  tempJob.desc = "%d blind dogs."
  tempJob.icon = "vgui/icons/dogdead.png"
  tempJob.tier = 1
  tempJob.listenTrigger = "blinddogKilled"
  tempJob.numberRec = 6
  tempJob.reward = {{"762x25", { ["quantity"] = 25 }}, {"22lr", { ["quantity"] = 35 }}, {"9x18", { ["quantity"] = 25 }}, {"9x19", { ["quantity"] = 25 }}, {"45acp", { ["quantity"] = 25 }}}
  tempJob.rewardCount = 2
  tempJob.repReward = 7
  tempJob.moneyReward = {500, 550}
  tempJob.categories = {"mutantkilleasy"}

  ix.jobs.register(tempJob, "killDogsMid")

  tempJob = nil 

  local tempJob = {}

  tempJob.name = "Kill %d blind dogs."
  tempJob.desc = "%d blind dogs."
  tempJob.icon = "vgui/icons/dogdead.png"
  tempJob.tier = 1
  tempJob.listenTrigger = "blinddogKilled"
  tempJob.numberRec = 12
  tempJob.reward = {{"762x25", { ["quantity"] = 25 }}, {"22lr", { ["quantity"] = 35 }}, {"9x18", { ["quantity"] = 25 }}, {"9x19", { ["quantity"] = 25 }}, {"45acp", { ["quantity"] = 25 }}}
  tempJob.rewardCount = 3
  tempJob.repReward = 13
  tempJob.moneyReward = {800, 900}
  tempJob.categories = {"mutantkilleasy"}

  ix.jobs.register(tempJob, "killDogsHigh")

  tempJob = nil  

--fleshes

  local tempJob = {}

  tempJob.name = "Kill %d fleshes."
  tempJob.desc = "%d fleshes."
  tempJob.icon = "vgui/icons/plotdead.png"
  tempJob.tier = 1
  tempJob.listenTrigger = "fleshKilled"
  tempJob.numberRec = 2
  tempJob.reward = {{"762x25", { ["quantity"] = 15 }}, {"22lr", { ["quantity"] = 25 }}, {"9x18", { ["quantity"] = 15 }}, {"9x19", { ["quantity"] = 15 }}, {"45acp", { ["quantity"] = 12 }}}
  tempJob.rewardCount = 1
  tempJob.repReward = 1
  tempJob.moneyReward = {120, 175}
  tempJob.categories = {"mutantkilleasy"}

  ix.jobs.register(tempJob, "killFleshesLow")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "Kill %d fleshes."
  tempJob.desc = "%d fleshes."
  tempJob.icon = "vgui/icons/plotdead.png"
  tempJob.tier = 1
  tempJob.listenTrigger = "fleshKilled"
  tempJob.numberRec = 5
  tempJob.reward = {{"762x25", { ["quantity"] = 25 }}, {"22lr", { ["quantity"] = 35 }}, {"9x18", { ["quantity"] = 25 }}, {"9x19", { ["quantity"] = 25 }}, {"45acp", { ["quantity"] = 25 }}}
  tempJob.rewardCount = 1
  tempJob.repReward = 2
  tempJob.moneyReward = {210, 290}
  tempJob.categories = {"mutantkilleasy"}

  ix.jobs.register(tempJob, "killFleshesMid")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "Kill %d fleshes."
  tempJob.desc = "%d fleshes."
  tempJob.icon = "vgui/icons/plotdead.png"
  tempJob.tier = 1
  tempJob.listenTrigger = "fleshKilled"
  tempJob.numberRec = 10
  tempJob.reward = {{"762x25", { ["quantity"] = 25 }}, {"22lr", { ["quantity"] = 35 }}, {"9x18", { ["quantity"] = 25 }}, {"9x19", { ["quantity"] = 25 }}, {"45acp", { ["quantity"] = 25 }}}
  tempJob.rewardCount = 2
  tempJob.repReward = 5
  tempJob.moneyReward = {300, 400}
  tempJob.categories = {"mutantkilleasy"}

  ix.jobs.register(tempJob, "killFleshesHigh")

  tempJob = nil

-- pseudodogs

  local tempJob = {}

  tempJob.name = "Kill %d pseudodogs."
  tempJob.desc = "%d pseudodogs."
  tempJob.icon = "vgui/icons/psi-dogdead.png"
  tempJob.tier = 1
  tempJob.listenTrigger = "pseudodogKilled"
  tempJob.numberRec = 1
  tempJob.reward = {{"kit_ammo_low"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 7
  tempJob.moneyReward = {450, 600}
  tempJob.categories = {"mutantkilleasy"}

  ix.jobs.register(tempJob, "killPseudodogsLow")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "Kill %d pseudodogs."
  tempJob.desc = "%d pseudodogs."
  tempJob.icon = "vgui/icons/psi-dogdead.png"
  tempJob.tier = 2
  tempJob.listenTrigger = "pseudodogKilled"
  tempJob.numberRec = 2
  tempJob.reward = {{"kit_ammo_med"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 12
  tempJob.moneyReward = {600, 900}
  tempJob.categories = {"mutantkilleasy"}

  ix.jobs.register(tempJob, "killPseudodogsMid")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "Kill %d pseudodogs."
  tempJob.desc = "%d pseudodogs."
  tempJob.icon = "vgui/icons/psi-dogdead.png"
  tempJob.tier = 2
  tempJob.listenTrigger = "pseudodogKilled"
  tempJob.numberRec = 3
  tempJob.reward = {{"kit_ammo_med"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 17
  tempJob.moneyReward = {750, 1000}
  tempJob.categories = {"mutantkilleasy"}

  ix.jobs.register(tempJob, "killPseudodogsHigh")

  tempJob = nil

-- Snork

  local tempJob = {}

  tempJob.name = "Kill %d snorks."
  tempJob.desc = "%d snorks."
  tempJob.icon = "vgui/icons/snorkdead.png"
  tempJob.tier = 2
  tempJob.listenTrigger = "snorkKilled"
  tempJob.numberRec = 1
  tempJob.reward = {{"kit_ammo_med"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 10
  tempJob.moneyReward = {500, 750}
  tempJob.categories = {"mutantkillmedium"}

  ix.jobs.register(tempJob, "killSnorksLow")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "Kill %d snorks."
  tempJob.desc = "%d snorks."
  tempJob.icon = "vgui/icons/snorkdead.png"
  tempJob.tier = 2
  tempJob.listenTrigger = "snorkKilled"
  tempJob.numberRec = 2
  tempJob.reward = {{"kit_ammo_med"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 14
  tempJob.moneyReward = {750, 1000}
  tempJob.categories = {"mutantkillmedium"}

  ix.jobs.register(tempJob, "killSnorksMid")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "Kill %d snorks."
  tempJob.desc = "%d snorks."
  tempJob.icon = "vgui/icons/snorkdead.png"
  tempJob.tier = 2
  tempJob.listenTrigger = "snorkKilled"
  tempJob.numberRec = 4
  tempJob.reward = {{"kit_ammo_high"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 20
  tempJob.moneyReward = {1000, 1250}
  tempJob.categories = {"mutantkillmedium"}

  ix.jobs.register(tempJob, "killSnorksHigh")

  tempJob = nil


-- psydogs
  local tempJob = {}

  tempJob.name = "Kill %d psydogs."
  tempJob.desc = "%d psydogs."
  tempJob.icon = "propic/event/mutanthunt"
  tempJob.tier = 2
  tempJob.listenTrigger = "psydogKilled"
  tempJob.numberRec = {1,1}
  tempJob.reward = {{"kit_ammo_med"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 15
  tempJob.moneyReward = {800, 1100}
  tempJob.categories = {"mutantkillmedium"}

  ix.jobs.register(tempJob, "killPsydogsLow")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "Kill %d psydogs."
  tempJob.desc = "%d psydogs."
  tempJob.icon = "propic/event/mutanthunt"
  tempJob.tier = 3
  tempJob.listenTrigger = "psydogKilled"
  tempJob.numberRec = {2,3}
  tempJob.reward = {{"kit_ammo_high"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 20
  tempJob.moneyReward = {950, 1300}
  tempJob.categories = {"mutantkillmedium"}

  ix.jobs.register(tempJob, "killPsydogsLow")

  tempJob = nil

-- Pseudogiants

  local tempJob = {}

  tempJob.name = "Kill %d pseudogiants."
  tempJob.desc = "%d pseudogiants."
  tempJob.icon = "propic/event/mutanthunt"
  tempJob.tier = 3
  tempJob.listenTrigger = "pseudogiantKilled"
  tempJob.numberRec = 1
  tempJob.reward = {{"kit_ammo_m_low"}, {"kit_ammo_m_rare"}}
  tempJob.rewardCount = 2
  tempJob.repReward = 75
  tempJob.moneyReward = {8000, 9500}
  tempJob.categories = {"mutantkillinsane"}

  ix.jobs.register(tempJob, "killPseudogiantsLow")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "Kill %d pseudogiants."
  tempJob.desc = "%d pseudogiants."
  tempJob.icon = "propic/event/mutanthunt"
  tempJob.tier = 4
  tempJob.listenTrigger = "pseudogiantKilled"
  tempJob.numberRec = {2,3}
  tempJob.reward = {{"kit_ammo_m_low"}, {"kit_ammo_m_rare"}}
  tempJob.rewardCount = 3
  tempJob.repReward = 150
  tempJob.moneyReward = {12000, 14000}
  tempJob.categories = {"mutantkillinsane"}

  ix.jobs.register(tempJob, "killPseudogiantsHigh")

  tempJob = nil


  local tempJob = {}

  tempJob.name = "Kill %d izloms."
  tempJob.desc = "%d izloms."
  tempJob.icon = "propic/event/mutanthunt"
  tempJob.tier = 1
  tempJob.listenTrigger = "izlomKilled"
  tempJob.numberRec = 2
  tempJob.reward = {{"kit_mixed_med"}}
  tempJob.rewardCount = {1,1}
  tempJob.repReward = 25
  tempJob.moneyReward = {1500, 2000}
  tempJob.categories = {"mutantkillmedium"}

  ix.jobs.register(tempJob, "killIzlomsLow")

  tempJob = nil

-- Spider

  local tempJob = {}

  tempJob.name = "Kill %d spiders."
  tempJob.desc = "%d spiders."
  tempJob.icon = "propic/event/mutanthunt"
  tempJob.tier = 1
  tempJob.listenTrigger = "spiderKilled"
  tempJob.numberRec = 2
  tempJob.reward = {{"kit_ammo_m_low"}}
  tempJob.rewardCount = 1
  tempJob.repReward = 12
  tempJob.moneyReward = {800, 1200}
  tempJob.categories = {"mutantkillmedium"}

  ix.jobs.register(tempJob, "killSpidersLow")

  tempJob = nil


  local tempJob = {}

  tempJob.name = "Kill %d spiders."
  tempJob.desc = "%d spiders."
  tempJob.icon = "propic/event/mutanthunt"
  tempJob.tier = 1
  tempJob.listenTrigger = "spiderKilled"
  tempJob.numberRec = 3
  tempJob.reward = {{"kit_aid_high"}}
  tempJob.rewardCount = 1
  tempJob.repReward = 18
  tempJob.moneyReward = {1300, 1500}
  tempJob.categories = {"mutantkillmedium"}

  ix.jobs.register(tempJob, "killSpidersMid")

  tempJob = nil


  local tempJob = {}

  tempJob.name = "Kill %d spiders."
  tempJob.desc = "%d spiders."
  tempJob.icon = "propic/event/mutanthunt"
  tempJob.tier = 1
  tempJob.listenTrigger = "spiderKilled"
  tempJob.numberRec = 6
  tempJob.reward = {{"kit_aid_large"}, {"kit_aid_high"}}
  tempJob.rewardCount = 1
  tempJob.repReward = 30
  tempJob.moneyReward = {1900, 2500}
  tempJob.categories = {"mutantkillmedium"}

  ix.jobs.register(tempJob, "killSpidersHigh")

  tempJob = nil

-- Tark

  local tempJob = {}

  tempJob.name = "Kill %d tarks."
  tempJob.desc = "%d tarks."
  tempJob.icon = "propic/event/mutanthunt"
  tempJob.tier = 1
  tempJob.listenTrigger = "tarkKilled"
  tempJob.numberRec = 1
  tempJob.reward = {{"kit_mixed_low"}}
  tempJob.rewardCount = 1
  tempJob.repReward = 15
  tempJob.moneyReward = {500, 700}
  tempJob.categories = {"mutantkilleasy"}

  ix.jobs.register(tempJob, "killTarksLow")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "Kill %d tarks."
  tempJob.desc = "%d tarks."
  tempJob.icon = "propic/event/mutanthunt"
  tempJob.tier = 1
  tempJob.listenTrigger = "tarkKilled"
  tempJob.numberRec = 2
  tempJob.reward = {{"kit_mixed_low"}, {"kit_mixed_med"}}
  tempJob.rewardCount = 1
  tempJob.repReward = 20
  tempJob.moneyReward = {1200, 1500}
  tempJob.categories = {"mutantkilleasy"}

  ix.jobs.register(tempJob, "killTarksMid")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "Kill %d tarks."
  tempJob.desc = "%d tarks."
  tempJob.icon = "propic/event/mutanthunt"
  tempJob.tier = 1
  tempJob.listenTrigger = "tarkKilled"
  tempJob.numberRec = 4
  tempJob.reward = {{"kit_mixed_m_low"}, {"kit_mixed_med"}}
  tempJob.rewardCount = 1
  tempJob.repReward = 25
  tempJob.moneyReward = {1900, 2500}
  tempJob.categories = {"mutantkilleasy"}

  ix.jobs.register(tempJob, "killTarksHigh")

  tempJob = nil

-- Sprig
  local tempJob = {}

  tempJob.name = "Kill %d sprigs."
  tempJob.desc = "%d sprigs."
  tempJob.icon = "propic/event/mutanthunt"
  tempJob.tier = 1
  tempJob.listenTrigger = "sprigKilled"
  tempJob.numberRec = 1
  tempJob.reward = {{"kit_mixed_low"}}
  tempJob.rewardCount = 1
  tempJob.repReward = 15
  tempJob.moneyReward = {1000, 1800}
  tempJob.categories = {"mutantkilleasy"}

  ix.jobs.register(tempJob, "killSprigsLow")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "Kill %d sprigs."
  tempJob.desc = "%d sprigs."
  tempJob.icon = "propic/event/mutanthunt"
  tempJob.tier = 1
  tempJob.listenTrigger = "sprigKilled"
  tempJob.numberRec = 2
  tempJob.reward = {{"kit_mixed_low"}, {"kit_mixed_med"}}
  tempJob.rewardCount = 1
  tempJob.repReward = 25
  tempJob.moneyReward = {1600, 2500}
  tempJob.categories = {"mutantkillmedium"}

  ix.jobs.register(tempJob, "killSprigsHigh")

  tempJob = nil

-- Vareshka

  local tempJob = {}

  tempJob.name = "Kill %d vareshkas."
  tempJob.desc = "%d vareshkas."
  tempJob.icon = "propic/event/mutanthunt"
  tempJob.tier = 3
  tempJob.listenTrigger = "vareshkaKilled"
  tempJob.numberRec = 1
  tempJob.reward = {{"kit_ammo_med"}}
  tempJob.rewardCount = 1
  tempJob.repReward = 25
  tempJob.moneyReward = {3000, 5500}
  tempJob.categories = {"mutantkillmedium"}

  ix.jobs.register(tempJob, "killVareshkasLow")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "Kill %d vareshkas."
  tempJob.desc = "%d vareshkas."
  tempJob.icon = "propic/event/mutanthunt"
  tempJob.tier = 3
  tempJob.listenTrigger = "vareshkaKilled"
  tempJob.numberRec = 2
  tempJob.reward = {{"kit_ammo_med"}, {"kit_ammo_high"}}
  tempJob.rewardCount = 1
  tempJob.repReward = 35
  tempJob.moneyReward = {4500, 7600}
  tempJob.categories = {"mutantkillmedium"}

  ix.jobs.register(tempJob, "killVareshkasHigh")

  tempJob = nil

-- Karlik

  local tempJob = {}

  tempJob.name = "Kill %d karliks."
  tempJob.desc = "%d karliks."
  tempJob.icon = "propic/event/mutanthunt"
  tempJob.tier = 3
  tempJob.listenTrigger = "karlikKilled"
  tempJob.numberRec = 1
  tempJob.reward = {{"kit_ammo_med"}}
  tempJob.rewardCount = 1
  tempJob.repReward = 60
  tempJob.moneyReward = {4000, 8400}
  tempJob.categories = {"mutantkillmedium"}

  ix.jobs.register(tempJob, "killKarliksLow")

  tempJob = nil

  local tempJob = {}

  tempJob.name = "Kill %d karliks."
  tempJob.desc = "%d karliks."
  tempJob.icon = "propic/event/mutanthunt"
  tempJob.tier = 3
  tempJob.listenTrigger = "karlikKilled"
  tempJob.numberRec = 3
  tempJob.reward = {{"kit_ammo_med"}, {"kit_ammo_med"}, {"kit_ammo_med"}, {"kit_ammo_m_rare"}}
  tempJob.rewardCount = 2
  tempJob.repReward = 90
  tempJob.moneyReward = {9000, 15000}
  tempJob.categories = {"mutantkillhard"}

  ix.jobs.register(tempJob, "killKarliksHigh")

  tempJob = nil

-- Skeleton

  local tempJob = {}

  tempJob.name = "Kill %d skeletons."
  tempJob.desc = "%d skeletons."
  tempJob.icon = "propic/event/mutanthunt"
  tempJob.tier = 3
  tempJob.listenTrigger = "skeletonKilled"
  tempJob.numberRec = 8
  tempJob.reward = {{"kit_ammo_high"}, {"kit_ammo_m_rare"}, {"kit_mixed_high"}}
  tempJob.rewardCount = 1
  tempJob.repReward = 60
  tempJob.moneyReward = {11000, 22000}
  tempJob.categories = {"mutantkillhigh"}

  ix.jobs.register(tempJob, "killSkeleton")

  tempJob = nil
end
