ITEM.name = "M1887"
ITEM.description= "A lever-action shotgun firing 12 gauge shells."
ITEM.longdesc = "PLACEHOLDER.\n\nAmmo: 12 Gauge \nMagazine Capacity: 6"
ITEM.model = ("models/weapons/w_shot_m1887.mdl")
ITEM.class = "cw_m1887"
ITEM.weaponCategory = "primary"
ITEM.price = 8000
ITEM.width = 4
ITEM.height = 1
ITEM.busflag = {"guns2_1"}
ITEM.repairCost = ITEM.price/100*1
ITEM.canAttach = false

ITEM.bulletweight = 0.031
ITEM.unloadedweight = 3.3

function ITEM:GetWeight()
  return self.unloadedweight + (self.bulletweight * self:GetData("ammo", 0))
end

ITEM.iconCam = {
	pos = Vector(12, -205, 2),
	ang = Angle(0, 90, 4.7058825492859),
	fov = 10,
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
						["Angles"] = Angle(62.727, 107.588, 8.727),
						["Position"] = Vector(-10.144, -3.047, -4.744),
						["Model"] = "models/weapons/w_shot_m1887.mdl",
						["ClassName"] = "model",
						["EditorExpand"] = true,
						["UniqueID"] = "8592533121",
						["Bone"] = "chest",
						["Name"] = "1887",
						["AngleOffset"] = Angle(200, 0, 0),
					},
				},
			},
			["self"] = {
				["AffectChildrenOnly"] = true,
				["ClassName"] = "event",
				["UniqueID"] = "1452356542",
				["Event"] = "weapon_class",
				["EditorExpand"] = true,
				["Name"] = "weapon class find simple\"@@1\"",
				["Arguments"] = "cw_m1887@@0",
			},
		},
	},
	["self"] = {
		["ClassName"] = "group",
		["UniqueID"] = "81242253283",
		["EditorExpand"] = true,
	},
},
}