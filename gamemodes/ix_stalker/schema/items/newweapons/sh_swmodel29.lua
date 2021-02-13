ITEM.name = "Smith&Wesson Model 29"
ITEM.description= "A double-action revolver chambered for .44 Magnum."
ITEM.longdesc = "The Model 29 was made famous worldwide by the 1971 movie Dirty Harry, being the most powerful production handgun in the world at the time. It has since been surpassed by other offerings from Smith&Wesson, but it still packs a punch.\n\nAmmo: .44 Magnum\nMagazine Capacity: 6"
ITEM.model = ("models/weapons/w_taurus_327p.mdl")
ITEM.class = "cw_model29"
ITEM.weaponCategory = "secondary"
ITEM.price = 12500
ITEM.width = 2
ITEM.height = 1
ITEM.canAttach = false

ITEM.exRender = true
--ITEM.img = ix.util.GetMaterial("vgui/hud/weapons/mateba.png")

ITEM.bulletweight = 0.019
ITEM.unloadedweight = 1.27

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
						["Model"] = "models/weapons/w_taurus_327p.mdl",
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
				["Arguments"] = "cw_model29@@0",
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