ITEM.name = "TOZ-34 Sawnoff"
ITEM.description= "A sawnoff break-action hunting shotgun firing 12 gauge shells."
ITEM.longdesc = "A double barrel hunting shotgun, a classic Russian design popular with hunters and loners alike.\nThis one has had its barrel cut, sacrificing accuracy for portability.\nThe over-and-under barrel placement helps to place shots in the center, but makes the gun more mechanically complex."
ITEM.model = "models/flaymi/anomaly/weapons/w_models/wpn_toz34_obrez_w.mdl"
ITEM.class = "cw_cotz_anomaly_toz34short"
ITEM.category = "Anomaly Reskins"
ITEM.noBusiness = true
ITEM.weaponCategory = "primary"
ITEM.price = 4000
ITEM.width = 3
ITEM.height = 1
ITEM.validAttachments = {
	"md_nightforce_nxs",
	"md_microt1",
	"md_eotech",
	"md_aimpoint",
	"md_cmore",
	"md_reflex",
	"md_schmidt_shortdot",
	"md_acog",
}
ITEM.canAttach = true

ITEM.bulletweight = 0.031
ITEM.unloadedweight = 1.95




function ITEM:GetWeight()
  return self:GetData("weight", self.unloadedweight) + (self.bulletweight * self:GetData("ammo", 0))
end

ITEM.iconCam = {
	pos = Vector(6.1, -205, 3.8),
	ang = Angle(0, 90, 0),
	fov = 6.1,
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
							["Angles"] = Angle(0, 20, 90),
							["Position"] = Vector(8.9, 7.201, -2.5),
							["Model"] = "models/flaymi/anomaly/weapons/w_models/wpn_toz34_obrez_w.mdl",
							["ClassName"] = "model",
						["Translucent"] = true,
							["EditorExpand"] = true,
							["UniqueID"] = "8592523121",
							["Bone"] = "spine 2",
							["Name"] = "toz34s",
						},
					},
				},
				["self"] = {
					["AffectChildrenOnly"] = true,
					["ClassName"] = "event",
					["UniqueID"] = "1424656542",
					["Event"] = "weapon_class",
				["Invert"] = false,
					["EditorExpand"] = true,
					["Name"] = "weapon class find simple\"@@1\"",
					["Arguments"] = "cw_cotz_anomaly_toz34short@@0",
				},
			},
		},
		["self"] = {
			["ClassName"] = "group",
			["UniqueID"] = "81242563283",
			["EditorExpand"] = true,
		},
	},
}
