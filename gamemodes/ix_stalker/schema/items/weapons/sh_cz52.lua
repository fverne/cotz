﻿ITEM.name = "CZ-52"
ITEM.description= "A semi-automatic pistol chambered for 7.62x25mm."
ITEM.longdesc = "The CZ 52 pistol is a roller-locked short recoil–operated, detachable box magazine–fed, single-action, semi-automatic pistol chambered for the 7.62×25mm Tokarev cartridge.\nIt is popular against armor as it can handle hotter rounds, meaning better muzzle velocity.\nIts magazine capacity is what many stalkers complain about, since its tiny 8 round magazine means much more reloading.\n\nAmmo: 7.62x25mm\nMagazine Capacity: 8"
ITEM.model = "models/weapons/w_pist_cz52.mdl"
ITEM.class = "cw_cz52"
ITEM.weaponCategory = "secondary"
ITEM.width = 2
ITEM.price = 2500
ITEM.height = 1
ITEM.busflag = {"guns1"}
ITEM.repairCost = ITEM.price/100*1
ITEM.validAttachments = {"md_microt1","md_eotech","md_rmr","md_tundra9mm"}
ITEM.Range = 30
ITEM.RoF = "S/3/-"
ITEM.Dmg = "1d10+1"
ITEM.Pen = 6
ITEM.Mag = 8
ITEM.Rld = "Ready"
ITEM.Special = "CQC"

ITEM.iconCam = {
	pos = Vector(0.40000000596046, -10, -2),
	ang = Angle(0, 90, 0),
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
						["Model"] = "models/weapons/w_pist_cz52.mdl",
						["ClassName"] = "model",
						["Position"] = Vector(-7.5, 2.084, 0.609),
						["AngleOffset"] = Angle(0, -10.5, 0),
						["EditorExpand"] = true,
						["UniqueID"] = "3544642191",
						["Bone"] = "pelvis",
						["Name"] = "cz52",
						["Angles"] = Angle(0, 90, 0),
					},
				},
			},
			["self"] = {
				["AffectChildrenOnly"] = true,
				["ClassName"] = "event",
				["UniqueID"] = "1087632402",
				["Event"] = "weapon_class",
				["EditorExpand"] = true,
				["Name"] = "weapon class find simple\"@@1\"",
				["Arguments"] = "cw_cz52@@0",
			},
		},
	},
	["self"] = {
		["ClassName"] = "group",
		["UniqueID"] = "1118387613",
		["EditorExpand"] = true,
	},
},
}