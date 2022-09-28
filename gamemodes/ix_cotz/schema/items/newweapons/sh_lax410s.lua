ITEM.name = "Henry Lever Action X Model .410 Short"
ITEM.description= "A lever-operated shotgun, chambered in .410."
ITEM.longdesc = "A crudely cut down lever action shotgun. Chambered in .410 gauge, it is mostly designed for hunting small game. It is also capable of chambering and firing .45 ACP, however the lack of rifling in the barrel makes it inaccurate. The extremly short barrel and unergonomic handle makes this weapon hard to use at range.\n\nAmmo: .410 Gauge \nMagazine Capacity: 3"
ITEM.model = ("models/weapons/w_bocw_ironhides.mdl")
ITEM.class = "cw_lax410s"
ITEM.weaponCategory = "secondary"
ITEM.price = 11000
ITEM.width = 3
ITEM.height = 1
ITEM.canAttach = false

ITEM.bulletweight = 0.031
ITEM.unloadedweight = 3.45

ITEM.repair_PartsComplexity = 1
ITEM.repair_PartsRarity = 2

function ITEM:GetWeight()
  return self.unloadedweight + (self.bulletweight * self:GetData("ammo", 0))
end

ITEM.exRender = true
ITEM.iconCam = {
	pos = Vector(24, 6, 0),
	ang = Angle(0, 180, 0),
	fov = 45,
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
						["Angles"] = Angle(0, -90, 180),
						["Position"] = Vector(11.98, -4.153, -3.575),
						["Model"] = "models/weapons/w_bocw_ironhides.mdl",
						["ClassName"] = "model",
						["EditorExpand"] = true,
						["UniqueID"] = "623677124",
						["Bone"] = "spine 2",
						["Name"] = "lax410s",
					},
				},
			},
			["self"] = {
				["AffectChildrenOnly"] = true,
				["ClassName"] = "event",
				["UniqueID"] = "123521345213",
				["Event"] = "weapon_class",
				["EditorExpand"] = true,
				["Name"] = "weapon class find simple\"@@1\"",
				["Arguments"] = "cw_lax410s@@0",
			},
		},
	},
	["self"] = {
		["ClassName"] = "group",
		["UniqueID"] = "123515135123",
		["EditorExpand"] = true,
	},
},
}