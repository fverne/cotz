
local function shell(wep)
	if SERVER then return end

	wep:shellEvent()
end

SWEP.Sounds = {
	base_draw = {
		{time = 0, sound = "CW_KK_INS2_UNIVERSAL_DRAW"},
	},

	base_holster = {
		{time = 0, sound = "CW_KK_INS2_UNIVERSAL_HOLSTER"},
	},

	base_ready = {
		{time = 0, sound = "CW_KK_INS2_UNIVERSAL_DRAW"},
		{time = 19/25, sound = "CW_KK_INS2_MOSIN_BOLTRELEASE"},
		{time = 24/25, sound = "CW_KK_INS2_MOSIN_BOLTBACK"},
		{time = 33/25, sound = "CW_KK_INS2_MOSIN_BOLTFORWARD"},
		{time = 38/25, sound = "CW_KK_INS2_MOSIN_BOLTLATCH"},
		{time = 56/25, sound = "CW_KK_INS2_UNIVERSAL_LEANIN"},
	},

	base_crawl = {
		{time = 0, sound = "CW_KK_INS2_UNIVERSAL_LEFTCRAWL"},
		{time = 22/30, sound = "CW_KK_INS2_UNIVERSAL_RIGHTCRAWL"},
	},

	base_fire_end = {
		// shell @ 15 ""},
		{time = 8/30, sound = "CW_KK_INS2_MOSIN_BOLTRELEASE"},
		{time = 13/30, sound = "CW_KK_INS2_MOSIN_BOLTBACK"},
		{time = 14/30, sound = "", callback = shell},
		{time = 24/30, sound = "CW_KK_INS2_MOSIN_BOLTFORWARD"},
		{time = 28/30, sound = "CW_KK_INS2_MOSIN_BOLTLATCH"},
	},

	base_dryfire = {
		{time = 0, sound = "CW_KK_INS2_MOSIN_EMPTY"},
	},

	reload_start = {
		// shell @ 15 "MOSIN EJECT"},
		{time = 4/30, sound = "CW_KK_INS2_MOSIN_BOLTRELEASE"},
		{time = 10/30, sound = "CW_KK_INS2_MOSIN_BOLTBACK"},
		{time = 15/30, sound = "", callback = shell},
	},

	reload_insert = {
		{time = 8/30, sound = "CW_KK_INS2_MOSIN_BULLETIN"},
		// reloaded @ 14 ""},
	},

	reload_end = {
		{time = 7/30, sound = "CW_KK_INS2_MOSIN_BOLTFORWARD"},
		{time = 11/30, sound = "CW_KK_INS2_MOSIN_BOLTLATCH"},
	},

	iron_fire_end = {
		// shell @ 17 ""},
		{time = 11/28.5, sound = "CW_KK_INS2_MOSIN_BOLTRELEASE"},
		{time = 15/28.5, sound = "CW_KK_INS2_MOSIN_BOLTBACK"},
		{time = 19/28.5, sound = "", callback = shell},
		{time = 25/28.5, sound = "CW_KK_INS2_MOSIN_BOLTFORWARD"},
		// pumpedrdy @ 27 ""},
		{time = 29/28.5, sound = "CW_KK_INS2_MOSIN_BOLTLATCH"},
		{time = 45/28.5, sound = "CW_KK_INS2_UNIVERSAL_LEANIN"},
	},

	iron_dryfire = {
		{time = 0, sound = "CW_KK_INS2_MOSIN_EMPTY"},
	},

	deployed_in = {
		{time = 12/20, sound = "CW_KK_INS2_UNIVERSAL_BIPOD_DEPLOYSTART"},
		{time = 16/20, sound = "CW_KK_INS2_UNIVERSAL_BIPOD_DEPLOYEND"},
	},

	deployed_out = {
		{time = 6/20, sound = "CW_KK_INS2_UNIVERSAL_BIPOD_RETRACT"},
	},

	deployed_fire_end = {
		// shell @ 15 ""},
		{time = 8/30, sound = "CW_KK_INS2_MOSIN_BOLTRELEASE"},
		{time = 13/30, sound = "CW_KK_INS2_MOSIN_BOLTBACK"},
		{time = 21/30, sound = "", callback = shell},
		{time = 24/30, sound = "CW_KK_INS2_MOSIN_BOLTFORWARD"},
		{time = 28/30, sound = "CW_KK_INS2_MOSIN_BOLTLATCH"},
	},

	deployed_dryfire = {
		{time = 0, sound = "CW_KK_INS2_MOSIN_EMPTY"},
	},

	deployed_reload_start = {
		// shell @ 15 ""},
		{time = 4/30, sound = "CW_KK_INS2_MOSIN_BOLTRELEASE"},
		{time = 10/30, sound = "CW_KK_INS2_MOSIN_BOLTBACK"},
		{time = 15/30, sound = "", callback = shell},
	},

	deployed_reload_insert = {
		{time = 8/30, sound = "CW_KK_INS2_MOSIN_BULLETIN"},
		// reloaded @ 12 ""},
	},

	deployed_reload_end = {
		{time = 7/30, sound = "CW_KK_INS2_MOSIN_BOLTFORWARD"},
		{time = 11/30, sound = "CW_KK_INS2_MOSIN_BOLTLATCH"},
	},

	iron_fire_deployed_end = {
		// shell @ 15 ""},
		{time = 8/34, sound = "CW_KK_INS2_MOSIN_BOLTRELEASE"},
		{time = 13/34, sound = "CW_KK_INS2_MOSIN_BOLTBACK"},
		{time = 19/34, sound = "", callback = shell},
		{time = 24/34, sound = "CW_KK_INS2_MOSIN_BOLTFORWARD"},
		{time = 28/34, sound = "CW_KK_INS2_MOSIN_BOLTLATCH"},
	},

	iron_dryfire_deployed = {
		{time = 0, sound = "CW_KK_INS2_MOSIN_EMPTY"},
	},
}
