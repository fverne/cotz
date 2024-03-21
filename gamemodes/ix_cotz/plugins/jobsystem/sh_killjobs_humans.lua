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


-- Bandits

local tempJob = {}

tempJob.name = "Kill %d bandits."
tempJob.desc = "%d bandits."
tempJob.icon = "propic/bandits/bandit11"
tempJob.tier = 1
tempJob.listenTrigger = "banditKilled"
tempJob.numberRec = 2
tempJob.reward = {{"kit_reward_ammo_tier01"}}
tempJob.rewardCount = 1
tempJob.repReward = 15
tempJob.categories = {"kill_human_NPC_easy"}

ix.jobs.register(tempJob, "kill_bandits_low")

tempJob = nil


local tempJob = {}

tempJob.name = "Kill %d bandits."
tempJob.desc = "%d bandits."
tempJob.icon = "propic/bandits/bandit11"
tempJob.tier = 1
tempJob.listenTrigger = "banditKilled"
tempJob.numberRec = 5
tempJob.reward = {{"kit_reward_ammo_tier01"}}
tempJob.rewardCount = 1
tempJob.repReward = 15
tempJob.categories = {"kill_human_NPC_easy"}

ix.jobs.register(tempJob, "kill_bandits_mid")

tempJob = nil


local tempJob = {}

tempJob.name = "Kill %d bandits."
tempJob.desc = "%d bandits."
tempJob.icon = "propic/bandits/bandit11"
tempJob.tier = 1
tempJob.listenTrigger = "banditKilled"
tempJob.numberRec = 8
tempJob.reward = {{"kit_reward_ammo_tier01"}}
tempJob.rewardCount = 1
tempJob.repReward = 25
tempJob.categories = {"kill_human_NPC_easy"}

ix.jobs.register(tempJob, "kill_bandits_high")

tempJob = nil


-- Mercs

local tempJob = {}

tempJob.name = "Kill %d mercenaries."
tempJob.desc = "%d mercenaries."
tempJob.icon = "propic/merc/merc7"
tempJob.tier = 1
tempJob.listenTrigger = "mercKilled"
tempJob.numberRec = 2
tempJob.reward = {{"kit_reward_ammo_tier02"}}
tempJob.rewardCount = 1
tempJob.repReward = 30
tempJob.categories = {"kill_human_NPC_medium"}

ix.jobs.register(tempJob, "kill_mercenaries_low")

tempJob = nil


local tempJob = {}

tempJob.name = "Kill %d mercenaries."
tempJob.desc = "%d mercenaries."
tempJob.icon = "propic/merc/merc7"
tempJob.tier = 1
tempJob.listenTrigger = "mercKilled"
tempJob.numberRec = 5
tempJob.reward = {{"kit_reward_ammo_tier02"}}
tempJob.rewardCount = 1
tempJob.repReward = 30
tempJob.categories = {"kill_human_NPC_medium"}

ix.jobs.register(tempJob, "kill_mercenaries_mid")

tempJob = nil


local tempJob = {}

tempJob.name = "Kill %d mercenaries."
tempJob.desc = "%d mercs."
tempJob.icon = "propic/merc/merc7"
tempJob.tier = 1
tempJob.listenTrigger = "mercKilled"
tempJob.numberRec = 8
tempJob.reward = {{"kit_reward_ammo_tier02"}}
tempJob.rewardCount = 1
tempJob.repReward = 40
tempJob.categories = {"kill_human_NPC_medium"}

ix.jobs.register(tempJob, "kill_mercenaries_high")

tempJob = nil


-- Mili

local tempJob = {}

tempJob.name = "Kill %d military."
tempJob.desc = "%d military."
tempJob.icon = "propic/mili/mili11"
tempJob.tier = 1
tempJob.listenTrigger = "miliKilled"
tempJob.numberRec = 2
tempJob.reward = {{"kit_reward_ammo_tier03"}}
tempJob.rewardCount = 1
tempJob.repReward = 45
tempJob.categories = {"kill_human_NPC_hard"}

ix.jobs.register(tempJob, "kill_military_low")

tempJob = nil


local tempJob = {}

tempJob.name = "Kill %d military."
tempJob.desc = "%d military."
tempJob.icon = "propic/mili/mili11"
tempJob.tier = 1
tempJob.listenTrigger = "miliKilled"
tempJob.numberRec = 5
tempJob.reward = {{"kit_reward_ammo_tier03"}}
tempJob.rewardCount = 1
tempJob.repReward = 45
tempJob.categories = {"kill_human_NPC_hard"}

ix.jobs.register(tempJob, "kill_military_mid")

tempJob = nil


local tempJob = {}

tempJob.name = "Kill %d military."
tempJob.desc = "%d mili."
tempJob.icon = "propic/mili/mili11"
tempJob.tier = 1
tempJob.listenTrigger = "miliKilled"
tempJob.numberRec = 8
tempJob.reward = {{"kit_reward_ammo_tier03"}}
tempJob.rewardCount = 1
tempJob.repReward = 55
tempJob.categories = {"kill_human_NPC_hard"}

ix.jobs.register(tempJob, "kill_military_high")

tempJob = nil
