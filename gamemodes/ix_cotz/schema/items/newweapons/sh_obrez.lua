ITEM.name = "Obrez"
ITEM.description= "A shortened bolt action rifle chambered for 7.62x54mm."
ITEM.longdesc = "A well-used sawn-off Mosin Nagant rifle, it's exact model is unclear.\nA direct hit with this weapon at close range is devastating, but accuracy leaves a lot to be desired.\n\nAmmo: 7.62x54mm\nMagazine Capacity: 5"
ITEM.model = ("models/weapons3/mosina.mdl")
ITEM.class = "cw_obrez"
ITEM.weaponCategory = "primary"
ITEM.price = 7350
ITEM.width = 3
ITEM.height = 1

ITEM.canAttach = false

ITEM.bulletweight = 0.022
ITEM.unloadedweight = 2.4

ITEM.repair_PartsComplexity = 3
ITEM.repair_PartsRarity = 1

function ITEM:GetWeight()
  return self.unloadedweight + (self.bulletweight * self:GetData("ammo", 0))
end

ITEM.iconCam = {
	pos = Vector(5, 1, 12),
	ang = Angle(90, 100, 0),
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
						["Model"] = "models/weapons3/mosina.mdl",
						["ClassName"] = "model",
						["Position"] = Vector(-23, -7, 0),
						["EditorExpand"] = true,
						["UniqueID"] = "3578648235",
						["Bone"] = "chest",
						["Name"] = "obrez",
						["Angles"] = Angle(100, 275, 90),
					},
				},
			},
			["self"] = {
				["AffectChildrenOnly"] = true,
				["ClassName"] = "event",
				["UniqueID"] = "1418327982",
				["Event"] = "weapon_class",
				["EditorExpand"] = true,
				["Name"] = "weapon class find simple\"@@1\"",
				["Arguments"] = "cw_obrez@@0",
			},
		},
	},
	["self"] = {
		["ClassName"] = "group",
		["UniqueID"] = "7391465467",
		["EditorExpand"] = true,
	},
},
}