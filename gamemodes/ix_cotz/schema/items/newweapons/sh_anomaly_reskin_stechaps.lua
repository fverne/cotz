ITEM.name = "Stechkin APS"
ITEM.description= "A fully-automatic handgun with a large magazine. Fires 9x18mm."
ITEM.longdesc = "When the Stetchkin automatic pistol was phased out of Soviet army service, a few hundred mysteriously made their way into the Zone.\nIt's low weight, fully automatic capacity and concealability makes it an useful alternative to a submachinegun.\nAutomatic fire makes recoil control an issue."
ITEM.model = "models/flaymi/anomaly/weapons/w_models/wpn_aps.mdl"
ITEM.class = "cw_cotz_anomaly_stechaps"
ITEM.category = "Anomaly Reskins"
ITEM.noBusiness = true
ITEM.weaponCategory = "secondary"
ITEM.price =  7500
ITEM.width = 2
ITEM.height = 1
ITEM.validAttachments = {"md_tundra9mm"}

ITEM.bulletweight = 0.011
ITEM.unloadedweight = 1.22




function ITEM:GetWeight()
  return self:GetData("weight", self.unloadedweight) + (self.bulletweight * self:GetData("ammo", 0))
end

ITEM.exRender = false
ITEM.img = ix.util.GetMaterial("vgui/hud/weapons/stechaps.png")

ITEM.pacData = {
[1] = {
	["children"] = {
		[1] = {
			["children"] = {
				[1] = {
					["children"] = {
					},
					["self"] = {
						["Model"] = "models/flaymi/anomaly/weapons/w_models/wpn_aps.mdl",
						["ClassName"] = "model",
						["Translucent"] = true,
						["Position"] = Vector(-7.72, -1.028, 4.074),
						["EditorExpand"] = true,
						["UniqueID"] = "3532329835",
						["Bone"] = "pelvis",
						["Name"] = "stech aps",
						["Angles"] = Angle(-30, 180, 0),
					},
				},
			},
			["self"] = {
				["AffectChildrenOnly"] = true,
				["ClassName"] = "event",
				["UniqueID"] = "1640777222",
				["Event"] = "weapon_class",
				["Invert"] = false,
				["EditorExpand"] = true,
				["Name"] = "weapon class find simple\"@@1\"",
				["Arguments"] = "cw_cotz_anomaly_stechaps@@0",
			},
		},
	},
	["self"] = {
		["ClassName"] = "group",
		["UniqueID"] = "1915262467",
		["EditorExpand"] = true,
	},
},
}

ITEM.iconCam = {
	pos = Vector(1.9, -205, -1.9),
	ang = Angle(0, 90, 0),
	fov = 3.3,
}
