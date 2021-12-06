ITEM.name = "SV-98"
ITEM.description= "A Russian sniper rifle. Fires 7.62x54mm."
ITEM.longdesc = "The SV-98 is a Russian-made sniper rifle that was based on a civillian sport shooting rifle by Izhmash. \nAccording to the manufacturer, the rifle can be used to engage targets up to 1000 meters. But that requires match ammunition, which is hard to find in the Zone. \nIt weighs about 5.8 kilograms without a sight or suppressor.\n\nAmmo: 7.62x54mm \nMagazine Capacity: 10"
ITEM.model = ("models/weapons/w_sv98_scopeless.mdl")
ITEM.class = "cw_sv98"
ITEM.weaponCategory = "primary"
ITEM.price = 38500
ITEM.width = 6
ITEM.height = 1
ITEM.validAttachments = {"md_microt1","md_eotech","md_aimpoint","md_cmore","md_schmidt_shortdot","md_acog","md_nightforce_nxs","md_reflex","md_saker","md_foregrip"}

ITEM.bulletweight = 0.022
ITEM.unloadedweight = 5.8

ITEM.repair_PartsComplexity = 1
ITEM.repair_PartsRarity = 3

function ITEM:GetWeight()
  return self.unloadedweight + (self.bulletweight * self:GetData("ammo", 0))
end

ITEM.exRender = false
ITEM.img = ix.util.GetMaterial("vgui/hud/weapons/sv98.png")

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
						["Position"] = Vector(2.152, -5.054, -3.132),
						["Model"] = "models/weapons/w_sv98_scopeless.mdl",
						["ClassName"] = "model",
						["EditorExpand"] = true,
						["UniqueID"] = "8544253421",
						["Bone"] = "spine 2",
						["Name"] = "sv98",
					},
				},
			},
			["self"] = {
				["AffectChildrenOnly"] = true,
				["ClassName"] = "event",
				["UniqueID"] = "1234444222",
				["Event"] = "weapon_class",
				["EditorExpand"] = true,
				["Name"] = "weapon class find simple\"@@1\"",
				["Arguments"] = "cw_sv98@@0",
			},
		},
	},
	["self"] = {
		["ClassName"] = "group",
		["UniqueID"] = "8412651483",
		["EditorExpand"] = true,
	},
},
}