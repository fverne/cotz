ITEM.name = "HK MP5"
ITEM.description= "A black submachinegun. Fires 9x19mm."
ITEM.longdesc = "The MP5 is an iconic German submachinegun developed in the 1960s, known for it's reliability and effectiveness.\nThe MP5 differentiates from other submachineguns because it fires from a closed bolt.\nIt uses the same operating mechanism as the G3 rifle which has made it one of the most accurate submachineguns in the world.\n\nAmmo: 9x19mm\nMagazine Capacity: 30"
ITEM.model = "models/srp/weapons/w_mp5.mdl"
ITEM.class = "cw_mp5"
ITEM.weaponCategory = "primary"
ITEM.price = 12750
ITEM.width = 3
ITEM.height = 2
ITEM.validAttachments = {"md_microt1","md_eotech","md_aimpoint","md_cmore","md_reflex","md_tundra9mm"}
ITEM.validUpgrades = {"up_firerate1"}

ITEM.bulletweight = 0.008
ITEM.unloadedweight = 2.52

ITEM.repair_PartsComplexity = 2
ITEM.repair_PartsRarity = 2

function ITEM:GetWeight()
  return self.unloadedweight + (self.bulletweight * self:GetData("ammo", 0))
end

ITEM.iconCam = {
	pos = Vector(10, -205, 2),
	ang = Angle(0, 90, 0),
	fov = 9.7,
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
						["Position"] = Vector(17.39, -4.308, 0.361),
						["Model"] = "models/srp/weapons/w_mp5.mdl",
						["ClassName"] = "model",
						["EditorExpand"] = true,
						["UniqueID"] = "79478794673",
						["Bone"] = "spine 2",
						["Name"] = "mp5",
					},
				},
			},
			["self"] = {
				["AffectChildrenOnly"] = true,
				["ClassName"] = "event",
				["UniqueID"] = "6247478922",
				["Event"] = "weapon_class",
				["EditorExpand"] = true,
				["Name"] = "weapon class find simple\"@@1\"",
				["Arguments"] = "cw_mp5@@0",
			},
		},
	},
	["self"] = {
		["ClassName"] = "group",
		["UniqueID"] = "8647796348",
		["EditorExpand"] = true,
	},
},
}