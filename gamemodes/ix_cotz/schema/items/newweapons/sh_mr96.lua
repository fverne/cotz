ITEM.name = "MR96"
ITEM.description= "A double-action revolver chambered for .357 Magnum."
ITEM.longdesc = "The Manurhin MR96 is a French-manufactured, double-action revolver chambered for .357 Magnum.\nThis specific weapon is a 6-inch version.\nEvery MR96 is match grade accurate, shipped with its own factory test target fired at 25 meters.\nAveraging 15 rounds, no group over 20mm diameter with selected ammunition is allowed.\n\nAmmo: .357 Magnum\nMagazine Capacity: 6"
ITEM.model = ("models/weapons/w_pist_mr_96s.mdl")
ITEM.class = "cw_mr96"
ITEM.weaponCategory = "secondary"
ITEM.width = 2
ITEM.price = 8400
ITEM.height = 1

ITEM.canAttach = false

ITEM.bulletweight = 0.019
ITEM.unloadedweight = 1.05

ITEM.repair_PartsComplexity = 1
ITEM.repair_PartsRarity = 3

function ITEM:GetWeight()
  return self.unloadedweight + (self.bulletweight * self:GetData("ammo", 0))
end

ITEM.exRender = false
ITEM.img = ix.util.GetMaterial("vgui/hud/weapons/mr96.png")

ITEM.pacData = {
[1] = {
	["children"] = {
		[1] = {
			["children"] = {
				[1] = {
					["children"] = {
					},
					["self"] = {
						["Model"] = "models/weapons/w_pist_mr_96s.mdl",
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
				["Arguments"] = "cw_mr96@@0",
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