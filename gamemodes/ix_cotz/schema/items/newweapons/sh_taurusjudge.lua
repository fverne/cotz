ITEM.name = "Taurus Judge"
ITEM.description= "A home security revolver chambered for .410 buckshot."
ITEM.longdesc = "The Judge, a derivative of the Taurus Tracker, is a long cylindered five shot revolver. The long cylinder allows for loading both .410 Buck and .45 ACP, and this makes the Judge a very versatile revolver, and therefore quite popular in the Zone.\n\nAmmo: .410 Buck\nMagazine Capacity: 5"
ITEM.model = "models/weapons/cwc_judge/w_khri_410jury.mdl"
ITEM.class = "cw_taurusjudge"
ITEM.weaponCategory = "secondary"
ITEM.width = 2
ITEM.price = 6800
ITEM.height = 1
ITEM.canAttach = false

ITEM.bulletweight = 0.020
ITEM.unloadedweight = 0.820

ITEM.repair_PartsComplexity = 1
ITEM.repair_PartsRarity = 2

function ITEM:GetWeight()
  return self.unloadedweight + (self.bulletweight * self:GetData("ammo", 0))
end

ITEM.iconCam = {
	pos = Vector(3, -205, 0),
	ang = Angle(0, 90, 0),
	fov = 4.7,
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
						["Model"] = "models/weapons/cwc_judge/w_khri_410jury.mdl",
						["ClassName"] = "model",
						["Position"] = Vector(-7.5, 2.084, 0.609),
						["AngleOffset"] = Angle(0, 170, 0),
						["EditorExpand"] = true,
						["UniqueID"] = "3544111191",
						["Bone"] = "pelvis",
						["Name"] = "tjudge",
						["Angles"] = Angle(0, 90, 0),
					},
				},
			},
			["self"] = {
				["AffectChildrenOnly"] = true,
				["ClassName"] = "event",
				["UniqueID"] = "1083332402",
				["Event"] = "weapon_class",
				["EditorExpand"] = true,
				["Name"] = "weapon class find simple\"@@1\"",
				["Arguments"] = "cw_taurusjudge@@0",
			},
		},
	},
	["self"] = {
		["ClassName"] = "group",
		["UniqueID"] = "11227613",
		["EditorExpand"] = true,
	},
},
}
