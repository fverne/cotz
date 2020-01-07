
local function shell(wep)
	if SERVER then return end

	wep:shellEvent()
end

SWEP.Sounds = {
	base_ready = {
		{time = 0, sound = "CW_KK_INS2_UNIVERSAL_DRAW"},
		{time = 19/25, sound = "CW_KK_INS2_M40A1_BOLTRELEASE"},
		{time = 24/25, sound = "CW_KK_INS2_M40A1_BOLTBACK"},
		{time = 33/25, sound = "CW_KK_INS2_M40A1_BOLTFORWARD"},
		{time = 38/25, sound = "CW_KK_INS2_M40A1_BOLTLATCH"},
		{time = 56/25, sound = "CW_KK_INS2_UNIVERSAL_LEANIN"},
	},

	base_draw = {
		{time = 0, sound = "CW_KK_INS2_UNIVERSAL_DRAW"},
	},

	base_holster = {
		{time = 0, sound = "CW_KK_INS2_UNIVERSAL_HOLSTER"},
	},

	base_crawl = {
		{time = 0, sound = "CW_KK_INS2_UNIVERSAL_LEFTCRAWL"},
		{time = 22/30, sound = "CW_KK_INS2_UNIVERSAL_RIGHTCRAWL"},
	},

	base_fire_end = {
		{time = 7/30, sound = "CW_KK_INS2_M40A1_BOLTRELEASE"},
		{time = 13/30, sound = "CW_KK_INS2_M40A1_BOLTBACK"},
		{time = 15/30, sound = "", callback = shell},
		{time = 24/30, sound = "CW_KK_INS2_M40A1_BOLTFORWARD"},
		// pumpedrdy @ 26 ""},
		{time = 28/30, sound = "CW_KK_INS2_M40A1_BOLTLATCH"},
	},

	base_dryfire = {
		{time = 0, sound = "CW_KK_INS2_M40A1_EMPTY"},
	},

	base_reload_start = {
		{time = 5/30, sound = "CW_KK_INS2_M40A1_BOLTRELEASE"},
		{time = 11/30, sound = "CW_KK_INS2_M40A1_BOLTBACK"},
		{time = 15/30, sound = "", callback = shell},
	},

	base_reload_insert = {
		{time = 12/32, sound = "CW_KK_INS2_M40A1_BULLETIN"},
		// reloaded @ 12 ""},
	},

	base_reload_end = {
		{time = 6/30, sound = "CW_KK_INS2_M40A1_BOLTFORWARD"},
		{time = 11/30, sound = "CW_KK_INS2_M40A1_BOLTLATCH"},
	},

	base_reload_end_empty = {
		{time = 6/30, sound = "CW_KK_INS2_M40A1_BOLTFORWARD"},
		{time = 11/30, sound = "CW_KK_INS2_M40A1_BOLTLATCH"},
	},

	iron_fire_end = {
		{time = 11/28.5, sound = "CW_KK_INS2_M40A1_BOLTRELEASE"},
		{time = 15/28.5, sound = "CW_KK_INS2_M40A1_BOLTBACK"},
		{time = 17/28.5, sound = "", callback = shell},
		{time = 23/28.5, sound = "CW_KK_INS2_M40A1_BOLTFORWARD"},
		// pumpedrdy @ 27 ""},
		{time = 27/28.5, sound = "CW_KK_INS2_M40A1_BOLTLATCH"},
		{time = 45/28.5, sound = "CW_KK_INS2_UNIVERSAL_LEANIN"},
	},

	iron_dryfire = {
		{time = 0, sound = "CW_KK_INS2_M40A1_EMPTY"},
	},

	deploy_in = {
		{time = 12/20, sound = "CW_KK_INS2_UNIVERSAL_BIPOD_DEPLOYSTART"},
		{time = 16/20, sound = "CW_KK_INS2_UNIVERSAL_BIPOD_DEPLOYEND"},
	},

	deploy_out = {
		{time = 6/20, sound = "CW_KK_INS2_UNIVERSAL_BIPOD_RETRACT"},
	},

	deployed_fire_end = {
		{time = 7/30, sound = "CW_KK_INS2_M40A1_BOLTRELEASE"},
		{time = 13/30, sound = "CW_KK_INS2_M40A1_BOLTBACK"},
		{time = 18/30, sound = "", callback = shell},
		{time = 24/30, sound = "CW_KK_INS2_M40A1_BOLTFORWARD"},
		// pumpedrdy @ 26 ""},
		{time = 28/30, sound = "CW_KK_INS2_M40A1_BOLTLATCH"},
	},

	deployed_dryfire = {
		{time = 0, sound = "CW_KK_INS2_M40A1_EMPTY"},
	},

	deployed_reload_start = {
		{time = 5/30, sound = "CW_KK_INS2_M40A1_BOLTRELEASE"},
		{time = 11/30, sound = "CW_KK_INS2_M40A1_BOLTBACK"},
		{time = 15/30, sound = "", callback = shell},
	},

	deployed_reload_insert = {
		{time = 8/30, sound = "CW_KK_INS2_M40A1_BULLETIN"},
		// reloaded @ 12 ""},
	},

	deployed_reload_end = {
		{time = 6/30, sound = "CW_KK_INS2_M40A1_BOLTFORWARD"},
		{time = 11/30, sound = "CW_KK_INS2_M40A1_BOLTLATCH"},
	},

	deployed_iron_fire_end = {
		{time = 7/34, sound = "CW_KK_INS2_M40A1_BOLTRELEASE"},
		{time = 13/34, sound = "CW_KK_INS2_M40A1_BOLTBACK"},
		{time = 16/34, sound = "", callback = shell},
		{time = 24/34, sound = "CW_KK_INS2_M40A1_BOLTFORWARD"},
		// pumpedrdy @ 26 ""},
		{time = 28/34, sound = "CW_KK_INS2_M40A1_BOLTLATCH"},
	},

	deployed_iron_dryfire = {
		{time = 0, sound = "CW_KK_INS2_M40A1_EMPTY"},
	},
}
