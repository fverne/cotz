ITEM.name = "TKPD"
ITEM.description= "A sharpshooter rifle based on the SVDK sniper rifle. Fires 9.3x64mm."
ITEM.longdesc = "The TKPD is based on the Dragunov SVDK large caliber sniper rifle. The high power cartridge allows users of this weapon to engage with targets wearing heavy body armor, or lighter armored targets hiding behind cover.\n\nAmmo: 9.3x64mm \nMagazine Capacity: 10"
ITEM.model = ("models/weapons/tfa_ins2/wpn_tkpd_w.mdl")
ITEM.class = "cw_tkpd"
ITEM.weaponCategory = "primary"
ITEM.price = 95000
ITEM.width = 6
ITEM.height = 2
ITEM.validAttachments = {"md_pbs1","md_foregrip"}

ITEM.bulletweight = 0.022
ITEM.unloadedweight = 6.0




function ITEM:GetWeight()
  return self.unloadedweight + (self.bulletweight * self:GetData("ammo", 0))
end

ITEM.iconCam = {
	pos = Vector(12.14, -198.53, -20.91),
	ang = Angle(-7.06, 90.93, 0),
	fov = 13.55
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
						["Model"] = "models/weapons/tfa_ins2/wpn_tkpd_w.mdl",
						["ClassName"] = "model",
						["Position"] = Vector(17.784, -5.054, -1.356),
						["EditorExpand"] = true,
						["UniqueID"] = "3859539124",
						["Bone"] = "spine 2",
						["Name"] = "svd",
						["Angles"] = Angle(0, 180, 180),
					},
				},
			},
			["self"] = {
				["AffectChildrenOnly"] = true,
				["ClassName"] = "event",
				["UniqueID"] = "2428315201",
				["Event"] = "weapon_class",
				["EditorExpand"] = true,
				["Name"] = "weapon class find simple\"@@1\"",
				["Arguments"] = "cw_tkpd@@0",
			},
		},
	},
	["self"] = {
		["ClassName"] = "group",
		["UniqueID"] = "0004518261",
		["EditorExpand"] = true,
	},
},
}