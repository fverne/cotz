ITEM.name = "Mauser C96 Carbine"
ITEM.description= "A semi-automatic pistol that was originally produced by German arms manufacturer Mauser from 1896 to 1937."
ITEM.longdesc = "It has a few distinctive characteristics, mainly the integral box magazine in front of the trigger, \nthe long barrel and an iconic grip shaped like the handle of a broom.\nWith its long barrel and high-velocity cartridge, the Mauser C96 had superior range and better penetration than most other pistols of its era.\nThis is a special carbine version with a larger detachable magazine, longer barrel and shoulder stock. It also has the select-fire capability.\n\nAmmo: 7.62x25mm\nMagazine Capacity: 20"
ITEM.model = "models/khrcw2/doipack/w_c96c.mdl"
ITEM.class = "cw_c96carbine"
ITEM.weaponCategory = "primary"
ITEM.width = 4
ITEM.price = 1000
ITEM.height = 1
ITEM.busflag = {"guns1_1"}
ITEM.repairCost = ITEM.price/100*1
ITEM.canAttach = true
ITEM.validAttachments = {"md_rmr","md_tundra9mm"}


ITEM.exRender = true
ITEM.iconCam = {
	pos = Vector(-8, 215.68627929688, 4),
	ang = Angle(0, 270, 4.7058825492859),
	fov = 5,
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
						["Model"] = "models/khrcw2/doipack/w_c96c.mdl",
						["ClassName"] = "model",
						["Position"] = Vector(-7.5, 2.993, -1.955),
						["AngleOffset"] = Angle(0, -10.5, 0),
						["EditorExpand"] = true,
						["UniqueID"] = "1256334613251",
						["Bone"] = "pelvis",
						["Name"] = "c96",
						["Angles"] = Angle(0, 180, 0),
					},
				},
			},
			["self"] = {
				["AffectChildrenOnly"] = true,
				["ClassName"] = "event",
				["UniqueID"] = "24624654235",
				["Event"] = "weapon_class",
				["EditorExpand"] = true,
				["Name"] = "weapon class find simple\"@@1\"",
				["Arguments"] = "cw_c96carbine@@0",
			},
		},
	},
	["self"] = {
		["ClassName"] = "group",
		["UniqueID"] = "15315134235",
		["EditorExpand"] = true,
	},
},
}