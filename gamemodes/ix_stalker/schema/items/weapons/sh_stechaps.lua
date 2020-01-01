ITEM.name = "Stechkin APS"
ITEM.description= "A fully-automatic handgun with a large magazine. Fires 9x18mm."
ITEM.longdesc = "When the Stetchkin automatic pistol was phased out of Soviet army service, a few hundred mysteriously made their way into the Zone.\nIt's low weight of 1.2 kilograms, fully automatic capacity and concealability makes it an useful alternative to a submachinegun.\nIts 750 rounds per minute firerate makes the recoil an issue.\n\nAmmo: 9x18mm \nMagazine Capacity: 20"
ITEM.model = "models/weapons/w_ma85_wf_pt10.mdl"
ITEM.class = "cw_stechaps"
ITEM.weaponCategory = "secondary"
ITEM.width = 2
ITEM.price =  7500
ITEM.height = 1
--ITEM.busflag = "ARMS2_1_1"
ITEM.repairCost = ITEM.price/100*1
ITEM.validAttachments = {"md_tundra9mm"}

ITEM.iconCam = {
	pos = Vector(-10, 4.5, -2.4000000953674),
	ang = Angle(0, -0, 0),
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
						["Model"] = "models/weapons/w_ma85_wf_pt10.mdl",
						["ClassName"] = "model",
						["Position"] = Vector(-7.5, 2.993, -1.955),
						["AngleOffset"] = Angle(0, -10.5, 0),
						["EditorExpand"] = true,
						["UniqueID"] = "3532329835",
						["Bone"] = "pelvis",
						["Name"] = "makarov",
						["Angles"] = Angle(0, 180, 0),
					},
				},
			},
			["self"] = {
				["AffectChildrenOnly"] = true,
				["ClassName"] = "event",
				["UniqueID"] = "1640777222",
				["Event"] = "weapon_class",
				["EditorExpand"] = true,
				["Name"] = "weapon class find simple\"@@1\"",
				["Arguments"] = "cw_stechaps@@0",
			},
		},
	},
	["self"] = {
		["ClassName"] = "group",
		["UniqueID"] = "1915262467",
		["EditorExpand"] = true,
	},
},
}