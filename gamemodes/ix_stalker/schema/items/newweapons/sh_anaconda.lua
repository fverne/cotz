ITEM.name = "Colt Anaconda"
ITEM.description= "A snub-nosed double-action revolver chambered for .44 Magnum."
ITEM.longdesc = "The Colt Anaconda is a double action handgun chambered for the .44 Magnum cartridge, built on Colt's large I-frame.\nAnacondas have a reputation for accuracy, smooth trigger pull, and a tight cylinder lock-up.\nIt is quite heavy considering it is a handgun.\n\nAmmo: .44 Magnum\nMagazine Capacity: 6"
ITEM.model = ("models/weapons/w_python.mdl")
ITEM.class = "cw_python"
ITEM.weaponCategory = "secondary"
ITEM.price = 7500
ITEM.width = 2
ITEM.height = 1

ITEM.canAttach = false

ITEM.bulletweight = 0.019
ITEM.unloadedweight = 1.3

ITEM.repair_PartsComplexity = 1
ITEM.repair_PartsRarity = 2

function ITEM:GetWeight()
  return self.unloadedweight + (self.bulletweight * self:GetData("ammo", 0))
end

ITEM.exRender = false
ITEM.img = Material("vgui/hud/weapons/python.png")

ITEM.pacData = {
[1] = {
	["children"] = {
		[1] = {
			["children"] = {
				[1] = {
					["children"] = {
					},
					["self"] = {
						["Model"] = "models/weapons/w_python.mdl",
						["ClassName"] = "model",
						["Position"] = Vector(-9.368, -6.696, 0.495),
						["EditorExpand"] = true,
						["UniqueID"] = "3989742835",
						["Bone"] = "pelvis",
						["Name"] = "python",
						["Angles"] = Angle(0, 90, 30),
					},
				},
			},
			["self"] = {
				["AffectChildrenOnly"] = true,
				["ClassName"] = "event",
				["UniqueID"] = "1643489682",
				["Event"] = "weapon_class",
				["EditorExpand"] = true,
				["Name"] = "weapon class find simple\"@@1\"",
				["Arguments"] = "cw_python@@0",
			},
		},
	},
	["self"] = {
		["ClassName"] = "group",
		["UniqueID"] = "1989894367",
		["EditorExpand"] = true,
	},
},
}