ITEM.name = "Ecologist Trenchcoat"
ITEM.model = "models/kek1ch/novice_outfit.mdl"
ITEM.newModel = "models/cotz/sectorfour/male_trenchcoat.mdl"
ITEM.newSkin = 4
ITEM.description= "A trenchcoat."
ITEM.longdesc = "A regular leather trench coat. Has no special purpose other than to keep the wearer warm at night or protect from a blind dog bite. Although the trench coat is not particularly comfortable, it is often used by Bandits in the Zone - either because it allows them to hide in the dark or simply due to its 'cool' appearance."

ITEM.width = 2
ITEM.height = 3
ITEM.img = ix.util.GetMaterial("vgui/hud/trenchcoat.png")
ITEM.weight = 3.132
ITEM.baseSuit = "suit_trenchcoat"
ITEM.suitVariant = "ecologist"

ITEM.price = 25652
ITEM.repairCost = ITEM.price/100*1 -- cost to repair from 0% durability
ITEM.fullRepairCost = 5710

ITEM.isGasmask = false
ITEM.isHelmet = false

ITEM.br = 0.035
ITEM.fbr = 1
ITEM.sr = 0.139
ITEM.fsr = 1
ITEM.impactRes = 0.098
ITEM.flatImpactRes = 1
ITEM.ar = 0.072
ITEM.far = 1
ITEM.thermalRes = 0.072
ITEM.flatThermalRes = 1
ITEM.electricalRes = 0.072
ITEM.flatElectricalRes = 1
ITEM.chemicalRes = 0.072
ITEM.flatChemicalRes = 1

ITEM.carryinc = 3.76
ITEM.exteriorSlots = 1
ITEM.interiorSlots = 0
ITEM.extraSlots = 0

ITEM.hoodBodygroup = {name = "Neck", down = 0, up = 1}
ITEM.skincustom = ix.suitAppearance.SkinOptions(0, 8)
