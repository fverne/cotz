ITEM.name = "MP-27"
ITEM.description= "An MP-27 .410 Bore O/U Break Action Shotgun."
ITEM.longdesc = "A classic shotgun design, firing .410 buckshot. \n\nAmmo: .410 Gauge \nMagazine Capacity: 2"
ITEM.model = ("models/weapons/tfa_ins2/wpn_mp27_hud_v.mdl")
ITEM.class = "cw_mp27"
ITEM.weaponCategory = "primary"
ITEM.price = 5800
ITEM.width = 5
ITEM.height = 1
ITEM.canAttach = false

ITEM.bulletweight = 0.031
ITEM.unloadedweight = 3.3




function ITEM:GetWeight()
  return self.unloadedweight + (self.bulletweight * self:GetData("ammo", 0))
end

ITEM.iconCam = {
	pos = Vector(2.55, -199.96, 2.97),
	ang = Angle(-0.01, 88.17, 0),
	fov = 13.47
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
						["Angles"] = Angle(0, 0, 180),
						["Position"] = Vector(0.066, -5.077, -3.147),
						["Model"] = "models/weapons/tfa_ins2/wpn_mp27_hud_v.mdl",
						["ClassName"] = "model",
						["EditorExpand"] = true,
						["UniqueID"] = "2352355232",
						["Bone"] = "spine 2",
						["Name"] = "mp27",
					},
				},
			},
			["self"] = {
				["AffectChildrenOnly"] = true,
				["ClassName"] = "event",
				["UniqueID"] = "253235235",
				["Event"] = "weapon_class",
				["EditorExpand"] = true,
				["Name"] = "weapon class find simple\"@@1\"",
				["Arguments"] = "cw_mp27@@0",
			},
		},
	},
	["self"] = {
		["ClassName"] = "group",
		["UniqueID"] = "523455324",
		["EditorExpand"] = true,
	},
},
}