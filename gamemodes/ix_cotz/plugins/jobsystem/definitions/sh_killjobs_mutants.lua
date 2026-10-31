ix.jobs.register({
	name = "Kill %d mutants.",
	desc = "%d mutants.",
	icon = "propic/event/mutanthunt",
	tier = 1,
	listenTrigger = "mutantKilled",
	numberRec = 12,
	reward = {
		{"762x25", { ["quantity"] = 25 }},
		{"22lr", { ["quantity"] = 35 }},
		{"9x18", { ["quantity"] = 25 }},
		{"9x19", { ["quantity"] = 25 }},
		{"45acp", { ["quantity"] = 25 }},
	},
	rewardCount = 2,
	repReward = 12,
	moneyReward = {750, 1100},
	categories = {"mutantkillgroupeasy"},
}, "killMutantsLow")

ix.jobs.register({
	name = "Kill %d mutants.",
	desc = "%d mutants.",
	icon = "propic/event/mutanthunt",
	tier = 2,
	listenTrigger = "mutantKilled",
	numberRec = 24,
	reward = {"kit_ammo_m_low"},
	rewardCount = 2,
	repReward = 21,
	moneyReward = {1250, 1650},
	categories = {"mutantkillgroupeasy"},
}, "killMutantsMid")

ix.jobs.register({
	name = "Kill %d mutants.",
	desc = "%d mutants.",
	icon = "propic/event/mutanthunt",
	tier = 2,
	listenTrigger = "mutantKilled",
	numberRec = 40,
	reward = {"kit_ammo_med"},
	rewardCount = 2,
	repReward = 34,
	moneyReward = {2500, 2900},
	categories = {"mutantkillgroupeasy"},
}, "killMutantsHigh")

ix.jobs.register({
	name = "Kill %d humanoid mutants.",
	desc = "%d humanoid mutants.",
	icon = "propic/event/mutanthunt",
	tier = 2,
	listenTrigger = "groupHumanoidKilled",
	numberRec = 5,
	reward = {{"kit_ammo_low"}},
	rewardCount = 1,
	repReward = 10,
	moneyReward = {400, 600},
	categories = {"mutantkillgroupeasy"},
}, "killHumanoidsLow")

ix.jobs.register({
	name = "Kill %d humanoid mutants.",
	desc = "%d humanoid mutants.",
	icon = "propic/event/mutanthunt",
	tier = 2,
	listenTrigger = "groupHumanoidKilled",
	numberRec = 9,
	reward = {{"kit_ammo_low"}},
	rewardCount = 1,
	repReward = 13,
	moneyReward = {600, 800},
	categories = {"mutantkillgroupeasy"},
}, "killHumanoidsMid")

ix.jobs.register({
	name = "Kill %d humanoid mutants.",
	desc = "%d humanoid mutants.",
	icon = "propic/event/mutanthunt",
	tier = 2,
	listenTrigger = "groupHumanoidKilled",
	numberRec = 15,
	reward = {{"kit_ammo_med"}},
	rewardCount = 1,
	repReward = 21,
	moneyReward = {900, 1300},
	categories = {"mutantkillgroupeasy"},
}, "killHumanoidsHigh")

ix.jobs.register({
	name = "Kill %d predator mutants.",
	desc = "%d predator mutants.",
	icon = "propic/event/mutanthunt",
	tier = 2,
	listenTrigger = "groupPredatorKilled",
	numberRec = 2,
	reward = {{"kit_ammo_low"}, 0},
	rewardCount = 1,
	repReward = 8,
	moneyReward = {500, 600},
	categories = {"mutantkillgroupmedium"},
}, "killPredatorsLow")

ix.jobs.register({
	name = "Kill %d predator mutants.",
	desc = "%d predator mutants.",
	icon = "propic/event/mutanthunt",
	tier = 2,
	listenTrigger = "groupPredatorKilled",
	numberRec = 4,
	reward = {{"kit_ammo_low"}, 0},
	rewardCount = 2,
	repReward = 12,
	moneyReward = {800, 1000},
	categories = {"mutantkillgroupmedium"},
}, "killPredatorsMid")

ix.jobs.register({
	name = "Kill %d predator mutants.",
	desc = "%d predator mutants.",
	icon = "propic/event/mutanthunt",
	tier = 2,
	listenTrigger = "groupPredatorKilled",
	numberRec = 6,
	reward = {{"kit_ammo_low"}, {"kit_ammo_low"}, 0},
	rewardCount = 2,
	repReward = 18,
	moneyReward = {1200, 1400},
	categories = {"mutantkillgroupmedium"},
}, "killPredatorsHigh")

ix.jobs.register({
	name = "Kill %d canine mutants.",
	desc = "%d canine mutants.",
	icon = "propic/event/mutanthunt",
	tier = 2,
	listenTrigger = "groupCanineKilled",
	numberRec = 5,
	reward = {{"kit_ammo_low"}, {"kit_ammo_low"}, 0},
	rewardCount = 1,
	repReward = 7,
	moneyReward = {350, 460},
	categories = {"mutantkillgroupeasy"},
}, "killCaninesLow")

ix.jobs.register({
	name = "Kill %d canine mutants.",
	desc = "%d canine mutants.",
	icon = "propic/event/mutanthunt",
	tier = 2,
	listenTrigger = "groupCanineKilled",
	numberRec = 9,
	reward = {{"kit_ammo_low"}, {"kit_ammo_low"}, 0},
	rewardCount = 1,
	repReward = 15,
	moneyReward = {600, 800},
	categories = {"mutantkillgroupeasy"},
}, "killCaninesMid")

ix.jobs.register({
	name = "Kill %d canine mutants.",
	desc = "%d canine mutants.",
	icon = "propic/event/mutanthunt",
	tier = 2,
	listenTrigger = "groupCanineKilled",
	numberRec = 13,
	reward = {{"kit_ammo_low"}, {"kit_ammo_low"}, 0},
	rewardCount = 2,
	repReward = 20,
	moneyReward = {700, 1000},
	categories = {"mutantkillgroupeasy"},
}, "killCaninesHigh")

ix.jobs.register({
	name = "Kill %d meat mutants.",
	desc = "%d meat mutants.",
	icon = "propic/event/mutanthunt",
	tier = 2,
	listenTrigger = "groupMeatKilled",
	numberRec = 4,
	reward = {{"kit_ammo_low"}, 0},
	rewardCount = 1,
	repReward = 5,
	moneyReward = {150, 250},
	categories = {"mutantkillgroupeasy"},
}, "killMeatsLow")

ix.jobs.register({
	name = "Kill %d meat mutants.",
	desc = "%d meat mutants.",
	icon = "propic/event/mutanthunt",
	tier = 2,
	listenTrigger = "groupMeatKilled",
	numberRec = 8,
	reward = {{"kit_ammo_low"}, 0},
	rewardCount = 1,
	repReward = 10,
	moneyReward = {190, 370},
	categories = {"mutantkillgroupeasy"},
}, "killMeatsMid")

ix.jobs.register({
	name = "Kill %d meat mutants.",
	desc = "%d meat mutants.",
	icon = "propic/event/mutanthunt",
	tier = 2,
	listenTrigger = "groupMeatKilled",
	numberRec = 14,
	reward = {{"kit_ammo_low"}, 0},
	rewardCount = 2,
	repReward = 15,
	moneyReward = {470, 770},
	categories = {"mutantkillgroupeasy"},
}, "killMeatsHigh")

ix.jobs.register({
	name = "Kill %d psychic mutants.",
	desc = "%d psychic mutants.",
	icon = "propic/event/mutanthunt",
	tier = 2,
	listenTrigger = "groupPsyKilled",
	numberRec = 2,
	reward = {{"kit_ammo_rare"}, 0},
	rewardCount = 1,
	repReward = 50,
	moneyReward = {2000, 4000},
	categories = {"mutantkillgroupmedium"},
}, "killPsyLow")

ix.jobs.register({
	name = "Kill %d psychic mutants.",
	desc = "%d psychic mutants.",
	icon = "propic/event/mutanthunt",
	tier = 2,
	listenTrigger = "groupPsyKilled",
	numberRec = 4,
	reward = {{"kit_ammo_rare"}, 0},
	rewardCount = 1,
	repReward = 75,
	moneyReward = {3000, 6000},
	categories = {"mutantkillgroupmedium"},
}, "killPsyMid")

ix.jobs.register({
	name = "Kill %d psychic mutants.",
	desc = "%d psychic mutants.",
	icon = "propic/event/mutanthunt",
	tier = 2,
	listenTrigger = "groupPsyKilled",
	numberRec = 6,
	reward = {{"kit_ammo_rare"}, 0},
	rewardCount = 2,
	repReward = 120,
	moneyReward = {4000, 7000},
	categories = {"mutantkillgroupmedium"},
}, "killPsyHigh")

ix.jobs.register({
	name = "Kill %d rodents.",
	desc = "%d rodents.",
	icon = "vgui/icons/tushkandead.png",
	tier = 1,
	listenTrigger = "rodentKilled",
	numberRec = 2,
	reward = {{"kit_reward_ammo_tier01"}},
	rewardCount = 1,
	repReward = 2,
	moneyReward = {120, 180},
	categories = {"mutantkilleasy"},
}, "killRodentsLow")

ix.jobs.register({
	name = "Kill %d rodents.",
	desc = "%d rodents.",
	icon = "vgui/icons/tushkandead.png",
	tier = 1,
	listenTrigger = "rodentKilled",
	numberRec = 5,
	reward = {{"kit_reward_ammo_tier01"}},
	rewardCount = 1,
	repReward = 6,
	moneyReward = {260, 420},
	categories = {"mutantkilleasy"},
}, "killRodentsMid")

ix.jobs.register({
	name = "Kill %d rodents.",
	desc = "%d rodents.",
	icon = "vgui/icons/tushkandead.png",
	tier = 1,
	listenTrigger = "rodentKilled",
	numberRec = 8,
	reward = {{"kit_reward_ammo_tier01"}},
	rewardCount = 1,
	repReward = 9,
	moneyReward = {320, 490},
	categories = {"mutantkilleasy"},
}, "killRodentsHigh")

ix.jobs.register({
	name = "Kill %d hellhounds.",
	desc = "%d hellhounds.",
	icon = "vgui/icons/dogdead.png",
	tier = 2,
	listenTrigger = "hellhoundKilled",
	numberRec = 2,
	reward = {{"kit_ammo_low"}, {"kit_ammo_med"}},
	rewardCount = 1,
	repReward = 9,
	moneyReward = {900, 1500},
	categories = {"mutantkillhard"},
}, "killHellhoundsLow")

ix.jobs.register({
	name = "Kill %d hellhounds.",
	desc = "%d hellhounds.",
	icon = "vgui/icons/dogdead.png",
	tier = 2,
	listenTrigger = "hellhoundKilled",
	numberRec = 4,
	reward = {{"kit_ammo_low"}, {"kit_ammo_med"}},
	rewardCount = 2,
	repReward = 17,
	moneyReward = {1200, 1800},
	categories = {"mutantkillhard"},
}, "killHellhoundsHigh")

ix.jobs.register({
	name = "Kill %d zombies.",
	desc = "%d zombies.",
	icon = "vgui/icons/face_42.png",
	tier = 2,
	listenTrigger = "zombieKilled",
	numberRec = 3,
	reward = {{"kit_reward_ammo_tier01"}},
	rewardCount = 1,
	repReward = 5,
	moneyReward = {320, 490},
	categories = {"mutantkilleasy"},
}, "killZombiesLow")

ix.jobs.register({
	name = "Kill %d zombies.",
	desc = "%d zombies.",
	icon = "vgui/icons/face_42.png",
	tier = 2,
	listenTrigger = "zombieKilled",
	numberRec = 7,
	reward = {{"kit_reward_ammo_tier01"}},
	rewardCount = 1,
	repReward = 8,
	moneyReward = {480, 600},
	categories = {"mutantkilleasy"},
}, "killZombiesMid")

ix.jobs.register({
	name = "Kill %d zombies.",
	desc = "%d zombies.",
	icon = "vgui/icons/face_42.png",
	tier = 2,
	listenTrigger = "zombieKilled",
	numberRec = 12,
	reward = {{"kit_reward_ammo_tier01"}},
	rewardCount = 1,
	repReward = 12,
	moneyReward = {550, 700},
	categories = {"mutantkilleasy"},
}, "killZombiesHigh")

ix.jobs.register({
	name = "Kill %d cats.",
	desc = "%d cats.",
	icon = "entities/vj_mutant_cat3.png",
	tier = 1,
	listenTrigger = "catKilled",
	numberRec = 1,
	reward = {{"kit_reward_ammo_tier01"}},
	rewardCount = {1,1},
	repReward = 8,
	moneyReward = {600, 900},
	categories = {"mutantkilleasy"},
}, "killCatsLow")

ix.jobs.register({
	name = "Kill %d cats.",
	desc = "%d cats.",
	icon = "entities/vj_mutant_cat3.png",
	tier = 2,
	listenTrigger = "catKilled",
	numberRec = 2,
	reward = {{"kit_reward_ammo_tier01"}},
	rewardCount = 1,
	repReward = 12,
	moneyReward = {850, 1150},
	categories = {"mutantkilleasy"},
}, "killCatsMid")

ix.jobs.register({
	name = "Kill %d cats.",
	desc = "%d cats.",
	icon = "entities/vj_mutant_cat3.png",
	tier = 2,
	listenTrigger = "catKilled",
	numberRec = 4,
	reward = {{"kit_reward_ammo_tier01"}},
	rewardCount = 1,
	repReward = 16,
	moneyReward = {1000, 1400},
	categories = {"mutantkilleasy"},
}, "killCatsHigh")

ix.jobs.register({
	name = "Kill %d bloodsuckers.",
	desc = "%d bloodsuckers.",
	icon = "vgui/icons/sosdead.png",
	tier = 2,
	listenTrigger = "bloodsuckerKilled",
	numberRec = 1,
	reward = {{"kit_reward_ammo_tier02"}},
	rewardCount = {1,1},
	repReward = 12,
	moneyReward = {1200, 1400},
	categories = {"mutantkillmedium"},
}, "killBloodsuckersLow")

ix.jobs.register({
	name = "Kill %d bloodsuckers.",
	desc = "%d bloodsuckers.",
	icon = "vgui/icons/sosdead.png",
	tier = 2,
	listenTrigger = "bloodsuckerKilled",
	numberRec = 2,
	reward = {{"kit_reward_ammo_tier02"}},
	rewardCount = {1,1},
	repReward = 18,
	moneyReward = {1300, 1690},
	categories = {"mutantkillmedium"},
}, "killBloodsuckersMid")

ix.jobs.register({
	name = "Kill %d bloodsuckers.",
	desc = "%d bloodsuckers.",
	icon = "vgui/icons/sosdead.png",
	tier = 2,
	listenTrigger = "bloodsuckerKilled",
	numberRec = 4,
	reward = {{"kit_reward_ammo_tier02"}},
	rewardCount = 1,
	repReward = 25,
	moneyReward = {1550, 1890},
	categories = {"mutantkillmedium"},
}, "killBloodsuckersHigh")

ix.jobs.register({
	name = "Kill %d boars.",
	desc = "%d boars.",
	icon = "vgui/icons/kabandead.png",
	tier = 1,
	listenTrigger = "boarKilled",
	numberRec = 1,
	reward = {{"kit_reward_ammo_tier01"}},
	rewardCount = {1,1},
	repReward = 3,
	moneyReward = {200, 300},
	categories = {"mutantkilleasy"},
}, "killBoarsLow")

ix.jobs.register({
	name = "Kill %d boars.",
	desc = "%d boars.",
	icon = "vgui/icons/kabandead.png",
	tier = 1,
	listenTrigger = "boarKilled",
	numberRec = 3,
	reward = {{"kit_reward_ammo_tier01"}},
	rewardCount = {1,1},
	repReward = 5,
	moneyReward = {350, 500},
	categories = {"mutantkilleasy"},
}, "killBoarsMid")

ix.jobs.register({
	name = "Kill %d boars.",
	desc = "%d boars.",
	icon = "vgui/icons/kabandead.png",
	tier = 1,
	listenTrigger = "boarKilled",
	numberRec = 6,
	reward = {{"kit_reward_ammo_tier01"}},
	rewardCount = {1,1},
	repReward = 9,
	moneyReward = {450, 700},
	categories = {"mutantkilleasy"},
}, "killBoarsHigh")

ix.jobs.register({
	name = "Kill %d burers.",
	desc = "%d burers.",
	icon = "entities/vj_mutant_burer.png",
	tier = 3,
	listenTrigger = "burerKilled",
	numberRec = 1,
	reward = {{"kit_reward_ammo_tier02"}},
	rewardCount = 1,
	repReward = 35,
	moneyReward = {2500, 5000},
	categories = {"mutantkillmedium"},
}, "killBurersLow")

ix.jobs.register({
	name = "Kill %d burers.",
	desc = "%d burers.",
	icon = "entities/vj_mutant_burer.png",
	tier = 3,
	listenTrigger = "burerKilled",
	numberRec = 3,
	reward = {{"kit_reward_ammo_tier02"}},
	rewardCount = 1,
	repReward = 75,
	moneyReward = {6000, 8500},
	categories = {"mutantkillmedium"},
}, "killBurersHigh")

ix.jobs.register({
	name = "Kill %d chimeras.",
	desc = "%d chimeras.",
	icon = "entities/vj_mutant_chimera.png",
	tier = 3,
	listenTrigger = "chimeraKilled",
	numberRec = 1,
	reward = {{"kit_reward_ammo_tier03"}},
	rewardCount = 1,
	repReward = 45,
	moneyReward = {5000, 8500},
	categories = {"mutantkillhard"},
}, "killChimerasLow")

ix.jobs.register({
	name = "Kill %d chimeras.",
	desc = "%d chimeras.",
	icon = "entities/vj_mutant_chimera.png",
	tier = 4,
	listenTrigger = "chimeraKilled",
	numberRec = 3,
	reward = {{"kit_reward_ammo_tier03"}},
	rewardCount = 1,
	repReward = 70,
	moneyReward = {12000, 16500},
	categories = {"mutantkillhard"},
}, "killChimerasHigh")

ix.jobs.register({
	name = "Kill %d electro-chimeras.",
	desc = "%d electro-chimeras.",
	icon = "entities/vj_mutant_chimera5.png",
	tier = 3,
	listenTrigger = "electrochimeraKilled",
	numberRec = 1,
	reward = {{"kit_reward_ammo_tier04"}},
	rewardCount = 1,
	repReward = 79,
	moneyReward = {8000, 11000},
	categories = {"mutantkillhard"},
}, "killChimerasLow")

ix.jobs.register({
	name = "Kill %d electro-chimeras.",
	desc = "%d electro-chimeras.",
	icon = "entities/vj_mutant_chimera5.png",
	tier = 4,
	listenTrigger = "electrochimeraKilled",
	numberRec = 2,
	reward = {{"kit_reward_ammo_tier04"}},
	rewardCount = 1,
	repReward = 120,
	moneyReward = {15500, 19600},
	categories = {"mutantkillhard"},
}, "killChimerasHigh")

ix.jobs.register({
	name = "Kill %d controllers.",
	desc = "%d controllers.",
	icon = "entities/vj_mutant_controler.png",
	tier = 2,
	listenTrigger = "controllerKilled",
	numberRec = 1,
	reward = {{"kit_reward_ammo_tier02"}},
	rewardCount = 1,
	repReward = 40,
	moneyReward = {10000, 14400},
	categories = {"mutantkillmedium"},
}, "killControllersLow")

ix.jobs.register({
	name = "Kill %d controllers.",
	desc = "%d controllers.",
	icon = "entities/vj_mutant_controler.png",
	tier = 3,
	listenTrigger = "controllerKilled",
	numberRec = {2,3},
	reward = {{"kit_reward_ammo_tier03"}},
	rewardCount = 1,
	moneyReward = {14000, 18500},
	repReward = 95,
	categories = {"mutantkillhard"},
}, "killControllersHigh")

ix.jobs.register({
	name = "Kill %d blind dogs.",
	desc = "%d blind dogs.",
	icon = "vgui/icons/dogdead.png",
	tier = 1,
	listenTrigger = "blinddogKilled",
	numberRec = 3,
	reward = {{"kit_reward_ammo_tier01"}},
	rewardCount = {1,1},
	repReward = 4,
	moneyReward = {300, 490},
	categories = {"mutantkilleasy"},
}, "killDogsLow")

ix.jobs.register({
	name = "Kill %d blind dogs.",
	desc = "%d blind dogs.",
	icon = "vgui/icons/dogdead.png",
	tier = 1,
	listenTrigger = "blinddogKilled",
	numberRec = 6,
	reward = {{"kit_reward_ammo_tier01"}},
	rewardCount = 1,
	repReward = 7,
	moneyReward = {500, 550},
	categories = {"mutantkilleasy"},
}, "killDogsMid")

ix.jobs.register({
	name = "Kill %d blind dogs.",
	desc = "%d blind dogs.",
	icon = "vgui/icons/dogdead.png",
	tier = 1,
	listenTrigger = "blinddogKilled",
	numberRec = 12,
	reward = {{"kit_reward_ammo_tier01"}},
	rewardCount = 1,
	repReward = 13,
	moneyReward = {800, 900},
	categories = {"mutantkilleasy"},
}, "killDogsHigh")

ix.jobs.register({
	name = "Kill %d fleshes.",
	desc = "%d fleshes.",
	icon = "vgui/icons/plotdead.png",
	tier = 1,
	listenTrigger = "fleshKilled",
	numberRec = 2,
	reward = {{"kit_reward_ammo_tier01"}},
	rewardCount = 1,
	repReward = 1,
	moneyReward = {120, 175},
	categories = {"mutantkilleasy"},
}, "killFleshesLow")

ix.jobs.register({
	name = "Kill %d fleshes.",
	desc = "%d fleshes.",
	icon = "vgui/icons/plotdead.png",
	tier = 1,
	listenTrigger = "fleshKilled",
	numberRec = 5,
	reward = {{"kit_reward_ammo_tier01"}},
	rewardCount = 1,
	repReward = 2,
	moneyReward = {210, 290},
	categories = {"mutantkilleasy"},
}, "killFleshesMid")

ix.jobs.register({
	name = "Kill %d fleshes.",
	desc = "%d fleshes.",
	icon = "vgui/icons/plotdead.png",
	tier = 1,
	listenTrigger = "fleshKilled",
	numberRec = 10,
	reward = {{"kit_reward_ammo_tier01"}},
	rewardCount = 1,
	repReward = 5,
	moneyReward = {300, 400},
	categories = {"mutantkilleasy"},
}, "killFleshesHigh")

ix.jobs.register({
	name = "Kill %d pseudodogs.",
	desc = "%d pseudodogs.",
	icon = "vgui/icons/psi-dogdead.png",
	tier = 1,
	listenTrigger = "pseudodogKilled",
	numberRec = 1,
	reward = {{"kit_reward_ammo_tier01"}},
	rewardCount = {1,1},
	repReward = 7,
	moneyReward = {450, 600},
	categories = {"mutantkilleasy"},
}, "killPseudodogsLow")

ix.jobs.register({
	name = "Kill %d pseudodogs.",
	desc = "%d pseudodogs.",
	icon = "vgui/icons/psi-dogdead.png",
	tier = 2,
	listenTrigger = "pseudodogKilled",
	numberRec = 2,
	reward = {{"kit_reward_ammo_tier01"}},
	rewardCount = {1,1},
	repReward = 12,
	moneyReward = {600, 900},
	categories = {"mutantkilleasy"},
}, "killPseudodogsMid")

ix.jobs.register({
	name = "Kill %d pseudodogs.",
	desc = "%d pseudodogs.",
	icon = "vgui/icons/psi-dogdead.png",
	tier = 2,
	listenTrigger = "pseudodogKilled",
	numberRec = 3,
	reward = {{"kit_reward_ammo_tier01"}},
	rewardCount = {1,1},
	repReward = 17,
	moneyReward = {750, 1000},
	categories = {"mutantkilleasy"},
}, "killPseudodogsHigh")

ix.jobs.register({
	name = "Kill %d snorks.",
	desc = "%d snorks.",
	icon = "vgui/icons/snorkdead.png",
	tier = 2,
	listenTrigger = "snorkKilled",
	numberRec = 1,
	reward = {{"kit_reward_ammo_tier02"}},
	rewardCount = {1,1},
	repReward = 10,
	moneyReward = {500, 750},
	categories = {"mutantkillmedium"},
}, "killSnorksLow")

ix.jobs.register({
	name = "Kill %d snorks.",
	desc = "%d snorks.",
	icon = "vgui/icons/snorkdead.png",
	tier = 2,
	listenTrigger = "snorkKilled",
	numberRec = 2,
	reward = {{"kit_reward_ammo_tier02"}},
	rewardCount = {1,1},
	repReward = 14,
	moneyReward = {750, 1000},
	categories = {"mutantkillmedium"},
}, "killSnorksMid")

ix.jobs.register({
	name = "Kill %d snorks.",
	desc = "%d snorks.",
	icon = "vgui/icons/snorkdead.png",
	tier = 2,
	listenTrigger = "snorkKilled",
	numberRec = 4,
	reward = {{"kit_reward_ammo_tier02"}},
	rewardCount = {1,1},
	repReward = 20,
	moneyReward = {1000, 1250},
	categories = {"mutantkillmedium"},
}, "killSnorksHigh")

ix.jobs.register({
	name = "Kill %d psydogs.",
	desc = "%d psydogs.",
	icon = "entities/vj_mutant_psydog.png",
	tier = 2,
	listenTrigger = "psydogKilled",
	numberRec = {1,1},
	reward = {{"kit_reward_ammo_tier02"}},
	rewardCount = {1,1},
	repReward = 15,
	moneyReward = {800, 1100},
	categories = {"mutantkillmedium"},
}, "killPsydogsLow")

ix.jobs.register({
	name = "Kill %d psydogs.",
	desc = "%d psydogs.",
	icon = "entities/vj_mutant_psydog.png",
	tier = 3,
	listenTrigger = "psydogKilled",
	numberRec = {2,3},
	reward = {{"kit_reward_ammo_tier02"}},
	rewardCount = {1,1},
	repReward = 20,
	moneyReward = {950, 1300},
	categories = {"mutantkillmedium"},
}, "killPsydogsLow")

ix.jobs.register({
	name = "Kill %d pseudogiants.",
	desc = "%d pseudogiants.",
	icon = "entities/vj_mutant_pseudogiant.png",
	tier = 3,
	listenTrigger = "pseudogiantKilled",
	numberRec = 1,
	reward = {{"kit_reward_ammo_tier04"}},
	rewardCount = 1,
	repReward = 75,
	moneyReward = {8000, 9500},
	categories = {"mutantkillhard"},
}, "killPseudogiantsLow")

ix.jobs.register({
	name = "Kill %d pseudogiants.",
	desc = "%d pseudogiants.",
	icon = "entities/vj_mutant_pseudogiant.png",
	tier = 4,
	listenTrigger = "pseudogiantKilled",
	numberRec = {2,3},
	reward = {{"kit_reward_ammo_tier04"}},
	rewardCount = 1,
	repReward = 150,
	moneyReward = {12000, 14000},
	categories = {"mutantkillhard"},
}, "killPseudogiantsHigh")

ix.jobs.register({
	name = "Kill %d izloms.",
	desc = "%d izloms.",
	icon = "entities/vj_mutant_izlom4.png",
	tier = 1,
	listenTrigger = "izlomKilled",
	numberRec = 2,
	reward = {{"kit_reward_ammo_tier02"}},
	rewardCount = {1,1},
	repReward = 25,
	moneyReward = {1500, 2000},
	categories = {"mutantkillmedium"},
}, "killIzlomsLow")

ix.jobs.register({
	name = "Kill %d spiders.",
	desc = "%d spiders.",
	icon = "propic/event/mutanthunt",
	tier = 1,
	listenTrigger = "spiderKilled",
	numberRec = 1,
	reward = {{"kit_reward_ammo_tier02"}},
	rewardCount = 1,
	repReward = 12,
	moneyReward = {800, 1200},
	categories = {"mutantkillmedium"},
}, "killSpidersLow")

ix.jobs.register({
	name = "Kill %d spiders.",
	desc = "%d spiders.",
	icon = "propic/event/mutanthunt",
	tier = 1,
	listenTrigger = "spiderKilled",
	numberRec = 2,
	reward = {{"kit_reward_ammo_tier02"}},
	rewardCount = 1,
	repReward = 18,
	moneyReward = {1300, 1500},
	categories = {"mutantkillmedium"},
}, "killSpidersMid")

ix.jobs.register({
	name = "Kill %d spiders.",
	desc = "%d spiders.",
	icon = "propic/event/mutanthunt",
	tier = 1,
	listenTrigger = "spiderKilled",
	numberRec = 4,
	reward = {{"kit_reward_ammo_tier02"}},
	rewardCount = 1,
	repReward = 30,
	moneyReward = {1900, 2500},
	categories = {"mutantkillmedium"},
}, "killSpidersHigh")

ix.jobs.register({
	name = "Kill %d tarks.",
	desc = "%d tarks.",
	icon = "entities/vj_mutant_tark.png",
	tier = 1,
	listenTrigger = "tarkKilled",
	numberRec = 1,
	reward = {{"kit_reward_ammo_tier01"}},
	rewardCount = 1,
	repReward = 15,
	moneyReward = {600, 800},
	categories = {"mutantkilleasy"},
}, "killTarksLow")

ix.jobs.register({
	name = "Kill %d tarks.",
	desc = "%d tarks.",
	icon = "entities/vj_mutant_tark.png",
	tier = 1,
	listenTrigger = "tarkKilled",
	numberRec = 2,
	reward = {{"kit_reward_ammo_tier01"}},
	rewardCount = 1,
	repReward = 20,
	moneyReward = {1500, 1700},
	categories = {"mutantkilleasy"},
}, "killTarksMid")

ix.jobs.register({
	name = "Kill %d tarks.",
	desc = "%d tarks.",
	icon = "entities/vj_mutant_tark.png",
	tier = 1,
	listenTrigger = "tarkKilled",
	numberRec = 3,
	reward = {{"kit_reward_ammo_tier01"}},
	rewardCount = 1,
	repReward = 25,
	moneyReward = {2400, 2700},
	categories = {"mutantkilleasy"},
}, "killTarksHigh")

ix.jobs.register({
	name = "Kill %d sprigs.",
	desc = "%d sprigs.",
	icon = "entities/vj_mutant_zanoza.png",
	tier = 1,
	listenTrigger = "sprigKilled",
	numberRec = 1,
	reward = {{"kit_reward_ammo_tier02"}},
	rewardCount = 1,
	repReward = 15,
	moneyReward = {1000, 1800},
	categories = {"mutantkillmedium"},
}, "killSprigsLow")

ix.jobs.register({
	name = "Kill %d sprigs.",
	desc = "%d sprigs.",
	icon = "entities/vj_mutant_zanoza.png",
	tier = 1,
	listenTrigger = "sprigKilled",
	numberRec = 2,
	reward = {{"kit_reward_ammo_tier02"}},
	rewardCount = 1,
	repReward = 25,
	moneyReward = {1600, 2500},
	categories = {"mutantkillmedium"},
}, "killSprigsHigh")

ix.jobs.register({
	name = "Kill %d vareshkas.",
	desc = "%d vareshkas.",
	icon = "entities/vj_mutant_borya.png",
	tier = 3,
	listenTrigger = "vareshkaKilled",
	numberRec = 1,
	reward = {{"kit_reward_ammo_tier02"}},
	rewardCount = 1,
	repReward = 25,
	moneyReward = {3000, 5500},
	categories = {"mutantkillmedium"},
}, "killVareshkasLow")

ix.jobs.register({
	name = "Kill %d vareshkas.",
	desc = "%d vareshkas.",
	icon = "entities/vj_mutant_borya.png",
	tier = 3,
	listenTrigger = "vareshkaKilled",
	numberRec = 2,
	reward = {{"kit_reward_ammo_tier02"}},
	rewardCount = 1,
	repReward = 35,
	moneyReward = {4500, 7600},
	categories = {"mutantkillmedium"},
}, "killVareshkasHigh")

ix.jobs.register({
	name = "Kill %d karliks.",
	desc = "%d karliks.",
	icon = "entities/vj_mutant_karlik2.png",
	tier = 3,
	listenTrigger = "karlikKilled",
	numberRec = 1,
	reward = {{"kit_reward_ammo_tier02"}},
	rewardCount = 1,
	repReward = 60,
	moneyReward = {4000, 8400},
	categories = {"mutantkillhard"},
}, "killKarliksLow")

ix.jobs.register({
	name = "Kill %d karliks.",
	desc = "%d karliks.",
	icon = "entities/vj_mutant_karlik2.png",
	tier = 3,
	listenTrigger = "karlikKilled",
	numberRec = 3,
	reward = {{"kit_reward_ammo_tier03"}},
	rewardCount = 1,
	repReward = 90,
	moneyReward = {9000, 15000},
	categories = {"mutantkillhard"},
}, "killKarliksHigh")

ix.jobs.register({
	name = "Kill %d skeletons.",
	desc = "%d skeletons.",
	icon = "entities/vj_mutant_zombi3.png",
	tier = 3,
	listenTrigger = "skeletonKilled",
	numberRec = 8,
	reward = {{"kit_reward_ammo_tier03"}},
	rewardCount = 1,
	repReward = 60,
	moneyReward = {11000, 22000},
	categories = {"mutantkillhard"},
}, "killSkeleton")
