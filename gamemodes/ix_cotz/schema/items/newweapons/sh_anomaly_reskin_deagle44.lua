ITEM.name = "IMI Desert Eagle .44"
ITEM.description= "A large semi-automatic pistol chambered for .44 Magnum"
ITEM.longdesc = "The IMI Desert Eagle is a semi-automatic handgun notable for chambering the largest centerfire cartridge of any magazine fed, self-loading pistol.\nThis variant is chambered in .44 Magnum.\nCompared to its larger sibling, this variant has a larger magazine and more controllable recoil.\nMore common than the .50 AE variant, but doesn't hit as hard."
ITEM.model = "models/flaymi/anomaly/weapons/w_models/wpn_desert_eagle_w.mdl"
ITEM.class = "cw_cotz_anomaly_deagle44"
ITEM.category = "Anomaly Reskins"
ITEM.noBusiness = true
ITEM.weaponCategory = "secondary"
ITEM.price = 14000
ITEM.width = 2
ITEM.height = 1
ITEM.validAttachments = {"md_microt1","md_eotech","md_rmr","md_cobram2"}

ITEM.bulletweight = 0.028
ITEM.unloadedweight = 1.995




function ITEM:GetWeight()
  return self:GetData("weight", self.unloadedweight) + (self.bulletweight * self:GetData("ammo", 0))
end

ITEM.iconCam = {
	pos = Vector(2.7, -205, 3.3),
	ang = Angle(0, 90, 0),
	fov = 3.5,
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
						["Model"] = "models/flaymi/anomaly/weapons/w_models/wpn_desert_eagle_w.mdl",
						["ClassName"] = "model",
						["Translucent"] = true,
						["Position"] = Vector(-9.63, 5.552, -2.062),
						["EditorExpand"] = true,
						["UniqueID"] = "3544642735",
						["Bone"] = "pelvis",
						["Name"] = "deagle",
						["Angles"] = Angle(0, 270, -30),
					},
				},
			},
			["self"] = {
				["AffectChildrenOnly"] = true,
				["ClassName"] = "event",
				["UniqueID"] = "1087631762",
				["Event"] = "weapon_class",
				["Invert"] = false,
				["EditorExpand"] = true,
				["Name"] = "weapon class find simple\"@@1\"",
				["Arguments"] = "cw_cotz_anomaly_deagle44@@0",
			},
		},
	},
	["self"] = {
		["ClassName"] = "group",
		["UniqueID"] = "1197387613",
		["EditorExpand"] = true,
	},
},
}
