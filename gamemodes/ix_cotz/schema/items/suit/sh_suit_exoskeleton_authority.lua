ITEM.name = "PSZ-6k"
ITEM.model = "models/kek1ch/exolight_outfit.mdl"
ITEM.newModel = "models/cotz/sectorfour/male_exoskeleton.mdl"
ITEM.description= "An armored exoskeleton suit"
ITEM.longdesc = "The PSZ-6k places its armoured panels around the same heavy supporting frame as the exoskeleton family. Its finish gives the broad body an issued-equipment appearance. The load-bearing construction is substantial even before the wearer adds separate headgear and supplies."

ITEM.width = 2
ITEM.height = 3
ITEM.img = ix.util.GetMaterial("vgui/hud/radsuit.png")
ITEM.weight = 33.50
ITEM.newSkin = 13
ITEM.baseSuit = "suit_exoskeleton"
ITEM.suitVariant = "authority"

ITEM.price = 9999999999
ITEM.repairCost = ITEM.price/100*1 -- cost to repair from 0% durability
ITEM.fullRepairCost = 430890

ITEM.isGasmask = false
ITEM.isHelmet = false
ITEM.isExoskeleton = true

ITEM.br = 0.423
ITEM.fbr = 5
ITEM.sr = 0.90
ITEM.fsr = 5
ITEM.impactRes = 0.592
ITEM.flatImpactRes = 2
ITEM.ar = 0.235
ITEM.far = 2
ITEM.thermalRes = 0.235
ITEM.flatThermalRes = 2
ITEM.electricalRes = 0.235
ITEM.flatElectricalRes = 2
ITEM.chemicalRes = 0.235
ITEM.flatChemicalRes = 2

ITEM.carryinc = 64.000
ITEM.exteriorSlots = 2
ITEM.interiorSlots = 3
ITEM.extraSlots = 2

ITEM.bodyGroups = {
	["Exoskeleton"] = 0,
}
ITEM.skincustom = ix.suitAppearance.SkinOptions(0, 36)
