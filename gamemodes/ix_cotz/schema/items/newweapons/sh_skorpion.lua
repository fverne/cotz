ITEM.name = "Skorpion"
ITEM.description= "A compact machine pistol. Fires 9x18mm."
ITEM.longdesc = "The Škorpion vz. 61 is a Czechoslovak machine pistol developed in 1959.\nAlthough it was developed for use with security forces and special forces, the weapon was also accepted into service with the Czechoslovak Army, as a personal sidearm for lower-ranking army staff, vehicle drivers, armoured vehicle personnel and special forces.\nCurrently the weapon is in use with the armed forces of several countries as a sidearm.\n\nAmmo: 9x18mm \nMagazine Capacity: 10"
ITEM.model = ("models/weapons/w_smg_skorp.mdl")
ITEM.class = "cw_skorpion"
ITEM.weaponCategory = "primary"
ITEM.price = 6200
ITEM.width = 3
ITEM.height = 1
ITEM.validAttachments = {"md_microt1","md_aimpoint","md_reflex","md_tundra9mm"}

ITEM.bulletweight = 0.011
ITEM.unloadedweight = 1.30

ITEM.repair_PartsComplexity = 3
ITEM.repair_PartsRarity = 2

function ITEM:GetWeight()
  return self.unloadedweight + (self.bulletweight * self:GetData("ammo", 0))
end

ITEM.iconCam = {
	pos = Vector(-8, -205, -2),
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
						["Angles"] = Angle(0, 180, 0),
						["Position"] = Vector(-11.007, -2.714, 3.862),
						["Model"] = "models/weapons/w_smg_skorp.mdl",
						["ClassName"] = "model",
						["EditorExpand"] = true,
						["UniqueID"] = "7764798673",
						["Bone"] = "spine 2",
						["Name"] = "skorp",
					},
				},
			},
			["self"] = {
				["AffectChildrenOnly"] = true,
				["ClassName"] = "event",
				["UniqueID"] = "1239764522",
				["Event"] = "weapon_class",
				["EditorExpand"] = true,
				["Name"] = "weapon class find simple\"@@1\"",
				["Arguments"] = "cw_skorpion@@0",
			},
		},
	},
	["self"] = {
		["ClassName"] = "group",
		["UniqueID"] = "2784647898",
		["EditorExpand"] = true,
	},
},
}