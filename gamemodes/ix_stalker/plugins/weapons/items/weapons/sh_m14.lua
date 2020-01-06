ITEM.name = "M14 EBR"
ITEM.description= "A modernized M14 battle rifle. Fires 7.62x51mm."
ITEM.longdesc = "The Mk 14 Enhanced Battle Rifle (EBR) is an American selective fire military designated marksman rifle chambered for the 7.62×51mm NATO cartridge.\nIt is a variant of the M14 battle rifle and was originally built for use with units of the United States Special Operations Command, such as the United States Navy SEALs, Delta Force, and task specific ODA units.\nThe EBRs are made with the intention of carrying out both designated marksman and CQB roles in combat.\n\nAmmo: 7.62x51mm \nMagazine Capacity: 20"
ITEM.model = "models/weapons/ethereal/w_m14.mdl"
ITEM.class = "cw_kk_ins2_m14"
ITEM.weaponCategory = "primary"
ITEM.width = 5
ITEM.price = 100000 -- price me daddy uwu
ITEM.height = 2
--ITEM.busflag = "ARMS1_2_1_1"
ITEM.repairCost = ITEM.price/100*1
ITEM.Range = 150
ITEM.RoF = "S/2/4"
ITEM.Dmg = "1d10+5"
ITEM.Pen = 18
ITEM.Mag = 20
ITEM.Rld = "Ready"
ITEM.isCW = true
ITEM.isPLWeapon = true
ITEM.modifier = 5

ITEM.iconCam = {
	pos = Vector(-11.5, 27.5, 1.5),
	ang = Angle(0, 270, 0),
	fov = 70
}

ITEM.pacData = {
[1] = {
	["children"] = {
		[1] = {
			["children"] = {
				[1] = {
					["children"] = {
					},
					["self"] = {
						["Angles"] = Angle(74.21875, -177.46875, -96.1875),
						["Position"] = Vector(-7.746, -3.287, 12.214),
						["Model"] = "models/weapons/w_cstm_m14.mdl",
						["ClassName"] = "model",
						["EditorExpand"] = true,
						["UniqueID"] = "7946894673",
						["Bone"] = "chest",
						["Name"] = "m14",
					},
				},
			},
			["self"] = {
				["AffectChildrenOnly"] = true,
				["ClassName"] = "event",
				["UniqueID"] = "1237473522",
				["Event"] = "weapon_class",
				["EditorExpand"] = true,
				["Name"] = "weapon class find simple\"@@1\"",
				["Arguments"] = "cw_m14@@0",
			},
		},
	},
	["self"] = {
		["ClassName"] = "group",
		["UniqueID"] = "2787896348",
		["EditorExpand"] = true,
	},
},
}