ITEM.name = "Sky-5a Suit"
ITEM.model = "models/kek1ch/cs_heavy_outfit.mdl"
ITEM.newModel = "models/cotz/sectorfour/male_cs4.mdl"
ITEM.description= "A Sky-5 suit"
ITEM.longdesc = "A pair of reinforced tactical pants, comfortable nomex jacket and a plate carrier with pouches, it's a bare minimum of equipment for a seasoned merc, faction soldier or professional bandit."

ITEM.width = 2
ITEM.height = 3
ITEM.img = ix.util.GetMaterial("vgui/hud/cs2.png")
ITEM.weight = 9.600
ITEM.newSkin = 2
ITEM.baseSuit = "suit_cs5"
ITEM.suitVariant = "ecologist"

ITEM.price = 1210000
ITEM.repairCost = ITEM.price/100*1 -- cost to repair from 0% durability
ITEM.fullRepairCost = 13060

ITEM.isGasmask = false
ITEM.isHelmet = false

ITEM.br = 0.277
ITEM.fbr = 2
ITEM.sr = 0.307
ITEM.fsr = 2
ITEM.impactRes = 0.327
ITEM.flatImpactRes = 2
ITEM.ar = 0.301
ITEM.far = 2
ITEM.thermalRes = 0.301
ITEM.flatThermalRes = 2
ITEM.electricalRes = 0.301
ITEM.flatElectricalRes = 2
ITEM.chemicalRes = 0.301
ITEM.flatChemicalRes = 2

ITEM.carryinc = 11.520
ITEM.exteriorSlots = 2
ITEM.interiorSlots = 2
ITEM.extraSlots = 2

ITEM.skincustom = ix.suitAppearance.SkinOptions(0, 4)
