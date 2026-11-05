ITEM.name = "Gepard PDW"
ITEM.description = "A compact personal defence weapon chambered for 9x21mm."
ITEM.longdesc = "The Gepard PDW concentrates its action and controls into a short body. Its compact outline is markedly less cumbersome than a full-length rifle in a confined interior. The detachable magazine remains a separate, conspicuous part of a weapon designed around keeping the main assembly small.\n\nAmmo: 9x21mm\nMagazine Capacity: 22"
ITEM.model = ("models/weapons/tfa_l4d2/w_gepard.mdl")
ITEM.class = "cw_gepardpdw"
ITEM.weaponCategory = "primary"
ITEM.width = 3
ITEM.price = 14500
ITEM.height = 2
ITEM.validAttachments = {"md_kobra","md_microt1","md_eotech","md_aimpoint","md_cmore", "md_reflex","md_tundra9mm"}

ITEM.bulletweight = 0.008
ITEM.unloadedweight = 2.0




function ITEM:GetWeight()
  return self:GetData("weight", self.unloadedweight) + (self.bulletweight * self:GetData("ammo", 0))
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
						["Translucent"] = true,
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
				["Invert"] = false,
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
