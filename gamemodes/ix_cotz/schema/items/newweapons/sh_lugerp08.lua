ITEM.name = "Luger P08"
ITEM.description= "A German handgun, firing the 9x19mm cartridge."
ITEM.longdesc = "The Pistole Parabellum—or Parabellum-Pistole, commonly known as just Luger—is a toggle-locked recoil-operated semi-automatic pistol which was produced in several models and by several nations from 1898 to 1948.\n\nAmmo: 9x19mm\nMagazine Capacity: 8"
ITEM.model = ("models/khrcw2/doipack/w_lugerp08.mdl")
ITEM.class = "cw_p08"
ITEM.weaponCategory = "secondary"
ITEM.price = 4250
ITEM.width = 2
ITEM.height = 1
ITEM.validAttachments = {"md_tundra9mm"}

ITEM.bulletweight = 0.008
ITEM.unloadedweight = 0.871

ITEM.repair_PartsComplexity = 2
ITEM.repair_PartsRarity = 3

function ITEM:GetWeight()
  return self.unloadedweight + (self.bulletweight * self:GetData("ammo", 0))
end

ITEM.iconCam = {
	pos = Vector(2, -205, -2.7000000476837),
	ang = Angle(0, 90, 1.5),
	fov = 4.5,
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
						["Model"] = "models/khrcw2/doipack/w_lugerp08.mdl",
						["ClassName"] = "model",
						["Position"] = Vector(-6.775, 4.688, 3.354),
						["EditorExpand"] = true,
						["UniqueID"] = "362833359835",
						["Bone"] = "pelvis",
						["Name"] = "p08",
						["Angles"] = Angle(0, 270, -30),
					},
				},
			},
			["self"] = {
				["AffectChildrenOnly"] = true,
				["ClassName"] = "event",
				["UniqueID"] = "16407286782",
				["Event"] = "weapon_class",
				["EditorExpand"] = true,
				["Name"] = "weapon class find simple\"@@1\"",
				["Arguments"] = "cw_p08@@0",
			},
		},
	},
	["self"] = {
		["ClassName"] = "group",
		["UniqueID"] = "19778939867",
		["EditorExpand"] = true,
	},
},
}