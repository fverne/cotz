ITEM.name = "SR-2 Veresk"
ITEM.description= "A russian submachinegun that fires an uncommon cartridge. Fires 9x21mm."
ITEM.longdesc = "PLACEHOLDER.\n\nAmmo: 9x21mm\nMagazine Capacity: 30"
ITEM.model = ("models/sr-2m veresk/sr2.mdl")
ITEM.class = "cw_veresk"
ITEM.weaponCategory = "secondary"
ITEM.width = 3
ITEM.price = 7500
ITEM.height = 2
ITEM.validAttachments = {"md_microt1", "md_tundra9mm"}

ITEM.bulletweight = 0.008
ITEM.unloadedweight = 3.5

ITEM.repair_PartsComplexity = 1
ITEM.repair_PartsRarity = 1

function ITEM:GetWeight()
  return self.unloadedweight + (self.bulletweight * self:GetData("ammo", 0))
end

ITEM.iconCam = {
	pos = Vector(-32, 2, 6.5),
	ang = Angle(0, -0, 0),
	fov = 45,
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
						["Angles"] = Angle(0, 0, 0),
						["Position"] = Vector(-19.377, -2.721, 2.522),
						["Model"] = "models/sr-2m veresk/sr2.mdl",
						["ClassName"] = "model",
						["EditorExpand"] = true,
						["UniqueID"] = "326463246",
						["Bone"] = "spine 2",
						["Name"] = "sr2",
					},
				},
			},
			["self"] = {
				["AffectChildrenOnly"] = true,
				["ClassName"] = "event",
				["UniqueID"] = "5322363632",
				["Event"] = "weapon_class",
				["EditorExpand"] = true,
				["Name"] = "weapon class find simple\"@@1\"",
				["Arguments"] = "cw_veresk@@0",
			},
		},
	},
	["self"] = {
		["ClassName"] = "group",
		["UniqueID"] = "346363466",
		["EditorExpand"] = true,
	},
},
}