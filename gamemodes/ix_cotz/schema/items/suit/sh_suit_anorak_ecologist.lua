ITEM.name = "Ecologists Anorak"
ITEM.model = "models/kek1ch/rookie_outfit.mdl"
ITEM.newModel = "models/cotz/sectorfour/male_anorak.mdl"
ITEM.description= "A worn anorak."
ITEM.longdesc = "A simple polyester-cotton mix anorak. Doesn't provide much protection from anything except the wind and rain."

ITEM.width = 2
ITEM.height = 2
ITEM.img = ix.util.GetMaterial("vgui/hud/outfit_anorak1.png")
ITEM.weight = 2.316
ITEM.newSkin = 47
ITEM.baseSuit = "suit_anorak"
ITEM.suitVariant = "ecologist"

ITEM.price = 7359
ITEM.repairCost = ITEM.price/100*1 -- cost to repair from 0% durability

ITEM.isGasmask = false 
ITEM.isHelmet = false

ITEM.br = 0.01
ITEM.fbr = 1
ITEM.sr = 0.11
ITEM.fsr = 1
ITEM.ar = 0.07
ITEM.far = 2
ITEM.thermalRes = 0.07
ITEM.flatThermalRes = 2
ITEM.electricalRes = 0.07
ITEM.flatElectricalRes = 2
ITEM.chemicalRes = 0.07
ITEM.flatChemicalRes = 2
ITEM.gravitationalRes = 0.07
ITEM.flatGravitationalRes = 2

ITEM.carryinc = 2.780
ITEM.exteriorSlots = 1
ITEM.interiorSlots = 0
ITEM.extraSlots = 0

ITEM.hoodBodygroup = {name = "Neck", down = 0, up = 1}
ITEM.skincustom = ix.suitAppearance.SkinOptions(0, 60)
