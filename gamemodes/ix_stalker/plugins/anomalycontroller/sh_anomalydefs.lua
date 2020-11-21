--[[

	Example of anomalydef definition

	PLUGIN.anomalydefs[index] = {
		name : name of definition
		entityname : name of entity to spawn
		interval : how many entities will be spawned at a point - (radius/interval) anomalies will be spawned
		commonArtifacts : table of item uniqueids that will be spawned the most commonly from the anomaly points
		rareArtifacts : table of item uniqueids that will be spawned more rarely from the anomaly points
		veryRareArtifacts : table of item uniqueids that will be spawned very rarely from the anomaly points
	}

]]--


PLUGIN.anomalydefs[1] = {
	name = "Burner",
	entityname = "anom_jarka",
	interval = 128,
	commonArtifacts = {
		"droplet",
		"jellyfish",
	},
	rareArtifacts = {
		"crystal",
	},
	veryRareArtifacts = {
		"fireball",
	},
}

PLUGIN.anomalydefs[2] = {
	name = "Burner 2",
	entityname = "anom_par",
	interval = 128,
	commonArtifacts = {
		"droplet",
		"jellyfish",
	},
	rareArtifacts = {
		"crystal",
	},
	veryRareArtifacts = {
		"fireball",
	},
}

PLUGIN.anomalydefs[3] = {
	name = "Electro",
	entityname = "anom_electra_anomaly",
	interval = 128,
	commonArtifacts = {
		"battery",
		"jellyfish",
	},
	rareArtifacts = {
		"sparkler",
		"flash",
	},
	veryRareArtifacts = {
		"snowflake",
	},
}

PLUGIN.anomalydefs[4] = {
	name = "Electro 2",
	entityname = "anom_electra_anomaly_type2",
	interval = 128,
	commonArtifacts = {
		"battery",
		"jellyfish",
	},
	rareArtifacts = {
		"sparkler",
		"flash",
	},
	veryRareArtifacts = {
		"snowflake",
	},
}

PLUGIN.anomalydefs[5] = {
	name = "Bubble",
	entityname = "anom_maysorubka_anomaly",
	interval = 128,	
	commonArtifacts = {
		"jellyfish",
		"nightstar",
	},
	rareArtifacts = {
		"stoneflower",
		"shell",
	},
	veryRareArtifacts = {
		"meatchunk",
	},
}

PLUGIN.anomalydefs[6] = {
	name = "Bubble 2",
	entityname = "anom_maysorubka_anomaly_type2",
	interval = 128,	
	commonArtifacts = {
		"jellyfish",
		"nightstar",
	},
	rareArtifacts = {
		"stoneflower",
		"shell",
	},
	veryRareArtifacts = {
		"meatchunk",
	},
}

PLUGIN.anomalydefs[7] = {
	name = "Whirlgig",
	entityname = "anom_voronka_anomaly",
	interval = 256,
	commonArtifacts = {
		"wrenched",
		"jellyfish",
		"stoneblood",
	},
	rareArtifacts = {
		"meatchunk",
		"shell",
	},
	veryRareArtifacts = {
		"soul",
	},
}

PLUGIN.anomalydefs[8] = {
	name = "Fruitpunch",
	entityname = "anom_gazirovka_anomaly",
	interval = 128,
	commonArtifacts = {
		"slime",
		"stoneblood",
	},
	rareArtifacts = {
		"meatchunk",
		"slug",
	},
	veryRareArtifacts = {
		"urchin",
	},
}

PLUGIN.anomalydefs[9] = {
	name = "Fruitpunch 2",
	entityname = "anom_kisel_anomaly",
	interval = 128,
	commonArtifacts = {
		"slime",
		"stoneblood",
	},
	rareArtifacts = {
		"meatchunk",
		"slug",
	},
	veryRareArtifacts = {
		"urchin",
	},
}

PLUGIN.anomalydefs[10] = {
	name = "Karusel (Dangerous!)",
	entityname = "anom_tramplin_anomaly",
	interval = 1024,
	commonArtifacts = {
		"wrenched",
		"stoneblood",
		"meatchunk",
		"sparkler",
	},
	rareArtifacts = {
		"soul",
		"gravi",
		"shell",
	},
	veryRareArtifacts = {
		"goldfish",
	},
}
