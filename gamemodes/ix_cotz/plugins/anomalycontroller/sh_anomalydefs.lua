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
		"artifact_droplet",
		"artifact_bolt",
		"artifact_bonecluster"
	},
	rareArtifacts = {
		"artifact_crystal",
		"artifact_eye"
	},
	veryRareArtifacts = {
		"artifact_fireball",
	},
}

PLUGIN.anomalydefs[2] = {
	name = "Burner 2",
	entityname = "anom_par",
	interval = 128,
	commonArtifacts = {
		"artifact_droplet",
		"artifact_bolt",
		"artifact_bonecluster"
	},
	rareArtifacts = {
		"artifact_crystal",
		"artifact_eye"
	},
	veryRareArtifacts = {
		"artifact_fireball",
	},
}

PLUGIN.anomalydefs[3] = {
	name = "Electro",
	entityname = "anom_electra_anomaly",
	interval = 128,
	commonArtifacts = {
		"artifact_battery",
		"artifact_blowncap",
		"artifact_bolt",
		"artifact_bonecluster"
	},
	rareArtifacts = {
		"artifact_sparkler",
		"artifact_flash",
		"artifact_capacitor"
	},
	veryRareArtifacts = {
		"arifact_halo",
	},
}

PLUGIN.anomalydefs[4] = {
	name = "Electro 2",
	entityname = "anom_electra_anomaly_type2",
	interval = 128,
	commonArtifacts = {
		"artifact_battery",
		"artifact_blowncap",
		"artifact_bolt",
		"artifact_bonecluster"
	},
	rareArtifacts = {
		"arifact_sparkler",
		"arifact_flash",
	},
	veryRareArtifacts = {
		"artifact_moonlight",
	},
}

PLUGIN.anomalydefs[5] = {
	name = "Bubble",
	entityname = "anom_maysorubka_anomaly",
	interval = 128,	
	commonArtifacts = {
		"artifact_mementomori",
		"nightstar",
		"artifact_bolt",
		"artifact_bonecluster"
	},
	rareArtifacts = {
		"artifact_dwarfgalaxy",
		"artifact_panacea",
	},
	veryRareArtifacts = {
		"artifact_galaxy",
	},
}

PLUGIN.anomalydefs[6] = {
	name = "Bubble 2",
	entityname = "anom_maysorubka_anomaly_type2",
	interval = 128,	
	commonArtifacts = {
		"artifact_mementomori",
		"artifact_bolt",
		"artifact_bonecluster"
	},
	rareArtifacts = {
		"artifact_mamasbeads",
		"artifact_gaia",
	},
	veryRareArtifacts = {
		"artifact_gmamasbeads",
	},
}

PLUGIN.anomalydefs[7] = {
	name = "Whirlgig",
	entityname = "anom_voronka_anomaly",
	interval = 256,
	commonArtifacts = {
		"artifact_mementomori",
		"artifact_thorn",
		"artifact_bolt",
		"artifact_bonecluster"
	},
	rareArtifacts = {
		"artifact_urchin",
		"artifact_kolobok",
	},
	veryRareArtifacts = {
		"artifact_arachno",
	},
}

PLUGIN.anomalydefs[8] = {
	name = "Fruitpunch",
	entityname = "anom_gazirovka_anomaly",
	interval = 128,
	commonArtifacts = {
		"artifact_mycelia",
		"artifact_slime",
		"artifact_bolt",
		"artifact_bonecluster"
	},
	rareArtifacts = {
		"artifact_slug",
		"artifact_cell",
	},
	veryRareArtifacts = {
		"artifact_mica",
	},
}

PLUGIN.anomalydefs[9] = {
	name = "Fruitpunch 2",
	entityname = "anom_kisel_anomaly",
	interval = 128,
	commonArtifacts = {
		"artifact_cell",
		"artifact_mementomori",
		"artifact_bolt",
		"artifact_bonecluster"
	},
	rareArtifacts = {
		"artifact_slug",
		"artifact_cell",
	},
	veryRareArtifacts = {
		"artifact_mica",
	},
}

PLUGIN.anomalydefs[10] = {
	name = "Karusel (Dangerous!)",
	entityname = "anom_tramplin_anomaly",
	interval = 1024,
	commonArtifacts = {
		"artifact_cell",
		"artifact_mementomori",
		"artifact_sparkler",
		"artifact_bolt",
		"artifact_bonecluster"
	},
	rareArtifacts = {
		"artifact_slug",
		"artifact_flash",
		"artifact_slug",
	},
	veryRareArtifacts = {
		"artifact_mica",
		"artifact_arachno",
	},
}
