--[[

	Example of anomalydef definition

	PLUGIN.anomalydefs[index] = {
		name : name of definition
		entityname : name of entity to spawn
		category : selector group for /anomalyadd (fire, electro, gravity, acid); definitions without one
			cannot be selected by name or category
		interval : how many entities will be spawned at a point - (radius/interval) anomalies will be spawned
		triggerRadius : horizontal reach of the anomaly's trigger or pull; anomalies are placed so these never overlap
		commonArtifacts : table of item uniqueids that will be spawned the most commonly from the anomaly points
		rareArtifacts : table of item uniqueids that will be spawned more rarely from the anomaly points
		veryRareArtifacts : table of item uniqueids that will be spawned very rarely from the anomaly points
	}

]]--


PLUGIN.anomalydefs[1] = {
	name = "Burner1",
	entityname = "anom_jarka",
	category = "fire",
	interval = 128,
	triggerRadius = 43,
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
		"artifact_flame",
	},
}

PLUGIN.anomalydefs[2] = {
	name = "Burner2",
	entityname = "anom_par",
	category = "fire",
	interval = 128,
	triggerRadius = 43,
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
		"artifact_flame",
	},
}

PLUGIN.anomalydefs[3] = {
	name = "Electro1",
	entityname = "anom_electra_anomaly",
	category = "electro",
	interval = 256,
	triggerRadius = 85,
	commonArtifacts = {
		"artifact_battery",
		"artifact_blowncap",
		"artifact_bolt",
		"artifact_bonecluster",
		"artifact_sparkler",
	},
	rareArtifacts = {
		"artifact_flash",
		"artifact_capacitor"
	},
	veryRareArtifacts = {
		"artifact_halo",
	},
}

PLUGIN.anomalydefs[4] = {
	name = "Electro2",
	entityname = "anom_electra_anomaly_type2",
	category = "electro",
	interval = 256,
	triggerRadius = 99,
	commonArtifacts = {
		"artifact_battery",
		"artifact_blowncap",
		"artifact_bolt",
		"artifact_bonecluster",
		"artifact_sparkler",
	},
	rareArtifacts = {
		"artifact_moonlight",
		"artifact_flash",
	},
	veryRareArtifacts = {
		"artifact_storm",
	},
}

PLUGIN.anomalydefs[5] = {
	name = "Bubble1",
	entityname = "anom_maysorubka_anomaly",
	category = "gravity",
	interval = 128,
	triggerRadius = 170,
	commonArtifacts = {
		"artifact_mementomori",
		-- "nightstar",
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
	name = "Bubble2",
	entityname = "anom_maysorubka_anomaly_type2",
	category = "gravity",
	interval = 128,
	triggerRadius = 114,
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
	category = "gravity",
	interval = 256,
	triggerRadius = 170,
	commonArtifacts = {
		"artifact_mementomori",
		"artifact_thorn",
		"artifact_bolt",
		"artifact_grapes"
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
	name = "Fruitpunch1",
	entityname = "anom_gazirovka_anomaly",
	category = "acid",
	interval = 128,
	triggerRadius = 128,
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
		"artifact_seraphim",
		"artifact_mica",
	},
}

PLUGIN.anomalydefs[9] = {
	name = "Fruitpunch2",
	entityname = "anom_kisel_anomaly",
	category = "acid",
	interval = 128,
	triggerRadius = 71,
	commonArtifacts = {
		"artifact_cell",
		"artifact_mementomori",
		"artifact_bolt",
		"artifact_bonecluster"
	},
	rareArtifacts = {
		"artifact_slug",
		"artifact_seraphim",
	},
	veryRareArtifacts = {
		"artifact_mica",
	},
}

PLUGIN.anomalydefs[10] = {
	name = "Karusel",
	entityname = "anom_tramplin_anomaly",
	category = "gravity",
	interval = 1024,
	triggerRadius = 300,
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

-- Added with the particle overhaul. They have no category yet, so /anomalyadd cannot select them; only an
-- old-style index mask longer than ten digits reaches them. See the plugin README.
PLUGIN.anomalydefs[11] = {
	name = "Springboard",
	entityname = "anom_springboard",
	interval = 160,
	triggerRadius = 114,
	commonArtifacts = {
		"artifact_mementomori",
		"artifact_bolt",
		"artifact_bonecluster"
	},
	rareArtifacts = {
		"artifact_dwarfgalaxy",
		"artifact_kolobok",
	},
	veryRareArtifacts = {
		"artifact_galaxy",
	},
}

PLUGIN.anomalydefs[12] = {
	name = "Tesla",
	entityname = "anom_tesla",
	interval = 1024,
	commonArtifacts = {
		"artifact_battery",
		"artifact_blowncap",
		"artifact_sparkler",
	},
	rareArtifacts = {
		"artifact_flash",
		"artifact_capacitor",
		"artifact_moonlight",
	},
	veryRareArtifacts = {
		"artifact_storm",
		"artifact_halo",
	},
}

PLUGIN.anomalydefs[13] = {
	name = "PsyPocket",
	entityname = "anom_psyfield",
	interval = 1024,
	commonArtifacts = {
		"artifact_mementomori",
		"artifact_bolt",
		"artifact_bonecluster"
	},
	rareArtifacts = {
		"artifact_eye",
	},
	veryRareArtifacts = {
		"artifact_moon",
	},
}

PLUGIN.anomalydefs[14] = {
	name = "FireZone",
	entityname = "anom_zone_fire",
	interval = 256,
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
		"artifact_flame",
	},
}

PLUGIN.anomalydefs[15] = {
	name = "AcidZone",
	entityname = "anom_zone_acid",
	interval = 256,
	commonArtifacts = {
		"artifact_mycelia",
		"artifact_slime",
		"artifact_bolt",
	},
	rareArtifacts = {
		"artifact_slug",
		"artifact_cell",
	},
	veryRareArtifacts = {
		"artifact_seraphim",
	},
}

PLUGIN.anomalydefs[16] = {
	name = "ElectroZone",
	entityname = "anom_zone_electro",
	interval = 256,
	commonArtifacts = {
		"artifact_battery",
		"artifact_bolt",
		"artifact_sparkler",
	},
	rareArtifacts = {
		"artifact_flash",
		"artifact_capacitor",
	},
	veryRareArtifacts = {
		"artifact_halo",
	},
}

PLUGIN.anomalydefs[17] = {
	name = "Comet",
	entityname = "anom_comet",
	interval = 1024,
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
		"artifact_flame",
	},
}

PLUGIN.anomalydefs[18] = {
	name = "BallLightning",
	entityname = "anom_comet_electra",
	interval = 1024,
	commonArtifacts = {
		"artifact_battery",
		"artifact_blowncap",
		"artifact_sparkler",
	},
	rareArtifacts = {
		"artifact_moonlight",
		"artifact_flash",
	},
	veryRareArtifacts = {
		"artifact_storm",
	},
}
