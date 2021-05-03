ITEM.name = "L85"
ITEM.description= "A bullpup assault rifle. Fires 5.56x45mm."
ITEM.longdesc = "The standard rifle for the British armed forces. This rifle was designed to be fitted with various attachments.\n\nAmmo: 5.56x45mm\nMagazine Capacity: 30"
ITEM.model = ("models/weapons/w_rif_l852.mdl")
ITEM.class = "cw_l85"
ITEM.weaponCategory = "primary"
ITEM.price = 24600
ITEM.width = 4
ITEM.height = 2
ITEM.validAttachments = {"md_saker","md_foregrip"}

ITEM.bulletweight = 0.012
ITEM.unloadedweight = 3.82

ITEM.repair_PartsComplexity = 5
ITEM.repair_PartsRarity = 3

function ITEM:GetWeight()
  return self.unloadedweight + (self.bulletweight * self:GetData("ammo", 0))
end

ITEM.iconCam = {
	pos = Vector(11.5, -205, 3),
	ang = Angle(0, 90, 0),
	fov = 9,
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
						["Position"] = Vector(19.599, -4.308, 0.19),
						["Model"] = "models/weapons/w_rif_l852.mdl",
						["ClassName"] = "model",
						["EditorExpand"] = true,
						["UniqueID"] = "8544325421",
						["Bone"] = "spine 2",
						["Name"] = "l85",
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
				["Arguments"] = "cw_l85@@0",
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