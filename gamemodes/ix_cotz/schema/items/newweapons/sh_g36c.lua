ITEM.name = "HK G36C"
ITEM.description= "An assault rifle that fires 5.56x45mm rounds."
ITEM.longdesc = "This subcarbine model is a further development of the G36K.\nIt has a shorter barrel than the G36K, and a four-prong open-type flash hider.\nThe extremely short barrel forced designers to move the gas block closer to the muzzle end and reduce the length of the gas piston operating rod.\nThe handguard and stock were also shortened and the fixed carry handle (with optics) was replaced with a carrying handle with an integrated Picatinny rail.\n\nAmmo: 5.56x45mm \nMagazine Capacity: 30"
ITEM.model = "models/weapons/cw20_g36c.mdl"
ITEM.class = "cw_g36c"
ITEM.weaponCategory = "primary"
ITEM.price = 24900
ITEM.width = 4
ITEM.height = 2
ITEM.validAttachments = {"md_microt1","md_eotech","md_aimpoint","md_cmore","md_schmidt_shortdot","md_acog","md_reflex","md_saker","md_foregrip"}

ITEM.bulletweight = 0.012
ITEM.unloadedweight = 2.82

ITEM.repair_PartsComplexity = 3
ITEM.repair_PartsRarity = 4

function ITEM:GetWeight()
  return self.unloadedweight + (self.bulletweight * self:GetData("ammo", 0))
end

ITEM.iconCam = {
	pos = Vector(6.5, -205, 1.3999999761581),
	ang = Angle(0, 90, 0),
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
						["Angles"] = Angle(0, 180, 180),
						["Position"] = Vector(14.673, -4.309, -1.334),
						["Model"] = "models/weapons/cw20_g36c.mdl",
						["ClassName"] = "model",
						["EditorExpand"] = true,
						["UniqueID"] = "7809869091",
						["Bone"] = "spine 2",
						["Name"] = "g36c",
					},
				},
			},
			["self"] = {
				["AffectChildrenOnly"] = true,
				["ClassName"] = "event",
				["UniqueID"] = "1237780642",
				["Event"] = "weapon_class",
				["EditorExpand"] = true,
				["Name"] = "weapon class find simple\"@@1\"",
				["Arguments"] = "cw_g36c@@0",
			},
		},
	},
	["self"] = {
		["ClassName"] = "group",
		["UniqueID"] = "2784642348",
		["EditorExpand"] = true,
	},
},
}