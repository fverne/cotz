ITEM.name = "Looted STALKER Suit"
ITEM.model = "models/kek1ch/stalker_outfit.mdl"
ITEM.newModel = "models/cotz/sectorfour/male_sunrise.mdl"
ITEM.description= "A STALKER suit."
ITEM.longdesc = "This DIY stalker bodysuit is a combination of twin-layered rubberised cloth with Plexiglas lining and built-in body armour. The vest stops slower, weaker pistol calibers. The suit enjoys great popularity due to its low cost and modification potential."

ITEM.width = 2
ITEM.height = 3
ITEM.img = ix.util.GetMaterial("vgui/hud/sunrise.png")
ITEM.weight = 6.262
ITEM.newSkin = 23
ITEM.baseSuit = "suit_sunrise"
ITEM.suitVariant = "looted"

ITEM.price = 52712
ITEM.repairCost = ITEM.price/100*1 -- cost to repair from 0% durability
ITEM.fullRepairCost = 7260
ITEM.meleeDamageBonus = 0.113

ITEM.isGasmask = false
ITEM.isHelmet = false

ITEM.br = 0.094
ITEM.fbr = 1
ITEM.sr = 0.156
ITEM.fsr = 1
ITEM.impactRes = 0.119
ITEM.flatImpactRes = 1
ITEM.ar = 0.099
ITEM.far = 1
ITEM.thermalRes = 0.099
ITEM.flatThermalRes = 1
ITEM.electricalRes = 0.099
ITEM.flatElectricalRes = 1
ITEM.chemicalRes = 0.099
ITEM.flatChemicalRes = 1
ITEM.radProt = 0.049

ITEM.carryinc = 4.910
ITEM.exteriorSlots = 2
ITEM.interiorSlots = 1
ITEM.extraSlots = 0

ITEM.skincustom = ix.suitAppearance.SkinOptions(ix.suitAppearance.SUNRISE_SKINS)
