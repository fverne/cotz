ITEM.name = "Mercenary Anorak"
ITEM.model = "models/kek1ch/rookie_outfit.mdl"
ITEM.newModel = "models/cotz/sectorfour/male_anorak.mdl"
ITEM.description= "A worn anorak."
ITEM.longdesc = "A simple polyester-cotton mix anorak. Doesn't provide much protection from anything except the wind and rain."

ITEM.width = 2
ITEM.height = 2
ITEM.img = ix.util.GetMaterial("vgui/hud/outfit_anorak1.png")
ITEM.weight = 3.937
ITEM.newSkin = 54
ITEM.baseSuit = "suit_anorak"
ITEM.suitVariant = "mercenary"

ITEM.price = 7359
ITEM.repairCost = ITEM.price/100*1 -- cost to repair from 0% durability
ITEM.fullRepairCost = 3770

ITEM.isGasmask = false 
ITEM.isHelmet = false

ITEM.br = 0.012
ITEM.fbr = 1
ITEM.sr = 0.107
ITEM.fsr = 1
ITEM.impactRes = 0.069
ITEM.flatImpactRes = 1
ITEM.ar = 0.051
ITEM.far = 1
ITEM.thermalRes = 0.055
ITEM.flatThermalRes = 1
ITEM.electricalRes = 0.049
ITEM.flatElectricalRes = 1
ITEM.chemicalRes = 0.049
ITEM.flatChemicalRes = 1
ITEM.radProt = 0.049

ITEM.carryinc = 3.120
ITEM.exteriorSlots = 1
ITEM.interiorSlots = 0
ITEM.extraSlots = 0

ITEM.hoodBodygroup = {name = "Neck", down = 0, up = 1}
ITEM.skincustom = ix.suitAppearance.SkinOptions(0, 60)
