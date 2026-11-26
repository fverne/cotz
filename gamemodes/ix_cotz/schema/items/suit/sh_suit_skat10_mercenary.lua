ITEM.name = "STS-N Body Armor"
ITEM.model = "models/kek1ch/military_outfit.mdl"
ITEM.newModel = "models/cotz/sectorfour/male_stingray9.mdl"
ITEM.description= "A dated military-grade body armor"
ITEM.longdesc = "This dated military armoured suit is designed for assault operations in anomalous areas. Has a built-in compensation suit, and an anomalous protection bodysuit. The armour provides excellent protection against bullet and fragmentation damage, without greatly reducing the wearer’s mobility."

ITEM.width = 2
ITEM.height = 3
ITEM.img = ix.util.GetMaterial("vgui/hud/skat.png")
ITEM.weight = 16.830
ITEM.newSkin = 19
ITEM.baseSuit = "suit_skat10"
ITEM.suitVariant = "mercenary"

ITEM.price = 2805000
ITEM.repairCost = ITEM.price/100*1 -- cost to repair from 0% durability
ITEM.fullRepairCost = 16930

ITEM.isGasmask = false
ITEM.isHelmet = false

ITEM.br = 0.368
ITEM.fbr = 3
ITEM.sr = 0.465
ITEM.fsr = 3
ITEM.impactRes = 0.46
ITEM.flatImpactRes = 2
ITEM.ar = 0.216
ITEM.far = 2
ITEM.thermalRes = 0.234
ITEM.flatThermalRes = 2
ITEM.electricalRes = 0.207
ITEM.flatElectricalRes = 2
ITEM.chemicalRes = 0.207
ITEM.flatChemicalRes = 2

ITEM.carryinc = 11.67
ITEM.exteriorSlots = 2
ITEM.interiorSlots = 2
ITEM.extraSlots = 1

ITEM.skincustom = ix.suitAppearance.SkinOptions(ix.suitAppearance.SKAT10_SKINS)
