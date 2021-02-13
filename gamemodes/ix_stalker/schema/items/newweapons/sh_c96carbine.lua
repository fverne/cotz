ITEM.name = "Mauser C96 Carbine"
ITEM.description= "A semi-automatic pistol that was originally produced by German arms manufacturer Mauser from 1896 to 1937."
ITEM.longdesc = "It has a few distinctive characteristics, mainly the integral box magazine in front of the trigger, \nthe long barrel and an iconic grip shaped like the handle of a broom.\nWith its long barrel and high-velocity cartridge, the Mauser C96 had superior range and better penetration than most other pistols of its era.\nThis is a special carbine version with a larger detachable magazine, longer barrel and shoulder stock. It also has the select-fire capability.\n\nAmmo: 7.62x25mm\nMagazine Capacity: 20"
ITEM.model = "models/khrcw2/doipack/w_c96c.mdl"
ITEM.class = "cw_c96carbine"
ITEM.weaponCategory = "primary"
ITEM.price = 6750
ITEM.width = 4
ITEM.height = 1
ITEM.canAttach = true
ITEM.validAttachments = {"md_rmr","md_tundra9mm"}

ITEM.bulletweight = 0.010
ITEM.unloadedweight = 1.45

ITEM.repair_PartsComplexity = 4
ITEM.repair_PartsRarity = 1

function ITEM:GetWeight()
  return self.unloadedweight + (self.bulletweight * self:GetData("ammo", 0))
end

ITEM.iconCam = {
	pos = Vector(4, -205, 0),
	ang = Angle(0, 90, 0),
	fov = 13,
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
						["Model"] = "models/khrcw2/doipack/w_c96c.mdl",
						["ClassName"] = "model",
						["Position"] = Vector(11.765, -4.449, -2.752),
						["EditorExpand"] = true,
						["UniqueID"] = "c96carbine",
						["Bone"] = "spine 2",
						["Name"] = "c96carbine",
						["Angles"] = Angle(180, 0, 0),
					},
				},
			},
			["self"] = {
				["AffectChildrenOnly"] = true,
				["ClassName"] = "event",
				["UniqueID"] = "24624654235",
				["Event"] = "weapon_class",
				["EditorExpand"] = true,
				["Name"] = "weapon class find simple\"@@1\"",
				["Arguments"] = "cw_c96carbine@@0",
			},
		},
	},
	["self"] = {
		["ClassName"] = "group",
		["UniqueID"] = "15315134235",
		["EditorExpand"] = true,
	},
},
}