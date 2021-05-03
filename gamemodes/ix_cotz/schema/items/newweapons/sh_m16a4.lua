ITEM.name = "M16A4"
ITEM.description= "An American combat rifle chambered for 5.56x45mm."
ITEM.longdesc = "As a weapon solely issued to the US Marines, the M16A4's origins and quantities in the Zone are unclear.\nThe first model was designed in the 60's and has been constantly modified and upgraded since.\nThis rifle is a very versatile choice, it remains accurate at distances up to 550 meters against small targets and weighs just over 4 kilograms loaded.\n\nAmmo: 5.56x45mm\nMagazine Capacity: 30"
ITEM.model = ("models/weapons/m16a4/w_rif_m16a4.mdl")
ITEM.class = "cw_ws_m16a4"
ITEM.weaponCategory = "primary"
ITEM.price = 22500
ITEM.width = 5
ITEM.height = 2
ITEM.validAttachments = {"md_microt1","md_eotech","md_aimpoint","md_cmore","md_schmidt_shortdot","md_acog","md_reflex","md_saker","md_foregrip"}

ITEM.bulletweight = 0.012
ITEM.unloadedweight = 2.89

ITEM.repair_PartsComplexity = 3
ITEM.repair_PartsRarity = 4

function ITEM:GetWeight()
  return self.unloadedweight + (self.bulletweight * self:GetData("ammo", 0))
end

ITEM.iconCam = {
	pos = Vector(15, -205, 1),
	ang = Angle(0, 90, 0),
	fov = 13.7,
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
						["Position"] = Vector(16.543, -4.312, -1.374),
						["Model"] = "models/weapons/m16a4/w_rif_m16a4.mdl",
						["ClassName"] = "model",
						["EditorExpand"] = true,
						["UniqueID"] = "8553655421",
						["Bone"] = "spine 2",
						["Name"] = "m16",
					},
				},
			},
			["self"] = {
				["AffectChildrenOnly"] = true,
				["ClassName"] = "event",
				["UniqueID"] = "1057453672",
				["Event"] = "weapon_class",
				["EditorExpand"] = true,
				["Name"] = "weapon class find simple\"@@1\"",
				["Arguments"] = "cw_ws_m16a4@@0",
			},
		},
	},
	["self"] = {
		["ClassName"] = "group",
		["UniqueID"] = "8736551483",
		["EditorExpand"] = true,
	},
},
}