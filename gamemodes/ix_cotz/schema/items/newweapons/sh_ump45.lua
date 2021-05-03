ITEM.name = "H&K UMP"
ITEM.description= "A German submachine gun, firing the .45ACP cartridge."
ITEM.longdesc = "The UMP is a blowback operated, magazine-fed submachine gun firing from a closed bolt.\nAs originally designed, the UMP is chambered for larger cartridges than other submachine guns like the MP5, to provide more stopping power against unarmored targets.\n\nAmmo: .45ACP \nMagazine Capacity: 25"
ITEM.model = ("models/weapons/w_smg_ump45.mdl")
ITEM.class = "cw_ump45"
ITEM.weaponCategory = "primary"
ITEM.price = 14700
ITEM.width = 3
ITEM.height = 2
ITEM.validAttachments = {"md_microt1","md_eotech","md_aimpoint","md_cmore","md_schmidt_shortdot","md_acog","md_reflex","md_cobram2"}

ITEM.bulletweight = 0.020
ITEM.unloadedweight = 2.65

ITEM.repair_PartsComplexity = 2
ITEM.repair_PartsRarity = 2

function ITEM:GetWeight()
  return self.unloadedweight + (self.bulletweight * self:GetData("ammo", 0))
end

ITEM.iconCam = {
	pos = Vector(-2, -205, 4),
	ang = Angle(0, 90, 0),
	fov = 8.4,
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
						["Position"] = Vector(8.614, -4.265, 3.43),
						["Model"] = "models/weapons/w_smg_ump45.mdl",
						["ClassName"] = "model",
						["EditorExpand"] = true,
						["UniqueID"] = "8545625421",
						["Bone"] = "spine 2",
						["Name"] = "ump45",
					},
				},
			},
			["self"] = {
				["AffectChildrenOnly"] = true,
				["ClassName"] = "event",
				["UniqueID"] = "1036896542",
				["Event"] = "weapon_class",
				["EditorExpand"] = true,
				["Name"] = "weapon class find simple\"@@1\"",
				["Arguments"] = "cw_ump45@@0",
			},
		},
	},
	["self"] = {
		["ClassName"] = "group",
		["UniqueID"] = "8123321483",
		["EditorExpand"] = true,
	},
},
}