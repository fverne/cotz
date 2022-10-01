ITEM.name = "Colt Chicago"
ITEM.description= "An American military surplus semi-automatic pistol chambered for .45 ACP."
ITEM.longdesc = "The M1911 first came into service in the American army in 1911 and has yet to be phased out of production.\nThis customized version has an extended magazine, longer barrel and slide, and a small foregrip has been affixed in front of the trigger. It has also had its trigger group altered to allow fully automatic fire. The extreme fire rate makes it very hard to control.\n\nAmmo: .45ACP\nMagazine Capacity: 13"
ITEM.model = "models/weapons/w_silverballer.mdl"
ITEM.class = "cw_m1911chic"
ITEM.weaponCategory = "secondary"
ITEM.price = 20000
ITEM.width = 2
ITEM.height = 1
ITEM.validAttachments = {"md_cobram2"}

ITEM.exRender = false
ITEM.img = ix.util.GetMaterial("vgui/hud/weapons/m1911chic.png")

ITEM.bulletweight = 0.020
ITEM.unloadedweight = 1.79

ITEM.repair_PartsComplexity = 2
ITEM.repair_PartsRarity = 2

function ITEM:GetWeight()
  return self.unloadedweight + (self.bulletweight * self:GetData("ammo", 0))
end

ITEM.iconCam = {
	pos = Vector(7, -205, 1.2000000476837),
	ang = Angle(0, 90, 0),
	fov = 4,
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
						["Model"] = "models/weapons/w_silverballer.mdl",
						["ClassName"] = "model",
						["Position"] = Vector(-9.071, 9.525, 0.823),
						["EditorExpand"] = true,
						["UniqueID"] = "35897338512535",
						["Bone"] = "pelvis",
						["Name"] = "m1911chic",
						["Angles"] = Angle(0, -90, -30),
					},
				},
			},
			["self"] = {
				["AffectChildrenOnly"] = true,
				["ClassName"] = "event",
				["UniqueID"] = "15152512",
				["Event"] = "weapon_class",
				["EditorExpand"] = true,
				["Name"] = "weapon class find simple\"@@1\"",
				["Arguments"] = "cw_m1911chic@@0",
			},
		},
	},
	["self"] = {
		["ClassName"] = "group",
		["UniqueID"] = "13214515413",
		["EditorExpand"] = true,
	},
},
}