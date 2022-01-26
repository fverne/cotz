ITEM.name = "Serbu Super Shorty"
ITEM.description= "An extremely short shotgun. Fires 12 Gauge rounds."
ITEM.longdesc = "The Super-Shorty is a compact, stockless, pump-action AOW chambered in 12-gauge. The basic architecture of most of the production models is based on the Mossberg Maverick 88 shotgun.\nAs the weapon is originally manufactured without a shoulder stock, it is considered a smooth-bore handgun, and thus an AOW, rather than a short-barrelled shotgun.\n\nAmmo: 12 Gauge \nMagazine Capacity: 4"
ITEM.model = "models/weapons/w_shot_shortygun.mdl"
ITEM.class = "cw_m3supershort"
ITEM.weaponCategory = "primary"
ITEM.price = 7200
ITEM.width = 2
ITEM.height = 1
ITEM.canAttach = false

ITEM.bulletweight = 0.031
ITEM.unloadedweight = 1.8

ITEM.repair_PartsComplexity = 1
ITEM.repair_PartsRarity = 2

function ITEM:GetWeight()
  return self.unloadedweight + (self.bulletweight * self:GetData("ammo", 0))
end

ITEM.iconCam = {
	pos = Vector(-1, -205, -2.7000000476837),
	ang = Angle(0, 90, 0),
	fov = 5,
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
						["Model"] = "models/weapons/w_shot_shortygun.mdl",
						["ClassName"] = "model",
						["Position"] = Vector(-8.284, -1.114, 3.494),
						["EditorExpand"] = true,
						["UniqueID"] = "3547763835",
						["Bone"] = "pelvis",
						["Name"] = "m3short",
						["Angles"] = Angle(0, -95, -30),
					},
				},
			},
			["self"] = {
				["AffectChildrenOnly"] = true,
				["ClassName"] = "event",
				["UniqueID"] = "1616466402",
				["Event"] = "weapon_class",
				["EditorExpand"] = true,
				["Name"] = "weapon class find simple\"@@1\"",
				["Arguments"] = "cw_m3supershort@@0",
			},
		},
	},
	["self"] = {
		["ClassName"] = "group",
		["UniqueID"] = "1980476967",
		["EditorExpand"] = true,
	},
},
}