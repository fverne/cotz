
local function m203(wep)
	if SERVER then return end

	wep:shellEvent203()
end

SWEP.Sounds = {
	animchktst = {
		{time = 0, sound = "CW_KK_INS2_UNIVERSAL_DRAW"},
	},

	base_ready = {
		{time = 0, sound = "CW_KK_INS2_UNIVERSAL_DRAW"},
		{time = 17/30, sound = "CW_KK_INS2_M16A4_BOLTBACK"},
		{time = 26/30, sound = "CW_KK_INS2_M16A4_BOLTRELEASE"},
	},

	base_draw = {
		{time = 0, sound = "CW_KK_INS2_UNIVERSAL_DRAW"},
	},

	base_holster = {
		{time = 0, sound = "CW_KK_INS2_UNIVERSAL_HOLSTER"},
	},

	base_dryfire = {
		{time = 0, sound = "CW_KK_INS2_M16A4_EMPTY"},
	},

	base_fireselect = {
		{time = 8/30, sound = "CW_KK_INS2_M16A4_FIRESELECT"},
	},

	base_reload = {
		{time = 16/30, sound = "CW_KK_INS2_M16A4_MAGRELEASE"},
		{time = 17/30, sound = "CW_KK_INS2_M16A4_MAGOUT"},
		{time = 71/30, sound = "CW_KK_INS2_M16A4_MAGIN"},
		{time = 87/30, sound = "CW_KK_INS2_M16A4_HIT"},
	},

	base_reloadempty = {
		{time = 16/30, sound = "CW_KK_INS2_M16A4_MAGRELEASE"},
		{time = 17/30, sound = "CW_KK_INS2_M16A4_MAGOUT"},
		{time = 71/30, sound = "CW_KK_INS2_M16A4_MAGIN"},
		{time = 87/30, sound = "CW_KK_INS2_M16A4_HIT"},
		{time = 112/30, sound = "CW_KK_INS2_M16A4_BOLTRELEASE"},
	},

	iron_dryfire = {
		{time = 0, sound = "CW_KK_INS2_M16A4_EMPTY"},
	},

	iron_fireselect = {
		{time = 8/30, sound = "CW_KK_INS2_M16A4_FIRESELECT"},
	},

	foregrip_ready = {
		{time = 0, sound = "CW_KK_INS2_UNIVERSAL_DRAW"},
		{time = 17/30, sound = "CW_KK_INS2_M16A4_BOLTBACK"},
		{time = 26/30, sound = "CW_KK_INS2_M16A4_BOLTRELEASE"},
	},

	foregrip_draw = {
		{time = 0, sound = "CW_KK_INS2_UNIVERSAL_DRAW"},
	},

	foregrip_holster = {
		{time = 0, sound = "CW_KK_INS2_UNIVERSAL_HOLSTER"},
	},

	foregrip_dryfire = {
		{time = 0, sound = "CW_KK_INS2_M16A4_EMPTY"},
	},

	foregrip_fireselect = {
		{time = 8/30, sound = "CW_KK_INS2_M16A4_FIRESELECT"},
	},

	foregrip_iron_dryfire = {
		{time = 0, sound = "CW_KK_INS2_M16A4_EMPTY"},
	},

	foregrip_iron_fireselect = {
		{time = 8/30, sound = "CW_KK_INS2_M16A4_FIRESELECT"},
	},

	foregrip_reload = {
		{time = 16/30, sound = "CW_KK_INS2_M16A4_MAGRELEASE"},
		{time = 17/30, sound = "CW_KK_INS2_M16A4_MAGOUT"},
		{time = 71/30, sound = "CW_KK_INS2_M16A4_MAGIN"},
		{time = 87/30, sound = "CW_KK_INS2_M16A4_HIT"},
	},

	foregrip_reloadempty = {
		{time = 16/30, sound = "CW_KK_INS2_M16A4_MAGRELEASE"},
		{time = 17/30, sound = "CW_KK_INS2_M16A4_MAGOUT"},
		{time = 71/30, sound = "CW_KK_INS2_M16A4_MAGIN"},
		{time = 87/30, sound = "CW_KK_INS2_M16A4_HIT"},
		{time = 112/30, sound = "CW_KK_INS2_M16A4_BOLTRELEASE"},
	},

	deployed_in = {
		{time = 16/30, sound = "CW_KK_INS2_UNIVERSAL_BIPOD_DEPLOYSTART"},
		{time = 23/30, sound = "CW_KK_INS2_UNIVERSAL_BIPOD_DEPLOYEND"},
	},

	deployed_out = {
		{time = 7/30, sound = "CW_KK_INS2_UNIVERSAL_BIPOD_RETRACT"},
	},

	deployed_dryfire = {
		{time = 0, sound = "CW_KK_INS2_M16A4_EMPTY"},
	},

	deployed_fireselect = {
		{time = 8/24, sound = "CW_KK_INS2_M16A4_FIRESELECT"},
	},

	deployed_reload_half = {
		{time = 16/30, sound = "CW_KK_INS2_M16A4_MAGRELEASE"},
		{time = 17/30, sound = "CW_KK_INS2_M16A4_MAGOUT"},
		{time = 71/30, sound = "CW_KK_INS2_M16A4_MAGIN"},
		{time = 87/30, sound = "CW_KK_INS2_M16A4_HIT"},
	},

	deployed_reload_empty = {
		{time = 16/30, sound = "CW_KK_INS2_M16A4_MAGRELEASE"},
		{time = 17/30, sound = "CW_KK_INS2_M16A4_MAGOUT"},
		{time = 71/30, sound = "CW_KK_INS2_M16A4_MAGIN"},
		{time = 87/30, sound = "CW_KK_INS2_M16A4_HIT"},
		{time = 112/30, sound = "CW_KK_INS2_M16A4_BOLTRELEASE"},
	},

	deployed_iron_dryfire = {
		{time = 0, sound = "CW_KK_INS2_M16A4_EMPTY"},
	},

	deployed_iron_fireselect = {
		{time = 8/24, sound = "CW_KK_INS2_M16A4_FIRESELECT"},
	},

	gl_ready = {
		{time = 0, sound = "CW_KK_INS2_UNIVERSAL_DRAW"},
		{time = 17/30, sound = "CW_KK_INS2_M16A4_BOLTBACK"},
		{time = 26/30, sound = "CW_KK_INS2_M16A4_BOLTRELEASE"},
	},

	gl_draw = {
		{time = 0, sound = "CW_KK_INS2_UNIVERSAL_DRAW"},
	},

	gl_holster = {
		{time = 0, sound = "CW_KK_INS2_UNIVERSAL_HOLSTER"},
	},

	gl_dryfire = {
		{time = 0, sound = "CW_KK_INS2_M16A4_EMPTY"},
	},

	gl_fireselect = {
		{time = 8/30, sound = "CW_KK_INS2_M16A4_FIRESELECT"},
	},

	gl_reload = {
		{time = 16/30, sound = "CW_KK_INS2_M16A4_MAGRELEASE"},
		{time = 17/30, sound = "CW_KK_INS2_M16A4_MAGOUT"},
		{time = 71/30, sound = "CW_KK_INS2_M16A4_MAGIN"},
		{time = 87/30, sound = "CW_KK_INS2_M16A4_HIT"},
	},

	gl_reloadempty = {
		{time = 16/30, sound = "CW_KK_INS2_M16A4_MAGRELEASE"},
		{time = 17/30, sound = "CW_KK_INS2_M16A4_MAGOUT"},
		{time = 71/30, sound = "CW_KK_INS2_M16A4_MAGIN"},
		{time = 87/30, sound = "CW_KK_INS2_M16A4_HIT"},
		{time = 112/30, sound = "CW_KK_INS2_M16A4_BOLTRELEASE"},
	},

	gl_iron_dryfire = {
		{time = 0, sound = "CW_KK_INS2_M16A4_EMPTY"},
	},

	gl_iron_fireselect = {
		{time = 8/30, sound = "CW_KK_INS2_M16A4_FIRESELECT"},
	},

	glsetup_in = {
		{time = 0, sound = "CW_KK_INS2_M203_SELECT"},
	},

	glsetup_out = {
		{time = 0, sound = "CW_KK_INS2_M203_DESELECT"},
	},

	glsetup_ready = {
		{time = 0, sound = "CW_KK_INS2_UNIVERSAL_DRAW"},
	},

	glsetup_draw = {
		{time = 0, sound = "CW_KK_INS2_UNIVERSAL_DRAW"},
	},

	glsetup_holster = {
		{time = 0, sound = "CW_KK_INS2_UNIVERSAL_HOLSTER"},
	},

	glsetup_dryfire = {
		{time = 0, sound = "CW_KK_INS2_M203_EMPTY"},
	},

	glsetup_reload = {
		{time = 0/30, sound = "CW_KK_INS2_GL_BEGINRELOAD"},
		{time = 23/30, sound = "CW_KK_INS2_M203_OPENBARREL"},
		{time = 32/30, sound = "", callback = m203},
		{time = 57/30, sound = "CW_KK_INS2_M203_INSERTGRENADE"},
		-- {time = 44/30, sound = "CW_KK_INS2_m203_GrenadeDrop"},
		{time = 84/30, sound = "CW_KK_INS2_M203_CLOSEBARREL"},
	},

	glsetup_iron_dryfire = {
		{time = 0, sound = "CW_KK_INS2_M203_EMPTY"},
	},

	base_crawl = {
		{time = 0/30, sound = "CW_KK_INS2_UNIVERSAL_LEFTCRAWL"},
		{time = 22/30, sound = "CW_KK_INS2_UNIVERSAL_RIGHTCRAWL"},
	},

	foregrip_crawl = {
		{time = 0/30, sound = "CW_KK_INS2_UNIVERSAL_LEFTCRAWL"},
		{time = 22/30, sound = "CW_KK_INS2_UNIVERSAL_RIGHTCRAWL"},
	},

	gl_crawl = {
		{time = 0/30, sound = "CW_KK_INS2_UNIVERSAL_LEFTCRAWL"},
		{time = 22/30, sound = "CW_KK_INS2_UNIVERSAL_RIGHTCRAWL"},
	},

	glsetup_crawl = {
		{time = 0/30, sound = "CW_KK_INS2_UNIVERSAL_LEFTCRAWL"},
		{time = 22/30, sound = "CW_KK_INS2_UNIVERSAL_RIGHTCRAWL"},
	},

}
