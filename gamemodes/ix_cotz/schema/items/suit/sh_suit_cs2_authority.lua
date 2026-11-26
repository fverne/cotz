ITEM.name = "Authority Sky-2 Suit"
ITEM.model = "models/kek1ch/cs_heavy_outfit.mdl"
ITEM.newModel = "models/cotz/sectorfour/male_cs2.mdl"
ITEM.description = "A Sky-2 suit"
ITEM.longdesc = "A pair of jeans, nomex jacket, with Russian class-3 vest and load bearing gear. Combined with a helmet, it is useful for low intensity conflicts within the zone. Worn by the kinds of people who'd walk far just to shoot somebody."

ITEM.width = 2
ITEM.height = 3
ITEM.img = ix.util.GetMaterial("vgui/hud/cs2.png")
ITEM.weight = 10.20
ITEM.newSkin = 1
ITEM.baseSuit = "suit_cs2"
ITEM.suitVariant = "authority"

ITEM.price = 214500
ITEM.repairCost = ITEM.price/100*1 -- cost to repair from 0% durability
ITEM.fullRepairCost = 10270

ITEM.isGasmask = false
ITEM.isHelmet = false

ITEM.br = 0.188
ITEM.fbr = 1
ITEM.sr = 0.25
ITEM.fsr = 2
ITEM.impactRes = 0.196
ITEM.flatImpactRes = 1
ITEM.ar = 0.164
ITEM.far = 1
ITEM.thermalRes = 0.164
ITEM.flatThermalRes = 1
ITEM.electricalRes = 0.164
ITEM.flatElectricalRes = 1
ITEM.chemicalRes = 0.164
ITEM.flatChemicalRes = 1

ITEM.carryinc = 8.16
ITEM.exteriorSlots = 2
ITEM.interiorSlots = 2
ITEM.extraSlots = 1

ITEM.skincustom = ix.suitAppearance.SkinOptions(0, 6)
