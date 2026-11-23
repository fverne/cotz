ITEM.name = "Glock 18"
ITEM.description= "An Austrian handgun that fires 9x19mm."
ITEM.longdesc = "The Glock is an Austrian polymer handgun, famous for it's price, reliability and trigger safety mechanism. The Glock 18 is a variant on the Glock 17 pattern, enabling it to fire in full auto.\nIt's favored by police agencies around the world and comes in many flavors."
ITEM.model = "models/flaymi/anomaly/weapons/w_models/wpn_glock_w.mdl"
ITEM.class = "cw_glock18"
ITEM.weaponCategory = "secondary"
ITEM.price = 6700
ITEM.width = 2
ITEM.height = 1

ITEM.validAttachments = {"md_tundra9mm", "md_microt1", "md_eotech", "md_rmr"}

ITEM.bulletweight = 0.008
ITEM.unloadedweight = 0.625




function ITEM:GetWeight()
  return self:GetData("weight", self.unloadedweight) + (self.bulletweight * self:GetData("ammo", 0))
end

ITEM.iconCam = {
	pos = Vector(1.6, -205, 2.7),
	ang = Angle(0, 90, 0),
	fov = 3.3,
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
						["Model"] = "models/flaymi/anomaly/weapons/w_models/wpn_glock_w.mdl",
						["ClassName"] = "model",
						["Translucent"] = true,
						["Position"] = Vector(-6.774, 4.172, 3.359),
						["EditorExpand"] = true,
						["UniqueID"] = "3547633835",
						["Bone"] = "pelvis",
						["Name"] = "glock18",
						["Angles"] = Angle(0, 180, 0),
					},
				},
			},
			["self"] = {
				["AffectChildrenOnly"] = true,
				["ClassName"] = "event",
				["UniqueID"] = "1640766402",
				["Event"] = "weapon_class",
				["Invert"] = false,
				["EditorExpand"] = true,
				["Name"] = "weapon class find simple\"@@1\"",
				["Arguments"] = "cw_glock18@@0",
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