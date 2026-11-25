ITEM.name = "HK MP5"
ITEM.description= "A black submachinegun. Fires 9x19mm."
ITEM.longdesc = "The MP5 is an iconic German submachinegun developed in the 1960s, known for it's reliability and effectiveness.\nThe MP5 differentiates from other submachineguns because it fires from a closed bolt.\nIt uses the same operating mechanism as the G3 rifle which has made it one of the most accurate submachineguns in the world."
ITEM.model = "models/flaymi/anomaly/weapons/w_models/wpn_mp5_w.mdl"
ITEM.class = "cw_cotz_anomaly_mp5"
ITEM.category = "Anomaly Reskins"
ITEM.noBusiness = true
ITEM.weaponCategory = "primary"
ITEM.price = 12750
ITEM.width = 3
ITEM.height = 2
ITEM.validAttachments = {"md_microt1","md_eotech","md_aimpoint","md_cmore","md_reflex","md_tundra9mm", "md_schmidt_shortdot", "md_acog", "md_nightforce_nxs"}
ITEM.validUpgrades = {"up_firerate1"}

ITEM.bulletweight = 0.008
ITEM.unloadedweight = 2.52




function ITEM:GetWeight()
  return self:GetData("weight", self.unloadedweight) + (self.bulletweight * self:GetData("ammo", 0))
end

ITEM.iconCam = {
	pos = Vector(1.2, -205, 5.6),
	ang = Angle(0, 90, 0),
	fov = 7.7,
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
						["Position"] = Vector(17.39, -2.808, 0.361),
						["Model"] = "models/flaymi/anomaly/weapons/w_models/wpn_mp5_w.mdl",
						["ClassName"] = "model",
						["Translucent"] = true,
						["EditorExpand"] = true,
						["UniqueID"] = "79478794673",
						["Bone"] = "spine 2",
						["Name"] = "mp5",
					},
				},
			},
			["self"] = {
				["AffectChildrenOnly"] = true,
				["ClassName"] = "event",
				["UniqueID"] = "6247478922",
				["Event"] = "weapon_class",
				["Invert"] = false,
				["EditorExpand"] = true,
				["Name"] = "weapon class find simple\"@@1\"",
				["Arguments"] = "cw_cotz_anomaly_mp5@@0",
			},
		},
	},
	["self"] = {
		["ClassName"] = "group",
		["UniqueID"] = "8647796348",
		["EditorExpand"] = true,
	},
},
}
