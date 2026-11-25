ITEM.name = "OTs-02 Kiparis"
ITEM.description= "A submachinegun with a folded stock. Fires 9x18mm."
ITEM.longdesc = "A russian submachinegun, the OTS-02 is a blowback-operated weapon of a conventional design chambered in 9×18mm Makarov."
ITEM.model = "models/flaymi/anomaly/weapons/w_models/wpn_kiparis_w.mdl"
ITEM.class = "cw_cotz_anomaly_kiparis"
ITEM.category = "Anomaly Reskins"
ITEM.noBusiness = true
ITEM.weaponCategory = "primary"
ITEM.price = 6300
ITEM.width = 3
ITEM.height = 1
ITEM.validAttachments = {"md_tundra9mm"}

ITEM.bulletweight = 0.011
ITEM.unloadedweight = 1.6




function ITEM:GetWeight()
  return self:GetData("weight", self.unloadedweight) + (self.bulletweight * self:GetData("ammo", 0))
end

ITEM.iconCam = {
	pos = Vector(-1.2, -205, 3.9),
	ang = Angle(0, 90, 0),
	fov = 9.7,
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
						["Position"] = Vector(4.75, -2.75, -5.38),
						["Model"] = "models/flaymi/anomaly/weapons/w_models/wpn_kiparis_w.mdl",
						["ClassName"] = "model",
						["Translucent"] = true,
						["EditorExpand"] = true,
						["UniqueID"] = "8544325421",
						["Bone"] = "spine 2",
						["Name"] = "kiparis",
					},
				},
			},
			["self"] = {
				["AffectChildrenOnly"] = true,
				["ClassName"] = "event",
				["UniqueID"] = "1036853672",
				["Event"] = "weapon_class",
				["Invert"] = false,
				["EditorExpand"] = true,
				["Name"] = "weapon class find simple\"@@1\"",
				["Arguments"] = "cw_cotz_anomaly_kiparis@@0",
			},
		},
	},
	["self"] = {
		["ClassName"] = "group",
		["UniqueID"] = "8537651483",
		["EditorExpand"] = true,
	},
},
}
