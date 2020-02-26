ITEM.name = "Luger P08"
ITEM.description= "A German handgun, firing the 9x19mm cartridge."
ITEM.longdesc = "The Pistole Parabellum—or Parabellum-Pistole, commonly known as just Luger—is a toggle-locked recoil-operated semi-automatic pistol which was produced in several models and by several nations from 1898 to 1948.\n\nAmmo: 9x19mm\nMagazine Capacity: 8"
ITEM.model = ("models/khrcw2/doipack/w_lugerp08.mdl")
ITEM.class = "cw_p08"
ITEM.weaponCategory = "secondary"
ITEM.width = 2
ITEM.price = 4250
ITEM.height = 1
ITEM.busflag = {"guns3"}
ITEM.repairCost = ITEM.price/100*1
ITEM.validAttachments = {"md_tundra9mm"}
--ITEM.iconCam = {
--	pos = Vector(-5, 8, 1.5),
--	ang = Angle(0, 270, 2),
--	fov = 70
--}
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