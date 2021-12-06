ITEM.name = "MP40"
ITEM.description= "A submachinegun chambered for 9x19mm."
ITEM.longdesc = "The MP 40 (Maschinenpistole 40) is a submachine gun chambered for the 9×19mm Parabellum cartridge. It was developed in Nazi Germany and used extensively by the Axis powers during World War II.  \n\nAmmo: 9x19mm \nMagazine Capacity: 32"
ITEM.model = ("models/khrcw2/doipack/w_mp40.mdl")
ITEM.class = "cw_mp40"
ITEM.weaponCategory = "primary"
ITEM.price = 7200
ITEM.width = 4
ITEM.height = 2
ITEM.validAttachments = {"md_tundra9mm"}

ITEM.bulletweight = 0.008
ITEM.unloadedweight = 3.97

ITEM.repair_PartsComplexity = 3
ITEM.repair_PartsRarity = 2

function ITEM:GetWeight()
  return self.unloadedweight + (self.bulletweight * self:GetData("ammo", 0))
end

ITEM.iconCam = {
	pos = Vector(5, -205, -1),
	ang = Angle(0, 90, 0),
	fov = 10.4,
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
						["Position"] = Vector(8.791, -4.174, -1.903),
						["Model"] = "models/khrcw2/doipack/w_mp40.mdl",
						["ClassName"] = "model",
						["EditorExpand"] = true,
						["UniqueID"] = "858831938491",
						["Bone"] = "spine 2",
						["Name"] = "cw_mp40",
					},
				},
			},
			["self"] = {
				["AffectChildrenOnly"] = true,
				["ClassName"] = "event",
				["UniqueID"] = "1044333654102",
				["Event"] = "weapon_class",
				["EditorExpand"] = true,
				["Name"] = "weapon class find simple\"@@1\"",
				["Arguments"] = "cw_mp40@@0",
			},
		},
	},
	["self"] = {
		["ClassName"] = "group",
		["UniqueID"] = "813442511183",
		["EditorExpand"] = true,
	},
},
}