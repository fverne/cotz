ITEM.name = "SR-3M 'Vikhr'"
ITEM.description= "A special forces assault rifle chambered for 9x39mm."
ITEM.longdesc = "The SR-3M 'Vikhr' is based on the AS 'Val' silenced assault rifle but lacks an integral suppressor and has a newly-designed folding stock and cocking handle for ease of concealed carry.\nThe iron sights have also been relocated to the upper front handguard as opposed to being located on the suppressor, apparently for when the gun is used without the suppressor attached.\n\nAmmo: 9x39mm\nMagazine Capacity: 30"
ITEM.model = ("models/weapons/w_dmg_vikhr.mdl")
ITEM.class = "cw_sr3m"
ITEM.weaponCategory = "primary"
ITEM.price = 45000
ITEM.width = 4
ITEM.height = 2
ITEM.validAttachments = {"md_kobra","md_microt1","md_eotech","md_aimpoint","md_cmore","md_schmidt_shortdot","md_acog","md_pso1","md_reflex","md_pbs1","md_foregrip"}

ITEM.bulletweight = 0.023
ITEM.unloadedweight = 2.2

ITEM.repair_PartsComplexity = 2
ITEM.repair_PartsRarity = 4

function ITEM:GetWeight()
  return self.unloadedweight + (self.bulletweight * self:GetData("ammo", 0))
end

ITEM.iconCam = {
	pos = Vector(11, 200, -1.8999999761581),
	ang = Angle(0, 270, 10),
	fov = 10,
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
						["Angles"] = Angle(-6, 0, 180),
						["Position"] = Vector(-1.724, -4.195, -3.961),
						["Model"] = "models/weapons/w_dmg_vikhr.mdl",
						["ClassName"] = "model",
						["EditorExpand"] = true,
						["UniqueID"] = "7767986673",
						["Bone"] = "spine 2",
						["Name"] = "vikhr",
					},
				},
			},
			["self"] = {
				["AffectChildrenOnly"] = true,
				["ClassName"] = "event",
				["UniqueID"] = "1275664522",
				["Event"] = "weapon_class",
				["EditorExpand"] = true,
				["Name"] = "weapon class find simple\"@@1\"",
				["Arguments"] = "cw_sr3m@@0",
			},
		},
	},
	["self"] = {
		["ClassName"] = "group",
		["UniqueID"] = "2775647898",
		["EditorExpand"] = true,
	},
},
}