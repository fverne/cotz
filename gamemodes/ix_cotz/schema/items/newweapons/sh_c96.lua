ITEM.name = "Mauser C96"
ITEM.description= "A semi-automatic pistol that was originally produced by German arms manufacturer Mauser from 1896 to 1937."
ITEM.longdesc = "It has a few distinctive characteristics, mainly the integral box magazine in front of the trigger, \nthe long barrel and an iconic grip shaped like the handle of a broom.\nWith its long barrel and high-velocity cartridge, the Mauser C96 had superior range and better penetration than most other pistols of its era.\n\nAmmo: 7.62x25mm\nMagazine Capacity: 10"
ITEM.model = "models/khrcw2/doipack/w_c96.mdl"
ITEM.class = "cw_c96"
ITEM.weaponCategory = "secondary"
ITEM.price = 3450
ITEM.width = 2
ITEM.height = 1
ITEM.canAttach = true
ITEM.validAttachments = {"md_rmr","md_tundra9mm"}

ITEM.bulletweight = 0.010
ITEM.unloadedweight = 1.13

ITEM.repair_PartsComplexity = 3
ITEM.repair_PartsRarity = 1

function ITEM:GetWeight()
  return self.unloadedweight + (self.bulletweight * self:GetData("ammo", 0))
end

ITEM.iconCam = {
	pos = Vector(5, -205, -2),
	ang = Angle(0, 90, 0),
	fov = 6,
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
						["Model"] = "models/khrcw2/doipack/w_c96.mdl",
						["ClassName"] = "model",
						["Position"] = Vector(-7.301, 5.344, 2.402),
						["EditorExpand"] = true,
						["UniqueID"] = "12513251",
						["Bone"] = "pelvis",
						["Name"] = "c96",
						["Angles"] = Angle(0, 270, -30),
					},
				},
			},
			["self"] = {
				["AffectChildrenOnly"] = true,
				["ClassName"] = "event",
				["UniqueID"] = "2452423523",
				["Event"] = "weapon_class",
				["EditorExpand"] = true,
				["Name"] = "weapon class find simple\"@@1\"",
				["Arguments"] = "cw_c96@@0",
			},
		},
	},
	["self"] = {
		["ClassName"] = "group",
		["UniqueID"] = "15315135",
		["EditorExpand"] = true,
	},
},
}