
local function shells(self)
	if SERVER then return end

	local vm = self.CW_VM
	local b = vm:GetBodygroup(self._beltBGID)
	local s = vm:GetBodygroup(self._shellsBGID)

	for _ = 1, (s - b) do
		self:shellEventRev()
	end
end

SWEP.Sounds = {
	base_ready = {
		{time = 0, sound = "CW_KK_INS2_UNIVERSAL_PISTOL_DRAW"},
		{time = 27/28, sound = "CW_KK_INS2_REVOLVER_OPENCHAMBER"},
		{time = 46/28, sound = "CW_KK_INS2_REVOLVER_CLOSECHAMBER"},
	},

	base_draw = {
		{time = 0, sound = "CW_KK_INS2_UNIVERSAL_PISTOL_DRAW"},
	},

	base_holster = {
		{time = 0, sound = "CW_KK_INS2_UNIVERSAL_PISTOL_HOLSTER"},
	},

	base_crawl = {
		{time = 0, sound = "CW_KK_INS2_UNIVERSAL_LEFTCRAWL"},
		{time = 22/30, sound = "CW_KK_INS2_UNIVERSAL_RIGHTCRAWL"},
	},

	base_fire = {
		{time = 0, sound = "CW_KK_INS2_REVOLVER_COCKHAMMER"},
	},

	base_fire2 = {
		{time = 0, sound = "CW_KK_INS2_REVOLVER_COCKHAMMER"},
	},

	base_dryfire = {
		{time = 0, sound = "CW_KK_INS2_REVOLVER_COCKHAMMER"},
		{time = 4/30, sound = "CW_KK_INS2_REVOLVER_EMPTY"},
	},

	base_reload_start = {
		{time = 0, sound = "", callback = CustomizableWeaponry_KK.ins2.bulletBgs.beltToClip},
		{time = 1/33.5, sound = "CW_KK_INS2_UNIVERSAL_LEANIN"},
		{time = 24/33.5, sound = "CW_KK_INS2_REVOLVER_OPENCHAMBER"},
		{time = 51/33.5, sound = "CW_KK_INS2_REVOLVER_DUMPROUNDS"},
		{time = 54/33.5, sound = "", callback = shells},
		{time = 58/33.5, sound = "", callback = CustomizableWeaponry_KK.ins2.bulletBgs.shellsToClip},
	},

	base_reload_insert = {
		{time = 0, sound = "", callback = CustomizableWeaponry_KK.ins2.bulletBgs.bothToClipP1},
		{time = 6/34.6, sound = "CW_KK_INS2_REVOLVER_INSERTSINGLE"},
		{time = 18/34.6, sound = "CW_KK_INS2_UNIVERSAL_LEANIN"},
	},

	base_reload_end = {
		{time = 6/34.5, sound = "CW_KK_INS2_UNIVERSAL_LEANOUT"},
		{time = 37/34.5, sound = "CW_KK_INS2_REVOLVER_CLOSECHAMBER"},
	},

	base_reload_speed = {
		{time = 0, sound = "", callback = CustomizableWeaponry_KK.ins2.bulletBgs.beltToClip},
		{time = 1/33.5, sound = "CW_KK_INS2_UNIVERSAL_LEANIN"},
		{time = 24/33.5, sound = "CW_KK_INS2_REVOLVER_OPENCHAMBER"},
		{time = 51/33.5, sound = "CW_KK_INS2_REVOLVER_DUMPROUNDS"},
		{time = 54/33.5, sound = "", callback = shells},
		{time = 60/33.5, sound = "", callback = CustomizableWeaponry_KK.ins2.bulletBgs.shellsToClip},
		{time = 65/33.5, sound = "", callback = CustomizableWeaponry_KK.ins2.bulletBgs.bothToReserve},
		{time = 81/33.5, sound = "CW_KK_INS2_REVOLVER_SPEEDLOADERINSERT"},
		{time = 113/33.5, sound = "CW_KK_INS2_REVOLVER_CLOSECHAMBER"},
	},

	iron_fire = {
		{time = 0, sound = "CW_KK_INS2_REVOLVER_COCKHAMMER"},
	},

	iron_dryfire = {
		{time = 0, sound = "CW_KK_INS2_REVOLVER_COCKHAMMER"},
		{time = 4/30, sound = "CW_KK_INS2_REVOLVER_EMPTY"},
	},
}
