ix.jobs.register({
	name = "Kill %d bandits.",
	desc = "%d bandits.",
	icon = "propic/bandits/bandit11",
	tier = 1,
	listenTrigger = "banditKilled",
	numberRec = 2,
	reward = {{"kit_reward_ammo_tier01"}},
	rewardCount = 1,
	repReward = 15,
	categories = {"kill_human_NPC_easy"},
}, "kill_bandits_low")

ix.jobs.register({
	name = "Kill %d bandits.",
	desc = "%d bandits.",
	icon = "propic/bandits/bandit11",
	tier = 1,
	listenTrigger = "banditKilled",
	numberRec = 5,
	reward = {{"kit_reward_ammo_tier01"}},
	rewardCount = 1,
	repReward = 15,
	categories = {"kill_human_NPC_easy"},
}, "kill_bandits_mid")

ix.jobs.register({
	name = "Kill %d bandits.",
	desc = "%d bandits.",
	icon = "propic/bandits/bandit11",
	tier = 1,
	listenTrigger = "banditKilled",
	numberRec = 8,
	reward = {{"kit_reward_ammo_tier01"}},
	rewardCount = 1,
	repReward = 25,
	categories = {"kill_human_NPC_easy"},
}, "kill_bandits_high")

ix.jobs.register({
	name = "Kill %d mercenaries.",
	desc = "%d mercenaries.",
	icon = "propic/merc/merc7",
	tier = 1,
	listenTrigger = "mercKilled",
	numberRec = 2,
	reward = {{"kit_reward_ammo_tier02"}},
	rewardCount = 1,
	repReward = 30,
	categories = {"kill_human_NPC_medium"},
}, "kill_mercenaries_low")

ix.jobs.register({
	name = "Kill %d mercenaries.",
	desc = "%d mercenaries.",
	icon = "propic/merc/merc7",
	tier = 1,
	listenTrigger = "mercKilled",
	numberRec = 5,
	reward = {{"kit_reward_ammo_tier02"}},
	rewardCount = 1,
	repReward = 30,
	categories = {"kill_human_NPC_medium"},
}, "kill_mercenaries_mid")

ix.jobs.register({
	name = "Kill %d mercenaries.",
	desc = "%d mercs.",
	icon = "propic/merc/merc7",
	tier = 1,
	listenTrigger = "mercKilled",
	numberRec = 8,
	reward = {{"kit_reward_ammo_tier02"}},
	rewardCount = 1,
	repReward = 40,
	categories = {"kill_human_NPC_medium"},
}, "kill_mercenaries_high")

ix.jobs.register({
	name = "Kill %d military.",
	desc = "%d military.",
	icon = "propic/mili/mili11",
	tier = 1,
	listenTrigger = "miliKilled",
	numberRec = 2,
	reward = {{"kit_reward_ammo_tier03"}},
	rewardCount = 1,
	repReward = 45,
	categories = {"kill_human_NPC_hard"},
}, "kill_military_low")

ix.jobs.register({
	name = "Kill %d military.",
	desc = "%d military.",
	icon = "propic/mili/mili11",
	tier = 1,
	listenTrigger = "miliKilled",
	numberRec = 5,
	reward = {{"kit_reward_ammo_tier03"}},
	rewardCount = 1,
	repReward = 45,
	categories = {"kill_human_NPC_hard"},
}, "kill_military_mid")

ix.jobs.register({
	name = "Kill %d military.",
	desc = "%d mili.",
	icon = "propic/mili/mili11",
	tier = 1,
	listenTrigger = "miliKilled",
	numberRec = 8,
	reward = {{"kit_reward_ammo_tier03"}},
	rewardCount = 1,
	repReward = 55,
	categories = {"kill_human_NPC_hard"},
}, "kill_military_high")
