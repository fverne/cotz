ITEM.name = "Steyr AUG"
ITEM.description= "A bull-pup assault rifle. Fires 5.56x45mm."
ITEM.longdesc = "The AUG is an Austrian assault rifle designed around the 60-70's and remains a viable solution to this day. \nIt's a bullpup configuration rifle, the magazine behind the handguard results in a shorter length. \nIt's not fully ambidextrious, but it can be changed for left-hand shooters if one changes the bolt with one that has the extractor and ejector on the other side.\n\nAmmo: 5.56x45mm \nMagazine Capacity: 30"
ITEM.model = "models/weapons/w_rif_aug.mdl"
ITEM.class = "cw_aug"
ITEM.weaponCategory = "primary"
ITEM.price = 28500
ITEM.width = 5
ITEM.height = 2
ITEM.validAttachments = {"md_microt1","md_eotech","md_aimpoint","md_cmore","md_schmidt_shortdot","md_acog","md_reflex","md_saker"}

ITEM.bulletweight = 0.012
ITEM.unloadedweight = 3.6

ITEM.repair_PartsComplexity = 3
ITEM.repair_PartsRarity = 3

function ITEM:GetWeight()
  return self.unloadedweight + (self.bulletweight * self:GetData("ammo", 0))
end

ITEM.iconCam = {
	pos = Vector(-5, -205, 5),
	ang = Angle(0, 90, 0),
	fov = 10.5,
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
						["Position"] =	Vector(1.943, -4.451, 1.975),
						["Model"] = "models/weapons/w_rif_aug.mdl",
						["ClassName"] = "model",
						["EditorExpand"] = true,
						["UniqueID"] = "7842129091",
						["Bone"] = "spine 2",
						["Name"] = "aug",
					},
				},
			},
			["self"] = {
				["AffectChildrenOnly"] = true,
				["ClassName"] = "event",
				["UniqueID"] = "1237784212",
				["Event"] = "weapon_class",
				["EditorExpand"] = true,
				["Name"] = "weapon class find simple\"@@1\"",
				["Arguments"] = "cw_aug@@0",
			},
		},
	},
	["self"] = {
		["ClassName"] = "group",
		["UniqueID"] = "2784612448",
		["EditorExpand"] = true,
	},
},
}