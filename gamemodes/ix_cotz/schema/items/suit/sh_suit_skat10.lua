ITEM.name = "Skat-10 Armored Suit"
ITEM.model = "models/kek1ch/military_outfit.mdl"
ITEM.newModel = "models/cotz/sectorfour/male_stingray9.mdl"
ITEM.description= "A dated military-grade body armor"
ITEM.longdesc = "This dated military armoured suit is designed for assault operations in anomalous areas. Has a built-in compensation suit, and an anomalous protection bodysuit. The armour provides excellent protection against bullet and fragmentation damage, without greatly reducing the wearer’s mobility."

ITEM.width = 2
ITEM.height = 3
ITEM.img = ix.util.GetMaterial("vgui/hud/skat.png")
ITEM.weight = 16.50
ITEM.newSkin = 0
ITEM.baseSuit = "suit_skat10"

ITEM.price = 2550000
ITEM.repairCost = ITEM.price/100*1 -- cost to repair from 0% durability
ITEM.fullRepairCost = 16930

ITEM.isGasmask = false
ITEM.isHelmet = false

ITEM.br = 0.32
ITEM.fbr = 3
ITEM.sr = 0.479
ITEM.fsr = 3
ITEM.impactRes = 0.40
ITEM.flatImpactRes = 2
ITEM.ar = 0.213
ITEM.far = 2
ITEM.thermalRes = 0.213
ITEM.flatThermalRes = 2
ITEM.electricalRes = 0.213
ITEM.flatElectricalRes = 2
ITEM.chemicalRes = 0.213
ITEM.flatChemicalRes = 2

ITEM.carryinc = 11.55
ITEM.exteriorSlots = 2
ITEM.interiorSlots = 2
ITEM.extraSlots = 1

ITEM.skincustom = ix.suitAppearance.SkinOptions(ix.suitAppearance.SKAT10_SKINS)
