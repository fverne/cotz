ITEM.name = "Mossberg 500"
ITEM.description= "A 12 gauge pump-action shotgun. Seems modern."
ITEM.longdesc = "The Mossberg 500 is one of the most popular smooth-bore pump action shotguns in the world.\nA low price and an inherently reliable design makes it a good choice for hunters and police officers alike.\n\nAmmo: 12 Gauge\nMagazine Capacity: 6"
ITEM.model = "models/weapons/w_shot_mossberg5.mdl"
ITEM.class = "cw_mossberg500"
ITEM.weaponCategory = "primary"
ITEM.width = 4
ITEM.price = 10200
ITEM.height = 1
ITEM.canAttach = false

ITEM.bulletweight = 0.031
ITEM.unloadedweight = 3.1

ITEM.repair_PartsComplexity = 2
ITEM.repair_PartsRarity = 2

function ITEM:GetWeight()
  return self.unloadedweight + (self.bulletweight * self:GetData("ammo", 0))
end

ITEM.iconCam = {
	pos = Vector(2, 200, 0.5),
	ang = Angle(0, 270, 5),
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
						["Angles"] = Angle(0, 0, 180),
						["Position"] = Vector(-2.502, -4.31, -2.254),
						["Model"] = "models/weapons/w_shot_mossberg5.mdl",
						["ClassName"] = "model",
						["EditorExpand"] = true,
						["UniqueID"] = "78798794673",
						["Bone"] = "spine 2",
						["Name"] = "moss500",
					},
				},
			},
			["self"] = {
				["AffectChildrenOnly"] = true,
				["ClassName"] = "event",
				["UniqueID"] = "1237868922",
				["Event"] = "weapon_class",
				["EditorExpand"] = true,
				["Name"] = "weapon class find simple\"@@1\"",
				["Arguments"] = "cw_mossberg500@@0",
			},
		},
	},
	["self"] = {
		["ClassName"] = "group",
		["UniqueID"] = "2787986348",
		["EditorExpand"] = true,
	},
},
}