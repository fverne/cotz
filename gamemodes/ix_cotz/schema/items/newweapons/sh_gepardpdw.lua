ITEM.name = "Gepard PDW"
ITEM.description= "PLACEHOLDER. Fires 9x21mm."
ITEM.longdesc = "PLACEHOLDER.\n\nAmmo: 9x21mm\nMagazine Capacity: 22"
ITEM.model = ("models/weapons/tfa_l4d2/w_gepard.mdl")
ITEM.class = "cw_gepardpdw"
ITEM.weaponCategory = "primary"
ITEM.width = 3
ITEM.price = 14500
ITEM.height = 2
ITEM.canAttach = false

ITEM.bulletweight = 0.008
ITEM.unloadedweight = 2.0




function ITEM:GetWeight()
  return self.unloadedweight + (self.bulletweight * self:GetData("ammo", 0))
end

ITEM.iconCam = {
	pos = Vector(0, -199.89, 6.62),
	ang = Angle(2.03, 90.03, 0),
	fov = 6.78
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
						["Position"] = Vector(4.8, -4, -4),
						["Model"] = "models/weapons/tfa_l4d2/w_gepard.mdl",
						["ClassName"] = "model",
						["EditorExpand"] = true,
						["UniqueID"] = "8544325421",
						["Bone"] = "spine 2",
						["Name"] = "uzi",
					},
				},
			},
			["self"] = {
				["AffectChildrenOnly"] = true,
				["ClassName"] = "event",
				["UniqueID"] = "1036853672",
				["Event"] = "weapon_class",
				["EditorExpand"] = true,
				["Name"] = "weapon class find simple\"@@1\"",
				["Arguments"] = "cw_gepardpdw@@0",
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
