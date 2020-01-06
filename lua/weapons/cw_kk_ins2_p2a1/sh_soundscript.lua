
local function shell(wep)
	if SERVER then return end

	wep:shellEventReload()
end

SWEP.Sounds = {
	base_ready = {
		{time = 0, sound = "CW_KK_INS2_UNIVERSAL_PISTOL_DRAW"},
		{time = 19/30, sound = "CW_KK_INS2_P2A1_COCKHAMMER"},
	},

	base_draw = {
		{time = 0, sound = "CW_KK_INS2_UNIVERSAL_PISTOL_DRAW"},
	},

	base_holster = {
		{time = 0, sound = "CW_KK_INS2_UNIVERSAL_PISTOL_HOLSTER"},
	},

	base_crawl = {
		{time = 0, sound = "CW_KK_INS2_UNIVERSAL_LEFTCRAWL"},
		{time = 22/35, sound = "CW_KK_INS2_UNIVERSAL_RIGHTCRAWL"},
	},

	base_dryfire = {
		{time = 0, sound = "CW_KK_INS2_P2A1_EMPTY"},
	},

	base_reload = {
		{time = 18/30, sound = "CW_KK_INS2_P2A1_OPENBARREL"},
		{time = 39/30, sound = "CW_KK_INS2_P2A1_REMOVEFLARE"},
		{time = 45/30, sound = "", callback = shell},
		-- {time = 61/30, sound = "CW_KK_INS2_P2A1_FlareDrop"},
		{time = 75/30, sound = "CW_KK_INS2_P2A1_INSERTFLARESTART"},
		{time = 90/30, sound = "CW_KK_INS2_P2A1_INSERTFLARE"},
		{time = 113/30, sound = "CW_KK_INS2_P2A1_CLOSEBARREL"},
		{time = 129/30, sound = "CW_KK_INS2_P2A1_COCKHAMMER"},
	},

	empty_draw = {
		{time = 0, sound = "CW_KK_INS2_UNIVERSAL_PISTOL_DRAW"},
	},

	empty_holster = {
		{time = 0, sound = "CW_KK_INS2_UNIVERSAL_PISTOL_HOLSTER"},
	},

	empty_crawl = {
		{time = 0, sound = "CW_KK_INS2_UNIVERSAL_LEFTCRAWL"},
		{time = 22/35, sound = "CW_KK_INS2_UNIVERSAL_RIGHTCRAWL"},
	},

	iron_dryfire = {
		{time = 0, sound = "CW_KK_INS2_P2A1_EMPTY"},
	},
}
