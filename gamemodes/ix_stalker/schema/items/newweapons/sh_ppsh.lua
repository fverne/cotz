ITEM.name = "PPSh-41"
ITEM.description= "A heavy submachinegun with a wooden stock. Fires 7.62x25mm."
ITEM.longdesc = "The PPSh is a Soviet submachinegun that gained a fearful reputation in World War II as a fast and effective weapon. \nIt's weight of 4.3 kilograms coupled with a gas compensator grants it low recoil in bursts and automatic fire. It fires from the open bolt. \nThese have been a popular choice with rookies compared to western, newer submachineguns because of the price and ammunition accessibility.\n\nAmmo: 7.62x25mm \nMagazine Capacity: 35"
ITEM.model = "models/weapons/w_grub_ppsh_stick.mdl"
ITEM.class = "cw_ppsh"
ITEM.weaponCategory = "primary"
ITEM.price = 4200
ITEM.width = 3
ITEM.height = 1

ITEM.canAttach = false

ITEM.bulletweight = 0.010
ITEM.unloadedweight = 3.63

ITEM.repair_PartsComplexity = 2
ITEM.repair_PartsRarity = 1

function ITEM:GetWeight()
  return self.unloadedweight + (self.bulletweight * self:GetData("ammo", 0))
end

ITEM.iconCam = {
	pos = Vector(0, 10.5, -235),
	ang = Angle(-87.658996582031, 0, -178),
	fov = 10.8,
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
						["Position"] = Vector(16.759, -7.327, 4.486),
						["Name"] = "ppsh",
						["ClassName"] = "model",
						["Size"] = 0.8,
						["UniqueID"] = "3544245692",
						["Angles"] = Angle(60.521, 89.241, 4.292),
						["Bone"] = "spine 2",
						["Model"] = "models/weapons/w_grub_ppsh_stick.mdl",
						["EditorExpand"] = true,
					},
				},
			},
			["self"] = {
				["AffectChildrenOnly"] = true,
				["ClassName"] = "event",
				["UniqueID"] = "1044232402",
				["Event"] = "weapon_class",
				["EditorExpand"] = true,
				["Name"] = "weapon class find simple\"@@1\"",
				["Arguments"] = "cw_ppsh@@0",
			},
		},
	},
	["self"] = {
		["ClassName"] = "group",
		["UniqueID"] = "1513321183",
		["EditorExpand"] = true,
	},
},
}