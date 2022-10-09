ITEM.name = "Iver Johnson IJ600"
ITEM.description= "An Iver Johnson IJ600 .410 Bore O/U Break Action Shotgun."
ITEM.longdesc = "A classic shotgun design, firing .410 buckshot. The Iver Johnson brand has an illustrious history of producing wonderful firearms, and this over under shotgun is no exception.\nThe ammo being \n\nAmmo: .410 Gauge \nMagazine Capacity: 2"
ITEM.model = ("models/weapons/w_sv10.mdl")
ITEM.class = "cw_ij600"
ITEM.weaponCategory = "primary"
ITEM.price = 5800
ITEM.width = 6
ITEM.height = 1
ITEM.canAttach = false

ITEM.bulletweight = 0.031
ITEM.unloadedweight = 3.3

ITEM.repair_PartsComplexity = 2
ITEM.repair_PartsRarity = 1

function ITEM:GetWeight()
  return self.unloadedweight + (self.bulletweight * self:GetData("ammo", 0))
end

ITEM.exRender = true
ITEM.iconCam = {
	pos = Vector(4, 200, -0.5),
	ang = Angle(0, 270, 0),
	fov = 14,
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
						["Position"] = Vector(0.066, -5.077, -3.147),
						["Model"] = "models/weapons/w_sv10.mdl",
						["ClassName"] = "model",
						["EditorExpand"] = true,
						["UniqueID"] = "2352355232",
						["Bone"] = "spine 2",
						["Name"] = "ij600",
					},
				},
			},
			["self"] = {
				["AffectChildrenOnly"] = true,
				["ClassName"] = "event",
				["UniqueID"] = "253235235",
				["Event"] = "weapon_class",
				["EditorExpand"] = true,
				["Name"] = "weapon class find simple\"@@1\"",
				["Arguments"] = "cw_ij600@@0",
			},
		},
	},
	["self"] = {
		["ClassName"] = "group",
		["UniqueID"] = "523455324",
		["EditorExpand"] = true,
	},
},
}