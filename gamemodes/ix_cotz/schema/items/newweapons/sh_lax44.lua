ITEM.name = "Henry Lever Action X Model .44"
ITEM.description= "A lever-operated shotgun, chambered in .44 Magnum."
ITEM.longdesc = "A fairly modern lever action rifle, made in America. Chambered in .44 Magnum, it is mostly designed for hunting medium game.\n\nAmmo: .44 Magnum \nMagazine Capacity: 6+1"
ITEM.model = ("models/weapons/w_bocw_ironhide.mdl")
ITEM.class = "cw_lax44"
ITEM.weaponCategory = "primary"
ITEM.price = 26500
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
						["UniqueID"] = "5125132153",
						["Bone"] = "spine 2",
						["Name"] = "lax410",
					},
				},
			},
			["self"] = {
				["AffectChildrenOnly"] = true,
				["ClassName"] = "event",
				["UniqueID"] = "152515251",
				["Event"] = "weapon_class",
				["Invert"] = false,
				["EditorExpand"] = true,
				["Name"] = "weapon class find simple\"@@1\"",
				["Arguments"] = "cw_lax44@@0",
			},
		},
	},
	["self"] = {
		["ClassName"] = "group",
		["UniqueID"] = "51251521",
		["EditorExpand"] = true,
	},
},
}