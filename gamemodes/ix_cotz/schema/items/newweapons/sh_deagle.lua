ITEM.name = "IMI Desert Eagle"
ITEM.description= "A large semi-automatic pistol chambered for .50 AE."
ITEM.longdesc = "The IMI Desert Eagle is a semi-automatic handgun notable for chambering the largest centerfire cartridge of any magazine fed, self-loading pistol. It has a unique design with a triangular barrel and large muzzle.\nThe Desert Eagle uses a gas-operated mechanism normally found in rifles, as opposed to the short recoil or blow-back designs most commonly seen in semi-automatic pistols.\nThe advantage of the gas operation is that it allows the use of far more powerful cartridges than traditional semi-automatic pistol designs.\nThus it allows the Desert Eagle to compete in an area that had previously been dominated by magnum revolvers.\n\nAmmo: .50AE\nMagazine Capacity: 7"
ITEM.model = "models/weapons/w_pist_deagle.mdl"
ITEM.class = "cw_deagle"
ITEM.weaponCategory = "secondary"
ITEM.price = 14000
ITEM.width = 2
ITEM.height = 1
ITEM.validAttachments = {"md_microt1","md_eotech","md_rmr","md_cobram2"}

ITEM.bulletweight = 0.028
ITEM.unloadedweight = 1.995

ITEM.repair_PartsComplexity = 3
ITEM.repair_PartsRarity = 2

function ITEM:GetWeight()
  return self.unloadedweight + (self.bulletweight * self:GetData("ammo", 0))
end

ITEM.iconCam = {
	pos = Vector(4, -205, 3.7000000476837),
	ang = Angle(0, 90, 0),
	fov = 4.5,
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
						["Model"] = "models/weapons/w_pist_deagle.mdl",
						["ClassName"] = "model",
						["Position"] = Vector(-9.88, 5.552, -2.062),
						["EditorExpand"] = true,
						["UniqueID"] = "3544642735",
						["Bone"] = "pelvis",
						["Name"] = "deagle",
						["Angles"] = Angle(0, 270, -30),
					},
				},
			},
			["self"] = {
				["AffectChildrenOnly"] = true,
				["ClassName"] = "event",
				["UniqueID"] = "1087631762",
				["Event"] = "weapon_class",
				["EditorExpand"] = true,
				["Name"] = "weapon class find simple\"@@1\"",
				["Arguments"] = "cw_deagle@@0",
			},
		},
	},
	["self"] = {
		["ClassName"] = "group",
		["UniqueID"] = "1197387613",
		["EditorExpand"] = true,
	},
},
}