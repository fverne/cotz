ITEM.name = "G2 Contender"
ITEM.description= "A markmanship pistol chambered in .45 ACP."
ITEM.longdesc = "Outside of the zone, it is mainly used in marksmanship competitions, as its high accuracy makes it very suited for it. The only issue is its low ammo capacity, as only a single round can be fired at a time. Some STALKERs have been using this with .410 Magnum Buckshot as a fairly cost and weight effective shotgun.\n\nAmmo: .45 ACP\nMagazine Capacity: 1"
ITEM.model = "models/cw2/pistols/w_contender.mdl"
ITEM.class = "cw_contender"
ITEM.weaponCategory = "secondary"
ITEM.width = 3
ITEM.price = 600
ITEM.height = 1
ITEM.validAttachments = {"md_aimpoint", "md_eotech", "md_microt1", "md_saker"}

ITEM.bulletweight = 0.020
ITEM.unloadedweight = 1.5

ITEM.repair_PartsComplexity = 0
ITEM.repair_PartsRarity = 3

function ITEM:GetWeight()
  return self.unloadedweight + (self.bulletweight * self:GetData("ammo", 0))
end

ITEM.iconCam = {
	pos = Vector(5, 200, -1),
	ang = Angle(0, -90, 10),
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
						["Model"] = "models/cw2/pistols/w_contender.mdl",
						["ClassName"] = "model",
						["Position"] = Vector(-7.5, 2.084, 0.609),
						["AngleOffset"] = Angle(0, -10.5, 0),
						["EditorExpand"] = true,
						["UniqueID"] = "3544121191",
						["Bone"] = "pelvis",
						["Name"] = "conted",
						["Angles"] = Angle(0, 90, 0),
					},
				},
			},
			["self"] = {
				["AffectChildrenOnly"] = true,
				["ClassName"] = "event",
				["UniqueID"] = "1083322402",
				["Event"] = "weapon_class",
				["EditorExpand"] = true,
				["Name"] = "weapon class find simple\"@@1\"",
				["Arguments"] = "cw_contender@@0",
			},
		},
	},
	["self"] = {
		["ClassName"] = "group",
		["UniqueID"] = "11227443",
		["EditorExpand"] = true,
	},
},
}
