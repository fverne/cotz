ITEM.name = "Baikal MP-153"
ITEM.description= "A semi-automatic shotgun. Fires 12 gauge."
ITEM.longdesc = "A 12 gauge gas operated semi-automatic shotgun, manufactured for the civilian market. Usually used for shooting skeet, or hunting small or medium game, however in the zone it becomes an excellent tool for survival.\n\nAmmo: 12 Gauge \nMagazine Capacity: 3"
ITEM.model = ("models/wick/weapons/stalker/stcopwep/w_mp153_model.mdl")
ITEM.class = "cw_mp153"
ITEM.weaponCategory = "primary"
ITEM.price = 11000
ITEM.width = 6
ITEM.height = 1
ITEM.canAttach = false

ITEM.bulletweight = 0.031
ITEM.unloadedweight = 3.45

ITEM.repair_PartsComplexity = 2
ITEM.repair_PartsRarity = 2

function ITEM:GetWeight()
  return self.unloadedweight + (self.bulletweight * self:GetData("ammo", 0))
end

ITEM.iconCam = {
	pos = Vector(-10, 184, -1),
	ang = Angle(0, 270, 0),
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
						["Angles"] = Angle(0, 0, 180),
						["Position"] = Vector(11.98, -4.153, -3.575),
						["Model"] = "models/wick/weapons/stalker/stcopwep/w_mp153_model.mdl",
						["ClassName"] = "model",
						["EditorExpand"] = true,
						["UniqueID"] = "15635315",
						["Bone"] = "spine 2",
						["Name"] = "mp153",
					},
				},
			},
			["self"] = {
				["AffectChildrenOnly"] = true,
				["ClassName"] = "event",
				["UniqueID"] = "5312253",
				["Event"] = "weapon_class",
				["EditorExpand"] = true,
				["Name"] = "weapon class find simple\"@@1\"",
				["Arguments"] = "cw_mp153@@0",
			},
		},
	},
	["self"] = {
		["ClassName"] = "group",
		["UniqueID"] = "132562561",
		["EditorExpand"] = true,
	},
},
}