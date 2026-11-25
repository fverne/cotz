ITEM.name = "X-16 Suit"
ITEM.model = "models/kek1ch/stalker_outfit.mdl"
ITEM.newModel = "models/cotz/sectorfour/male_sunrise.mdl"
ITEM.description= "A scout suit"
ITEM.longdesc = "A light stalker suit made by craftsmen not satisfied with the STALKER suit. Care went into improving protection against anomalous hazards. A pacifist's suit, lack of body armor and careful weight management allows one to 'run like the wind' from a fight."

ITEM.width = 2
ITEM.height = 3
ITEM.img = ix.util.GetMaterial("vgui/hud/wind.png")
ITEM.weight = 5.600
ITEM.newSkin = 46
ITEM.baseSuit = "suit_wind"
ITEM.suitVariant = "fanatic"

ITEM.price = 109450
ITEM.repairCost = ITEM.price/100*1 -- cost to repair from 0% durability

ITEM.isGasmask = false
ITEM.isHelmet = false

ITEM.br = 0.15
ITEM.fbr = 2
ITEM.sr = 0.25
ITEM.fsr = 1
ITEM.ar = 0.18
ITEM.far = 2
ITEM.thermalRes = 0.18
ITEM.flatThermalRes = 2
ITEM.electricalRes = 0.18
ITEM.flatElectricalRes = 2
ITEM.chemicalRes = 0.18
ITEM.flatChemicalRes = 2
ITEM.gravitationalRes = 0.18
ITEM.flatGravitationalRes = 2

ITEM.carryinc = 4.950
ITEM.exteriorSlots = 2
ITEM.interiorSlots = 1
ITEM.extraSlots = 2

ITEM.skincustom = ix.suitAppearance.SkinOptions(ix.suitAppearance.PATHFINDER_SKINS)
