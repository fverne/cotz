ITEM.name = "TOZ BM-16 Sawnoff"
ITEM.description= "A sawn-off hunting shotgun. Fires 12 gauge."
ITEM.longdesc = "This sawn-off double barrelled shotgun is a must-have in many rookies eyes.\nIt dispatches mutants and unarmored stalkers with ease, and is cheap to keep supplied with ammo.\n\nAmmo: 12 Gauge \nMagazine Capacity: 2"
ITEM.model = "models/dobytchick/weapons/gmzone/deadair/w_toz66_obrez.mdl"
ITEM.class = "cw_toz66short"
ITEM.weaponCategory = "primary"
ITEM.price = 4400
ITEM.width = 3
ITEM.height = 1
ITEM.canAttach = false

ITEM.bulletweight = 0.031
ITEM.unloadedweight = 1.54

ITEM.repair_PartsComplexity = 1
ITEM.repair_PartsRarity = 1

function ITEM:GetWeight()
  return self.unloadedweight + (self.bulletweight * self:GetData("ammo", 0))
end

ITEM.iconCam = {
	pos = Vector(-5, 25, 0.5),
	ang = Angle(0, 270, 0),
	fov = 45,
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
						["Model"] = "models/dobytchick/weapons/gmzone/deadair/w_toz66_obrez.mdl",
						["ClassName"] = "model",
						["Position"] = Vector(-7.89, 4.128, 0),
						["EditorExpand"] = true,
						["UniqueID"] = "3976837955",
						["Bone"] = "pelvis",
						["Name"] = "toz66short",
						["Angles"] = Angle(10, 90, 30),
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
				["Arguments"] = "cw_toz66short@@0",
			},
		},
	},
	["self"] = {
		["ClassName"] = "group",
		["UniqueID"] = "1954394367",
		["EditorExpand"] = true,
	},
},
}