ITEM.name = "SVT 40"
ITEM.description= "A semi-automatic battle rifle that fires 7.62x54mm rounds."
ITEM.longdesc = "The SVT-40 is a Soviet semi-automatic battle rifle.\nThe SVT-40 saw widespread service during and after World War II.\nAfter the war, SVTs were mostly withdrawn from service and refurbished in arsenals, then stored.\nMany of these storages have since then been found, and black market operatives have ensured a steady influx of SVT-40's to the zone.\n\nAmmo: 7.62x54mm\nMagazine Capacity: 10"
ITEM.model = ("models/weapons/w_svt40.mdl")
ITEM.class = "cw_svt40"
ITEM.weaponCategory = "primary"
ITEM.width = 6
ITEM.price = 23000
ITEM.height = 2
--ITEM.busflag = "ARMS2_4_1"
ITEM.repairCost = ITEM.price/100*1
ITEM.validAttachments = {"md_pso1","md_pbs1"}

ITEM.iconCam = {
	pos = Vector(-3, -32, 1),
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
						["Angles"] = Angle(0, 0, 180),
						["Position"] = Vector(3.44, -5.078, -2.039),
						["Model"] = "models/weapons/w_svt40.mdl",
						["ClassName"] = "model",
						["EditorExpand"] = true,
						["UniqueID"] = "8824425421",
						["Bone"] = "spine 2",
						["Name"] = "svt40",
					},
				},
			},
			["self"] = {
				["AffectChildrenOnly"] = true,
				["ClassName"] = "event",
				["UniqueID"] = "1062346542",
				["Event"] = "weapon_class",
				["EditorExpand"] = true,
				["Name"] = "weapon class find simple\"@@1\"",
				["Arguments"] = "cw_svt40@@0",
			},
		},
	},
	["self"] = {
		["ClassName"] = "group",
		["UniqueID"] = "8123985183",
		["EditorExpand"] = true,
	},
},
}