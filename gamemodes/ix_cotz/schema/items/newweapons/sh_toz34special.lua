ITEM.name = "TOZ-34 Special"
ITEM.description= "A break-action hunting shotgun firing 12 gauge shells."
ITEM.longdesc = "A special edition double barrel shotgun, customized for the long-range hunting. Modified barrel and integrated scope increase the overall damage and effective range.\n\nAmmo: 12 Gauge \nMagazine Capacity: 2"
ITEM.model = ("models/weapons/w_sv10.mdl")
ITEM.class = "cw_toz34special"
ITEM.weaponCategory = "primary"
ITEM.price = 27500
ITEM.width = 6
ITEM.height = 1
ITEM.canAttach = false

ITEM.bulletweight = 0.031
ITEM.unloadedweight = 3.6


function ITEM:GetWeight()
  return self:GetData("weight", self.unloadedweight) + (self.bulletweight * self:GetData("ammo", 0))
end

ITEM.iconCam = {
	pos = Vector(4, -200, -0.5),
	ang = Angle(0, 90, 0),
	fov = 14,
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
						["Model"] = "models/weapons/w_sv10.mdl",
						["ClassName"] = "model",
						["EditorExpand"] = true,
						["UniqueID"] = "8592523121",
						["Bone"] = "spine 2",
						["Name"] = "toz34special",
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
				["Arguments"] = "cw_toz34special@@0",
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