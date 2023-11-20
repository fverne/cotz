ITEM.name = "Nagant Revolver"
ITEM.description= "A single action revolver chambered for 7.62x25mm."
ITEM.longdesc = "The Nagant M1895 Revolver is a seven-shot, gas-seal revolver designed and produced by Belgian industrialist Léon Nagant for the Russian Empire. The Nagant M1895 was chambered for a proprietary cartridge, 7.62×38mmR, and featured an unusual 'gas-seal' system, in which the cylinder moved forward when the gun was cocked. This particular revolver has been modified by a technician to accept 7.62x25, which breaks this gas seal system, but enables it to fire the much more available 7.62x25 cartridge.\n\nAmmo: 7.62x25mm\nMagazine Capacity: 7"
ITEM.model = "models/weapons/tfa_ins2/wpn_m1895_w.mdl"
ITEM.class = "cw_nagantrev"
ITEM.weaponCategory = "secondary"
ITEM.width = 2
ITEM.price = 300
ITEM.height = 1

ITEM.bulletweight = 0.010
ITEM.unloadedweight = 0.95

function ITEM:GetWeight()
  return self.unloadedweight + (self.bulletweight * self:GetData("ammo", 0))
end

ITEM.iconCam = {
	pos = Vector(3.42, -199.83, -5.43),
	ang = Angle(-2.47, 90.74, 0),
	fov = 3.64
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
						["Model"] = "models/khrcw2/pistols/w_cz52.mdl",
						["ClassName"] = "model",
						["Position"] = Vector(-6.82, 2.691, 3.236),
						["EditorExpand"] = true,
						["UniqueID"] = "3544642191",
						["Bone"] = "pelvis",
						["Name"] = "cz52",
						["Angles"] = Angle(0, 90, 30),
					},
				},
			},
			["self"] = {
				["AffectChildrenOnly"] = true,
				["ClassName"] = "event",
				["UniqueID"] = "1087632402",
				["Event"] = "weapon_class",
				["EditorExpand"] = true,
				["Name"] = "weapon class find simple\"@@1\"",
				["Arguments"] = "cw_cz52@@0",
			},
		},
	},
	["self"] = {
		["ClassName"] = "group",
		["UniqueID"] = "1118387613",
		["EditorExpand"] = true,
	},
},
}