ITEM.name = "M1887"
ITEM.description= "A lever-action shotgun firing 12 gauge shells."
ITEM.longdesc = "The Model 1887 was one of the first successful repeating shotguns. Its lever-action design was chosen at the behest of the Winchester Repeating Arms Company, best known at the time as manufacturers of lever-action rifles such as the Winchester Model 1873. Designer John Browning suggested that a pump-action would be much more appropriate for a repeating shotgun, but Winchester management's position was that, at the time, the company was known as a 'lever-action firearm company', and felt that their new shotgun must also be a lever-action for reasons of brand recognition.\n\nAmmo: 12 Gauge \nMagazine Capacity: 6"
ITEM.model = ("models/weapons/w_shot_m1887.mdl")
ITEM.class = "cw_m1887"
ITEM.weaponCategory = "primary"
ITEM.price = 9500
ITEM.width = 4
ITEM.height = 1
ITEM.canAttach = false

ITEM.bulletweight = 0.031
ITEM.unloadedweight = 3.3

ITEM.repair_PartsComplexity = 3
ITEM.repair_PartsRarity = 4

function ITEM:GetWeight()
  return self.unloadedweight + (self.bulletweight * self:GetData("ammo", 0))
end

ITEM.exRender = false
ITEM.img = ix.util.GetMaterial("vgui/hud/weapons/m1887.png")

ITEM.pacData = {
[1] = {
	["children"] = {
		[1] = {
			["children"] = {
				[1] = {
					["children"] = {
					},
					["self"] = {
						["Angles"] = Angle(62.727, 107.588, 8.727),
						["Position"] = Vector(-10.144, -3.047, -4.744),
						["Model"] = "models/weapons/w_shot_m1887.mdl",
						["ClassName"] = "model",
						["EditorExpand"] = true,
						["UniqueID"] = "8592533121",
						["Bone"] = "chest",
						["Name"] = "1887",
						["AngleOffset"] = Angle(200, 0, 0),
					},
				},
			},
			["self"] = {
				["AffectChildrenOnly"] = true,
				["ClassName"] = "event",
				["UniqueID"] = "1452356542",
				["Event"] = "weapon_class",
				["EditorExpand"] = true,
				["Name"] = "weapon class find simple\"@@1\"",
				["Arguments"] = "cw_m1887@@0",
			},
		},
	},
	["self"] = {
		["ClassName"] = "group",
		["UniqueID"] = "81242253283",
		["EditorExpand"] = true,
	},
},
}
