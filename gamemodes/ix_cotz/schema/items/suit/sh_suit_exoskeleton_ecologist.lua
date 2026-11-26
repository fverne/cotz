ITEM.name = "Scientific Exoskeleton"
ITEM.model = "models/kek1ch/exolight_outfit.mdl"
ITEM.newModel = "models/cotz/sectorfour/male_exoskeleton.mdl"
ITEM.description= "An armored exoskeleton suit"
ITEM.longdesc = "The scientific exoskeleton carries research-associated colouring over an armoured body and support frame. Its elaborate joints and layered fittings are far removed from a simple protective coverall. The body system leaves head and respiratory equipment as separate parts of the complete outfit."

ITEM.width = 2
ITEM.height = 3
ITEM.img = ix.util.GetMaterial("vgui/hud/radsuit.png")
ITEM.weight = 32.60
ITEM.newSkin = 17
ITEM.baseSuit = "suit_exoskeleton"
ITEM.suitVariant = "ecologist"

ITEM.price = 9999999999
ITEM.repairCost = ITEM.price/100*1 -- cost to repair from 0% durability
ITEM.fullRepairCost = 430890

ITEM.isGasmask = false
ITEM.isHelmet = false
ITEM.isExoskeleton = true

ITEM.br = 0.423
ITEM.fbr = 5
ITEM.sr = 0.761
ITEM.fsr = 5
ITEM.impactRes = 0.662
ITEM.flatImpactRes = 2
ITEM.ar = 0.275
ITEM.far = 2
ITEM.thermalRes = 0.275
ITEM.flatThermalRes = 2
ITEM.electricalRes = 0.275
ITEM.flatElectricalRes = 2
ITEM.chemicalRes = 0.275
ITEM.flatChemicalRes = 2

ITEM.carryinc = 64.000
ITEM.exteriorSlots = 2
ITEM.interiorSlots = 3
ITEM.extraSlots = 2

ITEM.bodyGroups = {
	["Exoskeleton"] = 0,
}
ITEM.skincustom = ix.suitAppearance.SkinOptions(0, 36)
