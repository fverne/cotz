ITEM.name = "PTRS-41"
ITEM.description= "A humongous anti-tank rifle. Fires 14.5x114mm."
ITEM.longdesc = "The PTRS-41 is an anti-tank rifle developed during World War II. While it no longer puts up a threat against anything larger than an early BTR, it will take out any of the beasts or armored figures in the Zone with a single shot to center mass.\nIt's big, bulky and weighs 20 kilograms unloaded, requiring an exoskeleton or very strong arms to be carried and fired without problems.\nAmmunition is very hard to find as it is only shared by the military's armored troop carriers.\n\nAmmo: 14.5x114mm \nMagazine Capacity: 5"
ITEM.model = ("models/weapons/w_grub_ptrs.mdl")
ITEM.class = "cw_ptrs"
ITEM.weaponCategory = "primary"
ITEM.width = 6
ITEM.price = 150000
ITEM.height = 2

ITEM.canAttach = false

ITEM.bulletweight = 0.200
ITEM.unloadedweight = 20.3

ITEM.repair_PartsComplexity = 1
ITEM.repair_PartsRarity = 1

function ITEM:GetWeight()
  return self.unloadedweight + (self.bulletweight * self:GetData("ammo", 0))
end

ITEM.iconCam = {
	pos = Vector(-24, 117, -7),
	ang = Angle(0, -90, 0),
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
						["Model"] = "models/weapons/w_grub_ptrs.mdl",
						["ClassName"] = "model",
						["Angles"] = Angle(0, 0, 180),
						["Position"] = Vector(10.094, -4.718, -4.776),
						["EditorExpand"] = true,
						["UniqueID"] = "3824139124",
						["Bone"] = "spine 2",
						["Name"] = "ptrs",
					},
				},
			},
			["self"] = {
				["AffectChildrenOnly"] = true,
				["ClassName"] = "event",
				["UniqueID"] = "2412315201",
				["Event"] = "weapon_class",
				["EditorExpand"] = true,
				["Name"] = "weapon class find simple\"@@1\"",
				["Arguments"] = "cw_ptrs@@0",
			},
		},
	},
	["self"] = {
		["ClassName"] = "group",
		["UniqueID"] = "0224518261",
		["EditorExpand"] = true,
	},
},
}