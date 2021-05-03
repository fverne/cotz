ITEM.name = "TOZ-194"
ITEM.description= "A pump-action shotgun. Fires 12 gauge."
ITEM.longdesc = "A classic 90's russian civilian shotgun, used in much of Europe as a hunting weapon. It is fairly long and unweildy, as to be legal for the civilian market in its country of origin, Russia, it had to have an overall legnth of 80cm's.\n\nAmmo: 12 Gauge \nMagazine Capacity: 3"
ITEM.model = ("models/khrcw2/w_khri_khrtoz194.mdl")
ITEM.class = "cw_toz194"
ITEM.weaponCategory = "primary"
ITEM.price = 8000
ITEM.width = 4
ITEM.height = 1
ITEM.canAttach = false

ITEM.bulletweight = 0.031
ITEM.unloadedweight = 2.9

ITEM.repair_PartsComplexity = 1
ITEM.repair_PartsRarity = 2

function ITEM:GetWeight()
  return self.unloadedweight + (self.bulletweight * self:GetData("ammo", 0))
end

ITEM.iconCam = {
	pos = Vector(18, -160, 2),
	ang = Angle(0, 90, 0),
	fov = 12.5,
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
						["Model"] = "models/khrcw2/w_khri_khrtoz194.mdl",
						["ClassName"] = "model",
						["EditorExpand"] = true,
						["UniqueID"] = "15233125",
						["Bone"] = "spine 2",
						["Name"] = "toz194",
					},
				},
			},
			["self"] = {
				["AffectChildrenOnly"] = true,
				["ClassName"] = "event",
				["UniqueID"] = "13553232553",
				["Event"] = "weapon_class",
				["EditorExpand"] = true,
				["Name"] = "weapon class find simple\"@@1\"",
				["Arguments"] = "cw_toz194@@0",
			},
		},
	},
	["self"] = {
		["ClassName"] = "group",
		["UniqueID"] = "125512152",
		["EditorExpand"] = true,
	},
},
}