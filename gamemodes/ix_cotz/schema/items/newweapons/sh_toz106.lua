ITEM.name = "TOZ-106"
ITEM.description= "A russian bolt action shotgun."
ITEM.longdesc = "The TOZ-106 is a small, lightweight bolt-action shotgun produced and sold by Tulsky Oruzheiny Zavod. It features a metal stock that folds underneath the weapon in order to make it more compact, and a pistol grip. The rest of the stock is wooden. This shotgun was officially marketed as a hunting shotgun, but became popular among farmers, adventurers, travelers, campers, truck drivers and of course STALKERs, as a compact personal defense weapon. This version has been modified to fire .410 gauge buckshot.\n\nAmmo: .410 Gauge\nMagazine Capacity: 2"
ITEM.model = "models/weapons/arc9/darsu_eft/w_toz106.mdl"
ITEM.class = "cw_toz106"
ITEM.weaponCategory = "primary"
ITEM.width = 4
ITEM.price = 4000
ITEM.height = 1
ITEM.canAttach = false

ITEM.bulletweight = 0.031
ITEM.unloadedweight = 2.4

ITEM.repair_PartsComplexity = 2
ITEM.repair_PartsRarity = 2

function ITEM:GetWeight()
  return self.unloadedweight + (self.bulletweight * self:GetData("ammo", 0))
end

ITEM.iconCam = {
	pos = Vector(61.03, -194.75, -5.3),
	ang = Angle(-0.07, -257.11, 0),
	fov = 10.68
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
						["Angles"] = Angle(-15.857076644897, 180, -180),
						["Position"] = Vector(15.658203125, 0.03999999910593, -12.88525390625),
						["Model"] = "models/weapons/arc9/darsu_eft/w_toz106.mdl",
						["ClassName"] = "model",
						["EditorExpand"] = true,
						["UniqueID"] = "135635161356",
						["Bone"] = "spine 2",
						["Name"] = "toz106",
					},
				},
			},
			["self"] = {
				["AffectChildrenOnly"] = true,
				["ClassName"] = "event",
				["UniqueID"] = "216521563356",
				["Event"] = "weapon_class",
				["EditorExpand"] = true,
				["Name"] = "weapon class find simple\"@@1\"",
				["Arguments"] = "cw_toz106@@0",
			},
		},
	},
	["self"] = {
		["ClassName"] = "group",
		["UniqueID"] = "13631651356",
		["EditorExpand"] = true,
	},
},
}