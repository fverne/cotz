ix.taskRewards.settings = {
	profiles = {
		["'Old Timer'"] = {
			"12gauge", "22lr", "9x18", "medic_bandage_1", "medic_bandage_2", "sharpening_stone",
			"sharpening_stone_fine", "drink_bottlewater", "food_can_tushonka", "medic_medkit_1",
		},
		["'Technut'"] = {
			"22lr", "45acp41", "attachment_fabric_1", "attachment_ceramicplate_1", "9x18", "45acp", "medic_bandage_2",
		},
		["'Jitters'"] = {
			"medic_bandage_1", "medic_medkit_1", "medic_bandage_2", "medic_medkit_3", "medic_medkit_2",
			"medic_antirad_1", "drug_painkillers",
		},
		["'Cleaner'"] = {"12gauge", "22lr", "9x19", "medic_bandage_1", "drink_bottlewater", "lowtiercookerfuel"},
		["'Haggler'"] = {
			"12gauge", "9x18", "762x25", "762x39", "762x54", "45acp41", "45acp", "9x19", "food_can_beans",
		},
		["'Spicy Lemon'"] = {
			"drink_bottlewater", "drink_bottletea", "food_can_sprats", "lowtiercookerfuel", "food_bread",
			"food_can_beans", "food_can_corn", "food_raisins", "drug_caffeine",
		},
		["'Mute'"] = {
			"headlamp", "geigercounter", "binoculars_5", "compass", "drink_bottlewater", "medic_bandage_1",
			"drug_caffeine",
		},
		["'Quartermaster'"] = {
			"545x39", "556x45", "762x39", "762x51", "9x19", "medic_bandage_1", "medic_medkit_1", "drug_painkillers",
		},
		["'Boss'"] = {
			"545x39", "556x45", "762x51", "12gaugetr", "medic_bandage_1", "medic_medkit_1", "drug_painkillers",
		},
		["'Smartass'"] = {"9x19", "pso1", "cmore", "acog", "shortdot", "45acp", "medic_medkit_1", "drug_caffeine"},
		["'Egghead'"] = {
			"medic_stimpak_1", "medic_psyheal_2", "medic_antirad_2", "medic_antipsychotic_1", "drug_caffeine",
			"medic_medkit_1",
		},
		["'Beanstalk'"] = {
			"9x19", "medic_antirad_1", "medic_psyheal_1", "medic_antipsychotic_1", "drug_caffeine", "medic_medkit_1",
		},
		["'Intern'"] = {
			"medic_antirad_1", "medic_psyheal_1", "medic_medkit_5", "medic_antipsychotic_1", "drug_caffeine",
			"medic_medkit_1",
		},
		["'Computer'"] = {
			"medic_antirad_1", "medic_psyheal_2", "medic_antipsychotic_1", "drug_caffeine", "medic_medkit_1",
		},
		["'The Original'"] = {
			"food_can_tushonka", "drink_bottlewater", "lowtiercookerfuel", "medic_bandage_1", "food_bread",
			"food_can_beans", "drink_bottletea",
		},
		["'Hoarder'"] = {
			"500magnum", "127x55", "700nitro", "338lapua", "57x28", "45acp", "drug_painkillers", "drink_bottlewater",
		},
		["'Arena Master'"] = {
			"medic_bandage_1", "medic_medkit_1", "medic_bandage_2", "drug_painkillers", "drug_caffeine",
		},
		["'???'"] = {
			"medic_psyheal_2", "medic_antirad_2", "medic_antipsychotic_1", "drug_caffeine", "medic_medkit_1",
		},
		["NPC"] = {"drink_bottlewater", "drink_bottletea", "medic_bandage_1"},
	},

	supplyCatalogueVersion = 5,
	ammoRewardFraction = 0.5,
	maxPackageItems = 64,
	maxOffers = 512,
	maxPendingRewards = 1024,
	choiceCount = 3,
	difficultyReputation = {medium = 250, hard = 1600},
	jobSupplyShare = 1,
	jobMaxSupplyItems = 2,
	jobMinSupplyBudget = 600,
	bonusInterval = 5,
	creditPremium = 1.3,
	jobSupplyCashShare = 0.5,
	jobCashRate = 0.50,
	jobHandInBaseMoney = {500, 750, 1000},
	jobHandInSupplyMoney = {500, 1000, 1500},
	-- Preserve supply budgets and non-delivery cash independently of turn-in payouts.
	jobReferenceCashRate = 0.55,
	cashRoundingEpsilon = 0.000000001,
	maxDepth = 12,
	generatedQuantities = {
		value_capacitors = 2.5,
		value_9vbattery = 2.5,
		value_sparkplug = 1.5,
		value_pcpart_ram = 1.5,
		value_screws = 1.5,
		value_pcpart_cpu = 1.5,
		value_nuts = 5.5,
		value_battery = 3.5,
		value_bolts = 6,
		value_gasoline = 2.5,
		value_propanetank = 2.5,
		value_currency_euro = 1,
		value_currency_dollar = 1,
		value_currency_rubles_coins = 1,
	},
}
