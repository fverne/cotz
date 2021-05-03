ITEM.name = "Stoeger Double Defense"
ITEM.description= "A break-action hunting shotgun firing 12 gauge shells."
ITEM.longdesc = "The Stoeger Double Defense shotgun is a re-envisioned and modernised version of the classic coach gun. With picatinny rails for mounting optics and a light weight body, it's the quintessential double barreled shotgun for hunting and self defense. This is the classic full length version with 20 inch barrels.\n\nAmmo: 12 Gauge \nMagazine Capacity: 2"
ITEM.model = "models/weapons/w_pist_lyxn_dualb.mdl"
ITEM.class = "cw_stoegerdd"
ITEM.weaponCategory = "primary"
ITEM.width = 4
ITEM.price = 12000
ITEM.height = 1
ITEM.validAttachments = {"md_rmr", "md_microt1", "md_aimpoint", "md_eotech"}

ITEM.bulletweight = 0.031
ITEM.unloadedweight = 3.21

ITEM.repair_PartsComplexity = 1
ITEM.repair_PartsRarity = 2

function ITEM:GetWeight()
  return self.unloadedweight + (self.bulletweight * self:GetData("ammo", 0))
end

ITEM.iconCam = {
	pos = Vector(9, -205, 2),
	ang = Angle(0, 90, 0),
	fov = 7,
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
						["Model"] = "models/weapons/w_pist_lyxn_dualb.mdl",
						["ClassName"] = "model",
						["Angles"] = Angle(78.806, -89.399, 97.233),
						["Position"] = Vector(-7.858, -4.796, 1.549),
						["AngleOffset"] = Angle(0, -10.5, 0),
						["EditorExpand"] = true,
						["UniqueID"] = "3552155135",
						["Bone"] = "chest",
						["Name"] = "stdd",
					},
				},
			},
			["self"] = {
				["AffectChildrenOnly"] = true,
				["ClassName"] = "event",
				["UniqueID"] = "1616522402",
				["Event"] = "weapon_class",
				["EditorExpand"] = true,
				["Name"] = "weapon class find simple\"@@1\"",
				["Arguments"] = "cw_stoegerdd@@0",
			},
		},
	},
	["self"] = {
		["ClassName"] = "group",
		["UniqueID"] = "1922937684",
		["EditorExpand"] = true,
	},
},
}
