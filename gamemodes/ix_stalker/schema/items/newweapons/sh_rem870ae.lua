ITEM.name = "Remington 870 AE"
ITEM.description= "A pump-action shotgun. Fires 12 gauge."
ITEM.longdesc = "The Remington Model 870 is a pump-action shotgun manufactured by Remington Arms Company, LLC.\nIt is widely used by the public for sport shooting, hunting, and self-defense. It is also commonly used by law enforcement and military organizations worldwide.\nOn April 13, 2009, the ten millionth Model 870 was produced; the 870 holds the record for best-selling shotgun in history.\n\nAmmo: 12 Gauge \nMagazine Capacity: 8"
ITEM.model = ("models/weapons/w_shot_remington.mdl")
ITEM.class = "cw_rem870ae"
ITEM.weaponCategory = "primary"
ITEM.price = 14000
ITEM.width = 5
ITEM.height = 1
ITEM.canAttach = false

ITEM.bulletweight = 0.031
ITEM.unloadedweight = 3.6

ITEM.repair_PartsComplexity = 1
ITEM.repair_PartsRarity = 3

function ITEM:GetWeight()
  return self.unloadedweight + (self.bulletweight * self:GetData("ammo", 0))
end

ITEM.iconCam = {
	pos = Vector(12, -205, 1.5),
	ang = Angle(0, 90, 0),
	fov = 14.5,
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
						["Angles"] = Angle(0, 180, 180),
						["Position"] = Vector(14.98, -4.153, -1.175),
						["Model"] = "models/weapons/w_shot_remington.mdl",
						["ClassName"] = "model",
						["EditorExpand"] = true,
						["UniqueID"] = "7793798673",
						["Bone"] = "spine 2",
						["Name"] = "rem870",
					},
				},
			},
			["self"] = {
				["AffectChildrenOnly"] = true,
				["ClassName"] = "event",
				["UniqueID"] = "1239789522",
				["Event"] = "weapon_class",
				["EditorExpand"] = true,
				["Name"] = "weapon class find simple\"@@1\"",
				["Arguments"] = "cw_rem870ae@@0",
			},
		},
	},
	["self"] = {
		["ClassName"] = "group",
		["UniqueID"] = "2784687898",
		["EditorExpand"] = true,
	},
},
}