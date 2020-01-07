ITEM.name = "Sten Gun MKII"
ITEM.description= "An old pipe-like submachinegun. Fires 9x19mm."
ITEM.longdesc = "The Sten Gun was introduced when the British army was facing a shortage of submachineguns from the US.\nIt was made with stamped metal and minimal welding to minimize price, this naturally brought some side effects onto the table.\nThe gun is uncomfortable to hold and has a rather unsafe safety.\nHowever, it's a formidable cheap weapon that shoots bullets where you point it.\nThis one is a Mark 2 model, it weighs about 3.2 kilograms unloaded and is all metal. It fires 600 rounds per minute.\n\nAmmo: 9x19mm\nMagazine Capacity: 32"
ITEM.model = ("models/weapons/w_smg_ste.mdl")
ITEM.class = "cw_sten"
ITEM.weaponCategory = "primary"
ITEM.width = 3
ITEM.price = 15000
ITEM.height = 2
ITEM.busflag = {"guns3"}
ITEM.repairCost = ITEM.price/100*1
ITEM.Range = 50
ITEM.RoF = "S/3/6"
ITEM.Dmg = "1d10+3"
ITEM.Pen = 6
ITEM.Mag = 30
ITEM.Rld = "Ready"
ITEM.Special = "Short"
ITEM.isCW = true
ITEM.isPLWeapon = true
ITEM.modifier = 5
ITEM.weight = 3.2

ITEM.iconCam = {
	pos = Vector(0, 200, 0),
	ang = Angle(0, 270, 0),
	fov = 12.777777777778
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
						["Position"] = Vector(-8.965, -5.017, 1.394),
						["Model"] = "models/weapons/w_smg_ste.mdl",
						["ClassName"] = "model",
						["EditorExpand"] = true,
						["UniqueID"] = "8883945391",
						["Bone"] = "chest",
						["Name"] = "sten",
						["AngleOffset"] = Angle(0, 0, 90),
						["Scale"] = Vector(0.69999998807907, 0.69999998807907, 0.69999998807907),
					},
				},
			},
			["self"] = {
				["AffectChildrenOnly"] = true,
				["ClassName"] = "event",
				["UniqueID"] = "1058846402",
				["Event"] = "weapon_class",
				["EditorExpand"] = true,
				["Name"] = "weapon class find simple\"@@1\"",
				["Arguments"] = "cw_sten@@0",
			},
		},
	},
	["self"] = {
		["ClassName"] = "group",
		["UniqueID"] = "8132882183",
		["EditorExpand"] = true,
	},
},
}