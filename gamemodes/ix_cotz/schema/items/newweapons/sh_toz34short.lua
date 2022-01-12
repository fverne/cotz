ITEM.name = "TOZ-34 Sawnoff"
ITEM.description= "A sawnoff break-action hunting shotgun firing 12 gauge shells."
ITEM.longdesc = "A double barrel hunting shotgun, a classic Russian design popular with hunters and loners alike.\nThis one has had its barrel cut, sacrificing accuracy for portability.\nThe over-and-under barrel placement helps to place shots in the center, but makes the gun more mechanically complex.\n\nAmmo: 12 Gauge \nMagazine Capacity: 2"
ITEM.model = ("models/weapons/w_sv10s.mdl")
ITEM.class = "cw_toz34short"
ITEM.weaponCategory = "primary"
ITEM.price = 4000
ITEM.width = 3
ITEM.height = 1
ITEM.canAttach = false

ITEM.bulletweight = 0.031
ITEM.unloadedweight = 1.95

ITEM.repair_PartsComplexity = 2
ITEM.repair_PartsRarity = 1

function ITEM:GetWeight()
  return self.unloadedweight + (self.bulletweight * self:GetData("ammo", 0))
end

ITEM.iconCam = {
	pos = Vector(-10.60000038147, -2.5, 200),
	ang = Angle(90, 0, 80),
	fov = 7,
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
						["Angles"] = Angle(1.166, 74.608, -58.069),
						["Position"] = Vector(4.528, 7.364, -7.2),
						["Model"] = "models/weapons/w_sv10s.mdl",
						["ClassName"] = "model",
						["EditorExpand"] = true,
						["UniqueID"] = "8592523121",
						["Bone"] = "pelvis",
						["Name"] = "toz34s",
					},
				},
			},
			["self"] = {
				["AffectChildrenOnly"] = true,
				["ClassName"] = "event",
				["UniqueID"] = "1424656542",
				["Event"] = "weapon_class",
				["EditorExpand"] = true,
				["Name"] = "weapon class find simple\"@@1\"",
				["Arguments"] = "cw_toz34short@@0",
			},
		},
	},
	["self"] = {
		["ClassName"] = "group",
		["UniqueID"] = "81242563283",
		["EditorExpand"] = true,
	},
},
}