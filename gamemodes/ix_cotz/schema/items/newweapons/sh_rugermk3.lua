ITEM.name = "Ruger MKIII"
ITEM.description= "An internally silenced target practice pistol chambered for .22LR."
ITEM.longdesc = "The Ruger Mark III is a .22 Long Rifle semi-automatic pistol manufactured by Sturm, Ruger & Company.\nIt is the successor to the Ruger MK II, and includes several new features.\n\nAmmo: .22LR\nMagazine Capacity: 10"
ITEM.model = ("models/weapons/w_pist_ruger23a1.mdl")
ITEM.class = "cw_rugermk3"
ITEM.weaponCategory = "secondary"
ITEM.width = 2
ITEM.price = 3000
ITEM.height = 1
ITEM.canAttach = false

ITEM.bulletweight = 0.0025
ITEM.unloadedweight = 0.900

ITEM.repair_PartsComplexity = 1
ITEM.repair_PartsRarity = 2

function ITEM:GetWeight()
  return self.unloadedweight + (self.bulletweight * self:GetData("ammo", 0))
end

ITEM.iconCam = {
	pos = Vector(-2, 200, -1.6000000238419),
	ang = Angle(0, 270, -1.2000000476837),
	fov = 4,
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
						["Model"] = "models/weapons/w_pist_ruger23a1.mdl",
						["ClassName"] = "model",
						["Position"] = Vector(-6.862, 3.164, 3.017),
						["EditorExpand"] = true,
						["UniqueID"] = "3543276351",
						["Bone"] = "pelvis",
						["Name"] = "ruger",
						["Angles"] = Angle(0, 90, 30),
					},
				},
			},
			["self"] = {
				["AffectChildrenOnly"] = true,
				["ClassName"] = "event",
				["UniqueID"] = "1532812402",
				["Event"] = "weapon_class",
				["EditorExpand"] = true,
				["Name"] = "weapon class find simple\"@@1\"",
				["Arguments"] = "cw_rugermk3@@0",
			},
		},
	},
	["self"] = {
		["ClassName"] = "group",
		["UniqueID"] = "8358321183",
		["EditorExpand"] = true,
	},
},
}