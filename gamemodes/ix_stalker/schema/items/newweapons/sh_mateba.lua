ITEM.name = "Mateba Autorevolver"
ITEM.description= "A double-action revolver chambered for .44 Magnum."
ITEM.longdesc = "The Mateba Model 6 Unica (often known simply as the Mateba or the Mateba Autorevolver) is a recoil operated semi-automatic revolver, one of only a few of this type ever produced. It was developed by Mateba, based in Pavia, Italy.\nThe Mateba Model 6 uses the recoil from firing to rotate the cylinder and cock the hammer, unlike conventional revolvers, which depend on the user physically pulling the trigger and/or cocking the hammer to actuate the weapon's mechanism of operation.\n\nAmmo: .44 Magnum\nMagazine Capacity: 6"
ITEM.model = ("models/weapons/cwc_mateba/w_pist_mateba.mdl")
ITEM.class = "cw_mateba"
ITEM.weaponCategory = "secondary"
ITEM.price = 14000
ITEM.width = 2
ITEM.height = 1
ITEM.validAttachments = {"md_microt1","md_rmr","md_saker"}

ITEM.exRender = false
ITEM.img = ix.util.GetMaterial("vgui/hud/weapons/mateba.png")

ITEM.bulletweight = 0.019
ITEM.unloadedweight = 1.35

ITEM.repair_PartsComplexity = 5
ITEM.repair_PartsRarity = 2

function ITEM:GetWeight()
  return self.unloadedweight + (self.bulletweight * self:GetData("ammo", 0))
end

ITEM.iconCam = {
	pos = Vector(8, -205, 1.5),
	ang = Angle(0, 90, 0),
	fov = 4.2,
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
						["Model"] = "models/weapons/cwc_mateba/w_pist_mateba.mdl",
						["ClassName"] = "model",
						["Position"] = Vector(-9.679, 9.712, 0.126),
						["EditorExpand"] = true,
						["UniqueID"] = "3589648235",
						["Bone"] = "pelvis",
						["Name"] = "mr96",
						["Angles"] = Angle(0, 270, -30),
					},
				},
			},
			["self"] = {
				["AffectChildrenOnly"] = true,
				["ClassName"] = "event",
				["UniqueID"] = "1486277682",
				["Event"] = "weapon_class",
				["EditorExpand"] = true,
				["Name"] = "weapon class find simple\"@@1\"",
				["Arguments"] = "cw_mateba@@0",
			},
		},
	},
	["self"] = {
		["ClassName"] = "group",
		["UniqueID"] = "1977895467",
		["EditorExpand"] = true,
	},
},
}