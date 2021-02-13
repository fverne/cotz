ITEM.name = "M1917 Revolver"
ITEM.description= "A single-action variant of a revolver chambered for .45 ACP."
ITEM.longdesc = "The M1917 Revolvers are six-shot, .45 ACP, large frame revolvers adopted by the United States Military in 1917, to supplement the standard .45 ACP M1911 pistol during World War I.\n\nAmmo: .45 ACP\nMagazine Capacity: 6"
ITEM.model = ("models/khrcw2/doipack/w_sw1917.mdl")
ITEM.class = "cw_m1917"
ITEM.weaponCategory = "secondary"
ITEM.price = 850
ITEM.width = 2
ITEM.height = 1
ITEM.validAttachments = {"md_rmr","md_cobram2"}

ITEM.bulletweight = 0.020
ITEM.unloadedweight = 1.1

ITEM.repair_PartsComplexity = 1
ITEM.repair_PartsRarity = 3

function ITEM:GetWeight()
  return self.unloadedweight + (self.bulletweight * self:GetData("ammo", 0))
end

ITEM.iconCam = {
	pos = Vector(3.5, -205, -1.8999999761581),
	ang = Angle(0, 90, 0),
	fov = 4,
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
						["Model"] = "models/khrcw2/doipack/w_sw1917.mdl",
						["ClassName"] = "model",
						["Position"] = Vector(-7.063, 5.647, 2.876),
						["EditorExpand"] = true,
						["UniqueID"] = "33589648235",
						["Bone"] = "pelvis",
						["Name"] = "m1917",
						["Angles"] = Angle(0, -90, -30),
					},
				},
			},
			["self"] = {
				["AffectChildrenOnly"] = true,
				["ClassName"] = "event",
				["UniqueID"] = "14862772682",
				["Event"] = "weapon_class",
				["EditorExpand"] = true,
				["Name"] = "weapon class find simple\"@@1\"",
				["Arguments"] = "cw_m1917@@0",
			},
		},
	},
	["self"] = {
		["ClassName"] = "group",
		["UniqueID"] = "19772895467",
		["EditorExpand"] = true,
	},
},
}