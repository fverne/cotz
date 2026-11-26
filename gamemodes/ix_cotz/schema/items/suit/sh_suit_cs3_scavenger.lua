ITEM.name = "Scavenger Sky-3 Suit"
ITEM.model = "models/kek1ch/cs_heavy_outfit.mdl"
ITEM.newModel = "models/cotz/sectorfour/male_cs1a.mdl"
ITEM.description = "A Sky-3 suit"
ITEM.longdesc = "Weathered olive cloth makes up most of the Sky-3, with a plain jacket body and sewn patches. Straps and small pouches keep the working load close to the chest, within reach without hanging far from the body."

ITEM.width = 2
ITEM.height = 3
ITEM.img = ix.util.GetMaterial("vgui/hud/cs1.png")
ITEM.weight = 11.88
ITEM.newSkin = 1
ITEM.baseSuit = "suit_cs3"
ITEM.suitVariant = "scavenger"

ITEM.price = 339900
ITEM.repairCost = ITEM.price/100*1 -- cost to repair from 0% durability
ITEM.fullRepairCost = 11730

ITEM.isGasmask = false
ITEM.isHelmet = false

ITEM.br = 0.217
ITEM.fbr = 1
ITEM.sr = 0.238
ITEM.fsr = 2
ITEM.impactRes = 0.228
ITEM.flatImpactRes = 1
ITEM.ar = 0.203
ITEM.far = 1
ITEM.thermalRes = 0.194
ITEM.flatThermalRes = 1
ITEM.electricalRes = 0.22
ITEM.flatElectricalRes = 1
ITEM.chemicalRes = 0.194
ITEM.flatChemicalRes = 1

ITEM.carryinc = 19.20
ITEM.exteriorSlots = 2
ITEM.interiorSlots = 2
ITEM.extraSlots = 1

ITEM.skincustom = ix.suitAppearance.SkinOptions(0, 5)
