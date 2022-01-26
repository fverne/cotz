ITEM.name = "MP9a1"
ITEM.description= "A compact machine pistol. Fires 9x19mm."
ITEM.longdesc = "The Machine Pistol 9 is a Swiss-made submachinegun from the early 2000s, it weighs 1.4 kilograms unloaded and is generally compact.\nIt features a drop, trigger and ambidextrious safety switch and has a fire-rate of 900 rounds a minute.\n\nAmmo: 9x19mm\nMagazine Capacity: 3"
ITEM.model = ("models/weapons/w_smg_mp9a1.mdl")
ITEM.class = "cw_mp9a1"
ITEM.weaponCategory = "primary"
ITEM.price = 11100
ITEM.width = 2
ITEM.height = 2
ITEM.validAttachments = {"md_microt1","md_eotech","md_aimpoint","md_cmore","md_reflex","md_tundra9mm"}

ITEM.bulletweight = 0.008
ITEM.unloadedweight = 1.4

ITEM.repair_PartsComplexity = 2
ITEM.repair_PartsRarity = 2

function ITEM:GetWeight()
  return self.unloadedweight + (self.bulletweight * self:GetData("ammo", 0))
end

ITEM.iconCam = {
	pos = Vector(-4, -205, -4),
	ang = Angle(0, 90, 0),
	fov = 4.6,
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
						["Position"] = Vector(-11.714, -2.715, 4.444),
						["Model"] = "models/weapons/w_smg_mp9a1.mdl",
						["ClassName"] = "model",
						["EditorExpand"] = true,
						["UniqueID"] = "79898994673",
						["Bone"] = "spine 2",
						["Name"] = "mp9a1",
					},
				},
			},
			["self"] = {
				["AffectChildrenOnly"] = true,
				["ClassName"] = "event",
				["UniqueID"] = "1238978922",
				["Event"] = "weapon_class",
				["EditorExpand"] = true,
				["Name"] = "weapon class find simple\"@@1\"",
				["Arguments"] = "cw_mp9a1@@0",
			},
		},
	},
	["self"] = {
		["ClassName"] = "group",
		["UniqueID"] = "2786496348",
		["EditorExpand"] = true,
	},
},
}