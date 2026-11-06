/*
	PLUGIN.eventdefs["Zombie1"] = {
		entities = {
			{"npc_mutant_classiczombie", 6}, -- {ent_name, amount}
			{"npc_mutant_dog", 2},
		},
		items = {
			{"mp5", {["durability"] = 15}}, -- {nut_item uniqueID, data}
			{"mp5", {["durability"] = 60}},
		},
		props = {
			{"models/props_c17/oildrum001.mdl", 5}, -- {propmodel, amount}
			{"models/props_c17/oildrum002.mdl", 5},
		},
		ragdolls = {
			{"models/kleiner.mdl", 2, 1, "000000000"}, -- {ragdollmodel, amount, skingroup, bodygroups}
			{"models/kleiner.mdl", 3, 2, "000000000"},
		},
		loot = {
			{"kit_event", 1}, 
		},
		pdabroadcast = "Zombies have been spotted at %s, proceed with caution.",
		difficulty = {"swamps_outside_easy", "swamps_outside_hard"},
		lootChance = 10, --percentage
	}
*/
--entities: spawns <amount> entities of the type listed
--items: spawns the listed items with the given data
--props: spawns <amount> props with the model listed
--ragdolls: spawns <amount> ragdolls and sets skin and bodygroup
--loot: like items, except each item has a chance to spawn


-- Location tags match the third field of event points (see README.md).

--[[-------------------------------------------------------------------------
dogs
---------------------------------------------------------------------------]]
PLUGIN.eventdefs["Dog1"] = {
	entities = {
		{"npc_mutant_dog", 2},
	},
	pdabroadcast = "A small pack of dogs have been spotted %s.",
	difficulty = {"swamps_outside_easy", "swamps_outside_hard", "garbage_outside_easy"},
	lootChance = 10,
}

PLUGIN.eventdefs["Dog2"] = {
	entities = {
		{"npc_mutant_dog", 3},
	},
	pdabroadcast = "A small pack of dogs have been spotted %s.",
	difficulty = {"swamps_outside_hard", "garbage_outside_easy"},
	lootChance = 10,
}

PLUGIN.eventdefs["Dog3"] = {
	entities = {
		{"npc_mutant_dog", 3},
		{"npc_mutant_pseudodog", 1},
	},
	pdabroadcast = "A small pack of dogs have been spotted %s.",
	difficulty = {"waystation_outside_easy", "waystation_outside_hard"},
	lootChance = 15,
}

PLUGIN.eventdefs["Dog4"] = {
	entities = {
		{"npc_mutant_dog", 4},
	},
	pdabroadcast = "A pack of dogs have been seen wandering %s aimlessly, be alert, stalker.",
	difficulty = {"swamps_outside_hard", "garbage_outside_easy"},
	lootChance = 15,
}

PLUGIN.eventdefs["Dog5"] = {
	entities = {
		{"npc_mutant_dog", 4},
		{"npc_mutant_pseudodog", 1},
	},
	pdabroadcast = "A pack of dogs have been seen wandering %s aimlessly, be alert, stalker.",
	difficulty = {"waystation_outside_easy", "waystation_outside_hard"},
	lootChance = 20,
}


--[[-------------------------------------------------------------------------
bloodsuckers
---------------------------------------------------------------------------]]

PLUGIN.eventdefs["bloodsucker1"] = {
	entities = {
		{"npc_mutant_bloodsucker", 1}, 
	},
	pdabroadcast = "There's been sightings of a bloodsucker %s, any stalkers brave enough to take them out?",
	difficulty = {"waystation_outside_easy", "waystation_building", "waystation_underground"},
	lootChance = 10,
}

PLUGIN.eventdefs["bloodsucker2"] = {
	entities = {
		{"npc_mutant_bloodsucker", 2}, 
	},
	pdabroadcast = "There's been sightings of a couple bloodsuckers %s, any stalkers brave enough to take them out?",
	difficulty = {"waystation_outside_easy", "waystation_outside_hard", "waystation_building", "waystation_underground"},
	lootChance = 10, 
}

PLUGIN.eventdefs["bloodsucker3"] = {
	entities = {
		{"npc_mutant_bloodsucker", 3}, 
	},
	props = {
		{"models/Gibs/HGIBS.mdl", 1}, 
		{"models/Gibs/HGIBS_spine.mdl", 1},
	},
	
	pdabroadcast = "A group of stalkers %s has been massacred by a small pack of bloodsuckers, be careful, stalkers.",
	difficulty = {"waystation_building", "waystation_underground", "pripyat_outside_easy"},
	lootChance = 15, 
}

PLUGIN.eventdefs["bloodsucker4"] = {
	entities = {
		{"npc_mutant_bloodsucker", 4}, 
	},
	props = {
		{"models/Gibs/HGIBS.mdl", 1}, 
		{"models/Gibs/HGIBS_spine.mdl", 2},
	},
	
	pdabroadcast = "A pack of bloodsuckers has been sighted %s, proceed with caution, stalker.",
	difficulty = {"pripyat_outside_hard", "pripyat_building", "pripyat_underground"},
	lootChance = 20, 
}

--[[-------------------------------------------------------------------------
rodents
---------------------------------------------------------------------------]]
PLUGIN.eventdefs["rodent1"] = {
	entities = {
		{"npc_mutant_rodent", 4},
	},
	pdabroadcast = "There is a bit of a mice problem %s, exterminate them stalker.",
	difficulty = {"swamps_outside_easy", "swamps_outside_hard", "swamps_building"},
	lootChance = 10,
}


PLUGIN.eventdefs["rodent2"] = {
	entities = {
		{"npc_mutant_rodent", 5},
	},
	pdabroadcast = "Rodents are being a menace %s, deal with them with caution, stalker.",
	difficulty = {
		"swamps_outside_easy",
		"swamps_outside_hard",
		"swamps_building",
		"garbage_outside_easy",
		"garbage_building",
		"garbage_underground",
	},
	lootChance = 15,
}

-- PLUGIN.eventdefs["rodent3"] = {
-- 	entities = {
-- 		{"npc_mutant_rodent", 8},
-- 	},
-- 	pdabroadcast = "Rodents are overrunning %s, proceed with caution, stalker.",
-- 	difficulty = {"swamps_outside_easy", "swamps_outside_hard", "swamps_building"},
-- 	lootChance = 20,
-- }

-- PLUGIN.eventdefs["rodent4"] = {
-- 	entities = {
-- 		{"npc_mutant_rodent", 9},
-- 	},
-- 	pdabroadcast = "It seems %s is completely infested with swarms of rodents! Stay away, stalker!",
-- 	difficulty = {"swamps_outside_easy", "swamps_outside_hard", "swamps_building"},
-- 	lootChance = 25,
-- }

--[[-------------------------------------------------------------------------
pseudogiants
---------------------------------------------------------------------------]]

PLUGIN.eventdefs["pseudogiant1"] = {
	entities = {
		{"npc_mutant_pseudogiant_slow", 1}, 
	},

	pdabroadcast = "A pseudogiant has been spotted %s! Stay away from there, stalker.",
	difficulty = {"waystation_outside_hard"},
	lootChance = 20, 
}

PLUGIN.eventdefs["pseudogiant2"] = {
	entities = {
		{"npc_mutant_pseudogiant_slow", 1},
		{"npc_mutant_rodent", 3}, 
	},
	
	pdabroadcast = "A pseudogiant has been spotted %s! Stay away from there, stalker.",
	difficulty = {"pripyat_outside_easy", "pripyat_outside_hard"},
	lootChance = 20, 
}

PLUGIN.eventdefs["pseudogiant3"] = {
	entities = {
		{"npc_mutant_pseudogiant_slow", 2} 
	},
	props = {
		{"models/Gibs/HGIBS.mdl", 3}, 
		{"models/Gibs/HGIBS_spine.mdl", 3},
	},
	
	pdabroadcast = "Pseudogiants have been spotted %s! Evacuate the area for your safety, stalker.",
	difficulty = {"pripyat_outside_hard"},
	lootChance = 30, 
}

PLUGIN.eventdefs["pseudogiant4"] = {
	entities = {
		{"npc_mutant_pseudogiant_fast", 1} 
	},
	pdabroadcast = "A hulking mass has been spotted leaping through the air %s! Get out of there if you value your lives.",
	difficulty = {"pripyat_outside_hard"},
	lootChance = 30, 
}

--[[-------------------------------------------------------------------------
boars
---------------------------------------------------------------------------]]
PLUGIN.eventdefs["boar0"] = {
	entities = {
		{"npc_mutant_boar", 1},
	},
	pdabroadcast = "A boar is spotted %s, any stalkers up for boar stew should deal with it.",
	difficulty = {"swamps_outside_easy"},
	lootChance = 10,
}

PLUGIN.eventdefs["boar1"] = {
	entities = {
		{"npc_mutant_boar", 2},
	},
	pdabroadcast = "A pair of boars are spotted %s, any stalkers up for boar stew should deal with them.",
	difficulty = {"swamps_outside_easy", "swamps_outside_hard"},
	lootChance = 10,
}

PLUGIN.eventdefs["boar2"] = {
	entities = {
		{"npc_mutant_boar", 3},
	},
	pdabroadcast = "Wild boars have been disrupting stalker activity %s, try to wipe them out, stalker.",
	difficulty = {"waystation_outside_easy", "waystation_outside_hard"},
	lootChance = 15,
}

PLUGIN.eventdefs["boar3"] = {
	entities = {
		{"npc_mutant_boar", 4},
	},
	pdabroadcast = "A pack of boars are running rampant %s, proceed with caution, stalker.",
	difficulty = {"waystation_outside_easy", "waystation_outside_hard"},
	lootChance = 20,
}

--[[-------------------------------------------------------------------------
chimeras
---------------------------------------------------------------------------]]

PLUGIN.eventdefs["chimera1"] = {
	entities = {
		{"npc_mutant_chimera", 1}, 
	},
	props = {
		{"models/Gibs/HGIBS.mdl", 1}, 
		{"models/Gibs/HGIBS_spine.mdl", 1},
	},
	pdabroadcast = "Stalkers has reported a Chimera %s! Avoid them, stalkers.",
	difficulty = {"waystation_outside_hard", "pripyat_outside_easy", "pripyat_outside_hard"},
	lootChance = 20, 
}

PLUGIN.eventdefs["chimera2"] = {
	entities = {
		{"npc_mutant_chimera", 1},
		{"npc_mutant_dog", 3}, 
	},
	props = {
		{"models/Gibs/HGIBS.mdl", 1}, 
		{"models/Gibs/HGIBS_spine.mdl", 2},
	},
	
	pdabroadcast = "Stalkers has reported a Chimera %s! Avoid them, stalkers.",
	difficulty = {"pripyat_outside_easy", "pripyat_outside_hard"},
	lootChance = 20, 
}

PLUGIN.eventdefs["chimera3"] = {
	entities = {
		{"npc_mutant_chimera", 2},
	},
	props = {
		{"models/Gibs/HGIBS.mdl", 1}, 
		{"models/Gibs/HGIBS_spine.mdl", 2},
	},
	
	pdabroadcast = "Stalkers has reported multiple Chimeras %s! Avoid them, stalkers.",
	difficulty = {"pripyat_outside_easy", "pripyat_outside_hard"},
	lootChance = 20, 
}

PLUGIN.eventdefs["electrochimera1"] = {
	entities = {
		{"npc_mutant_chimera_electro", 1},
	},
	pdabroadcast = "We have sightings of an electrically charged Chimera %s! Make sure you're properly prepared if you're taking it on, stalkers.",
	difficulty = {"pripyat_outside_hard"},
	lootChance = 20, 
}

--[[-------------------------------------------------------------------------
cats
---------------------------------------------------------------------------]]

PLUGIN.eventdefs["cat1"] = {
	entities = {
		{"npc_mutant_cat", 1} 
	},
	
	pdabroadcast = "A cat has been spotted %s just now. Be careful, stalker.",
	difficulty = {"swamps_outside_hard", "garbage_outside_easy"},
	lootChance = 10, 
}

PLUGIN.eventdefs["cat2"] = {
	entities = {
		{"npc_mutant_cat", 1} 
	},
	ragdolls = {
		{"models/crow.mdl", 2, 0, "000000000"},
	},
	
	pdabroadcast = "A cat has been spotted %s just now, chasing some birds. Take care, stalker.",
	difficulty = {"swamps_outside_hard", "garbage_outside_easy"},
	lootChance = 10, 
}

PLUGIN.eventdefs["cat3"] = {
	entities = {
		{"npc_mutant_cat", 2} 
	},
	ragdolls = {
		{"models/crow.mdl", 2, 0, "000000000"},
	},
	
	pdabroadcast = "A pair of cats have been spotted %s just now, playing around. Don't mistake them for pettable, stalker.",
	difficulty = {"waystation_outside_easy", "waystation_outside_hard", "pripyat_outside_easy", "pripyat_outside_hard"},
	lootChance = 15, 
}

--[[-------------------------------------------------------------------------
hoverstones
---------------------------------------------------------------------------]]
/*
PLUGIN.eventdefs["hoverstones1"] = {
	entities = {
		{"anom_hoverstone", 2}, 
	},
	loot = {
		{"artifact_droplet", 1},
	},
	pdabroadcast = "Hoverstones has been spotted %s, don't bump your head walking into one.",
	difficulty = {0, 1},
	lootChance = 2, 
}

PLUGIN.eventdefs["hoverstones2"] = {
	entities = {
		{"anom_hoverstone", 2},
		{"npc_mutant_classiczombie", 2}, 
	},
	loot = {
		{"artifact_droplet", 1},
	},
	pdabroadcast = "Hoverstones has been spotted %s, don't bump your head walking into one.",
	difficulty = {0, 1},
	lootChance = 5, 
}


PLUGIN.eventdefs["hoverstones3"] = {
	entities = {
		{"anom_hoverstone", 2},
		{"npc_mutant_dog", 2}, 
	},
	loot = {
		{"artifact_droplet", 1},
	},
	pdabroadcast = "Hoverstones has been spotted %s, don't bump your head walking into one.",
	difficulty = {0, 1},
	lootChance = 5, 
}
*/
--[[-------------------------------------------------------------------------
Izloms
---------------------------------------------------------------------------]]
PLUGIN.eventdefs["izlom1"] = {
	entities = {
		{"npc_mutant_izlom", 1}, 
	},
	pdabroadcast = "One of those long-limbed Izloms has been seen %s.",
	difficulty = {"swamps_outside_hard", "garbage_outside_easy"},
	lootChance = 10, 
}

PLUGIN.eventdefs["izlom2"] = {
	entities = {
		{"npc_mutant_izlom", 2}, 
	},
	pdabroadcast = "A pair of Izloms have just been seen %s.",
	difficulty = {"waystation_outside_easy", "waystation_outside_hard", "pripyat_outside_easy", "pripyat_outside_hard"},
	lootChance = 15, 
}

PLUGIN.eventdefs["izlom3"] = {
	entities = {
		{"npc_mutant_izlom", 2}, 
	},
	ragdolls = {
		{"models/crow.mdl", 1, 0, "000000000"},
	},
	pdabroadcast = "Just saw a pair of those hunchbacked izloms eat a crow %s.",
	difficulty = {"waystation_outside_easy", "waystation_outside_hard", "pripyat_outside_easy", "pripyat_outside_hard"},
	lootChance = 15, 
}

--[[-------------------------------------------------------------------------
Psydogs
---------------------------------------------------------------------------]]
PLUGIN.eventdefs["psydog1"] = {
	entities = {
		{"npc_mutant_psydog", 1}, 
	},
	pdabroadcast = "A psydog has been reported deceiving stalkers %s, don't get too close, stalker.",
	difficulty = {"waystation_outside_easy", "waystation_outside_hard", "pripyat_outside_easy"},
	lootChance = 10, 
}

PLUGIN.eventdefs["psydog2"] = {
	entities = {
		{"npc_mutant_psydog", 2}, 
	},
	pdabroadcast = "A psydog has been reported feasting on a dead stalker %s, don't add a body for it to eat, stalker",
	difficulty = {"pripyat_outside_easy"},
	lootChance = 15, 
}

PLUGIN.eventdefs["psydog3"] = {
	entities = {
		{"npc_mutant_psydog", 1}, 
		{"npc_mutant_pseudodog", 2}, 
	},
	pdabroadcast = "A psydog has been reported feasting on a dead stalker %s, don't let it feast on another, stalker",
	difficulty = {"pripyat_outside_easy"},
	lootChance = 20, 
}

--[[-------------------------------------------------------------------------
Burers
---------------------------------------------------------------------------]]
PLUGIN.eventdefs["burer1"] = {
	entities = {
		{"npc_mutant_burer", 1}, 
	},
	pdabroadcast = "A burer has been spotted %s! Watch out for any figure in a trenchcoat, stalker.",
	difficulty = {"waystation_underground"},
	lootChance = 10, 
}

PLUGIN.eventdefs["burer2"] = {
	entities = {
		{"npc_mutant_burer", 1}, 
		{"npc_mutant_classiczombie", 2}, 
	},
	pdabroadcast =  "A burer has been spotted %s! Watch out for any figure in a trenchcoat, stalker.",
	difficulty = {"waystation_underground", "pripyat_underground"},
	lootChance = 15, 
}

PLUGIN.eventdefs["burer3"] = {
	entities = {
		{"npc_mutant_burer", 3}, 
	},
	pdabroadcast = "A trio of burers has been spotted %s! Avoid any hooded figures, stalkers.",
	difficulty = {"pripyat_underground"},
	lootChance = 20, 
}

--[[-------------------------------------------------------------------------
Fleshes
---------------------------------------------------------------------------]]
PLUGIN.eventdefs["flesh1"] = {
	entities = {
		{"npc_mutant_flesh", 2}, 
	},
	pdabroadcast = "A few flesh were spotted %s, up for an easy hunt, stalker?.",
	difficulty = {"swamps_outside_easy"},
	lootChance = 10, 
}


PLUGIN.eventdefs["flesh2"] = {
	entities = {
		{"npc_mutant_flesh", 1}, 
		{"npc_mutant_boar", 1},
	},
	pdabroadcast = "A few flesh were spotted %s, up for an easy hunt, stalker?.",
	difficulty = {"swamps_outside_easy", "swamps_outside_hard"},
	lootChance = 10, 
}

PLUGIN.eventdefs["flesh3"] = {
	entities = {
		{"npc_mutant_flesh", 3}, 
	},
	pdabroadcast = "A few flesh were spotted %s, up for an easy hunt, stalker?.",
	difficulty = {"swamps_outside_hard"},
	lootChance = 10, 
}

PLUGIN.eventdefs["flesh4"] = {
	entities = {
		{"npc_mutant_flesh", 3}, 
		{"npc_mutant_boar", 1},
	},

	pdabroadcast = "A small pack of flesh are wandering %s, we could always use more food, stalker.",
	difficulty = {"swamps_outside_hard"},
	lootChance = 15, 
}

PLUGIN.eventdefs["flesh5"] = {
	entities = {
		{"npc_mutant_flesh", 4}, 
	},

	pdabroadcast = "A small pack of flesh are wandering %s, we could always use more food, stalker.",
	difficulty = {"swamps_outside_hard"},
	lootChance = 15, 
}

PLUGIN.eventdefs["flesh6"] = {
	entities = {
		{"npc_mutant_flesh", 4}, 
		{"npc_mutant_boar", 1},
	},

	pdabroadcast = "There has been sightings of aggressive fleshes %s, somebody put them down.",
	difficulty = {"waystation_outside_easy"},
	lootChance = 20, 
}


--[[-------------------------------------------------------------------------
Snorks
---------------------------------------------------------------------------]]

PLUGIN.eventdefs["snork1"] = {
	entities = {
		{"npc_mutant_snork", 1}, 
	},
	pdabroadcast = "A snork has been sneaking about %s, careful stalker.",
	difficulty = {"waystation_building", "waystation_underground", "pripyat_building"},
	lootChance = 10, 
}

PLUGIN.eventdefs["snork2"] = {
	entities = {
		{"npc_mutant_snork", 2}, 
	},
	pdabroadcast = "A couple of snorks have been heard growling %s, careful stalker.",
	difficulty = {"waystation_building", "waystation_underground", "pripyat_building", "pripyat_underground"},
	lootChance = 15, 
}

PLUGIN.eventdefs["snork3"] = {
	entities = {
		{"npc_mutant_snork", 3}, 
	},
	pdabroadcast = "A small group of snorks have been seen prowling %s, careful stalker.",
	difficulty = {"waystation_building", "waystation_underground", "pripyat_building", "pripyat_underground"},
	lootChance = 20, 
}

--[[-------------------------------------------------------------------------
Zombies
---------------------------------------------------------------------------]]
PLUGIN.eventdefs["zombies0"] = {
	entities = {
		{"npc_mutant_classiczombie_babka", 1},
		{"npc_mutant_classiczombie", 2}, 
	},
	pdabroadcast = "There has been sightings of a few zombies %s, put them out of their misery, stalker.",
	difficulty = {"swamps_outside_easy"},
	lootChance = 10, 
}

PLUGIN.eventdefs["zombies1"] = {
	entities = {
		{"npc_mutant_classiczombie_babka", 1},
		{"npc_mutant_classiczombie", 3}, 
	},
	pdabroadcast = "There has been sightings of a few zombies %s, put them out of their misery, stalker.",
	difficulty = {"swamps_outside_hard", "swamps_building", "garbage_outside_easy"},
	lootChance = 10, 
}

PLUGIN.eventdefs["zombies2"] = {
	entities = {
		{"npc_human_z_rookie_pistolman", 1},
	},
	pdabroadcast = "A pistol wielding zombie has appeared %s, watch yourself, stalker.",
	difficulty = {"swamps_outside_easy"},
	lootChance = 15, 
}

PLUGIN.eventdefs["zombies3"] = {
	entities = {
		{"npc_mutant_classiczombie_babka", 1},
		{"npc_mutant_classiczombie", 3}, 
	},
	pdabroadcast = "A small group of zombies have appeared %s, watch yourself, stalker.",
	difficulty = {"swamps_outside_hard", "swamps_building", "waystation_underground"},
	lootChance = 15, 
}

PLUGIN.eventdefs["zombies4"] = {
	entities = {
		{"npc_mutant_classiczombie_babka", 2},
		{"npc_mutant_classiczombie", 3}, 
		{"npc_human_z_rookie_pistolman", 1},
		{"npc_human_z_rookie_rifleman", 1},
	},
	pdabroadcast = "There is a group of zombies %s, and has occupied it. Tread with caution, stalker.",
	difficulty = {"waystation_outside_easy", "waystation_building", "waystation_underground"},
	lootChance = 20, 
}

--[[-------------------------------------------------------------------------
Tarks
---------------------------------------------------------------------------]]
PLUGIN.eventdefs["tark1"] = {
	entities = {
		{"npc_mutant_tark", 1},
	},
	pdabroadcast = "Horse-like creature spotted %s. Don't try to feed it, stalker.",
	difficulty = {"swamps_outside_hard", "garbage_outside_easy"},
}

PLUGIN.eventdefs["tark2"] = {
	entities = {
		{"npc_mutant_tark", 2},
	},
	pdabroadcast = "A pair of horse-like creatures spotted %s.",
	difficulty = {"swamps_outside_hard", "garbage_outside_easy"},
}

PLUGIN.eventdefs["tark3"] = {
	entities = {
		{"npc_mutant_tark", 3},
	},
	pdabroadcast = "Small pack of horse-like creatures spotted %s.",
	difficulty = {"waystation_outside_hard"},
}

--[[-------------------------------------------------------------------------
Spiders
---------------------------------------------------------------------------]]
PLUGIN.eventdefs["spider1"] = {
	entities = {
		{"npc_mutant_spider", 1},
	},
	pdabroadcast = "Arachnid has been detected %s.",
	difficulty = {
		"swamps_outside_hard",
		"garbage_outside_easy",
		"waystation_building",
		"waystation_underground",
	},
}

PLUGIN.eventdefs["spider2"] = {
	entities = {
		{"npc_mutant_spider", 2},
	},
	pdabroadcast = "Arachnid creatures spotted %s. Take care, stalker.",
	difficulty = {"waystation_outside_easy", "waystation_outside_hard", "waystation_building", "waystation_underground"},
}

PLUGIN.eventdefs["spider3"] = {
	entities = {
		{"npc_mutant_spider", 3},
	},
	pdabroadcast = "A hunting pack of arachnid creatures spotted %s. Take care, stalker.",
	difficulty = {
		"waystation_outside_easy",
		"waystation_outside_hard",
		"pripyat_outside_hard",
		"pripyat_building",
		"pripyat_underground",
	},
}

--[[-------------------------------------------------------------------------
Sprigs
---------------------------------------------------------------------------]]
PLUGIN.eventdefs["sprig1"] = {
	entities = {
		{"npc_mutant_sprig", 1},
	},
	pdabroadcast = "Getting some motion detection readings %s, but we don't see anything. Take care, stalker.",
	difficulty = {
		"swamps_outside_hard",
		"garbage_outside_easy",
		"pripyat_outside_easy",
		"pripyat_outside_hard",
	},
}

PLUGIN.eventdefs["sprig2"] = {
	entities = {
		{"npc_mutant_sprig", 2},
	},
	pdabroadcast = "Motion sensors spike out %s, but we don't see anything. Take care, stalker.",
	difficulty = {"waystation_outside_easy", "waystation_outside_hard", "pripyat_outside_easy", "pripyat_outside_hard"},
}

--[[-------------------------------------------------------------------------
Swamp Controller
---------------------------------------------------------------------------]]
PLUGIN.eventdefs["controllerswamp3"] = {
	entities = {
		{"npc_mutant_controller_swamp", 1},
		{"npc_human_z_rookie_pistolman", 2},
		{"npc_human_z_rookie_rifleman", 1},
	},
	pdabroadcast = "Getting strange readings %s... Be very cautious, stalker.",
	difficulty = {"waystation_outside_easy", "waystation_outside_hard", "waystation_building"},
}

--[[-------------------------------------------------------------------------
Fast Controller
---------------------------------------------------------------------------]]
PLUGIN.eventdefs["controllerfast1"] = {
	entities = {
		{"npc_mutant_controller_fast", 1},
	},
	pdabroadcast = "Getting strange readings %s... Take care, stalker.",
	difficulty = {
		"waystation_outside_easy",
		"waystation_outside_hard",
		"waystation_building",
		"waystation_underground",
		"pripyat_outside_easy",
		"pripyat_building",
		"pripyat_underground",
	},
}

PLUGIN.eventdefs["controllerfast2"] = {
	entities = {
		{"npc_mutant_controller_fast", 2},
	},
	pdabroadcast = "Getting multiple strange readings %s... Be very cautious, stalker.",
	difficulty = {
		"waystation_building",
		"pripyat_outside_easy",
		"pripyat_outside_hard",
		"pripyat_building",
		"pripyat_underground",
	},
}


--[[-------------------------------------------------------------------------
Regular Controller
---------------------------------------------------------------------------]]
PLUGIN.eventdefs["controller1"] = {
	entities = {
		{"npc_mutant_controller", 1},
		{"npc_human_z_rookie_pistolman", 1},
		{"npc_human_z_rookie_rifleman", 2},
	},
	pdabroadcast = "Getting strange readings %s... Take care, stalker.",
	difficulty = {"waystation_underground", "pripyat_building", "pripyat_underground"},
}

--[[-------------------------------------------------------------------------
Electric Controller
---------------------------------------------------------------------------]]
PLUGIN.eventdefs["controllerelectric1"] = {
	entities = {
		{"npc_mutant_controller_electro", 1},
	},
	pdabroadcast = "Getting strange readings %s... Take care, stalker.",
	difficulty = {"pripyat_outside_hard", "pripyat_building", "pripyat_underground"},
}

--[[-------------------------------------------------------------------------
Karlik
---------------------------------------------------------------------------]]
PLUGIN.eventdefs["karlik1"] = {
	entities = {
		{"npc_mutant_karlik", 1},
	},
	pdabroadcast = "Getting strange readings %s... Take care, stalker.",
	difficulty = {"pripyat_outside_hard"},
}

PLUGIN.eventdefs["karlik2"] = {
	entities = {
		{"npc_mutant_karlik", 2},
	},
	pdabroadcast = "Getting multiple strange readings %s... Be very cautious, stalker.",
	difficulty = {"pripyat_outside_hard"},
}

--[[-------------------------------------------------------------------------
Vareshka
---------------------------------------------------------------------------]]
PLUGIN.eventdefs["vareshka1"] = {
	entities = {
		{"npc_mutant_vareshka", 1},
	},
	pdabroadcast = "Vareshka detected %s... Take care, stalker.",
	difficulty = {"waystation_outside_hard"},
}

PLUGIN.eventdefs["vareshka2"] = {
	entities = {
		{"npc_mutant_vareshka", 2},
	},
	pdabroadcast = "A pair of Vareshkas has been detected %s... Be very cautious, stalker.",
	difficulty = {"waystation_outside_hard", "pripyat_outside_easy", "pripyat_outside_hard"},
}

PLUGIN.eventdefs["vareshka3"] = {
	entities = {
		{"npc_mutant_vareshka", 3},
	},
	pdabroadcast = "Getting information about multiple Vareshkas detected %s... Be extremely very cautious, stalker.",
	difficulty = {"pripyat_outside_easy", "pripyat_outside_hard"},
}


--[[-------------------------------------------------------------------------
Bear
---------------------------------------------------------------------------]]
-- PLUGIN.eventdefs["bear1"] = {
-- 	entities = {
-- 		{"npc_mutant_bear", 1},
-- 	},
-- 	pdabroadcast = "Huge Bear detected %s, don't get too close, stalker.",
-- 	difficulty = {"waystation_outside_hard", "pripyat_outside_easy"},
-- }

-- PLUGIN.eventdefs["bear2"] = {
-- 	entities = {
-- 		{"npc_mutant_bear", 2},
-- 	},
-- 	pdabroadcast = "A pair of Bears has been detected %s, I suggest legging it out of there, stalker.",
-- 	difficulty = {"pripyat_outside_easy", "pripyat_outside_hard"},
-- }


--[[-------------------------------------------------------------------------
Special
---------------------------------------------------------------------------]]

PLUGIN.eventdefs["zombieradio1"] = {
	entities = {
		{"npc_mutant_classiczombie_radio", 1},
		{"npc_mutant_classiczombie", 3},
	},
	pdabroadcast = "Zombies detected %s... Getting some high radiation readings too. Be careful, stalker.",
	difficulty = {"waystation_outside_easy", "waystation_building", "waystation_underground"},
}

PLUGIN.eventdefs["zombievolatile1"] = {
	entities = {
		{"npc_mutant_classiczombie_volatile", 1},
		{"npc_mutant_classiczombie", 3},
	},
	pdabroadcast = "Zombies detected %s... Getting some high radiation readings too. Be careful, stalker.",
	difficulty = {
		"waystation_outside_easy",
		"waystation_outside_hard",
		"waystation_building",
		"waystation_underground",
		"pripyat_outside_easy",
		"pripyat_building",
		"pripyat_underground",
	},
}

PLUGIN.eventdefs["skeleton1"] = {
	entities = {
		{"npc_mutant_skeleton", 2},
	},
	pdabroadcast = "Getting strange readings %s... Take care, stalker.",
	difficulty = {"waystation_building", "waystation_underground", "pripyat_building", "pripyat_underground"},
}

PLUGIN.eventdefs["skeleton2"] = {
	entities = {
		{"npc_mutant_skeleton", 3},
		{"npc_mutant_classiczombie", 3},
	},
	pdabroadcast = "Getting strange readings %s... Take care, stalker.",
	difficulty = {"waystation_building", "waystation_underground", "pripyat_building", "pripyat_underground"},
}


PLUGIN.eventdefs["hellhound1"] = {
	entities = {
		{"npc_mutant_hellhound", 1},
		{"npc_mutant_dog", 3}
	},
	pdabroadcast = "A small pack of dogs have been spotted %s. I'm also getting increased heat signatures - strange.",
	difficulty = {"waystation_outside_hard", "pripyat_outside_easy", "pripyat_outside_hard"},
}



-- Garbage bridges Swamps packs and Waystation threats; keep its tuning explicit.
PLUGIN.eventdefs["garbage_pseudodog_pack"] = {
	entities = {
		{"npc_mutant_dog", 3},
		{"npc_mutant_pseudodog", 1},
	},
	pdabroadcast = "Dogs led by a pseudodog have been spotted %s.",
	difficulty = {"garbage_outside_hard"},
	lootChance = 15,
}

PLUGIN.eventdefs["garbage_boars"] = {
	entities = {
		{"npc_mutant_boar", 2},
	},
	pdabroadcast = "A pair of boars has been spotted %s.",
	difficulty = {"garbage_outside_easy"},
	lootChance = 10,
}

PLUGIN.eventdefs["garbage_boar_pack"] = {
	entities = {
		{"npc_mutant_boar", 3},
	},
	pdabroadcast = "A pack of boars is roaming %s.",
	difficulty = {"garbage_outside_hard"},
	lootChance = 15,
}

PLUGIN.eventdefs["garbage_flesh_boar"] = {
	entities = {
		{"npc_mutant_flesh", 3},
		{"npc_mutant_boar", 1},
	},
	pdabroadcast = "Flesh and a boar are roaming %s.",
	difficulty = {"garbage_outside_easy", "garbage_outside_hard"},
	lootChance = 15,
}

PLUGIN.eventdefs["garbage_izlom"] = {
	entities = {
		{"npc_mutant_izlom", 1},
	},
	pdabroadcast = "An izlom has been spotted %s.",
	difficulty = {"garbage_outside_hard", "garbage_building"},
	lootChance = 10,
}

PLUGIN.eventdefs["garbage_bloodsucker"] = {
	entities = {
		{"npc_mutant_bloodsucker", 1},
	},
	pdabroadcast = "A lone bloodsucker has been spotted %s. Take care, stalker.",
	difficulty = {"garbage_outside_hard", "garbage_building", "garbage_underground"},
	lootChance = 15,
}

PLUGIN.eventdefs["garbage_snork"] = {
	entities = {
		{"npc_mutant_snork", 1},
	},
	pdabroadcast = "A snork has been heard %s. Watch your step, stalker.",
	difficulty = {"garbage_building", "garbage_underground"},
	lootChance = 10,
}

PLUGIN.eventdefs["garbage_spider"] = {
	entities = {
		{"npc_mutant_spider", 1},
	},
	pdabroadcast = "An arachnid creature has been spotted %s.",
	difficulty = {"garbage_outside_hard", "garbage_building", "garbage_underground"},
	lootChance = 10,
}

PLUGIN.eventdefs["garbage_sprigs"] = {
	entities = {
		{"npc_mutant_sprig", 2},
	},
	pdabroadcast = "Motion sensors are picking up something %s, but nothing is visible.",
	difficulty = {"garbage_outside_hard"},
	lootChance = 15,
}

PLUGIN.eventdefs["garbage_zombies"] = {
	entities = {
		{"npc_mutant_classiczombie", 3},
		{"npc_mutant_classiczombie_babka", 1},
	},
	pdabroadcast = "A small group of zombies has been spotted %s.",
	difficulty = {"garbage_building", "garbage_underground"},
	lootChance = 10,
}

PLUGIN.eventdefs["garbage_radioactive_zombies"] = {
	entities = {
		{"npc_mutant_classiczombie_radio", 1},
		{"npc_mutant_classiczombie", 3},
	},
	pdabroadcast = "Zombies have been spotted %s, with elevated radiation readings.",
	difficulty = {"garbage_outside_hard", "garbage_building", "garbage_underground"},
	lootChance = 15,
}

--[[-------------------------------------------------------------------------
Human
---------------------------------------------------------------------------]]

-- Temporary Garbage patrols until the map-specific human NPCs are supplied.
PLUGIN.eventdefs["garbage_bandit_patrol"] = {
	entities = {{"npc_human_bandit_pistolman", 2}, {"npc_human_bandit_shotgunner", 1}},
	pdabroadcast = "Bandits spotted %s. Take care.",
	difficulty = {"garbage_outside_easy", "garbage_building"},
}

PLUGIN.eventdefs["garbage_bandit_patrol_heavy"] = {
	entities = {{"npc_human_bandit_pistolman", 1}, {"npc_human_bandit_shotgunner", 1},
		{"npc_human_bandit_rifleman", 2}},
	pdabroadcast = "An armed bandit patrol has been spotted %s.",
	difficulty = {"garbage_outside_hard", "garbage_underground"},
}

PLUGIN.eventdefs["bandit0"] = {
	entities = {
		{"npc_human_bandit_pistolman", 1},
	},
	pdabroadcast = "Bandit scout spotted %s. Take care.",
	difficulty = {"swamps_outside_easy"},
}

PLUGIN.eventdefs["bandit1"] = {
	entities = {
		{"npc_human_bandit_pistolman", 2},
		{"npc_human_bandit_shotgunner", 1}
	},
	pdabroadcast = "Bandits spotted %s. Take care.",
	difficulty = {
		"swamps_outside_hard",
		"swamps_building",
		"waystation_outside_easy",
		"waystation_outside_hard",
		"waystation_building",
	},
}

PLUGIN.eventdefs["bandit2"] = {
	entities = {
		{"npc_human_bandit_pistolman", 1},
		{"npc_human_bandit_shotgunner", 1},
		{"npc_human_bandit_rifleman", 2},
	},
	pdabroadcast = "Bandits spotted %s. Take care.",
	difficulty = {
		"swamps_outside_hard",
		"swamps_building",
		"waystation_outside_easy",
		"waystation_outside_hard",
		"waystation_building",
	},
}

PLUGIN.eventdefs["bandit3"] = {
	entities = {
		{"npc_human_bandit_pistolman", 3},
		{"npc_human_bandit_rifleman", 2},
	},
	pdabroadcast = "Bandits spotted %s. Take care.",
	difficulty = {
		"swamps_outside_hard",
		"swamps_building",
		"waystation_outside_easy",
		"waystation_outside_hard",
		"waystation_building",
		"waystation_underground",
	},
}

PLUGIN.eventdefs["banditsniper"] = {
	entities = {
		{"npc_human_bandit_sniper", 1},		
	},
	pdabroadcast = "Bandit sniper spotted %s. Take care.",
	difficulty = {"swamps_sniperspot", "waystation_sniperspot"},
}

PLUGIN.eventdefs["merc1"] = {
	entities = {
		{"npc_human_merc_shotgunner", 1},
		{"npc_human_merc_rifleman", 1},	
	},
	pdabroadcast = "Mercenaries spotted %s. Take care.",
	difficulty = {
		"waystation_outside_easy",
		"waystation_outside_hard",
		"waystation_building",
		"waystation_underground",
		"pripyat_outside_easy",
		"pripyat_building",
	},
}

PLUGIN.eventdefs["merc2"] = {
	entities = {
		{"npc_human_merc_pistolman", 1},
		{"npc_human_merc_shotgunner", 1},
		{"npc_human_merc_rifleman", 2},	
	},
	pdabroadcast = "Mercenaries spotted %s. Take care.",
	difficulty = {
		"waystation_outside_easy",
		"waystation_outside_hard",
		"waystation_building",
		"waystation_underground",
		"pripyat_outside_easy",
		"pripyat_building",
	},
}

PLUGIN.eventdefs["merc3"] = {
	entities = {
		{"npc_human_merc_pistolman", 3},
		{"npc_human_merc_rifleman", 2},	
	},
	pdabroadcast = "Mercenaries spotted %s. Take care.",
	difficulty = {
		"waystation_outside_easy",
		"waystation_outside_hard",
		"waystation_building",
		"waystation_underground",
		"pripyat_outside_easy",
		"pripyat_building",
	},
}

PLUGIN.eventdefs["mercsniper"] = {
	entities = {
		{"npc_human_merc_sniper", 1},	
	},
	pdabroadcast = "Mercenary sniper spotted %s. Take care.",
	difficulty = {"waystation_sniperspot"},
}

PLUGIN.eventdefs["mili1"] = {
	entities = {
		{"npc_human_mili_shotgunner", 1},
		{"npc_human_mili_pistolman", 1},	
	},
	pdabroadcast = "Military patrol spotted %s. Take good care.",
	difficulty = {"pripyat_outside_easy", "pripyat_outside_hard", "pripyat_building", "pripyat_underground"},
}

PLUGIN.eventdefs["mili2"] = {
	entities = {
		{"npc_human_mili_pistolman", 1},
		{"npc_human_mili_shotgunner", 1},
		{"npc_human_mili_rifleman", 2},	
	},
	pdabroadcast = "Military patrol spotted %s. Take good care.",
	difficulty = {"pripyat_outside_easy", "pripyat_outside_hard", "pripyat_building", "pripyat_underground"},
}

PLUGIN.eventdefs["mili3"] = {
	entities = {
		{"npc_human_mili_pistolman", 3},
		{"npc_human_mili_rifleman", 2},	
	},
	pdabroadcast = "Military patrol spotted %s. Take good care.",
	difficulty = {"pripyat_outside_easy", "pripyat_outside_hard", "pripyat_building", "pripyat_underground"},
}

-- PLUGIN.eventdefs["milisniper"] = {
-- 	entities = {
-- 		{"npc_human_mili_rifleman", 1}, -- Create real entity.
-- 	},
-- 	pdabroadcast = "Military sniper spotted %s. Take good care.",
-- 	difficulty = {"pripyat_sniperspot"}, --??
-- }
