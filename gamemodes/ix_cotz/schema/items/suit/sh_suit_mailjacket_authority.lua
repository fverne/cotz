ITEM.name = "Authority Mail Jacket"
ITEM.model = "models/kek1ch/rookie_outfit.mdl"
ITEM.newModel = "models/cotz/sectorfour/male_anorak.mdl"
ITEM.description= "An armoured anorak."
ITEM.longdesc = "A leather jacket with woven armour elements in common use amongst bandits and crooks. Gives some amount of protection, though is extremely inadequate in the conditions of the Zone. Fitted with reinforced armour."

ITEM.width = 2
ITEM.height = 2
ITEM.img = ix.util.GetMaterial("vgui/hud/outfit_anorak1.png")
ITEM.weight = 7.058
ITEM.newSkin = 49
ITEM.baseSuit = "suit_mailjacket"
ITEM.suitVariant = "authority"

ITEM.price = 19283
ITEM.repairCost = ITEM.price/100*1 -- cost to repair from 0% durability
ITEM.fullRepairCost = 5200

ITEM.isGasmask = false 
ITEM.isHelmet = false

ITEM.br = 0.054
ITEM.fbr = 1
ITEM.sr = 0.152
ITEM.fsr = 1
ITEM.impactRes = 0.089
ITEM.flatImpactRes = 1
ITEM.ar = 0.054
ITEM.far = 1
ITEM.thermalRes = 0.054
ITEM.flatThermalRes = 1
ITEM.electricalRes = 0.054
ITEM.flatElectricalRes = 1
ITEM.chemicalRes = 0.054
ITEM.flatChemicalRes = 1

ITEM.carryinc = 4.940
ITEM.exteriorSlots = 1
ITEM.interiorSlots = 0
ITEM.extraSlots = 0

ITEM.hoodBodygroup = {name = "Neck", down = 0, up = 1}
ITEM.skincustom = ix.suitAppearance.SkinOptions(0, 60)
