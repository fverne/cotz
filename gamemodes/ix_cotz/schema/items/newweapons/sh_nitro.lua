ITEM.name = "Accurate Reloading .700 Nitro Express"
ITEM.description= "Big game hunting rifle for big targets."
ITEM.longdesc = "The .700 Nitro Express rifle is primarily designed for taking on big game, and has found practical application in the Zone. The .700 Nitro Express develops an approximate average of 12,100 J force of muzzle energy with a 1,000 gr bullet at 610 m/s.\n\nAmmo: .700 Nitro Express \nMagazine Capacity: 2"
ITEM.model = ("models/weapons/w_fc4_700nitro_fixed.mdl")
ITEM.class = "cw_ne700"
ITEM.weaponCategory = "primary"
ITEM.price = 800000
ITEM.width = 7
ITEM.height = 2
ITEM.canAttach = false

ITEM.bulletweight = 0.150
ITEM.unloadedweight = 8.2




function ITEM:GetWeight()
  return self:GetData("weight", self.unloadedweight) + (self.bulletweight * self:GetData("ammo", 0))
end

ITEM.iconCam = {
	pos = Vector(-13.83, -740.09, 131.76),
	ang = Angle(9.95, 88.04, 0),
	fov = 3.69
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
						["Position"] = Vector(11.8, -5, -2.1),
						["Model"] = "models/weapons/w_fc4_700nitro_fixed.mdl",
						["ClassName"] = "model",
						["EditorExpand"] = true,
						["UniqueID"] = "6782786768",
						["Bone"] = "spine 2",
						["Name"] = "700nit",
					},
				},
			},
			["self"] = {
				["AffectChildrenOnly"] = true,
				["ClassName"] = "event",
				["UniqueID"] = "264687267",
				["Event"] = "weapon_class",
				["Invert"] = false,
				["EditorExpand"] = true,
				["Name"] = "weapon class find simple\"@@1\"",
				["Arguments"] = "cw_ne700@@0",
			},
		},
	},
	["self"] = {
		["ClassName"] = "group",
		["UniqueID"] = "6827782676",
		["EditorExpand"] = true,
	},
},
}
