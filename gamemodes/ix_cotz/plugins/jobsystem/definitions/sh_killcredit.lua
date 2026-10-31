ix.jobs.killCredit = {
	{
		patterns = {"npc_human"},
		triggers = {"groupHumanoidKilled"},
	},
	{
		patterns = {"npc_human_bandit"},
		triggers = {"banditKilled"},
	},
	{
		patterns = {"npc_human_merc"},
		triggers = {"mercKilled"},
	},
	{
		patterns = {"npc_human_mili"},
		triggers = {"miliKilled"},
	},
	{
		patterns = {"npc_mutant"},
		triggers = {"mutantKilled"},
	},
	{
		classes = {
			"npc_mutant_classiczombie",
			"npc_mutant_classiczombie_babka",
			"npc_mutant_classiczombie_radio",
			"npc_mutant_classiczombie_volatile",
		},
		patterns = {"npc_human_z_"},
		triggers = {"zombieKilled", "groupHumanoidKilled"},
	},
	{
		classes = {"npc_mutant_rodent"},
		triggers = {"rodentKilled"},
	},
	{
		classes = {"npc_mutant_karlik"},
		triggers = {"karlikKilled", "groupPsyKilled"},
	},
	{
		classes = {"npc_mutant_snork"},
		triggers = {"snorkKilled", "groupHumanoidKilled"},
	},
	{
		classes = {"npc_mutant_cat"},
		triggers = {"catKilled", "groupPredatorKilled"},
	},
	{
		classes = {"npc_mutant_bloodsucker"},
		triggers = {"bloodsuckerKilled", "groupPredatorKilled", "groupHumanoidKilled"},
	},
	{
		classes = {"npc_mutant_boar"},
		triggers = {"boarKilled", "groupMeatKilled"},
	},
	{
		classes = {"npc_mutant_burer"},
		triggers = {"burerKilled", "groupHumanoidKilled", "groupPsyKilled"},
	},
	{
		classes = {"npc_mutant_chimera"},
		triggers = {"chimeraKilled"},
	},
	{
		classes = {"npc_mutant_chimera_electro"},
		triggers = {"electrochimeraKilled"},
	},
	{
		classes = {
			"npc_mutant_controller",
			"npc_mutant_controller_swamp",
			"npc_mutant_controller_electro",
			"npc_mutant_controller_fast",
		},
		triggers = {"controllerKilled", "groupHumanoidKilled", "groupPsyKilled"},
	},
	{
		classes = {"npc_mutant_dog"},
		triggers = {"blinddogKilled", "groupCanineKilled"},
	},
	{
		classes = {"npc_mutant_hellhound"},
		triggers = {"hellhoundKilled", "groupCanineKilled"},
	},
	{
		classes = {"npc_mutant_flesh"},
		triggers = {"fleshKilled", "groupMeatKilled"},
	},
	{
		classes = {"npc_mutant_pseudodog"},
		triggers = {"pseudodogKilled", "groupCanineKilled"},
	},
	{
		classes = {"npc_mutant_psydog"},
		triggers = {"psydogKilled", "groupCanineKilled", "groupPsyKilled"},
	},
	{
		classes = {"npc_mutant_pseudogiant_fast", "npc_mutant_pseudogiant_slow"},
		triggers = {"pseudogiantKilled"},
	},
	{
		classes = {"npc_mutant_izlom"},
		triggers = {"izlomKilled", "groupHumanoidKilled"},
	},
	{
		classes = {"npc_mutant_spider"},
		triggers = {"spiderKilled", "groupPredatorKilled"},
	},
	{
		classes = {"npc_mutant_sprig"},
		triggers = {"sprigKilled", "groupPredatorKilled"},
	},
	{
		classes = {"npc_mutant_tark"},
		triggers = {"tarkKilled", "groupMeatKilled"},
	},
	{
		classes = {"npc_mutant_bear"},
		triggers = {"bearKilled", "groupPredatorKilled"},
	},
	{
		classes = {"npc_mutant_vareshka"},
		triggers = {"vareshkaKilled"},
	},
	{
		classes = {"npc_mutant_skeleton"},
		triggers = {"skeletonKilled"},
	},
}
