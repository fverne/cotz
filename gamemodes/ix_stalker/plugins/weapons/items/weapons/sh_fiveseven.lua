ITEM.name = "Five-Seven"
ITEM.description= "A polymer-framed pistol chambered for 5.7x28mm."
ITEM.longdesc = "The FiveSeven and its iconic cartridge, the FN 5.7x28mm, was designed to replace the aging 9x19mm cartridge.\nThe cartridge sports excellent penetration power and impressively tight groupings.\nThe FiveSeven pistol has a staggering magazine capacity of 20 rounds, however acquiring it in the Zone is fairly tough and will cost you dearly, as will supplying the pistol with ammunition.\n\nAmmo: 5.7x28mm\nMagazine Capacity: 20"
ITEM.model = "models/weapons/ethereal/w_fiveseven.mdl"
ITEM.class = "cw_kk_ins2_fiveseven"
ITEM.weaponCategory = "secondary"
ITEM.width = 2
ITEM.price = 15000
ITEM.height = 1
--ITEM.busflag = {"ARMS1_1", "SPECIAL1"}
ITEM.repairCost = ITEM.price/100*1
ITEM.Range = 50
ITEM.RoF = "S/3/-"
ITEM.Dmg = "1d10"
ITEM.Pen = 14
ITEM.Mag = 20
ITEM.Rld = "Ready"
ITEM.Special = "CQC"
ITEM.isCW = true
ITEM.isPLWeapon = true
ITEM.modifier = 5

ITEM.iconCam = {
	pos = Vector(-2.5999999046326, 10, 3.5),
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
						["Model"] = "models/weapons/w_pist_fiveseven.mdl",
						["ClassName"] = "model",
						["Position"] = Vector(-7.221, 2.695, -3.742),
						["AngleOffset"] = Angle(0, -10.5, 0),
						["EditorExpand"] = true,
						["UniqueID"] = "3544603835",
						["Bone"] = "pelvis",
						["Name"] = "five7",
						["Angles"] = Angle(0, 270, 0),
					},
				},
			},
			["self"] = {
				["AffectChildrenOnly"] = true,
				["ClassName"] = "event",
				["UniqueID"] = "1087768762",
				["Event"] = "weapon_class",
				["EditorExpand"] = true,
				["Name"] = "weapon class find simple\"@@1\"",
				["Arguments"] = "cw_fiveseven@@0",
			},
		},
	},
	["self"] = {
		["ClassName"] = "group",
		["UniqueID"] = "1197387467",
		["EditorExpand"] = true,
	},
},
}