PLUGIN.categoryDefs = 
{
	["barrel_easy"] = {
		appearTime = 600, -- Will be present for 600 +/- 10% of time
		disappearTime = 10800, -- Will then be missing for 10800 +/- 10%
		allowedStashTypes = {
			"pistol_lo",
			"pistol_mi",
			"shotgun_lo",
			"ammo_cache_rifle_1",
			"ammo_cache_pistol_3",
			"ammo_cache_shotgun_1",
			"consumable_cache",
			"consumable_valueable_cache",
			"valueable_cache_artifact_3"
		}
	},
	["barrel_hard"] = {
		appearTime = 300,
		disappearTime = 16200,
		allowedStashTypes = {
			"contender",
			"pistol_mi",
			"pistol_hi",
			"shotgun_hi",
			"ammo_cache_pistol_1",
			"ammo_cache_shotgun_2",
			"ammo_cache_assorted",
			"assorted_cache_1",
			"assorted_cache_2",
			"consumable_cache",
			"consumable_valueable_cache",
			"valueable_cache_1",
			"valueable_cache_2",
			"valueable_cache_artifact_1",
			"valueable_cache_artifact_2",
			"valueable_cache_artifact_3"
		}
	},
	["cache_easy"] = {
		appearTime = 600,
		disappearTime = 15600,
		allowedStashTypes = {
			"weapons_cache_1",
			"ammo_cache_pistol_1",
			"ammo_cache_pistol_2",
			"ammo_cache_shotgun_2",
			"assorted_cache_1",
			"assorted_cache_2",
			"consumable_cache",
			"consumable_valueable_cache",
			"valueable_cache_1",
			"valueable_cache_artifact_2",
			"valueable_cache_artifact_3",
			"contender"
		}
	},
	["cache_hard"] = {
		appearTime = 600,
		disappearTime = 21500,
		allowedStashTypes = {
			"weapons_cache_1",
			"weapons_cache_2",
			"ammo_cache_pistol_2",
			"ammo_cache_rifle_2",
			"ammo_cache_shotgun_2",
			"assorted_cache_1",
			"assorted_cache_2",
			"consumable_cache",
			"consumable_valueable_cache",
			"valueable_cache_1",
			"valueable_cache_2",
			"valueable_cache_klondike",
			"valueable_cache_artifact_1",
			"valueable_cache_artifact_2"
		}
	},
	["cache_cbt"] = {
		appearTime = 300,
		disappearTime = 25000,
		allowedStashTypes = {
			"weapons_cache_1",
			"weapons_cache_2",
			"assorted_cache_1",
			"assorted_cache_2",
			"consumable_valueable_cache",
			"valueable_cache_1",
			"valueable_cache_2",
			"valueable_cache_klondike",
			"valueable_cache_artifact_1",
			"valueable_cache_artifact_2"
		}
	},
}