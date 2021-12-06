ITEM.name = "Fort-12"
ITEM.description= "A semi-automatic pistol chambered for 9x18mm."
ITEM.longdesc = "An Ukranian-made service pistol that has been adopted by many east-block countries.\nAlmost as common as the PMm and is more popular due to its larger magazine capacity.\n\nAmmo: 9x18mm\nMagazine Capacity: 12"
ITEM.model = "models/srp/weapons/w_fort12.mdl"
ITEM.class = "cw_fort12"
ITEM.weaponCategory = "secondary"
ITEM.width = 2
ITEM.price = 1500
ITEM.height = 1
ITEM.validAttachments = {"md_microt1","md_eotech","md_rmr","md_tundra9mm"}

ITEM.bulletweight = 0.011
ITEM.unloadedweight = 0.830

ITEM.repair_PartsComplexity = 1
ITEM.repair_PartsRarity = 2

function ITEM:GetWeight()
  return self.unloadedweight + (self.bulletweight * self:GetData("ammo", 0))
end

ITEM.iconCam = {
	pos = Vector(6, -15, 1.5),
	ang = Angle(0, 90, 0),
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
						["Model"] = "models/srp/weapons/w_fort12.mdl",
						["ClassName"] = "model",
						["Position"] = Vector(-9.11, 8.792, 0.84),
						["EditorExpand"] = true,
						["UniqueID"] = "3540503835",
						["Bone"] = "pelvis",
						["Name"] = "fort12",
						["Angles"] = Angle(0, 270, -30),
					},
				},
			},
			["self"] = {
				["AffectChildrenOnly"] = true,
				["ClassName"] = "event",
				["UniqueID"] = "1640768762",
				["Event"] = "weapon_class",
				["EditorExpand"] = true,
				["Name"] = "weapon class find simple\"@@1\"",
				["Arguments"] = "cw_fort12@@0",
			},
		},
	},
	["self"] = {
		["ClassName"] = "group",
		["UniqueID"] = "1170487467",
		["EditorExpand"] = true,
	},
},
}