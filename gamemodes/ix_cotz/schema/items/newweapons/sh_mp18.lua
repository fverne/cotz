ITEM.name = "MP-18"
ITEM.description= "Russian single shot rifle, primarily designed for hunting. Fires 7.62x54mm."
ITEM.longdesc = "MP-18 is the legendary Soviet single-barreled rifle. This gun behaves perfectly in all weather conditions, no breakdowns or failures have ever been identified.\n\nAmmo: 7.62x54mm\nMagazine Capacity: 1"
ITEM.model = ("models/weapons/arc9/darsu_eft/w_mp18.mdl")
ITEM.class = "cw_mp18"
ITEM.weaponCategory = "primary"
ITEM.price = 9000
ITEM.width = 5
ITEM.height = 1
ITEM.canAttach = false

ITEM.bulletweight = 0.022
ITEM.unloadedweight = 3.5

ITEM.repair_PartsComplexity = 0
ITEM.repair_PartsRarity = 1

function ITEM:GetWeight()
  return self.unloadedweight + (self.bulletweight * self:GetData("ammo", 0))
end


ITEM.iconCam = {
	pos = Vector(5.23, -199.86, -5.24),
	ang = Angle(-0.18, 85.71, 0),
	fov = 12.72
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
						["Angles"] = Angle(-15.857076644897, 180, -180),
						["Position"] = Vector(15.658203125, 0.03999999910593, -12.88525390625),
						["Model"] = "models/weapons/arc9/darsu_eft/w_mp18.mdl",
						["ClassName"] = "model",
						["EditorExpand"] = true,
						["UniqueID"] = "7682768276",
						["Bone"] = "spine 2",
						["Name"] = "mp18",
					},
				},
			},
			["self"] = {
				["AffectChildrenOnly"] = true,
				["ClassName"] = "event",
				["UniqueID"] = "78266782672",
				["Event"] = "weapon_class",
				["EditorExpand"] = true,
				["Name"] = "weapon class find simple\"@@1\"",
				["Arguments"] = "cw_mp18@@0",
			},
		},
	},
	["self"] = {
		["ClassName"] = "group",
		["UniqueID"] = "798264526",
		["EditorExpand"] = true,
	},
},
}