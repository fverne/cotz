ITEM.name = "M1928A1 'Thompson'"
ITEM.description= "A submachinegun chambered for .45 ACP."
ITEM.longdesc = "The Thompson submachine gun is an American submachine gun invented by John T. Thompson in 1918 which became infamous during the Prohibition era, being a signature weapon of various organized crime syndicates in the United States.\nThe Thompson submachine gun was also known informally as the 'Tommy Gun', 'Annihilator', 'Chicago Typewriter' and many more.\nThe Thompson was favored by soldiers, criminals, police, FBI, and civilians alike for its large .45 ACP cartridge and high volume of fully automatic fire. \n\nAmmo: .45 ACP \nMagazine Capacity: 50"
ITEM.model = ("models/khrcw2/doipack/w_thompson1928.mdl")
ITEM.class = "cw_m1928a1"
ITEM.weaponCategory = "primary"
ITEM.width = 4
ITEM.price = 100
ITEM.height = 2
ITEM.busflag = {"guns3_1"}
ITEM.repairCost = ITEM.price/100*1
ITEM.validAttachments = {"md_cobram2"}

ITEM.iconCam = {
	pos = Vector(-22, 8, -2),
	ang = Angle(0, -0, 0),
	fov = 70
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
						["Position"] = Vector(10.833, -4.312, -3.803),
						["Model"] = "models/khrcw2/doipack/w_thompson1928.mdl",
						["ClassName"] = "model",
						["EditorExpand"] = true,
						["UniqueID"] = "8882318491",
						["Bone"] = "spine 2",
						["Name"] = "m1928a1",
					},
				},
			},
			["self"] = {
				["AffectChildrenOnly"] = true,
				["ClassName"] = "event",
				["UniqueID"] = "10443236402",
				["Event"] = "weapon_class",
				["EditorExpand"] = true,
				["Name"] = "weapon class find simple\"@@1\"",
				["Arguments"] = "cw_m1928a1@@0",
			},
		},
	},
	["self"] = {
		["ClassName"] = "group",
		["UniqueID"] = "81344211833",
		["EditorExpand"] = true,
	},
},
}

if (CLIENT) then
    function ITEM:DrawEntity(entity, item)
    	entity:SetBodygroup(1,2)

        entity:DrawModel()
    end
end