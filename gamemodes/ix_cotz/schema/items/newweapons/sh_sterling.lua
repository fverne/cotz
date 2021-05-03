ITEM.name = "Sterling"
ITEM.description= "A submachinegun chambered for 9x19mm."
ITEM.longdesc = "The Sterling was taken into service as a replacement for the Sten gun roughly ten years after World War II ended. \nIt's built entirely out of metal and plastic and has a folding stock underneath the reciever. While being a slow weapon with 550 RPM, this helps to fire full-auto with ease and high accuracy. \nA suppressor can be mounted which greatly decreases the sound level.\n\nAmmo: 9x19mm \nMagazine Capacity: 32"
ITEM.model = ("models/weapons/b_sterling.mdl")
ITEM.class = "cw_sterling"
ITEM.weaponCategory = "primary"
ITEM.price = 9600
ITEM.width = 3
ITEM.height = 1
ITEM.validAttachments = {"md_tundra9mm"}

ITEM.bulletweight = 0.008
ITEM.unloadedweight = 2.7

ITEM.repair_PartsComplexity = 1
ITEM.repair_PartsRarity = 1

function ITEM:GetWeight()
  return self.unloadedweight + (self.bulletweight * self:GetData("ammo", 0))
end

ITEM.iconCam = {
	pos = Vector(200, -8, -3),
	ang = Angle(180, -0, 180),
	fov = 9,
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
						["Angles"] = Angle(0, 270, 180),
						["Position"] = Vector(1.419, -5.056, -5.256),
						["Model"] = "models/weapons/b_sterling.mdl",
						["ClassName"] = "model",
						["EditorExpand"] = true,
						["UniqueID"] = "8883938491",
						["Bone"] = "spine 2",
						["Name"] = "sterling",
					},
				},
			},
			["self"] = {
				["AffectChildrenOnly"] = true,
				["ClassName"] = "event",
				["UniqueID"] = "1044336402",
				["Event"] = "weapon_class",
				["EditorExpand"] = true,
				["Name"] = "weapon class find simple\"@@1\"",
				["Arguments"] = "cw_sterling@@0",
			},
		},
	},
	["self"] = {
		["ClassName"] = "group",
		["UniqueID"] = "8134421183",
		["EditorExpand"] = true,
	},
},
}