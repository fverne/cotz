ITEM.name = "X-12 Exoskeleton"
ITEM.model = "models/kek1ch/exolight_outfit.mdl"
ITEM.newModel = "models/cotz/sectorfour/male_exoskeleton.mdl"
ITEM.description= "An armored exoskeleton suit"
ITEM.longdesc = "The X-12 groups its armour and supporting structure into a broad, articulated body suit. Reinforced joints allow the separate sections to remain part of one worn assembly. Its imposing appearance does not change the need to arrange head protection independently."

ITEM.width = 2
ITEM.height = 3
ITEM.img = ix.util.GetMaterial("vgui/hud/radsuit.png")
ITEM.weight = 33.00
ITEM.newSkin = 29
ITEM.baseSuit = "suit_exoskeleton"
ITEM.suitVariant = "fanatic"

ITEM.price = 9999999999
ITEM.repairCost = ITEM.price/100*1 -- cost to repair from 0% durability
ITEM.fullRepairCost = 430890

ITEM.isGasmask = false
ITEM.isHelmet = false
ITEM.isExoskeleton = true

ITEM.br = 0.437
ITEM.fbr = 5
ITEM.sr = 0.786
ITEM.fsr = 5
ITEM.impactRes = 0.611
ITEM.flatImpactRes = 2
ITEM.ar = 0.263
ITEM.far = 2
ITEM.thermalRes = 0.263
ITEM.flatThermalRes = 2
ITEM.electricalRes = 0.263
ITEM.flatElectricalRes = 2
ITEM.chemicalRes = 0.263
ITEM.flatChemicalRes = 2
ITEM.pr = 0.437
ITEM.fpr = 0

ITEM.carryinc = 64.000
ITEM.exteriorSlots = 2
ITEM.interiorSlots = 3
ITEM.extraSlots = 2

ITEM.bodyGroups = {
	["Exoskeleton"] = 0,
}
ITEM.skincustom = ix.suitAppearance.SkinOptions(0, 36)
