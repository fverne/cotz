ITEM.name = "Saiga-410"
ITEM.description= "A semi-automatic shotgun. Fires .410 gauge."
ITEM.longdesc = "The Saiga-410 is a shotgun firing .410 gauge available in a wide range of configurations, patterned after the Kalashnikov series of assault rifles and named for the Saiga antelope.\nLike the Kalashnikov rifle variants, it is a rotating bolt, gas-operated gun that feeds from a box magazine. The much slimmer profile of the .410 shell means that a greater amount of shots can be fit in the same size magazine.\n\nAmmo: .410 Gauge \nMagazine Capacity: 9"
ITEM.model = "models/cw2/weapons/w_saiga_chan.mdl"
ITEM.class = "cw_saiga410"
ITEM.weaponCategory = "primary"
ITEM.price = 20600
ITEM.width = 5
ITEM.height = 2
ITEM.canAttach = false

ITEM.bulletweight = 0.031
ITEM.unloadedweight = 3.6

ITEM.repair_PartsComplexity = 2
ITEM.repair_PartsRarity = 2

function ITEM:GetWeight()
  return self.unloadedweight + (self.bulletweight * self:GetData("ammo", 0))
end

ITEM.iconCam = {
	pos = Vector(7, -205, 1.6000000238419),
	ang = Angle(0, 90, 0),
	fov = 11,
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
						["Model"] = "models/cw2/weapons/w_saiga_chan.mdl",
						["ClassName"] = "model",
						["Position"] = Vector(12.524, -4.193, -1.228),
						["EditorExpand"] = true,
						["UniqueID"] = "46546546",
						["Bone"] = "spine 2",
						["Name"] = "saiga410",
						["Angles"] = Angle(0, 180, 180),
					},
				},
			},
			["self"] = {
				["AffectChildrenOnly"] = true,
				["ClassName"] = "event",
				["UniqueID"] = "64524652",
				["Event"] = "weapon_class",
				["EditorExpand"] = true,
				["Name"] = "weapon class find simple\"@@1\"",
				["Arguments"] = "cw_saiga410@@0",
			},
		},
	},
	["self"] = {
		["ClassName"] = "group",
		["UniqueID"] = "4526645264",
		["EditorExpand"] = true,
	},
},
}