
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
		{time = 10/30, sound = "CW_KK_INS2_TOZ_BREAKCLOSE"}, -- Changes Needed
	},

	base_crawl = {
		{time = 15/30, sound = "CW_KK_INS2_UNIVERSAL_RIGHTCRAWL"},
		{time = 38/30, sound = "CW_KK_INS2_UNIVERSAL_LEFTCRAWL"},
	},

	base_dryfire = {
		{time = 0, sound = "CW_KK_INS2_M590_EMPTY"},
	},
	
	base_reload = {
		{time = 10/35, sound = "CW_KK_INS2_TOZ_BREAKOPEN"},
		{time = 35/35, sound = "CW_KK_INS2_TOZ_SHELLEJECT1"},
		{time = 40/35, sound = "CW_KK_INS2_TOZ_SHELLGRAB1"},
		{time = 90/35, sound = "CW_KK_INS2_TOZ_SHELLINSERT1"},
		{time = 125/35, sound = "CW_KK_INS2_TOZ_BREAKCLOSE"},
	},
	
	base_reloadempty = {
		{time = 10/35, sound = "CW_KK_INS2_TOZ_BREAKOPEN"},
		{time = 40/35, sound = "CW_KK_INS2_TOZ_SHELLSEJECT"},
		{time = 105/35, sound = "CW_KK_INS2_TOZ_SHELLINSERT1"},
		{time = 135/35, sound = "CW_KK_INS2_TOZ_SHELLINSERT2"},
		{time = 175/35, sound = "CW_KK_INS2_TOZ_BREAKCLOSE"},
	},

	iron_dryfire = {
		{time = 0, sound = "CW_KK_INS2_M590_EMPTY"},
	},
}
