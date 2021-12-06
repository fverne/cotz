ITEM.name = "Dragunov SVD"
ITEM.description= "A sharpshooter rifle based on the AK. Fires 7.62x54mm."
ITEM.longdesc = "The SVD is a marksman's rifle designed to fill the gap between assault and sniper rifle for infantry squads. It was designed from the AK rifle. \nThe SVD is able to deliver accurate shots in rapid succession, but it is not as precise as a sniper rifle.\n\nAmmo: 7.62x54mm \nMagazine Capacity: 10"
ITEM.model = ("models/weapons/drag/w_snip_dragn.mdl")
ITEM.class = "cw_dragunov"
ITEM.weaponCategory = "primary"
ITEM.price = 44000
ITEM.width = 6
ITEM.height = 1
ITEM.validAttachments = {"md_kobra","md_pso1","md_microt1","md_eotech","md_aimpoint","md_cmore","md_schmidt_shortdot","md_acog","md_nightforce_nxs","md_reflex","md_pbs1","md_foregrip"}

ITEM.bulletweight = 0.022
ITEM.unloadedweight = 4.0

ITEM.repair_PartsComplexity = 2
ITEM.repair_PartsRarity = 2

function ITEM:GetWeight()
  return self.unloadedweight + (self.bulletweight * self:GetData("ammo", 0))
end

ITEM.iconCam = {
	pos = Vector(15, -205, 1.6000000238419),
	ang = Angle(0, 90, -3),
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
						["Model"] = "models/weapons/drag/w_snip_dragn.mdl",
						["ClassName"] = "model",
						["Position"] = Vector(17.784, -5.054, -1.356),
						["EditorExpand"] = true,
						["UniqueID"] = "3859539124",
						["Bone"] = "spine 2",
						["Name"] = "svd",
						["Angles"] = Angle(0, 180, 180),
					},
				},
			},
			["self"] = {
				["AffectChildrenOnly"] = true,
				["ClassName"] = "event",
				["UniqueID"] = "2428315201",
				["Event"] = "weapon_class",
				["EditorExpand"] = true,
				["Name"] = "weapon class find simple\"@@1\"",
				["Arguments"] = "cw_dragunov@@0",
			},
		},
	},
	["self"] = {
		["ClassName"] = "group",
		["UniqueID"] = "0004518261",
		["EditorExpand"] = true,
	},
},
}