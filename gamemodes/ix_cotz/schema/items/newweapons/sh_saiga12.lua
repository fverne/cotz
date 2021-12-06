ITEM.name = "Saiga-12"
ITEM.description= "A semi-automatic shotgun. Fires 12 gauge."
ITEM.longdesc = "The Saiga-12 is a 12-gauge shotgun available in a wide range of configurations, patterned after the Kalashnikov series of assault rifles and named for the Saiga antelope.\nLike the Kalashnikov rifle variants, it is a rotating bolt, gas-operated gun that feeds from a box magazine.\nAll Saiga-12 configurations are recognizable as Kalashnikov-pattern guns by the large lever-safety on the right side of the receiver, the optic mounting rail on the left side of the receiver and the large top-mounted dust cover held in place by the rear of the recoil spring assembly.\n\nAmmo: 12 Gauge \nMagazine Capacity: 5"
ITEM.model = "models/cw2/weapons/w_saiga_chan.mdl"
ITEM.class = "cw_saiga12"
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
						["UniqueID"] = "3547633835",
						["Bone"] = "spine 2",
						["Name"] = "saiga12",
						["Angles"] = Angle(0, 180, 180),
					},
				},
			},
			["self"] = {
				["AffectChildrenOnly"] = true,
				["ClassName"] = "event",
				["UniqueID"] = "1640766402",
				["Event"] = "weapon_class",
				["EditorExpand"] = true,
				["Name"] = "weapon class find simple\"@@1\"",
				["Arguments"] = "cw_saiga12@@0",
			},
		},
	},
	["self"] = {
		["ClassName"] = "group",
		["UniqueID"] = "1980487467",
		["EditorExpand"] = true,
	},
},
}