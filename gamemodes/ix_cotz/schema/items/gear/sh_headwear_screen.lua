ITEM.name = "Screen Helmet"
ITEM.description = "A screen helmet with closed respiratory system."
ITEM.longdesc = "The Screen encloses the head behind a broad visor and connects to a closed respiratory assembly. The complete equipment occupies space beyond the helmet itself. Its emphasis is on environmental protection and a self-contained arrangement, rather than a thick ballistic shell."
ITEM.model = "models/shtokerbox/ground_seva_visor.mdl"

ITEM.price = 100000
ITEM.weight = 4
ITEM.overlayPath = "vgui/overlays/hud_sci"

ITEM.isGasmask = true
ITEM.filterType = "scientific"
ITEM.isHelmet = true

ITEM.br = 0.01
ITEM.fbr = 0
ITEM.sr = 0.01
ITEM.fsr = 0
ITEM.ar = 0
ITEM.far = 0
ITEM.pr = 0.45
ITEM.fpr = 0
ITEM.radProt = 0.98
ITEM.flatRadProt = 0.02

-- Skins follow male_seva's 65 gear finishes; the five original IDs keep their saved choices.
ITEM.appearanceCustomization = {
	targets = {
		{1, 1},
	},
	defaultSkin = "seva_lone",
	worldMaterialSlots = {},
	worldNotice = "Some worn finishes have no matching ground-model surface.",
	skins = {
		{id = "seva_lone", name = "Loner 1", skin = 0, worldSkin = 0},
		{id = "psz9_loner2", name = "Loner 2", skin = 1, worldSkin = 0},
		{id = "psz9_loner3", name = "Loner 3", skin = 2, worldSkin = 0},
		{id = "psz9_loner4", name = "Loner 4", skin = 3, worldSkin = 0},
		{id = "psz9_loner5", name = "Loner 5", skin = 4, worldSkin = 0},
		{id = "psz9_bandit1", name = "Bandit 1", skin = 5, worldSkin = 0},
		{id = "psz9_bandit2", name = "Bandit 2", skin = 6, worldSkin = 0},
		{id = "psz9_clearsky1", name = "Clear Sky 1", skin = 7, worldSkin = 0},
		{id = "psz9_duty1", name = "Duty 1", skin = 8, worldSkin = 0},
		{id = "psz9_duty2", name = "Duty 2", skin = 9, worldSkin = 0},
		{id = "psz9_duty3", name = "Duty 3", skin = 10, worldSkin = 0},
		{id = "psz9_duty4", name = "Duty 4", skin = 11, worldSkin = 0},
		{id = "psz9_ecologist1", name = "Ecologist 1", skin = 12, worldSkin = 0},
		{id = "psz9_ecologist2", name = "Ecologist 2", skin = 13, worldSkin = 0},
		{id = "psz9_ecologist3", name = "Ecologist 3", skin = 14, worldSkin = 0},
		{id = "psz9_ecologist4", name = "Ecologist 4", skin = 15, worldSkin = 0},
		{id = "psz9_freedom1", name = "Freedom 1", skin = 16, worldSkin = 0},
		{id = "psz9_freedom2", name = "Freedom 2", skin = 17, worldSkin = 0},
		{id = "psz9_freedom3", name = "Freedom 3", skin = 18, worldSkin = 0},
		{id = "psz9_freedom4", name = "Freedom 4", skin = 19, worldSkin = 0},
		{id = "psz9_freedom5", name = "Freedom 5", skin = 20, worldSkin = 0},
		{id = "psz9_freedom6", name = "Freedom 6", skin = 21, worldSkin = 0},
		{id = "psz9_freedom7", name = "Freedom 7", skin = 22, worldSkin = 0},
		{id = "psz9_isg1", name = "ISG 1", skin = 23, worldSkin = 0},
		{id = "psz9_military1", name = "Military 1", skin = 24, worldSkin = 0},
		{id = "psz9_military2", name = "Military 2", skin = 25, worldSkin = 0},
		{id = "psz9_monolith1", name = "Monolith 1", skin = 26, worldSkin = 0},
		{id = "psz9_sin1", name = "Sin 1", skin = 27, worldSkin = 0},
		{id = "psz9_sin2", name = "Sin 2", skin = 28, worldSkin = 0},
		{id = "psz9_sin3", name = "Sin 3", skin = 29, worldSkin = 0},
		{id = "seva_loner1", name = "Loner 6", skin = 30, worldSkin = 0},
		{id = "seva_loner2", name = "Loner 7", skin = 31, worldSkin = 0},
		{id = "seva_loner3", name = "Loner 8", skin = 32, worldSkin = 0},
		{id = "seva_loner4", name = "Loner 9", skin = 33, worldSkin = 0},
		{id = "seva_loner5", name = "Loner 10", skin = 34, worldSkin = 0},
		{id = "seva_bandit1", name = "Bandit 3", skin = 35, worldSkin = 0},
		{id = "seva_bandit2", name = "Bandit 4", skin = 36, worldSkin = 0},
		{id = "seva_csky", name = "Clear Sky 2", skin = 37, worldSkin = 0},
		{id = "seva_clearsky2", name = "Clear Sky 3", skin = 38, worldSkin = 0},
		{id = "seva_clearsky3", name = "Clear Sky 4", skin = 39, worldSkin = 0},
		{id = "seva_duty", name = "Duty 5", skin = 40, worldSkin = 0},
		{id = "seva_duty2", name = "Duty 6", skin = 41, worldSkin = 0},
		{id = "seva_duty3", name = "Duty 7", skin = 42, worldSkin = 0},
		{id = "seva_duty4", name = "Duty 8", skin = 43, worldSkin = 0},
		{id = "seva_ecologist1", name = "Ecologist 5", skin = 44, worldSkin = 0},
		{id = "seva_free", name = "Freedom 8", skin = 45, worldSkin = 0},
		{id = "seva_freedom2", name = "Freedom 9", skin = 46, worldSkin = 0},
		{id = "seva_freedom3", name = "Freedom 10", skin = 47, worldSkin = 0},
		{id = "seva_isg1", name = "ISG 2", skin = 48, worldSkin = 0},
		{id = "seva_isg2", name = "ISG 3", skin = 49, worldSkin = 0},
		{id = "seva_isg3", name = "ISG 4", skin = 50, worldSkin = 0},
		{id = "seva_midn", name = "Mercenary 1", skin = 51, worldSkin = 0},
		{id = "seva_merc2", name = "Mercenary 2", skin = 52, worldSkin = 0},
		{id = "seva_merc3", name = "Mercenary 3", skin = 53, worldSkin = 0},
		{id = "seva_merc4", name = "Mercenary 4", skin = 54, worldSkin = 0},
		{id = "seva_merc5", name = "Mercenary 5", skin = 55, worldSkin = 0},
		{id = "seva_merc6", name = "Mercenary 6", skin = 56, worldSkin = 0},
		{id = "seva_military1", name = "Military 3", skin = 57, worldSkin = 0},
		{id = "seva_military2", name = "Military 4", skin = 58, worldSkin = 0},
		{id = "seva_monolith1", name = "Monolith 2", skin = 59, worldSkin = 0},
		{id = "seva_monolith2", name = "Monolith 3", skin = 60, worldSkin = 0},
		{id = "seva_monolith3", name = "Monolith 4", skin = 61, worldSkin = 0},
		{id = "seva_monolith4", name = "Monolith 5", skin = 62, worldSkin = 0},
		{id = "seva_monolith5", name = "Monolith 6", skin = 63, worldSkin = 0},
		{id = "seva_renegade1", name = "Renegade 1", skin = 64, worldSkin = 0},
	},
	bodygroups = {},
}

ITEM.exRender = true
ITEM.iconCam = {
	pos = Vector(0, 0, 200),
	ang = Angle(90, -90, 0),
	fov = 3.85
}


ITEM.pacData = {
	[1] = {
		["children"] = {
			[1] = {
				["children"] = {},
				["self"] = {
					["ClassName"] = "model2",
					["UniqueID"] = "7f3343dbd2881a4aa18f3d870d2a75267b5f98cd5ffe9b2f0b80f62ebb88937b",
					["Model"] = "models/cotz/sectorfour/headwear_screen.mdl",
					["Skin"] = 0,
					["BoneMerge"] = true,
					["Bone"] = "head",
					["Position"] = Vector(0, 0, 0),
					["Angles"] = Angle(0, 0, 0),
					["Scale"] = Vector(1, 1, 1),
					["Size"] = 1,
					["Translucent"] = true,
					["Alpha"] = 1,
					["Color"] = Vector(1, 1, 1),
					["Brightness"] = 1,
				},
			},
		},
		["self"] = {
			["ClassName"] = "group",
			["UniqueID"] = "fb9f0fb1ee92ca3e7681ef966ffa58b68e1cf72b7b8f1114fb71f767bd7dc85e",
			["Name"] = "new",
			["OwnerName"] = "self",
		},
	},
}
