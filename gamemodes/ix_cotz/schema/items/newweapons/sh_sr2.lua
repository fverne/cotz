ITEM.name = "SR-2 Veresk"
ITEM.description= "A russian submachinegun that fires an uncommon cartridge. Fires 9x21mm."
ITEM.longdesc = "The SR-2 'Veresk' is a Russian submachine gun designed to fire the 9x21mm Gyurza pistol cartridge. This weapon and its round were created as a compact weapon capable of engaging enemies wearing Russian class-II body armor (able to stop ordinary pistol bullets, such as 9x19mm Parabellum and 7.62x25mm Tokarev), and soft-skinned vehicles, at distances up to 200 metres.\n\nAmmo: 9x21mm\nMagazine Capacity: 30"
ITEM.model = ("models/sr-2m veresk/sr2.mdl")
ITEM.class = "cw_veresk"
ITEM.weaponCategory = "primary"
ITEM.width = 3
ITEM.price = 18000
ITEM.height = 2
ITEM.validAttachments = {"md_microt1","md_eotech","md_aimpoint","md_cmore","md_reflex","md_tundra9mm"}

ITEM.bulletweight = 0.008
ITEM.unloadedweight = 3.5

ITEM.repair_PartsComplexity = 1
ITEM.repair_PartsRarity = 1

function ITEM:GetWeight()
  return self.unloadedweight + (self.bulletweight * self:GetData("ammo", 0))
end

ITEM.iconCam = {
	pos = Vector(-32, 2, 6.5),
	ang = Angle(0, -0, 0),
	fov = 45,
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
						["Angles"] = Angle(11, 87, 178),
						["Position"] = Vector(-2.082, -4.832, 4.78),
						["Model"] = "models/sr-2m veresk/sr2.mdl",
						["ClassName"] = "model",
						["EditorExpand"] = true,
						["UniqueID"] = "326463246",
						["Bone"] = "spine 2",
						["Name"] = "sr2",
					},
				},
			},
			["self"] = {
				["AffectChildrenOnly"] = true,
				["ClassName"] = "event",
				["UniqueID"] = "5322363632",
				["Event"] = "weapon_class",
				["EditorExpand"] = true,
				["Name"] = "weapon class find simple\"@@1\"",
				["Arguments"] = "cw_veresk@@0",
			},
		},
	},
	["self"] = {
		["ClassName"] = "group",
		["UniqueID"] = "346363466",
		["EditorExpand"] = true,
	},
},
}