ITEM.name = "Ecologist Nosorog"
ITEM.model = "models/kek1ch/exolight_outfit.mdl"
ITEM.newModel = "models/cotz/sectorfour/male_exoskeleton.mdl"
ITEM.description= "A behemoth exoskeleton suit"
ITEM.longdesc = "The Nosorog surrounds its supporting structure with a particularly heavy armoured body. Broad panels and reinforced joints make it an unusually substantial outfit even among exoskeleton-class equipment. The suit occupies the body as a complete assembly while leaving the head separately equipped."

ITEM.width = 2
ITEM.height = 3
ITEM.img = ix.util.GetMaterial("vgui/hud/radsuit.png")
ITEM.weight = 21
ITEM.baseSuit = "suit_nosorog"
ITEM.suitVariant = "ecologist"
ITEM.newSkin = 17

ITEM.price = 9999999999
ITEM.repairCost = ITEM.price/100*1 -- cost to repair from 0% durability
ITEM.fullRepairCost = 430890

ITEM.isGasmask = false
ITEM.isHelmet = false

ITEM.br = 0.451
ITEM.fbr = 5
ITEM.sr = 0.808
ITEM.fsr = 5
ITEM.impactRes = 0.704
ITEM.flatImpactRes = 2
ITEM.ar = 0.286
ITEM.far = 2
ITEM.thermalRes = 0.286
ITEM.flatThermalRes = 2
ITEM.electricalRes = 0.286
ITEM.flatElectricalRes = 2
ITEM.chemicalRes = 0.286
ITEM.flatChemicalRes = 2

ITEM.carryinc = 64.000
ITEM.exteriorSlots = 2
ITEM.interiorSlots = 3
ITEM.extraSlots = 2

ITEM.bodyGroups = {
	["Exoskeleton"] = 0,
}
ITEM.skincustom = ix.suitAppearance.SkinOptions(0, 36)
