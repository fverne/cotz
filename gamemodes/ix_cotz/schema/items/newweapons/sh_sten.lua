ITEM.name = "Sten Gun MKII"
ITEM.description= "An old pipe-like submachinegun. Fires 9x19mm."
ITEM.longdesc = "The Sten Gun was introduced when the British army was facing a shortage of submachineguns from the US.\nIt was made with stamped metal and minimal welding to minimize price, this naturally brought some side effects onto the table.\nThe gun is uncomfortable to hold and has a rather unsafe safety.\nHowever, it's a formidable cheap weapon that shoots bullets where you point it.\nThis one is a Mark 2 model, it weighs about 3.2 kilograms unloaded and is all metal. It fires 600 rounds per minute.\n\nAmmo: 9x19mm\nMagazine Capacity: 32"
ITEM.model = ("models/weapons/w_smg_ste.mdl")
ITEM.class = "cw_sten"
ITEM.weaponCategory = "primary"
ITEM.price = 3500
ITEM.width = 3
ITEM.height = 1
ITEM.validAttachments = {"md_tundra9mm"}

ITEM.bulletweight = 0.008
ITEM.unloadedweight = 3.2

ITEM.repair_PartsComplexity = 1
ITEM.repair_PartsRarity = 1

function ITEM:GetWeight()
  return self.unloadedweight + (self.bulletweight * self:GetData("ammo", 0))
end

ITEM.iconCam = {
	pos = Vector(0, -200, -2),
	ang = Angle(0, 90, 0),
	fov = 12,
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
						["Position"] = Vector(6.518, -4.195, -2.685),
						["Model"] = "models/weapons/w_smg_ste.mdl",
						["ClassName"] = "model",
						["EditorExpand"] = true,
						["UniqueID"] = "8883945391",
						["Bone"] = "spine 2",
						["Name"] = "sten",
						["Size"] = 0.85,
					},
				},
			},
			["self"] = {
				["AffectChildrenOnly"] = true,
				["ClassName"] = "event",
				["UniqueID"] = "1058846402",
				["Event"] = "weapon_class",
				["EditorExpand"] = true,
				["Name"] = "weapon class find simple\"@@1\"",
				["Arguments"] = "cw_sten@@0",
			},
		},
	},
	["self"] = {
		["ClassName"] = "group",
		["UniqueID"] = "8132882183",
		["EditorExpand"] = true,
	},
},
}