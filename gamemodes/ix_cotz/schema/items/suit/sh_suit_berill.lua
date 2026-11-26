ITEM.name = "Berill-5M"
ITEM.model = "models/kek1ch/spec_sold_outfit.mdl"
ITEM.newModel = "models/cotz/sectorfour/male_berill5m.mdl"
ITEM.description= "A military-grade vest"
ITEM.longdesc = "This modern version of a STALKER bodysuit is better suited for recruits who are used to lightweight suits. Unlike the SKAT series, the suit provides reasonable protection against anomalies while also being capable of stopping some smaller caliber bullets."

ITEM.width = 2
ITEM.height = 3
ITEM.img = ix.util.GetMaterial("vgui/hud/berill7.png")
ITEM.weight = 12.000
ITEM.newSkin = 0
ITEM.baseSuit = "suit_berill"

ITEM.price = 400000
ITEM.repairCost = ITEM.price/100*1 -- cost to repair from 0% durability
ITEM.fullRepairCost = 12630

ITEM.isGasmask = false
ITEM.isHelmet = false

ITEM.br = 0.205
ITEM.fbr = 3
ITEM.sr = 0.365
ITEM.fsr = 2
ITEM.impactRes = 0.285
ITEM.flatImpactRes = 2
ITEM.ar = 0.107
ITEM.far = 2
ITEM.thermalRes = 0.107
ITEM.flatThermalRes = 2
ITEM.electricalRes = 0.107
ITEM.flatElectricalRes = 2
ITEM.chemicalRes = 0.107
ITEM.flatChemicalRes = 2

ITEM.carryinc = 9.600
ITEM.exteriorSlots = 2
ITEM.interiorSlots = 2
ITEM.extraSlots = 1

ITEM.skincustom = ix.suitAppearance.SkinOptions(0, 12)
