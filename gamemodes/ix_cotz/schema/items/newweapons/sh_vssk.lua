ITEM.name = "VSSK 'Vykhlop'"
ITEM.description= "A special forces silent sniper rifle. Fires 12.7x55mm."
ITEM.longdesc = "The VSSK is a Russian bullpup, straight-pull bolt-action, magazine-fed sniper rifle chambered for the 12.7x55mm STs-130 subsonic round. It is also known as the VKS. The 12.7×55mm VKS silenced sniper rifle is intended for special operations that require silent firing and penetration much superior to that provided by 9×39mm VSS silenced sniper rifle. Typical targets for the VKS are combatants in heavy body armor or behind cover. The weapon uses an integral suppressor.\n\nAmmo: 12.7x55mm\nMagazine Capacity: 5"
ITEM.model = "models/flaymi/anomaly/weapons/w_models/wpn_vssk_w.mdl"
ITEM.class = "cw_vssk"
ITEM.weaponCategory = "primary"
ITEM.width = 7
ITEM.price = 95000
ITEM.height = 2

ITEM.canAttach = false

ITEM.bulletweight = 0.017
ITEM.unloadedweight = 7.0

function ITEM:GetWeight()
  return self.unloadedweight + (self.bulletweight * self:GetData("ammo", 0))
end

ITEM.iconCam = {
	pos = Vector(6.95, -199.12, -17.43),
	ang = Angle(-6.99, 90.13, 0),
	fov = 14.35
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
						["Position"] = Vector(16.218, -4.315, -2.859),
						["Model"] = "models/flaymi/anomaly/weapons/w_models/wpn_vssk_w.mdl",
						["ClassName"] = "model",
						["EditorExpand"] = true,
						["UniqueID"] = "7946869091",
						["Bone"] = "spine 2",
						["Name"] = "vssk",
					},
				},
			},
			["self"] = {
				["AffectChildrenOnly"] = true,
				["ClassName"] = "event",
				["UniqueID"] = "1237786422",
				["Event"] = "weapon_class",
				["EditorExpand"] = true,
				["Name"] = "weapon class find simple\"@@1\"",
				["Arguments"] = "cw_vssk@@0",
			},
		},
	},
	["self"] = {
		["ClassName"] = "group",
		["UniqueID"] = "2784946348",
		["EditorExpand"] = true,
	},
},
}