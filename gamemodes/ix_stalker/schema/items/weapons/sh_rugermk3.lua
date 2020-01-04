ITEM.name = "Ruger MKIII"
ITEM.description= "An internally silenced target practice pistol chambered for .22LR."
ITEM.longdesc = "The Ruger Mark III is a .22 Long Rifle semi-automatic pistol manufactured by Sturm, Ruger & Company.\nIt is the successor to the Ruger MK II, and includes several new features.\n\nAmmo: .22LR\nMagazine Capacity: 10"
ITEM.model = ("models/weapons/w_pist_ruger23a1.mdl")
ITEM.class = "cw_rugermk3"
ITEM.weaponCategory = "secondary"
ITEM.width = 2
ITEM.price = 1000
ITEM.height = 1
ITEM.busflag = {"guns"}
ITEM.repairCost = ITEM.price/100*1
ITEM.Range = 30
ITEM.RoF = "S/-/-"
ITEM.Dmg = "1d10"
ITEM.Pen = 0
ITEM.Mag = 9
ITEM.Rld = "Ready"
ITEM.Special = "CQC, Subsonic"

ITEM.canAttach = false
ITEM.iconCam = {
	pos = Vector(2, -10, -1.5),
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
						["Model"] = "models/weapons/w_pist_ruger23a1.mdl",
						["ClassName"] = "model",
						["Position"] = Vector(-7.5, 0.10999999940395, 2.4000000953674),
						["AngleOffset"] = Angle(0, -10.5, 0),
						["EditorExpand"] = true,
						["UniqueID"] = "3543276351",
						["Bone"] = "pelvis",
						["Name"] = "ruger",
						["Angles"] = Angle(0, 90, 0),
					},
				},
			},
			["self"] = {
				["AffectChildrenOnly"] = true,
				["ClassName"] = "event",
				["UniqueID"] = "1532812402",
				["Event"] = "weapon_class",
				["EditorExpand"] = true,
				["Name"] = "weapon class find simple\"@@1\"",
				["Arguments"] = "cw_rugermk3@@0",
			},
		},
	},
	["self"] = {
		["ClassName"] = "group",
		["UniqueID"] = "8358321183",
		["EditorExpand"] = true,
	},
},
}