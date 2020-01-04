ITEM.name = "Fort-12"
ITEM.description= "A semi-automatic pistol chambered for 9x18mm."
ITEM.longdesc = "An Ukranian-made service pistol that has been adopted by many east-block countries.\nAlmost as common as the PMm and is more popular due to its larger magazine capacity.\n\nAmmo: 9x18mm\nMagazine Capacity: 12"
ITEM.model = "models/srp/weapons/w_fort12.mdl"
ITEM.class = "cw_fort12"
ITEM.weaponCategory = "secondary"
ITEM.width = 2
ITEM.price = 2000
ITEM.height = 1
ITEM.busflag = {"guns1_1"}
ITEM.repairCost = ITEM.price/100*1
ITEM.validAttachments = {"md_microt1","md_eotech","md_rmr","md_tundra9mm"}
ITEM.Range = 30
ITEM.RoF = "S/3/-"
ITEM.Dmg = "1d10+1"
ITEM.Pen = 4
ITEM.Mag = 12
ITEM.Rld = "Ready"
ITEM.Special = "CQC, Subsonic"

ITEM.iconCam = {
	pos = Vector(-6, 8.5, 1.3999999761581),
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
						["Model"] = "models/srp/weapons/w_fort12.mdl",
						["ClassName"] = "model",
						["Position"] = Vector(-7.69, 8.579, -0.722),
						["AngleOffset"] = Angle(0, -10.5, 0),
						["EditorExpand"] = true,
						["UniqueID"] = "3540503835",
						["Bone"] = "pelvis",
						["Name"] = "fort12",
						["Angles"] = Angle(0, 270, 0),
					},
				},
			},
			["self"] = {
				["AffectChildrenOnly"] = true,
				["ClassName"] = "event",
				["UniqueID"] = "1640768762",
				["Event"] = "weapon_class",
				["EditorExpand"] = true,
				["Name"] = "weapon class find simple\"@@1\"",
				["Arguments"] = "cw_fort12@@0",
			},
		},
	},
	["self"] = {
		["ClassName"] = "group",
		["UniqueID"] = "1170487467",
		["EditorExpand"] = true,
	},
},
}