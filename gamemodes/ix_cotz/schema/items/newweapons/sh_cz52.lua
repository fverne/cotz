ITEM.name = "CZ-52"
ITEM.description= "A semi-automatic pistol chambered for 7.62x25mm."
ITEM.longdesc = "The CZ 52 pistol is a roller-locked short recoil–operated, detachable box magazine–fed, single-action, semi-automatic pistol chambered for the 7.62×25mm Tokarev cartridge.\nIt is popular against armor as it can handle hotter rounds, meaning better muzzle velocity.\nIts magazine capacity is what many stalkers complain about, since its tiny 8 round magazine means much more reloading.\n\nAmmo: 7.62x25mm\nMagazine Capacity: 8"
ITEM.model = "models/khrcw2/pistols/w_cz52.mdl"
ITEM.class = "cw_cz52"
ITEM.weaponCategory = "secondary"
ITEM.width = 2
ITEM.price = 1500
ITEM.height = 1
ITEM.validAttachments = {"md_tundra9mm"}

ITEM.bulletweight = 0.010
ITEM.unloadedweight = 0.95

ITEM.repair_PartsComplexity = 2
ITEM.repair_PartsRarity = 1

function ITEM:GetWeight()
  return self.unloadedweight + (self.bulletweight * self:GetData("ammo", 0))
end

ITEM.iconCam = {
	pos = Vector(1.2999999523163, -16, -0.5),
	ang = Angle(0, 90, 0),
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