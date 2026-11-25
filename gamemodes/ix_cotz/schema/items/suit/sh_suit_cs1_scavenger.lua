ITEM.name = "Sky-1a Suit"
ITEM.model = "models/kek1ch/cs_light_outfit.mdl"
ITEM.newModel = "models/cotz/sectorfour/male_cs1a.mdl"
ITEM.description= "A Sky-1 suit"
ITEM.longdesc = "A pair of jeans, a rain jacket and a kevlar vest with lots of pouches. Another type of stalker 'uniform', made from off-the-shelf products. This one seems to have a high quality kevlar package."

ITEM.width = 2
ITEM.height = 3
ITEM.img = ix.util.GetMaterial("vgui/hud/cs1.png")
ITEM.weight = 6.930
ITEM.newSkin = 0
ITEM.baseSuit = "suit_cs1"
ITEM.suitVariant = "scavenger"

ITEM.price = 54175
ITEM.repairCost = ITEM.price/100*1 -- cost to repair from 0% durability

ITEM.isGasmask = false
ITEM.isHelmet = true

ITEM.br = 0.13
ITEM.fbr = 1
ITEM.sr = 0.19
ITEM.fsr = 1
ITEM.ar = 0.14
ITEM.far = 1
ITEM.thermalRes = 0.14
ITEM.flatThermalRes = 1
ITEM.electricalRes = 0.14
ITEM.flatElectricalRes = 1
ITEM.chemicalRes = 0.14
ITEM.flatChemicalRes = 1
ITEM.gravitationalRes = 0.14
ITEM.flatGravitationalRes = 1

ITEM.carryinc = 11.200
ITEM.exteriorSlots = 2
ITEM.interiorSlots = 1
ITEM.extraSlots = 1

ITEM.skincustom = ix.suitAppearance.SkinOptions(0, 5)
