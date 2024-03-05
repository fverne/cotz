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
		difficulty = {11, 12},
		lootChance = 10, --percentage
	}
*/
--entities: spawns <amount> entities of the type listed
--items: spawns the listed items with the given data
--props: spawns <amount> props with the model listed
--ragdolls: spawns <amount> ragdolls and sets skin and bodygroup
--loot: like items, except each item has a chance to spawn


-- Explananation for difficulties:
-- First integer = Map
-- 1 = Swamps
-- 2 = Waystation
-- 3 = Pripyat
-- Second integer = location on map
-- 1 = Close to spawn in wilderness
-- 2 = Far from spawn in wilderness
-- 3 = In previous populated areas, such as buildings, intended for humanoid npcs
-- 4 = Sniper spots
-- 5 = Underground
-- Examples:
-- 12 - Swamps, far from spawn
-- 14 - Swamps, sniper spot (guard tower for instance)
-- 23 - Waystation, inside a building
-- 33 - Pripyat, inside a building
-- 35 - Pripyat, underground

--[[-------------------------------------------------------------------------
dogs
---------------------------------------------------------------------------]]
PLUGIN.eventdefs["Dog1"] = {
	entities = {
		{"npc_mutant_dog", 2},
	},
	pdabroadcast = "A small pack of dogs have been spotted %s.",
	difficulty = {11},
	lootChance = 10,
}

PLUGIN.eventdefs["Dog2"] = {
	entities = {
		{"npc_mutant_dog", 3},
	},
	pdabroadcast = "A small pack of dogs have been spotted %s.",
	difficulty = {12, 21},
	lootChance = 10,
}

PLUGIN.eventdefs["Dog3"] = {
	entities = {
		{"npc_mutant_dog", 3},
		{"npc_mutant_pseudodog", 1},
	},
	pdabroadcast = "A small pack of dogs have been spotted %s.",
	difficulty = {12, 21, 22},
	lootChance = 15,
}

PLUGIN.eventdefs["Dog4"] = {
	entities = {
		{"npc_mutant_dog", 4},
	},
	pdabroadcast = "A pack of dogs have been seen wandering %s aimlessly, be alert, stalker.",
	difficulty = {12, 21, 22, 31, 32},
	lootChance = 15,
}

PLUGIN.eventdefs["Dog5"] = {
	entities = {
		{"npc_mutant_dog", 4},
		{"npc_mutant_pseudodog", 1},
	},
	pdabroadcast = "A pack of dogs have been seen wandering %s aimlessly, be alert, stalker.",
	difficulty = {12, 21, 22, 31, 32},
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
	difficulty = {12, 13, 21, 23, 25},
	lootChance = 10,
}

PLUGIN.eventdefs["bloodsucker2"] = {
	entities = {
		{"npc_mutant_bloodsucker", 2}, 
	},
	pdabroadcast = "There's been sightings of a couple bloodsuckers %s, any stalkers brave enough to take them out?",
	difficulty = {21, 22, 23, 25},
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
	difficulty = {23, 25, 31, 33, 35},
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
	difficulty = {32, 33, 35},
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
	difficulty = {11, 12, 13, 21, 22, 23, 31, 32, 33},
	lootChance = 10,
}


-- PLUGIN.eventdefs["rodent2"] = {
-- 	entities = {
-- 		{"npc_mutant_rodent", 6},
-- 	},
-- 	pdabroadcast = "Rodents are being a menace %s, deal with them with caution, stalker.",
-- 	difficulty = {11, 12, 13},
-- 	lootChance = 15,
-- }

-- PLUGIN.eventdefs["rodent3"] = {
-- 	entities = {
-- 		{"npc_mutant_rodent", 8},
-- 	},
-- 	pdabroadcast = "Rodents are overrunning %s, proceed with caution, stalker.",
-- 	difficulty = {11, 12, 13},
-- 	lootChance = 20,
-- }

-- PLUGIN.eventdefs["rodent4"] = {
-- 	entities = {
-- 		{"npc_mutant_rodent", 9},
-- 	},
-- 	pdabroadcast = "It seems %s is completely infested with swarms of rodents! Stay away, stalker!",
-- 	difficulty = {11, 12, 13},
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
	difficulty = {22},
	lootChance = 20, 
}

PLUGIN.eventdefs["pseudogiant2"] = {
	entities = {
		{"npc_mutant_pseudogiant_slow", 1},
		{"npc_mutant_rodent", 3}, 
	},
	
	pdabroadcast = "A pseudogiant has been spotted %s! Stay away from there, stalker.",
	difficulty = {31, 32},
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
	difficulty = {32},
	lootChance = 30, 
}

PLUGIN.eventdefs["pseudogiant4"] = {
	entities = {
		{"npc_mutant_pseudogiant_fast", 1} 
	},
	pdabroadcast = "A hulking mass has been spotted leaping through the air %s! Get out of there if you value your lives.",
	difficulty = {32},
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
	difficulty = {11},
	lootChance = 10,
}

PLUGIN.eventdefs["boar1"] = {
	entities = {
		{"npc_mutant_boar", 2},
	},
	pdabroadcast = "A pair of boars are spotted %s, any stalkers up for boar stew should deal with them.",
	difficulty = {11, 12, 21},
	lootChance = 10,
}

PLUGIN.eventdefs["boar2"] = {
	entities = {
		{"npc_mutant_boar", 3},
	},
	pdabroadcast = "Wild boars have been disrupting stalker activity %s, try to wipe them out, stalker.",
	difficulty = {12, 21, 22},
	lootChance = 15,
}

PLUGIN.eventdefs["boar3"] = {
	entities = {
		{"npc_mutant_boar", 4},
	},
	pdabroadcast = "A pack of boars are running rampant %s, proceed with caution, stalker.",
	difficulty = {12, 21, 22},
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
	difficulty = {22, 31, 32},
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
	difficulty = {31, 32},
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
	difficulty = {32},
	lootChance = 20, 
}

PLUGIN.eventdefs["electrochimera1"] = {
	entities = {
		{"npc_mutant_chimera_electro", 1},
	},
	pdabroadcast = "We have sightings of an electrically charged Chimera %s! Make sure you're properly prepared if you're taking it on, stalkers.",
	difficulty = {32},
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
	difficulty = {12, 21, 22},
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
	difficulty = {12, 21, 22, 31},
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
	difficulty = {21, 22, 31, 32},
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
	difficulty = {12, 21, 22, 31, 32},
	lootChance = 10, 
}

PLUGIN.eventdefs["izlom2"] = {
	entities = {
		{"npc_mutant_izlom", 2}, 
	},
	pdabroadcast = "A pair of Izloms have just been seen %s.",
	difficulty = {21, 22, 31, 32},
	lootChance = 15, 
}

PLUGIN.eventdefs["izlom2"] = {
	entities = {
		{"npc_mutant_izlom", 2}, 
	},
	ragdolls = {
		{"models/crow.mdl", 1, 0, "000000000"},
	},
	pdabroadcast = "Just saw a pair of those hunchbacked izloms eat a crow %s.",
	difficulty = {21, 22, 31, 32},
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
	difficulty = {21, 22, 31, 32},
	lootChance = 10, 
}

PLUGIN.eventdefs["psydog2"] = {
	entities = {
		{"npc_mutant_psydog", 2}, 
	},
	pdabroadcast = "A psydog has been reported feasting on a dead stalker %s, don't add a body for it to eat, stalker",
	difficulty = {31, 32},
	lootChance = 15, 
}

PLUGIN.eventdefs["psydog3"] = {
	entities = {
		{"npc_mutant_psydog", 1}, 
		{"npc_mutant_pseudodog", 2}, 
	},
	pdabroadcast = "A psydog has been reported feasting on a dead stalker %s, don't let it feast on another, stalker",
	difficulty = {32},
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
	difficulty = {25, 35},
	lootChance = 10, 
}

PLUGIN.eventdefs["burer2"] = {
	entities = {
		{"npc_mutant_burer", 1}, 
		{"npc_mutant_classiczombie", 2}, 
	},
	pdabroadcast =  "A burer has been spotted %s! Watch out for any figure in a trenchcoat, stalker.",
	difficulty = {25, 35},
	lootChance = 15, 
}

PLUGIN.eventdefs["burer3"] = {
	entities = {
		{"npc_mutant_burer", 3}, 
	},
	pdabroadcast = "A trio of burers has been spotted %s! Avoid any hooded figures, stalkers.",
	difficulty = {35},
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
	difficulty = {11},
	lootChance = 10, 
}


PLUGIN.eventdefs["flesh2"] = {
	entities = {
		{"npc_mutant_flesh", 1}, 
		{"npc_mutant_boar", 1},
	},
	pdabroadcast = "A few flesh were spotted %s, up for an easy hunt, stalker?.",
	difficulty = {11, 12},
	lootChance = 10, 
}

PLUGIN.eventdefs["flesh3"] = {
	entities = {
		{"npc_mutant_flesh", 3}, 
	},
	pdabroadcast = "A few flesh were spotted %s, up for an easy hunt, stalker?.",
	difficulty = {12},
	lootChance = 10, 
}

PLUGIN.eventdefs["flesh4"] = {
	entities = {
		{"npc_mutant_flesh", 3}, 
		{"npc_mutant_boar", 1},
	},

	pdabroadcast = "A small pack of flesh are wandering %s, we could always use more food, stalker.",
	difficulty = {12},
	lootChance = 15, 
}

PLUGIN.eventdefs["flesh5"] = {
	entities = {
		{"npc_mutant_flesh", 4}, 
	},

	pdabroadcast = "A small pack of flesh are wandering %s, we could always use more food, stalker.",
	difficulty = {12},
	lootChance = 15, 
}

PLUGIN.eventdefs["flesh6"] = {
	entities = {
		{"npc_mutant_flesh", 4}, 
		{"npc_mutant_boar", 1},
	},

	pdabroadcast = "There has been sightings of aggressive fleshes %s, somebody put them down.",
	difficulty = {12, 21},
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
	difficulty = {13, 23, 25, 33},
	lootChance = 10, 
}

PLUGIN.eventdefs["snork2"] = {
	entities = {
		{"npc_mutant_snork", 2}, 
	},
	pdabroadcast = "A couple of snorks have been heard growling %s, careful stalker.",
	difficulty = {23, 25, 33, 35},
	lootChance = 15, 
}

PLUGIN.eventdefs["snork3"] = {
	entities = {
		{"npc_mutant_snork", 3}, 
	},
	pdabroadcast = "A small group of snorks have been seen prowling %s, careful stalker.",
	difficulty = {23, 25, 33, 35},
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
	difficulty = {11},
	lootChance = 10, 
}

PLUGIN.eventdefs["zombies1"] = {
	entities = {
		{"npc_mutant_classiczombie_babka", 1},
		{"npc_mutant_classiczombie", 3}, 
	},
	pdabroadcast = "There has been sightings of a few zombies %s, put them out of their misery, stalker.",
	difficulty = {12, 13, 21},
	lootChance = 10, 
}

PLUGIN.eventdefs["zombies2"] = {
	entities = {
		{"npc_human_z_rookie_pistolman", 1},
	},
	pdabroadcast = "A pistol wielding zombie has appeared %s, watch yourself, stalker.",
	difficulty = {11},
	lootChance = 15, 
}

PLUGIN.eventdefs["zombies3"] = {
	entities = {
		{"npc_mutant_classiczombie_babka", 1},
		{"npc_mutant_classiczombie", 3}, 
	},
	pdabroadcast = "A small group of zombies have appeared %s, watch yourself, stalker.",
	difficulty = {12, 13, 25},
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
	difficulty = {21, 23, 25},
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
	difficulty = {12, 21, 22},
}

PLUGIN.eventdefs["tark2"] = {
	entities = {
		{"npc_mutant_tark", 2},
	},
	pdabroadcast = "A pair of horse-like creatures spotted %s.",
	difficulty = {12, 21, 22},
}

PLUGIN.eventdefs["tark3"] = {
	entities = {
		{"npc_mutant_tark", 3},
	},
	pdabroadcast = "Small pack of horse-like creatures spotted %s.",
	difficulty = {22},
}

--[[-------------------------------------------------------------------------
Spiders
---------------------------------------------------------------------------]]
PLUGIN.eventdefs["spider1"] = {
	entities = {
		{"npc_mutant_spider", 1},
	},
	pdabroadcast = "Arachnid has been detected %s.",
	difficulty = {12, 21, 23, 25},
}

PLUGIN.eventdefs["spider2"] = {
	entities = {
		{"npc_mutant_spider", 2},
	},
	pdabroadcast = "Arachnid creatures spotted %s. Take care, stalker.",
	difficulty = {21, 22, 23, 25},
}

PLUGIN.eventdefs["spider3"] = {
	entities = {
		{"npc_mutant_spider", 3},
	},
	pdabroadcast = "A hunting pack of arachnid creatures spotted %s. Take care, stalker.",
	difficulty = {21, 22, 32, 33, 35},
}

--[[-------------------------------------------------------------------------
Sprigs
---------------------------------------------------------------------------]]
PLUGIN.eventdefs["sprig1"] = {
	entities = {
		{"npc_mutant_sprig", 1},
	},
	pdabroadcast = "Getting some motion detection readings %s, but we don't see anything. Take care, stalker.",
	difficulty = {12, 21, 22, 31, 32},
}

PLUGIN.eventdefs["sprig2"] = {
	entities = {
		{"npc_mutant_sprig", 2},
	},
	pdabroadcast = "Motion sensors spike out %s, but we don't see anything. Take care, stalker.",
	difficulty = {12, 21, 22, 31, 32},
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
	difficulty = {12, 13, 21, 22, 23},
}

--[[-------------------------------------------------------------------------
Fast Controller
---------------------------------------------------------------------------]]
PLUGIN.eventdefs["controllerfast1"] = {
	entities = {
		{"npc_mutant_controller_fast", 1},
	},
	pdabroadcast = "Getting strange readings %s... Take care, stalker.",
	difficulty = {21, 22, 23, 25, 31, 33, 35},
}

PLUGIN.eventdefs["controllerfast2"] = {
	entities = {
		{"npc_mutant_controller_fast", 2},
	},
	pdabroadcast = "Getting multiple strange readings %s... Be very cautious, stalker.",
	difficulty = {23, 31, 32, 33, 35},
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
	difficulty = {25, 33, 35},
}

--[[-------------------------------------------------------------------------
Electric Controller
---------------------------------------------------------------------------]]
PLUGIN.eventdefs["controllerelectric1"] = {
	entities = {
		{"npc_mutant_controller_electro", 1},
	},
	pdabroadcast = "Getting strange readings %s... Take care, stalker.",
	difficulty = {32, 33, 35},
}

--[[-------------------------------------------------------------------------
Karlik
---------------------------------------------------------------------------]]
PLUGIN.eventdefs["karlik1"] = {
	entities = {
		{"npc_mutant_karlik", 1},
	},
	pdabroadcast = "Getting strange readings %s... Take care, stalker.",
	difficulty = {32},
}

PLUGIN.eventdefs["karlik2"] = {
	entities = {
		{"npc_mutant_karlik", 2},
	},
	pdabroadcast = "Getting multiple strange readings %s... Be very cautious, stalker.",
	difficulty = {32},
}

--[[-------------------------------------------------------------------------
Vareshka
---------------------------------------------------------------------------]]
PLUGIN.eventdefs["vareshka1"] = {
	entities = {
		{"npc_mutant_vareshka", 1},
	},
	pdabroadcast = "Vareshka detected %s... Take care, stalker.",
	difficulty = {22},
}

PLUGIN.eventdefs["vareshka2"] = {
	entities = {
		{"npc_mutant_vareshka", 2},
	},
	pdabroadcast = "A pair of Vareshkas has been detected %s... Be very cautious, stalker.",
	difficulty = {22, 31, 32},
}

PLUGIN.eventdefs["vareshka3"] = {
	entities = {
		{"npc_mutant_vareshka", 3},
	},
	pdabroadcast = "Getting information about multiple Vareshkas detected %s... Be extremely very cautious, stalker.",
	difficulty = {31, 32},
}


--[[-------------------------------------------------------------------------
Bear
---------------------------------------------------------------------------]]
-- PLUGIN.eventdefs["bear1"] = {
-- 	entities = {
-- 		{"npc_mutant_bear", 1},
-- 	},
-- 	pdabroadcast = "Huge Bear detected %s, don't get too close, stalker.",
-- 	difficulty = {22, 31},
-- }

-- PLUGIN.eventdefs["bear2"] = {
-- 	entities = {
-- 		{"npc_mutant_bear", 2},
-- 	},
-- 	pdabroadcast = "A pair of Bears has been detected %s, I suggest legging it out of there, stalker.",
-- 	difficulty = {31, 32},
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
	difficulty = {12, 13, 21, 23, 25, 31, 33, 35},
}

PLUGIN.eventdefs["zombievolatile1"] = {
	entities = {
		{"npc_mutant_classiczombie_volatile", 1},
		{"npc_mutant_classiczombie", 3},
	},
	pdabroadcast = "Zombies detected %s... Getting some high radiation readings too. Be careful, stalker.",
	difficulty = {21, 22, 23, 25, 31, 33, 35},
}

PLUGIN.eventdefs["skeleton1"] = {
	entities = {
		{"npc_mutant_skeleton", 2},
	},
	pdabroadcast = "Getting strange readings %s... Take care, stalker.",
	difficulty = {23, 25, 33, 35},
}

PLUGIN.eventdefs["skeleton2"] = {
	entities = {
		{"npc_mutant_skeleton", 3},
		{"npc_mutant_classiczombie", 3},
	},
	pdabroadcast = "Getting strange readings %s... Take care, stalker.",
	difficulty = {23, 25, 33, 35},
}


PLUGIN.eventdefs["hellhound1"] = {
	entities = {
		{"npc_mutant_hellhound", 1},
		{"npc_mutant_dog", 3}
	},
	pdabroadcast = "A small pack of dogs have been spotted %s. I'm also getting increased heat signatures - strange.",
	difficulty = {22, 31, 32},
}


--[[-------------------------------------------------------------------------
Human
---------------------------------------------------------------------------]]

PLUGIN.eventdefs["bandit0"] = {
	entities = {
		{"npc_human_bandit_pistolman", 1},
	},
	pdabroadcast = "Bandit scout spotted %s. Take care.",
	difficulty = {11},
}

PLUGIN.eventdefs["bandit1"] = {
	entities = {
		{"npc_human_bandit_pistolman", 2},
		{"npc_human_bandit_shotgunner", 1}
	},
	pdabroadcast = "Bandits spotted %s. Take care.",
	difficulty = {12, 13, 21, 22, 23},
}

PLUGIN.eventdefs["bandit2"] = {
	entities = {
		{"npc_human_bandit_pistolman", 1},
		{"npc_human_bandit_shotgunner", 1},
		{"npc_human_bandit_rifleman", 2},
	},
	pdabroadcast = "Bandits spotted %s. Take care.",
	difficulty = {12, 13, 21, 22, 23},
}

PLUGIN.eventdefs["bandit3"] = {
	entities = {
		{"npc_human_bandit_pistolman", 3},
		{"npc_human_bandit_rifleman", 2},
	},
	pdabroadcast = "Bandits spotted %s. Take care.",
	difficulty = {12, 13, 21, 22, 23, 25},
}

PLUGIN.eventdefs["banditsniper"] = {
	entities = {
		{"npc_human_bandit_sniper", 1},		
	},
	pdabroadcast = "Bandit sniper spotted %s. Take care.",
	difficulty = {14, 24},
}

PLUGIN.eventdefs["merc1"] = {
	entities = {
		{"npc_human_merc_shotgunner", 1},
		{"npc_human_merc_rifleman", 1},	
	},
	pdabroadcast = "Mercenaries spotted %s. Take care.",
	difficulty = {21, 22, 23, 25, 31, 33},
}

PLUGIN.eventdefs["merc2"] = {
	entities = {
		{"npc_human_merc_pistolman", 1},
		{"npc_human_merc_shotgunner", 1},
		{"npc_human_merc_rifleman", 2},	
	},
	pdabroadcast = "Mercenaries spotted %s. Take care.",
	difficulty = {21, 22, 23, 25, 31, 33},
}

PLUGIN.eventdefs["merc3"] = {
	entities = {
		{"npc_human_merc_pistolman", 3},
		{"npc_human_merc_rifleman", 2},	
	},
	pdabroadcast = "Mercenaries spotted %s. Take care.",
	difficulty = {21, 22, 23, 25, 31, 33},
}

PLUGIN.eventdefs["mercsniper"] = {
	entities = {
		{"npc_human_merc_sniper", 1},	
	},
	pdabroadcast = "Mercenary sniper spotted %s. Take care.",
	difficulty = {24},
}

PLUGIN.eventdefs["mili1"] = {
	entities = {
		{"npc_human_mili_shotgunner", 1},
		{"npc_human_mili_pistolman", 1},	
	},
	pdabroadcast = "Military patrol spotted %s. Take good care.",
	difficulty = {31, 32, 33, 35},
}

PLUGIN.eventdefs["mili2"] = {
	entities = {
		{"npc_human_mili_pistolman", 1},
		{"npc_human_mili_shotgunner", 1},
		{"npc_human_mili_rifleman", 2},	
	},
	pdabroadcast = "Military patrol spotted %s. Take good care.",
	difficulty = {31, 32, 33, 35},
}

PLUGIN.eventdefs["mili3"] = {
	entities = {
		{"npc_human_mili_pistolman", 3},
		{"npc_human_mili_rifleman", 2},	
	},
	pdabroadcast = "Military patrol spotted %s. Take good care.",
	difficulty = {31, 32, 33, 35},
}

-- PLUGIN.eventdefs["milisniper"] = {
-- 	entities = {
-- 		{"npc_human_mili_rifleman", 1}, -- Create real entity.
-- 	},
-- 	pdabroadcast = "Military sniper spotted %s. Take good care.",
-- 	difficulty = {34}, --??
-- }