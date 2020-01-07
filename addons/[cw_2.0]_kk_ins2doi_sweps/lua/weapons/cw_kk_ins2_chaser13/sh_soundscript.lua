
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
		{time = 26/30, sound = "CW_KK_INS2_M590_PUMPBACK"},
		{time = 36/30, sound = "CW_KK_INS2_M590_PUMPFORWARD"},
	},

	base_crawl = {
		{time = 15/30, sound = "CW_KK_INS2_UNIVERSAL_RIGHTCRAWL"},
		{time = 38/30, sound = "CW_KK_INS2_UNIVERSAL_LEFTCRAWL"},
	},

	base_fire_cock_1 = {
		{time = 1/24, sound = "CW_KK_INS2_M590_PUMPBACK"},
		{time = 2/24, sound = "", callback = shell},
		{time = 5/24, sound = "CW_KK_INS2_M590_PUMPFORWARD"},
		// pumpedrdy @ 6 ""},
	},

	base_fire_cock_2 = {
		{time = 1/24, sound = "CW_KK_INS2_M590_PUMPBACK"},
		{time = 2/24, sound = "", callback = shell},
		{time = 5/24, sound = "CW_KK_INS2_M590_PUMPFORWARD"},
		// pumpedrdy @ 6 ""},
	},

	base_dryfire = {
		{time = 0, sound = "CW_KK_INS2_M590_EMPTY"},
	},

	base_reload_start = {
		{time = 5/30, sound = "CW_KK_INS2_UNIVERSAL_LEANIN"},
	},

	base_reload_start_empty = {
		{time = 5/35, sound = "CW_KK_INS2_UNIVERSAL_LEANIN"},
		{time = 18/35, sound = "CW_KK_INS2_M590_PUMPBACK"},
		{time = 20/35, sound = "", callback = shell},
		{time = 51/35, sound = "CW_KK_INS2_M590_SHELLINSERTSINGLE"},
		{time = 76/35, sound = "CW_KK_INS2_M590_PUMPFORWARD"},
		// reloaded @ 78 ""},
	},

	base_reload_insert = {
		{time = 5/36, sound = "CW_KK_INS2_M590_SHELLINSERT"},
		// reloaded @ 15 ""},
	},

	base_reload_end = {
		{time = 5/35, sound = "CW_KK_INS2_UNIVERSAL_LEANIN"},
	},

	base_reload_end_empty = {
		{time = 5/35, sound = "CW_KK_INS2_UNIVERSAL_LEANIN"},
	},

	iron_fire_cock_1 = {
		{time = 3/35, sound = "CW_KK_INS2_M590_PUMPBACK"},
		{time = 4/35, sound = "", callback = shell},
		{time = 11/35, sound = "CW_KK_INS2_M590_PUMPFORWARD"},
		// pumpedrdy @ 12 ""},
	},

	iron_fire_cock_2 = {
		{time = 3/35, sound = "CW_KK_INS2_M590_PUMPBACK"},
		{time = 4/35, sound = "", callback = shell},
		{time = 11/35, sound = "CW_KK_INS2_M590_PUMPFORWARD"},
		// pumpedrdy @ 12 ""},
	},

	iron_dryfire = {
		{time = 0, sound = "CW_KK_INS2_M590_EMPTY"},
	},

	foregrip_draw = {
		{time = 0, sound = "CW_KK_INS2_UNIVERSAL_DRAW"},
	},

	foregrip_holster = {
		{time = 0, sound = "CW_KK_INS2_UNIVERSAL_HOLSTER"},
	},

	foregrip_ready = {
		{time = 0, sound = "CW_KK_INS2_UNIVERSAL_DRAW"},
		{time = 26/30, sound = "CW_KK_INS2_M590_PUMPBACK"},
		{time = 36/30, sound = "CW_KK_INS2_M590_PUMPFORWARD"},
	},

	foregrip_crawl = {
		{time = 0, sound = "CW_KK_INS2_UNIVERSAL_LEFTCRAWL"},
		{time = 22/30, sound = "CW_KK_INS2_UNIVERSAL_RIGHTCRAWL"},
	},

	foregrip_fire_cock_1 = {
		{time = 1/24, sound = "CW_KK_INS2_M590_PUMPBACK"},
		{time = 2/24, sound = "", callback = shell},
		{time = 5/24, sound = "CW_KK_INS2_M590_PUMPFORWARD"},
		// pumpedrdy @ 6 ""},
	},

	foregrip_fire_cock_2 = {
		{time = 1/24, sound = "CW_KK_INS2_M590_PUMPBACK"},
		{time = 2/24, sound = "", callback = shell},
		{time = 5/24, sound = "CW_KK_INS2_M590_PUMPFORWARD"},
		// pumpedrdy @ 6 ""},
	},

	foregrip_dryfire = {
		{time = 0, sound = "CW_KK_INS2_M590_EMPTY"},
	},

	foregrip_reload_start = {
		{time = 5/30, sound = "CW_KK_INS2_UNIVERSAL_LEANIN"},
	},

	foregrip_reload_start_empty = {
		{time = 5/35, sound = "CW_KK_INS2_UNIVERSAL_LEANIN"},
		{time = 18/35, sound = "CW_KK_INS2_M590_PUMPBACK"},
		{time = 20/35, sound = "", callback = shell},
		{time = 51/35, sound = "CW_KK_INS2_M590_SHELLINSERTSINGLE"},
		{time = 76/35, sound = "CW_KK_INS2_M590_PUMPFORWARD"},
		// reloaded @ 78 ""},
	},

	foregrip_reload_insert = {
		{time = 5/36, sound = "CW_KK_INS2_M590_SHELLINSERT"},
		// reloaded @ 15 ""},
	},

	foregrip_reload_end = {
		{time = 5/35, sound = "CW_KK_INS2_UNIVERSAL_LEANIN"},
	},

	foregrip_reload_end_empty = {
		{time = 5/35, sound = "CW_KK_INS2_UNIVERSAL_LEANIN"},
	},

	foregrip_iron_fire_cock_1 = {
		{time = 3/35, sound = "CW_KK_INS2_M590_PUMPBACK", callback = shell},
		{time = 11/35, sound = "CW_KK_INS2_M590_PUMPFORWARD"},
		// pumpedrdy @ 12 ""},
	},

	foregrip_iron_fire_cock_2 = {
		{time = 3/35, sound = "CW_KK_INS2_M590_PUMPBACK", callback = shell},
		{time = 11/35, sound = "CW_KK_INS2_M590_PUMPFORWARD"},
		// pumpedrdy @ 12 ""},
	},

	foregrip_iron_dryfire = {
		{time = 0, sound = "CW_KK_INS2_M590_EMPTY"},
	},
}
