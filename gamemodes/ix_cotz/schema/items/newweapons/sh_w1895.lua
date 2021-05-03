ITEM.name = "Winchester 1895"
ITEM.description= "A classic lever-action rifle. Fires 7.62x54mmR."
ITEM.longdesc = "A modified version of the Winchester rifle. It is a traditional lever-action with exposed hammer, straight grip, tube magazine and barrel bands.\n\nAmmo: 7.62x54mmR\nMagazine Capacity: 5"
ITEM.model = ("models/weapons/w_rif_win1895.mdl")
ITEM.class = "cw_w1895"
ITEM.weaponCategory = "primary"
ITEM.price = 17500
ITEM.width = 6
ITEM.height = 1
ITEM.canAttach = false

ITEM.bulletweight = 0.022
ITEM.unloadedweight = 4.2

ITEM.repair_PartsComplexity = 3
ITEM.repair_PartsRarity = 3

function ITEM:GetWeight()
  return self.unloadedweight + (self.bulletweight * self:GetData("ammo", 0))
end

ITEM.iconCam = {
	pos = Vector(4, -205, -1.7999999523163),
	ang = Angle(0, 90, 0),
	fov = 15.5,
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
						["Position"] = Vector(-14.65, -0.247, -9.327),
						["Model"] = "models/weapons/w_rif_win1895.mdl",
						["ClassName"] = "model",
						["EditorExpand"] = true,
						["UniqueID"] = "85445421",
						["Bone"] = "chest",
						["Name"] = "w1895",
						["AngleOffset"] = Angle(200, 0, 0),
					},
				},
			},
			["self"] = {
				["AffectChildrenOnly"] = true,
				["ClassName"] = "event",
				["UniqueID"] = "1055553672",
				["Event"] = "weapon_class",
				["EditorExpand"] = true,
				["Name"] = "weapon class find simple\"@@1\"",
				["Arguments"] = "cw_w1895@@0",
			},
		},
	},
	["self"] = {
		["ClassName"] = "group",
		["UniqueID"] = "81241483",
		["EditorExpand"] = true,
	},
},
}