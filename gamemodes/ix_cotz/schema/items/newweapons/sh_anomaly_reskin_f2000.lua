ITEM.name = "FN F2000"
ITEM.description= "A polymer-framed rifle chambered for 5.56x45mm."
ITEM.longdesc = "The FN F2000 is a 5.56×45mm NATO bullpup assault rifle, designed by FN Herstal in Belgium.\nIt is a gas operated, fully automatic and ambidextrous bullpup rifle.\nBoth the safety system and trigger mechanism were adopted from the P90 personal defense weapon; the selector toggle is a rotating disc located below the trigger.\nThe fire selector doubles as the weapon’s manual safety and secures the firearm against accidental discharge.\nThe hammers, group pins, and springs are steel while all other components are nylon injection molding.\nThe shell of the rifle is made of composite materials."
ITEM.model = "models/flaymi/anomaly/weapons/w_models/wpn_fn2000_w.mdl"
ITEM.class = "cw_cotz_anomaly_f2000"
ITEM.category = "Anomaly Reskins"
ITEM.noBusiness = true
ITEM.weaponCategory = "primary"
ITEM.price = 28500
ITEM.width = 4
ITEM.height = 2
ITEM.validAttachments = {"md_saker"}

ITEM.bulletweight = 0.012
ITEM.unloadedweight = 3.6




function ITEM:GetWeight()
  return self:GetData("weight", self.unloadedweight) + (self.bulletweight * self:GetData("ammo", 0))
end

ITEM.iconCam = {
	pos = Vector(-0.3, -205, 5.5),
	ang = Angle(0, 90, 0),
	fov = 7.8,
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
						["Angles"] = Angle(180, 0, 0),
						["Position"] = Vector(16.652, -3.444, -1.132),
						["Model"] = "models/flaymi/anomaly/weapons/w_models/wpn_fn2000_w.mdl",
						["ClassName"] = "model",
						["Translucent"] = true,
						["EditorExpand"] = true,
						["UniqueID"] = "5551187212",
						["Bone"] = "spine 2",
						["Name"] = "f2000",
					},
				},
			},
			["self"] = {
				["AffectChildrenOnly"] = true,
				["ClassName"] = "event",
				["UniqueID"] = "7408540013",
				["Event"] = "weapon_class",
				["Invert"] = false,
				["EditorExpand"] = true,
				["Name"] = "weapon class find simple\"@@1\"",
				["Arguments"] = "cw_cotz_anomaly_f2000@@0",
			},
		},
	},
	["self"] = {
		["ClassName"] = "group",
		["UniqueID"] = "9751620001",
		["EditorExpand"] = true,
	},
},
}
