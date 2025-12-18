ITEM.name = "IMI Uzi Custom"
ITEM.description= "A submachinegun with a folded stock. Fires .50 AE."
ITEM.longdesc = "The Uzi is a name that many know of, remaining one of the most known guns after the AK47 with ten million built.\nThe weapon still remains somewhat rare in the Zone compared to weapons like the MP5 and Mac-11.\nIt was designed in the late 1940's by the Israeli Major Uziel Gal and has been in service since the 1950s.\nIt fires 600 rounds a minute and is useful up to two hundred meters against area targets.\nThis specially zone-modified has been rigged to fire .50 Action Express, purpose-made for taking out the toughest beasts in the zone.\nAmmo: .50 AE\nMagazine Capacity: 18"
ITEM.model = ("models/weapons/w_uzi.mdl")
ITEM.class = "cw_uzi50ae"
ITEM.weaponCategory = "primary"
ITEM.width = 3
ITEM.price = 95000
ITEM.height = 2
ITEM.validAttachments = {"md_microt1","md_eotech","md_aimpoint","md_cmore","md_reflex","md_tundra9mm","md_foregrip"}

ITEM.bulletweight = 0.028
ITEM.unloadedweight = 3.5




function ITEM:GetWeight()
  return self:GetData("weight", self.unloadedweight) + (self.bulletweight * self:GetData("ammo", 0))
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
						["Angles"] = Angle(0, 0, 180),
						["Position"] = Vector(-7.7, -4.5, -3.3),
						["Model"] = "models/weapons/w_uzi.mdl",
						["ClassName"] = "model",
						["EditorExpand"] = true,
						["UniqueID"] = "623623236236",
						["Bone"] = "spine 2",
						["Name"] = "uzi",
					},
				},
			},
			["self"] = {
				["AffectChildrenOnly"] = true,
				["ClassName"] = "event",
				["UniqueID"] = "266234623",
				["Event"] = "weapon_class",
				["Invert"] = false,
				["EditorExpand"] = true,
				["Name"] = "weapon class find simple\"@@1\"",
				["Arguments"] = "cw_uzi50ae@@0",
			},
		},
	},
	["self"] = {
		["ClassName"] = "group",
		["UniqueID"] = "262362643",
		["EditorExpand"] = true,
	},
},
}