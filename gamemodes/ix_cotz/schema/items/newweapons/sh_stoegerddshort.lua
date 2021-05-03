ITEM.name = "Stoeger Double Defense Short"
ITEM.description= "A short break-action hunting shotgun firing 12 gauge shells."
ITEM.longdesc = "The Stoeger Double Defense shotgun is a re-envisioned and modernised version of the classic coach gun. With picatinny rails for mounting optics and a light weight body, it's the quintessential double barreled shotgun for hunting and self defense. This is a cut down, sawn off version with no stock, cutting the weight down by a lot, but sacrificing accuraccy for it.\n\nAmmo: 12 Gauge \nMagazine Capacity: 2"
ITEM.model = "models/weapons/w_pist_lyxn_dualb.mdl"
ITEM.class = "cw_stoegerddshort"
ITEM.weaponCategory = "primary"
ITEM.width = 3
ITEM.price = 9500
ITEM.height = 1
ITEM.validAttachments = {"md_rmr", "md_microt1", "md_aimpoint", "md_eotech"}

ITEM.bulletweight = 0.031
ITEM.unloadedweight = 1.8

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
						["UniqueID"] = "3552151235",
						["Bone"] = "chest",
						["Name"] = "stdds",
					},
				},
			},
			["self"] = {
				["AffectChildrenOnly"] = true,
				["ClassName"] = "event",
				["UniqueID"] = "1616242402",
				["Event"] = "weapon_class",
				["EditorExpand"] = true,
				["Name"] = "weapon class find simple\"@@1\"",
				["Arguments"] = "cw_stoegerddshort@@0",
			},
		},
	},
	["self"] = {
		["ClassName"] = "group",
		["UniqueID"] = "19255937684",
		["EditorExpand"] = true,
	},
},
}
