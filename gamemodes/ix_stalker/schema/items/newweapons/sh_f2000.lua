ITEM.name = "FN F2000"
ITEM.description= "A polymer-framed rifle chambered for 5.56x45mm."
ITEM.longdesc = "The FN F2000 is a 5.56×45mm NATO bullpup assault rifle, designed by FN Herstal in Belgium.\nIt is a gas operated, fully automatic and ambidextrous bullpup rifle.\nBoth the safety system and trigger mechanism were adopted from the P90 personal defense weapon; the selector toggle is a rotating disc located below the trigger.\nThe fire selector doubles as the weapon’s manual safety and secures the firearm against accidental discharge (the selector/safety disc has 3 settings: 'S'—safe, '1'—semi-automatic mode, 'A'—fully automatic fire).\nThe 'safe' setting disables the trigger.\nThe hammers, group pins, and springs are steel while all other components are nylon injection molding.\nThe shell of the rifle is made of composite materials.\n\nAmmo: 5.56x45mm \nMagazine Capacity: 30 "
ITEM.model = ("models/cw2/weapons/w_cw2_efi.mdl")
ITEM.class = "cw_f2000"
ITEM.weaponCategory = "primary"
ITEM.price = 28500
ITEM.width = 4
ITEM.height = 2
ITEM.validAttachments = {"md_microt1","md_eotech","md_aimpoint","md_cmore","md_schmidt_shortdot","md_acog","md_reflex","md_saker"}

ITEM.bulletweight = 0.012
ITEM.unloadedweight = 3.6

ITEM.repair_PartsComplexity = 4
ITEM.repair_PartsRarity = 2

function ITEM:GetWeight()
  return self.unloadedweight + (self.bulletweight * self:GetData("ammo", 0))
end

ITEM.iconCam = {
	pos = Vector(9.6000003814697, -205, 2.5),
	ang = Angle(0, 90, 0),
	fov = 8,
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
						["Angles"] = Angle(180, 0, 0),
						["Position"] = Vector(16.652, -4.444, -1.132),
						["Model"] = "models/cw2/weapons/w_cw2_efi.mdl",
						["ClassName"] = "model",
						["EditorExpand"] = true,
						["UniqueID"] = "5551187212",
						["Bone"] = "spine 2",
						["Name"] = "f2000",
					},
				},
			},
			["self"] = {
				["AffectChildrenOnly"] = true,
				["ClassName"] = "event",
				["UniqueID"] = "7408540013",
				["Event"] = "weapon_class",
				["EditorExpand"] = true,
				["Name"] = "weapon class find simple\"@@1\"",
				["Arguments"] = "cw_f2000@@0",
			},
		},
	},
	["self"] = {
		["ClassName"] = "group",
		["UniqueID"] = "9751620001",
		["EditorExpand"] = true,
	},
},
}