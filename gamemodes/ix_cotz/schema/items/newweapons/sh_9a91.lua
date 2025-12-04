ITEM.name = "9A-91"
ITEM.description= "A special forces assault rifle chambered for 9x39mm."
ITEM.longdesc = "The 9A-91 is a gas operated, rotating bolt weapon, which utilizes a long stroke gas piston, located above the barrel, and a rotating bolt with 4 lugs. The receiver is made from steel stampings; the forend and pistol grip are made from polymer. The steel buttstock folds up and above the receiver when not in use.\nThe iron sights have also been relocated to the upper front handguard as opposed to being located on the suppressor, apparently for when the gun is used without the suppressor attached.\n\nAmmo: 9x39mm\nMagazine Capacity: 20"
ITEM.model = ("models/flaymi/anomaly/weapons/w_models/9a91.mdl")
ITEM.class = "cw_9a91"
ITEM.weaponCategory = "primary"
ITEM.price = 35000
ITEM.width = 4
ITEM.height  	= 2
ITEM.validAttachments = {"md_pbs1","md_kobra","md_pso1"}

ITEM.bulletweight = 0.023
ITEM.unloadedweight = 1.8




function ITEM:GetWeight()
  return self:GetData("weight", self.unloadedweight) + (self.bulletweight * self:GetData("ammo", 0))
end

ITEM.iconCam = {
	pos = Vector(-20.83, -198.15, -17.43),
	ang = Angle(-4.93, 83.88, 0),
	fov = 7.23
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
						["Angles"] = Angle(-6, 0, 180),
						["Position"] = Vector(-1.724, -4.195, -3.961),
						["Model"] = "models/flaymi/anomaly/weapons/w_models/9a91.mdl",
						["ClassName"] = "model",
						["EditorExpand"] = true,
						["UniqueID"] = "7767986673",
						["Bone"] = "spine 2",
						["Name"] = "vikhr",
					},
				},
			},
			["self"] = {
				["AffectChildrenOnly"] = true,
				["ClassName"] = "event",
				["UniqueID"] = "1275664522",
				["Event"] = "weapon_class",
				["EditorExpand"] = true,
				["Name"] = "weapon class find simple\"@@1\"",
				["Arguments"] = "cw_9a91@@0",
			},
		},
	},
	["self"] = {
		["ClassName"] = "group",
		["UniqueID"] = "2775647898",
		["EditorExpand"] = true,
	},
},
}