ITEM.name = "Five-Seven"
ITEM.description= "A polymer-framed pistol chambered for 5.7x28mm."
ITEM.longdesc = "The FiveSeven and its iconic cartridge, the FN 5.7x28mm, was designed to replace the aging 9x19mm cartridge.\nThe cartridge sports excellent penetration power and impressively tight groupings.\nThe FiveSeven pistol has a staggering magazine capacity of 20 rounds, however acquiring it in the Zone is fairly tough and will cost you dearly, as will supplying the pistol with ammunition.\n\nAmmo: 5.7x28mm\nMagazine Capacity: 20"
ITEM.model = "models/weapons/w_pist_fiveseven.mdl"
ITEM.class = "cw_fiveseven"
ITEM.weaponCategory = "secondary"
ITEM.price = 6900
ITEM.width = 2
ITEM.height = 1
ITEM.validAttachments = {"md_microt1","md_eotech","md_rmr","md_tundra9mm"}

ITEM.bulletweight = 0.006
ITEM.unloadedweight = 0.610

ITEM.repair_PartsComplexity = 2
ITEM.repair_PartsRarity = 4

function ITEM:GetWeight()
  return self.unloadedweight + (self.bulletweight * self:GetData("ammo", 0))
end

ITEM.iconCam = {
	pos = Vector(3, -205, 3.4000000953674),
	ang = Angle(0, 90, 0),
	fov = 4,
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
						["Model"] = "models/weapons/w_pist_fiveseven.mdl",
						["ClassName"] = "model",
						["Position"] = Vector(-9.746, 4.888, -1.755),
						["EditorExpand"] = true,
						["UniqueID"] = "3544603835",
						["Bone"] = "pelvis",
						["Name"] = "five7",
						["Angles"] = Angle(0, 270, -30),
					},
				},
			},
			["self"] = {
				["AffectChildrenOnly"] = true,
				["ClassName"] = "event",
				["UniqueID"] = "1087768762",
				["Event"] = "weapon_class",
				["EditorExpand"] = true,
				["Name"] = "weapon class find simple\"@@1\"",
				["Arguments"] = "cw_fiveseven@@0",
			},
		},
	},
	["self"] = {
		["ClassName"] = "group",
		["UniqueID"] = "1197387467",
		["EditorExpand"] = true,
	},
},
}