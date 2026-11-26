ITEM.name = "Mercenary Expedition Suit"
ITEM.model = "models/kek1ch/merc_outfit.mdl"
ITEM.newModel = "models/cotz/sectorfour/male_outfit_expedition.mdl"
ITEM.description = "An expedition suit"
ITEM.longdesc = "A dark field jacket and trousers form the base of the Expedition suit, with a fitted vest worn over them. Broad pockets and closed flaps hold small kit against the body, and the muted cloth gives the outfit a plain, workmanlike outline."

ITEM.width = 2
ITEM.height = 3
ITEM.img = ix.util.GetMaterial("vgui/hud/io7a.png")
ITEM.weight = 10.71
ITEM.newSkin = 2
ITEM.baseSuit = "suit_expedition"
ITEM.suitVariant = "mercenary"

ITEM.price = 140800
ITEM.repairCost = ITEM.price/100*1 -- cost to repair from 0% durability
ITEM.fullRepairCost = 9670

ITEM.isGasmask = false
ITEM.isHelmet = false

ITEM.br = 0.181
ITEM.fbr = 2
ITEM.sr = 0.253
ITEM.fsr = 1
ITEM.impactRes = 0.24
ITEM.flatImpactRes = 1
ITEM.ar = 0.079
ITEM.far = 1
ITEM.thermalRes = 0.086
ITEM.flatThermalRes = 1
ITEM.electricalRes = 0.076
ITEM.flatElectricalRes = 1
ITEM.chemicalRes = 0.076
ITEM.flatChemicalRes = 1

ITEM.carryinc = 8.48
ITEM.exteriorSlots = 2
ITEM.interiorSlots = 1
ITEM.extraSlots = 0

ITEM.skincustom = ix.suitAppearance.SkinOptions(0, 10)
