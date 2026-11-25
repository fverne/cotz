ITEM.name = "PPSh-41"
ITEM.description= "A heavy submachinegun with a wooden stock. Fires 7.62x25mm."
ITEM.longdesc = "The PPSh is a Soviet submachinegun that gained a fearful reputation in World War II as a fast and effective weapon. \nIt's substantial weight coupled with a gas compensator grants it low recoil in bursts and automatic fire. It fires from the open bolt. \nThese have been a popular choice with rookies compared to western, newer submachineguns because of the price and ammunition accessibility."
ITEM.model = "models/flaymi/anomaly/weapons/w_models/wpn_ppsh41_w.mdl"
ITEM.class = "cw_cotz_anomaly_ppsh"
ITEM.category = "Anomaly Reskins"
ITEM.noBusiness = true
ITEM.weaponCategory = "primary"
ITEM.price = 4200
ITEM.width = 3
ITEM.height = 1

ITEM.canAttach = false

ITEM.bulletweight = 0.010
ITEM.unloadedweight = 3.63




function ITEM:GetWeight()
  return self:GetData("weight", self.unloadedweight) + (self.bulletweight * self:GetData("ammo", 0))
end

ITEM.iconCam = {
	pos = Vector(4.2, -205, 4.3),
	ang = Angle(0, 90, 0),
	fov = 8.7,
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
						["Position"] = Vector(16.759, -8.327, 4.486),
						["Name"] = "ppsh",
						["ClassName"] = "model",
						["Translucent"] = true,
						["Size"] = 0.8,
						["UniqueID"] = "3544245692",
						["Angles"] = Angle(60.521, 89.241, 4.292),
						["Bone"] = "spine 2",
						["Model"] = "models/flaymi/anomaly/weapons/w_models/wpn_ppsh41_w.mdl",
						["EditorExpand"] = true,
					},
				},
			},
			["self"] = {
				["AffectChildrenOnly"] = true,
				["ClassName"] = "event",
				["UniqueID"] = "1044232402",
				["Event"] = "weapon_class",
				["Invert"] = false,
				["EditorExpand"] = true,
				["Name"] = "weapon class find simple\"@@1\"",
				["Arguments"] = "cw_cotz_anomaly_ppsh@@0",
			},
		},
	},
	["self"] = {
		["ClassName"] = "group",
		["UniqueID"] = "1513321183",
		["EditorExpand"] = true,
	},
},
}
