ITEM.name = "IMI Uzi"
ITEM.description= "A submachinegun with a folded stock. Fires 9x19mm."
ITEM.longdesc = "The Uzi is a name that many know of, remaining one of the most known guns after the AK47 with ten million built.\nThe weapon still remains somewhat rare in the Zone compared to weapons like the MP5 and Mac-11.\nIt was designed in the late 1940's by the Israeli Major Uziel Gal and has been in service since the 1950s.\nIt fires 600 rounds a minute and is useful up to two hundred meters against area targets.\n\nAmmo: 9x19mm\nMagazine Capacity: 30"
ITEM.model = ("models/weapons/w_uzi.mdl")
ITEM.class = "cw_uzi"
ITEM.weaponCategory = "primary"
ITEM.width = 3
ITEM.price = 7500
ITEM.height = 2
ITEM.validAttachments = {"md_microt1","md_eotech","md_aimpoint","md_cmore","md_reflex","md_tundra9mm","md_foregrip"}

ITEM.bulletweight = 0.008
ITEM.unloadedweight = 3.5

ITEM.repair_PartsComplexity = 1
ITEM.repair_PartsRarity = 1

function ITEM:GetWeight()
  return self.unloadedweight + (self.bulletweight * self:GetData("ammo", 0))
end

ITEM.iconCam = {
	pos = Vector(10, 200, 0),
	ang = Angle(0, 270, 0),
	fov = 6.5,
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
						["Angles"] = Angle(0, 0, 0),
						["Position"] = Vector(-19.377, -2.721, 2.522),
						["Model"] = "models/weapons/w_uzi.mdl",
						["ClassName"] = "model",
						["EditorExpand"] = true,
						["UniqueID"] = "8544325421",
						["Bone"] = "spine 2",
						["Name"] = "uzi",
					},
				},
			},
			["self"] = {
				["AffectChildrenOnly"] = true,
				["ClassName"] = "event",
				["UniqueID"] = "1036853672",
				["Event"] = "weapon_class",
				["EditorExpand"] = true,
				["Name"] = "weapon class find simple\"@@1\"",
				["Arguments"] = "cw_uzi@@0",
			},
		},
	},
	["self"] = {
		["ClassName"] = "group",
		["UniqueID"] = "8537651483",
		["EditorExpand"] = true,
	},
},
}