ITEM.name = "Smith&Wesson M&P R8"
ITEM.description= "A double-action revolver chambered for .357 Magnum."
ITEM.longdesc = "This small-framed revolver is a newer offering from Smith&Wesson, housing 8 shots in its cylinder, giving a slightly higher capacity than most revolvers. This makes it quite popular in the Zone, as being caught with an empty cylinder usually means death.\n\nAmmo: .357 Magnum\nMagazine Capacity: 8"
ITEM.model = ("models/weapons/w_revolver_r8.mdl")
ITEM.class = "cw_swr8"
ITEM.weaponCategory = "secondary"
ITEM.price = 12000
ITEM.width = 2
ITEM.height = 1
ITEM.validAttachments = {"md_rmr"}

ITEM.exRender = true
--ITEM.img = ix.util.GetMaterial("vgui/hud/weapons/mateba.png")

ITEM.bulletweight = 0.019
ITEM.unloadedweight = 1.01

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
						["Model"] = "models/weapons/w_revolver_r8.mdl",
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
				["Arguments"] = "cw_swr8@@0",
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