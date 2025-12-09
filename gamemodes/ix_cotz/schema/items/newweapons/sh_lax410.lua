ITEM.name = "Henry Lever Action X Model .410"
ITEM.description= "A lever-operated shotgun, chambered in .410."
ITEM.longdesc = "A fairly modern lever action shotgun, made in America. Chambered in .410 gauge, it is mostly designed for hunting small game. It is also capable of chambering and firing .45 ACP, however the lack of rifling in the barrel makes it inaccurate.\n\nAmmo: .410 Gauge \nMagazine Capacity: 4+1"
ITEM.model = ("models/weapons/w_bocw_ironhide.mdl")
ITEM.class = "cw_lax410"
ITEM.weaponCategory = "primary"
ITEM.price = 11000
ITEM.width = 6
ITEM.height = 1
ITEM.canAttach = false

ITEM.bulletweight = 0.031
ITEM.unloadedweight = 3.45




function ITEM:GetWeight()
  return self:GetData("weight", self.unloadedweight) + (self.bulletweight * self:GetData("ammo", 0))
end

ITEM.exRender = true
ITEM.iconCam = {
	pos = Vector(50, 7, -1),
	ang = Angle(0, 180, 0),
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
						["Angles"] = Angle(0, -90, 180),
						["Position"] = Vector(11.98, -4.153, -3.575),
						["Model"] = "models/weapons/w_bocw_ironhide.mdl",
						["ClassName"] = "model",
						["EditorExpand"] = true,
						["UniqueID"] = "15513215",
						["Bone"] = "spine 2",
						["Name"] = "lax410",
					},
				},
			},
			["self"] = {
				["AffectChildrenOnly"] = true,
				["ClassName"] = "event",
				["UniqueID"] = "1534252",
				["Event"] = "weapon_class",
				["Invert"] = false,
				["EditorExpand"] = true,
				["Name"] = "weapon class find simple\"@@1\"",
				["Arguments"] = "cw_lax410@@0",
			},
		},
	},
	["self"] = {
		["ClassName"] = "group",
		["UniqueID"] = "12452313",
		["EditorExpand"] = true,
	},
},
}