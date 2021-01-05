ITEM.name = "Browning Hi-Power"
ITEM.description= "A semi-automatic pistol chambered for 9x19mm."
ITEM.longdesc = "The Browning Hi-Power pistol is product of the French military requesting a new service pistol.\nThe Hi-Power name alludes to the 13-round magazine capacity, almost twice that of contemporary designs such as the Luger or Colt M1911.\nIt has been widely used throughout history, mainly in the second world war by both the Axis and the Allied forces.\nWhen the war ended, over 50 armies adopted it as their service pistol.\n\nAmmo: 9x19mm\nMagazine Capacity: 13"
ITEM.model = "models/weapons/w_pist_brhp.mdl"
ITEM.class = "cw_brhp"
ITEM.weaponCategory = "secondary"
ITEM.price = 1200
ITEM.width = 2
ITEM.height = 1
ITEM.validAttachments = {"md_microt1","md_eotech","md_rmr","md_tundra9mm"}

ITEM.bulletweight = 0.008
ITEM.unloadedweight = 1.01

ITEM.repair_PartsComplexity = 2
ITEM.repair_PartsRarity = 2

function ITEM:GetWeight()
  return self.unloadedweight + (self.bulletweight * self:GetData("ammo", 0))
end

ITEM.exRender = false
ITEM.img = ix.util.GetMaterial("vgui/hud/weapons/brhp.png")

ITEM.pacData = {
[1] = {
	["children"] = {
		[1] = {
			["children"] = {
				[1] = {
					["children"] = {
					},
					["self"] = {
						["Model"] = "models/weapons/w_pist_brhp.mdl",
						["ClassName"] = "model",
						["Position"] = Vector(-6.918, 3.162, 3.067),
						["EditorExpand"] = true,
						["UniqueID"] = "3543276491",
						["Bone"] = "pelvis",
						["Name"] = "brhp",
						["Angles"] = Angle(-30, 180, 0),
					},
				},
			},
			["self"] = {
				["AffectChildrenOnly"] = true,
				["ClassName"] = "event",
				["UniqueID"] = "1016812402",
				["Event"] = "weapon_class",
				["EditorExpand"] = true,
				["Name"] = "weapon class find simple\"@@1\"",
				["Arguments"] = "cw_brhp@@0",
			},
		},
	},
	["self"] = {
		["ClassName"] = "group",
		["UniqueID"] = "1118321183",
		["EditorExpand"] = true,
	},
},
}