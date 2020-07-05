ITEM.name = "TOZ BM-16 Sawnoff"
ITEM.description= "A sawn-off hunting shotgun. Fires 12 gauge."
ITEM.longdesc = "This sawn-off double barrelled shotgun is a must-have in many rookies eyes.\nIt dispatches mutants and unarmored stalkers with ease, and is cheap to keep supplied with ammo.\n\nAmmo: 12 Gauge \nMagazine Capacity: 2"
ITEM.model = ("models/weapons/w_sawnoff.mdl")
ITEM.class = "cw_shawedoff"
ITEM.weaponCategory = "secondary"
ITEM.price = 4400
ITEM.width = 3
ITEM.height = 1
ITEM.busflag = {"guns2"}
ITEM.repairCost = ITEM.price/100*1
ITEM.canAttach = false

ITEM.bulletweight = 0.031
ITEM.unloadedweight = 1.54

function ITEM:GetWeight()
  return self.unloadedweight + (self.bulletweight * self:GetData("ammo", 0))
end

ITEM.iconCam = {
	pos = Vector(-0.80000001192093, -205, -2),
	ang = Angle(0, 90, 0),
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
						["Model"] = "models/weapons/w_sawnoff.mdl",
						["ClassName"] = "model",
						["Position"] = Vector(-7.89, -1.128, 3.612),
						["EditorExpand"] = true,
						["UniqueID"] = "3976837955",
						["Bone"] = "pelvis",
						["Name"] = "sawnoff",
						["Angles"] = Angle(0, 270, -30),
					},
				},
			},
			["self"] = {
				["AffectChildrenOnly"] = true,
				["ClassName"] = "event",
				["UniqueID"] = "1643489682",
				["Event"] = "weapon_class",
				["EditorExpand"] = true,
				["Name"] = "weapon class find simple\"@@1\"",
				["Arguments"] = "cw_shawedoff@@0",
			},
		},
	},
	["self"] = {
		["ClassName"] = "group",
		["UniqueID"] = "1954394367",
		["EditorExpand"] = true,
	},
},
}