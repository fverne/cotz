ITEM.name = "SAKO RK 95"
ITEM.description= "A grey assault rifle. Fires 7.62x39mm."
ITEM.longdesc = "The RK 95 TP is the Finnish answer to the Kalashnikov rifles.\nIt's as reliable as the AK rifles as well as having a number of improvements of its own.\nIt fires the large 7.62x39mm intermediate cartridge, meaning it packs quite a punch.\n\nAmmo: 7.62x39mm \nMagazine Capacity: 30"
ITEM.model = "models/weapons/world/rifles/rk95.mdl"
ITEM.class = "cw_rk95"
ITEM.weaponCategory = "primary"
ITEM.price = 25150
ITEM.width = 5
ITEM.height = 2
ITEM.validAttachments = {"md_microt1","md_eotech","md_aimpoint","md_cmore","md_schmidt_shortdot","md_acog","md_reflex","md_pbs1"}

ITEM.bulletweight = 0.019
ITEM.unloadedweight = 3.7

ITEM.repair_PartsComplexity = 2
ITEM.repair_PartsRarity = 2

function ITEM:GetWeight()
  return self.unloadedweight + (self.bulletweight * self:GetData("ammo", 0))
end

ITEM.iconCam = {
	pos = Vector(3.7999999523163, -205, -1.7999999523163),
	ang = Angle(0, 90, 0),
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
						["Angles"] = Angle(0, 180, 180),
						["Model"] = "models/weapons/world/rifles/rk95.mdl",
						["ClassName"] = "model",
						["Position"] =	Vector(10.203, -4.154, -4.08),
						["EditorExpand"] = true,
						["UniqueID"] = "3547382491",
						["Bone"] = "spine 2",
						["Name"] = "rk95",
					},
				},
			},
			["self"] = {
				["AffectChildrenOnly"] = true,
				["ClassName"] = "event",
				["UniqueID"] = "10421523402",
				["Event"] = "weapon_class",
				["EditorExpand"] = true,
				["Name"] = "weapon class find simple\"@@1\"",
				["Arguments"] = "cw_rk95@@0",
			},
		},
	},
	["self"] = {
		["ClassName"] = "group",
		["UniqueID"] = "1118412183",
		["EditorExpand"] = true,
	},
},
}