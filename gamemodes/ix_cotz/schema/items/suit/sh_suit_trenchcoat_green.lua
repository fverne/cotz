ITEM.name = "Green Trenchcoat"
ITEM.model = "models/kek1ch/novice_outfit.mdl"
ITEM.newModel = "models/cotz/sectorfour/male_trenchcoat.mdl"
ITEM.newSkin = 4
ITEM.description= "A trenchcoat."
ITEM.longdesc = "A regular leather trench coat. Has no special purpose other than to keep the wearer warm at night or protect from a blind dog bite. Although the trench coat is not particularly comfortable, it is often used by Bandits in the Zone - either because it allows them to hide in the dark or simply due to its 'cool' appearance."

ITEM.width = 2
ITEM.height = 3
ITEM.img = ix.util.GetMaterial("vgui/hud/trenchcoat.png")
ITEM.weight = 5.220

ITEM.price = 23320
ITEM.repairCost = ITEM.price/100*1 -- cost to repair from 0% durability

ITEM.isGasmask = false 
ITEM.isHelmet = false

ITEM.br = 0.04
ITEM.fbr = 1
ITEM.sr = 0.16
ITEM.fsr = 1
ITEM.ar = 0.07
ITEM.far = 1
ITEM.thermalRes = 0.07
ITEM.flatThermalRes = 1
ITEM.electricalRes = 0.07
ITEM.flatElectricalRes = 1
ITEM.chemicalRes = 0.07
ITEM.flatChemicalRes = 1
ITEM.gravitationalRes = 0.07
ITEM.flatGravitationalRes = 1

ITEM.carryinc = 4.180
ITEM.exteriorSlots = 1
ITEM.interiorSlots = 0
ITEM.extraSlots = 0

ITEM.hoodBodygroup = {name = "Neck", down = 0, up = 1}
ITEM.skincustom = ix.suitAppearance.SkinOptions(0, 8)
