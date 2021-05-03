ITEM.name = "Striker"
ITEM.description= "A revolver-magazine fed shotgun. 12 gauge."
ITEM.longdesc = "The Striker-12 is an unique shotgun, as it is fed by a permanently attached revolver magazine.\nWhile being an effective tool in combat and priceless for mutant hunting, it's unwieldy and has a non-adjustible stock.\nThe drum has to be manually winded up, each shell has to be manually ejected and it features a very janky trigger.\n\nAmmo: 12 Gauge\nMagazine Capacity: 12"
ITEM.model = ("models/weapons/w_shot_strike.mdl")
ITEM.class = "cw_striker"
ITEM.weaponCategory = "primary"
ITEM.price = 28900
ITEM.width = 3
ITEM.height = 1
ITEM.canAttach = false

ITEM.bulletweight = 0.031
ITEM.unloadedweight = 4.2

ITEM.repair_PartsComplexity = 4
ITEM.repair_PartsRarity = 2

function ITEM:GetWeight()
  return self.unloadedweight + (self.bulletweight * self:GetData("ammo", 0))
end

ITEM.iconCam = {
	pos = Vector(1, -205, -1.5),
	ang = Angle(0, 90, 0),
	fov = 7.5,
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
						["Angles"] = Angle(0, 180, 180),
						["Position"] = Vector(5.922, -5.054, -4.465),
						["Model"] = "models/weapons/w_shot_strike.mdl",
						["ClassName"] = "model",
						["EditorExpand"] = true,
						["UniqueID"] = "8883923491",
						["Bone"] = "spine 2",
						["Name"] = "striker",
					},
				},
			},
			["self"] = {
				["AffectChildrenOnly"] = true,
				["ClassName"] = "event",
				["UniqueID"] = "1065346402",
				["Event"] = "weapon_class",
				["EditorExpand"] = true,
				["Name"] = "weapon class find simple\"@@1\"",
				["Arguments"] = "cw_striker@@0",
			},
		},
	},
	["self"] = {
		["ClassName"] = "group",
		["UniqueID"] = "8137397183",
		["EditorExpand"] = true,
	},
},
}