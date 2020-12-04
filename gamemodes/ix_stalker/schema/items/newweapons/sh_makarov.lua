ITEM.name = "Makarov"
ITEM.description= "A Russian steel-framed police pistol that fires 9x18 rounds."
ITEM.longdesc = "The Makarov is the replacement for the Tokarev pistol.\nIt's a cheap, compact and reliable choice, but it's not very comfortable and has a smaller magazine than other handguns of same weight category.\n\nAmmo: 9x18mm\nMagazine Capacity: 8"
ITEM.model = "models/weapons/w_makarov_pm_fixed.mdl"
ITEM.class = "cw_makarov"
ITEM.weaponCategory = "secondary"
ITEM.price = 900
ITEM.width = 2
ITEM.height = 1
ITEM.canAttach = false

ITEM.bulletweight = 0.011
ITEM.unloadedweight = 0.73

ITEM.repair_PartsComplexity = 1
ITEM.repair_PartsRarity = 1

function ITEM:GetWeight()
  return self.unloadedweight + (self.bulletweight * self:GetData("ammo", 0))
end

ITEM.iconCam = {
	pos = Vector(-7.5, -205, 4.5),
	ang = Angle(0, 90, -5),
	fov = 3.5,
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
						["Model"] = "models/cw2/pistols/w_makarov.mdl",
						["ClassName"] = "model",
						["Position"] = Vector(-9.266, 6.039, -0.924),
						["EditorExpand"] = true,
						["UniqueID"] = "3589789835",
						["Bone"] = "pelvis",
						["Name"] = "makarov",
						["Angles"] = Angle(-30, 180, 0),
					},
				},
			},
			["self"] = {
				["AffectChildrenOnly"] = true,
				["ClassName"] = "event",
				["UniqueID"] = "1640777682",
				["Event"] = "weapon_class",
				["EditorExpand"] = true,
				["Name"] = "weapon class find simple\"@@1\"",
				["Arguments"] = "cw_makarov@@0",
			},
		},
	},
	["self"] = {
		["ClassName"] = "group",
		["UniqueID"] = "1977897467",
		["EditorExpand"] = true,
	},
},
}