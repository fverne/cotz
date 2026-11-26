ITEM.name = "Pathfinder Suit"
ITEM.model = "models/kek1ch/stalker_outfit.mdl"
ITEM.newModel = "models/cotz/sectorfour/male_sunrise.mdl"
ITEM.description= "A scout suit"
ITEM.longdesc = "A light stalker suit made by craftsmen not satisfied with the STALKER suit. Care went into improving protection against anomalous hazards. A pacifist's suit, lack of body armor and careful weight management allows one to 'run like the wind' from a fight."

ITEM.width = 2
ITEM.height = 3
ITEM.img = ix.util.GetMaterial("vgui/hud/wind.png")
ITEM.weight = 5.000
ITEM.newSkin = 41
ITEM.baseSuit = "suit_wind"

ITEM.price = 108000
ITEM.repairCost = ITEM.price/100*1 -- cost to repair from 0% durability
ITEM.fullRepairCost = 9270

ITEM.isGasmask = false
ITEM.isHelmet = false

ITEM.br = 0.126
ITEM.fbr = 2
ITEM.sr = 0.216
ITEM.fsr = 1
ITEM.impactRes = 0.171
ITEM.flatImpactRes = 2
ITEM.ar = 0.153
ITEM.far = 2
ITEM.thermalRes = 0.153
ITEM.flatThermalRes = 2
ITEM.electricalRes = 0.153
ITEM.flatElectricalRes = 2
ITEM.chemicalRes = 0.153
ITEM.flatChemicalRes = 2

ITEM.carryinc = 5.000
ITEM.exteriorSlots = 2
ITEM.interiorSlots = 1
ITEM.extraSlots = 2

ITEM.skincustom = ix.suitAppearance.SkinOptions(ix.suitAppearance.PATHFINDER_SKINS)
