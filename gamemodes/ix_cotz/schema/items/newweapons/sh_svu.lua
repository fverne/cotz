ITEM.name = "SVU-A"
ITEM.description= "PLACEHOLDER."
ITEM.longdesc = "PLACEHOLDER.\n\nAmmo: 7.62x54mm \nMagazine Capacity: 20"
ITEM.model = ("models/weapons/w_snip_svu.mdl")
ITEM.class = "cw_svu"
ITEM.weaponCategory = "primary"
ITEM.price = 76000
ITEM.width = 5
ITEM.height = 2
ITEM.validAttachments = {"md_kobra","md_pso1"}

ITEM.bulletweight = 0.022
ITEM.unloadedweight = 3.6

ITEM.repair_PartsComplexity = 2
ITEM.repair_PartsRarity = 2

function ITEM:GetWeight()
  return self.unloadedweight + (self.bulletweight * self:GetData("ammo", 0))
end

ITEM.iconCam = {
	pos = Vector(-6.95, -199.12, 17.43),
	ang = Angle(4.6, 85.73, 0),
	fov = 13.36
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
						["Model"] = "models/weapons/w_snip_svu.mdl",
						["ClassName"] = "model",
						["Position"] = Vector(17.784, -5.054, -1.356),
						["EditorExpand"] = true,
						["UniqueID"] = "3859539124",
						["Bone"] = "spine 2",
						["Name"] = "svd",
						["Angles"] = Angle(0, 180, 180),
					},
				},
			},
			["self"] = {
				["AffectChildrenOnly"] = true,
				["ClassName"] = "event",
				["UniqueID"] = "2428315201",
				["Event"] = "weapon_class",
				["EditorExpand"] = true,
				["Name"] = "weapon class find simple\"@@1\"",
				["Arguments"] = "cw_svu@@0",
			},
		},
	},
	["self"] = {
		["ClassName"] = "group",
		["UniqueID"] = "0004518261",
		["EditorExpand"] = true,
	},
},
}