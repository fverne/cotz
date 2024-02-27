ITEM.name = "Defender of Anarchists"
ITEM.model = "models/kek1ch/exolight_outfit.mdl"
ITEM.newModel = "models/stalkerisaac/playermodel/male_01_radsuit.mdl"
ITEM.description= "An armored exoskeleton suit"
ITEM.longdesc = "TODO"

ITEM.width = 2
ITEM.height = 3
ITEM.img = ix.util.GetMaterial("vgui/hud/radsuit.png")
ITEM.weight = 32.50
ITEM.newSkin = 14
ITEM.baseSuit = "suit_exoskeleton"

ITEM.price = 1810200
ITEM.repairCost = ITEM.price/100*1 -- cost to repair from 0% durability

ITEM.isGasmask = false
ITEM.isHelmet = false

ITEM.br = 0.45
ITEM.fbr = 5
ITEM.sr = 0.81
ITEM.fsr = 5
ITEM.ar = 0.27
ITEM.far = 3

ITEM.carryinc = 64.000
ITEM.miscslots = 3



-- ITEM.skincustom[1] = {
-- 	name = "Skin 0",
-- 	skingroup = 0,
-- }
-- ITEM.skincustom[2] = {
-- 	name = "Skin 1",
-- 	skingroup = 1,
-- }
-- ITEM.skincustom[3] = {
-- 	name = "Skin 2",
-- 	skingroup = 2,
-- }
-- ITEM.skincustom[4] = {
-- 	name = "Skin 3",
-- 	skingroup = 3,
-- }
-- ITEM.skincustom[5] = {
-- 	name = "Skin 4",
-- 	skingroup = 4,
-- }
-- ITEM.skincustom[6] = {
-- 	name = "Skin 5",
-- 	skingroup = 5,
-- }
-- ITEM.skincustom[7] = {
-- 	name = "Skin 6",
-- 	skingroup = 6,
-- }
-- ITEM.skincustom[8] = {
-- 	name = "Skin 7",
-- 	skingroup = 7,
-- }
-- ITEM.skincustom[9] = {
-- 	name = "Skin 8",
-- 	skingroup = 8,
-- }
-- ITEM.skincustom[10] = {
-- 	name = "Skin 9",
-- 	skingroup = 9,
-- }
-- ITEM.skincustom[11] = {
-- 	name = "Skin 10",
-- 	skingroup = 10,
-- }
-- ITEM.skincustom[12] = {
-- 	name = "Skin 11",
-- 	skingroup = 11,
-- }
-- ITEM.skincustom[13] = {
-- 	name = "Skin 12",
-- 	skingroup = 12,
-- }
-- ITEM.skincustom[14] = {
-- 	name = "Skin 13",
-- 	skingroup = 13,
-- }
ITEM.skincustom[15] = {
	name = "Skin 14",
	skingroup = 14,
}
ITEM.skincustom[16] = {
	name = "Skin 15",
	skingroup = 15,
}
-- ITEM.skincustom[17] = {
-- 	name = "Skin 16",
-- 	skingroup = 16,
-- }
-- ITEM.skincustom[18] = {
-- 	name = "Skin 17",
-- 	skingroup = 17,
-- }
-- ITEM.skincustom[19] = {
-- 	name = "Skin 18",
-- 	skingroup = 18,
-- }
-- ITEM.skincustom[20] = {
-- 	name = "Skin 19",
-- 	skingroup = 19,
-- }
-- ITEM.skincustom[21] = {
-- 	name = "Skin 20",
-- 	skingroup = 20,
-- }
-- ITEM.skincustom[22] = {
-- 	name = "Skin 21",
-- 	skingroup = 21,
-- }
-- ITEM.skincustom[23] = {
-- 	name = "Skin 22",
-- 	skingroup = 22,
-- }

ITEM.pacData = {
	[1] = {
		["children"] = {
			[1] = {
				["children"] = {
				},
				["self"] = {
					["UniqueID"] = "exoskeleton1_1",
					["Skin"] = 11,
					["BoneMerge"] = true,
					["Model"] = "models/shtokerbox/outfits/male_outfit_sunrise_overlay_exo.mdl",
					["ClassName"] = "model",
				},
			},
		},
		["self"] = {
			["ClassName"] = "group",
			["UniqueID"] = "exoskeleton1",
			["EditorExpand"] = true,
		},
	},
}