ITEM.name = "LR-300"
ITEM.description= "A modern assault rifle. Fires 5.56x45mm."
ITEM.longdesc = "When one is looking for an M4 in the Zone, chances are he'll settle for the LR-300 carbine instead. While there are some differences in design and build, the LR-300 was imported in much greater quantities than any other automatic rifle of this caliber. \nIt's well-used in close-quarters combat with the fire-rate of 950 rounds a minute and 91 centimeter length. \nIt's bolt is placed further forward in the weapon, allowing the use of a foldable stock.\n\nAmmo: 5.56x45mm \nMagazine Capacity: 30"
ITEM.model = "models/weapons/w_lr300.mdl"
ITEM.class = "cw_lr300"
ITEM.weaponCategory = "primary"
ITEM.price = 23100
ITEM.width = 5
ITEM.height = 2
ITEM.validAttachments = {"md_microt1","md_eotech","md_aimpoint","md_cmore","md_schmidt_shortdot","md_acog","md_reflex","md_saker","md_foregrip"}

ITEM.bulletweight = 0.012
ITEM.unloadedweight = 3.1

ITEM.repair_PartsComplexity = 3
ITEM.repair_PartsRarity = 3

function ITEM:GetWeight()
  return self.unloadedweight + (self.bulletweight * self:GetData("ammo", 0))
end

ITEM.iconCam = {
	pos = Vector(-5, -205, 5),
	ang = Angle(0, 90, 0),
	fov = 12,
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
						["Position"] = Vector(1.203, -4.313, 2.519),
						["Model"] = "models/weapons/w_lr300.mdl",
						["ClassName"] = "model",
						["EditorExpand"] = true,
						["UniqueID"] = "7442869091",
						["Bone"] = "spine 2",
						["Name"] = "lr300",
					},
				},
			},
			["self"] = {
				["AffectChildrenOnly"] = true,
				["ClassName"] = "event",
				["UniqueID"] = "1237444442",
				["Event"] = "weapon_class",
				["EditorExpand"] = true,
				["Name"] = "weapon class find simple\"@@1\"",
				["Arguments"] = "cw_lr300@@0",
			},
		},
	},
	["self"] = {
		["ClassName"] = "group",
		["UniqueID"] = "2788492872",
		["EditorExpand"] = true,
	},
},
}