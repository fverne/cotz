ITEM.name = "Mercenary Exoskeleton"
ITEM.model = "models/kek1ch/exolight_outfit.mdl"
ITEM.newModel = "models/cotz/sectorfour/male_exoskeleton.mdl"
ITEM.description= "An armored exoskeleton suit"
ITEM.longdesc = "The Mercenary exoskeleton places particularly substantial armour around the family's load-bearing framework. Its body has a greater weight of its own than the basic version. The contracted-equipment finish covers a system whose size is apparent at every joint and fastening."

ITEM.width = 2
ITEM.height = 3
ITEM.img = ix.util.GetMaterial("vgui/hud/radsuit.png")
ITEM.weight = 34.50
ITEM.newSkin = 24
ITEM.baseSuit = "suit_exoskeleton"
ITEM.suitVariant = "mercenary"

ITEM.price = 9999999999
ITEM.repairCost = ITEM.price/100*1 -- cost to repair from 0% durability
ITEM.fullRepairCost = 430890

ITEM.isGasmask = false
ITEM.isHelmet = false
ITEM.isExoskeleton = true

ITEM.br = 0.518
ITEM.fbr = 5
ITEM.sr = 0.786
ITEM.fsr = 5
ITEM.impactRes = 0.724
ITEM.flatImpactRes = 2
ITEM.ar = 0.254
ITEM.far = 2
ITEM.thermalRes = 0.275
ITEM.flatThermalRes = 2
ITEM.electricalRes = 0.243
ITEM.flatElectricalRes = 2
ITEM.chemicalRes = 0.243
ITEM.flatChemicalRes = 2

ITEM.carryinc = 64.000
ITEM.exteriorSlots = 2
ITEM.interiorSlots = 3
ITEM.extraSlots = 2

ITEM.bodyGroups = {
	["Exoskeleton"] = 0,
}
ITEM.skincustom = ix.suitAppearance.SkinOptions(0, 36)
