ITEM.name = "CS-10a"
ITEM.model = "models/kek1ch/military_outfit.mdl"
ITEM.newModel = "models/cotz/sectorfour/male_stingray9.mdl"
ITEM.description= "A dated military-grade body armor"
ITEM.longdesc = "This dated military armoured suit is designed for assault operations in anomalous areas. Has a built-in compensation suit, and an anomalous protection bodysuit. The armour provides excellent protection against bullet and fragmentation damage, without greatly reducing the wearer’s mobility."

ITEM.width = 2
ITEM.height = 3
ITEM.img = ix.util.GetMaterial("vgui/hud/skat.png")
ITEM.weight = 9.900
ITEM.newSkin = 7
ITEM.baseSuit = "suit_skat10"
ITEM.suitVariant = "ecologist"

ITEM.price = 666820
ITEM.repairCost = ITEM.price/100*1 -- cost to repair from 0% durability

ITEM.isGasmask = false
ITEM.isHelmet = false

ITEM.br = 0.29
ITEM.fbr = 3
ITEM.sr = 0.45
ITEM.fsr = 3
ITEM.ar = 0.28
ITEM.far = 3
ITEM.thermalRes = 0.28
ITEM.flatThermalRes = 3
ITEM.electricalRes = 0.28
ITEM.flatElectricalRes = 3
ITEM.chemicalRes = 0.28
ITEM.flatChemicalRes = 3
ITEM.gravitationalRes = 0.28
ITEM.flatGravitationalRes = 3

ITEM.carryinc = 10.40
ITEM.exteriorSlots = 2
ITEM.interiorSlots = 2
ITEM.extraSlots = 1

ITEM.skincustom = ix.suitAppearance.SkinOptions(ix.suitAppearance.SKAT10_SKINS)
