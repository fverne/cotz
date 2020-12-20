ITEM.name = "Smith&Wesson .500 Magnum"
ITEM.description= "A double-action revolver chambered for .500 Magnum."
ITEM.longdesc = "PLACEHOLDER.\n\nAmmo: .500 Magnum\nMagazine Capacity: 5"
ITEM.model = ("models/weapons/w_erect_re500.mdl")
ITEM.class = "cw_sw500"
ITEM.weaponCategory = "secondary"
ITEM.price = 14000
ITEM.width = 3
ITEM.height = 1
ITEM.validAttachments = {"md_rmr","md_saker"}

ITEM.exRender = false
ITEM.img = Material("vgui/hud/weapons/sw500.png")

ITEM.bulletweight = 0.019
ITEM.unloadedweight = 1.35

ITEM.repair_PartsComplexity = 2
ITEM.repair_PartsRarity = 4

function ITEM:GetWeight()
  return self.unloadedweight + (self.bulletweight * self:GetData("ammo", 0))
end

ITEM.iconCam = {
	pos = Vector(11, -200, 2),
	ang = Angle(0, 90, 0),
	fov = 6,
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
						["Model"] = "models/weapons/w_erect_re500.mdl",
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
				["Arguments"] = "cw_sw500@@0",
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