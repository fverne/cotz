ITEM.name = "TOZ-66"
ITEM.description= "A break-action hunting shotgun firing 12 gauge shells."
ITEM.longdesc = "A double barrel hunting shotgun, a classic Russian design popular with hunters and loners alike.\nThe cheap price and long barrel makes it useful for engaging animals and unarmed targets at ranges up to fifty meters.\nThe side-by-side barrels makes the weapon simpler built compared to the TOZ, but the sights are not aligned to both barrels.\n\nAmmo: 12 Gauge \nMagazine Capacity: 2"
ITEM.model = "models/dobytchick/weapons/gmzone/deadair/w_toz66.mdl"

ITEM.width = 5
ITEM.height = 1
ITEM.price = 7900

ITEM.class = "cw_toz66"
ITEM.weaponCategory = "primary"

ITEM.canAttach = false

ITEM.bulletweight = 0.031
ITEM.unloadedweight = 3.2

ITEM.repair_PartsComplexity = 1
ITEM.repair_PartsRarity = 1

function ITEM:GetWeight()
  return self.unloadedweight + (self.bulletweight * self:GetData("ammo", 0))
end

ITEM.iconCam = {
	pos = Vector(-9, 52, -0.30000001192093),
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
						["Model"] = "models/dobytchick/weapons/gmzone/deadair/w_toz66.mdl",
						["ClassName"] = "model",
						["Angles"] = Angle(0, 0, 180),
						["Position"] = Vector(6.687, -2.597, -5.128),
						["EditorExpand"] = true,
						["UniqueID"] = "3552126135",
						["Bone"] = "spine 2",
						["Name"] = "toz66",
					},
				},
			},
			["self"] = {
				["AffectChildrenOnly"] = true,
				["ClassName"] = "event",
				["UniqueID"] = "1616512402",
				["Event"] = "weapon_class",
				["EditorExpand"] = true,
				["Name"] = "weapon class find simple\"@@1\"",
				["Arguments"] = "cw_toz66@@0",
			},
		},
	},
	["self"] = {
		["ClassName"] = "group",
		["UniqueID"] = "1980937684",
		["EditorExpand"] = true,
	},
},
}