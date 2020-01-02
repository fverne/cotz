ITEM.name = "PKM"
ITEM.description= "A large machinegun. Fires 7.62x54mm."
ITEM.longdesc = "The PK is a 7.62x54mm general-purpose machine gun designed in the Soviet Union and currently in production in Russia.\nThe original PK machine gun was introduced in 1961 and then the improved PKM in 1969 to replace the SGM and RP-46 machine guns in Soviet service.\nIt remains in use as a front-line infantry and vehicle-mounted weapon with Russia's armed forces.\nThe PK has been exported extensively and produced in several other countries under license.\n\nAmmo: 7.62x54mm \nMagazine Capacity: 200"
ITEM.model = ("models/weapons/w_mach_pkmbenis.mdl")
ITEM.class = "cw_pkm"
ITEM.weaponCategory = "primary"
ITEM.width = 6
ITEM.price = 100000 -- price me daddy uwu
ITEM.height = 2
ITEM.flag = "0"
ITEM.repairCost = ITEM.price/100*1
ITEM.validAttachments = {"md_microt1","md_eotech","md_aimpoint","md_cmore","md_reflex","md_pbs1"}
ITEM.Range = 150
ITEM.RoF = "S/3/6"
ITEM.Dmg = "1d10+5"
ITEM.Pen = 18
ITEM.Mag = 100
ITEM.Rld = "2 Ready"
ITEM.Special = "Long, Braced"

ITEM.iconCam = {
	pos = Vector(-9.1999998092651, 32, 2),
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
						["Position"] = Vector(-8.946, -3.987, 12.214),
						["Model"] = "models/weapons/w_mach_pkmbenis.mdl",
						["ClassName"] = "model",
						["EditorExpand"] = true,
						["UniqueID"] = "7923894673",
						["Bone"] = "chest",
						["Name"] = "pkm",
					},
				},
			},
			["self"] = {
				["AffectChildrenOnly"] = true,
				["ClassName"] = "event",
				["UniqueID"] = "1237573522",
				["Event"] = "weapon_class",
				["EditorExpand"] = true,
				["Name"] = "weapon class find simple\"@@1\"",
				["Arguments"] = "cw_pkm@@0",
			},
		},
	},
	["self"] = {
		["ClassName"] = "group",
		["UniqueID"] = "2787236348",
		["EditorExpand"] = true,
	},
},
}