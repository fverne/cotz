ITEM.name = "SKS"
ITEM.description= "An old Russian semi-automatic rifle chambered for 7.62x39mm."
ITEM.longdesc = "The SKS is a Soviet semi-automatic carbine chambered for the 7.62x39mm round, designed in 1943 by Sergei Gavrilovich Simonov.\nIn the early 1950s, the Soviets took the SKS carbine out of front-line service and replaced it with the AK-47; however, the SKS remained in second-line service for decades.\nThe SKS is currently popular on the civilian surplus market as a hunting and marksmanship semi-automatic rifle in many countries, including the Zone.\n\nAmmo: 7.62x39mm \nMagazine Capacity: 30"
ITEM.model = "models/weapons/world/rifles/sks.mdl"
ITEM.class = "cw_sks"
ITEM.weaponCategory = "primary"
ITEM.price = 13500
ITEM.width = 5
ITEM.height = 1
ITEM.validAttachments = {"md_kobra","md_microt1","md_eotech","md_aimpoint","md_cmore","md_schmidt_shortdot","md_acog","md_nightforce_nxs","md_pso1","md_reflex","md_pbs1","md_foregrip"}

ITEM.bulletweight = 0.019
ITEM.unloadedweight = 3.85

ITEM.repair_PartsComplexity = 2
ITEM.repair_PartsRarity = 2

function ITEM:GetWeight()
  return self.unloadedweight + (self.bulletweight * self:GetData("ammo", 0))
end

ITEM.iconCam = {
	pos = Vector(-10, 200, -0.5),
	ang = Angle(0, 270, 0),
	fov = 12,
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
						["Angles"] = Angle(0, 0, 180),
						["Model"] = "models/weapons/world/rifles/sks.mdl",
						["ClassName"] = "model",
						["Position"] =	Vector(15.415, -4.194, -4.119),
						["EditorExpand"] = true,
						["UniqueID"] = "3888831291",
						["Bone"] = "spine 2",
						["Name"] = "sks",
					},
				},
			},
			["self"] = {
				["AffectChildrenOnly"] = true,
				["ClassName"] = "event",
				["UniqueID"] = "1053552402",
				["Event"] = "weapon_class",
				["EditorExpand"] = true,
				["Name"] = "weapon class find simple\"@@1\"",
				["Arguments"] = "cw_sks@@0",
			},
		},
	},
	["self"] = {
		["ClassName"] = "group",
		["UniqueID"] = "1515522183",
		["EditorExpand"] = true,
	},
},
}