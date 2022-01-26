ITEM.name = "OTs-02 Kiparis"
ITEM.description= "A submachinegun with a folded stock. Fires 9x18mm."
ITEM.longdesc = "A russian submachinegun, the OTS-02 is a blowback-operated weapon of a conventional design chambered in 9×18mm Makarov.\n\nAmmo: 9x18mm\nMagazine Capacity: 20"
ITEM.model = ("models/dobytchick/weapons/gmzone/deadair/w_kiparis.mdl")
ITEM.class = "cw_kiparis"
ITEM.weaponCategory = "primary"
ITEM.price = 6300
ITEM.width = 3
ITEM.height = 1
ITEM.validAttachments = {"md_tundra9mm"}

ITEM.bulletweight = 0.011
ITEM.unloadedweight = 1.6

ITEM.repair_PartsComplexity = 3
ITEM.repair_PartsRarity = 2

function ITEM:GetWeight()
  return self.unloadedweight + (self.bulletweight * self:GetData("ammo", 0))
end

ITEM.iconCam = {
	ang = Angle(0, 270, 0),
	fov = 5,
	pos = Vector(1, 320, 0),
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
						["Position"] = Vector(-2.386, -2.259, 2.735),
						["Model"] = "models/dobytchick/weapons/gmzone/deadair/w_kiparis.mdl",
						["ClassName"] = "model",
						["EditorExpand"] = true,
						["UniqueID"] = "8544325421",
						["Bone"] = "spine 2",
						["Name"] = "kiparis",
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
				["Arguments"] = "cw_kiparis@@0",
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