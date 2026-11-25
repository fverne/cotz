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

ITEM.price = 9999999999
ITEM.repairCost = ITEM.price/100*1 -- cost to repair from 0% durability

ITEM.isGasmask = false
ITEM.isHelmet = false
ITEM.isExoskeleton = true

ITEM.br = 0.46
ITEM.fbr = 6
ITEM.sr = 0.82
ITEM.fsr = 6
ITEM.ar = 0.26
ITEM.far = 3
ITEM.thermalRes = 0.26
ITEM.flatThermalRes = 3
ITEM.electricalRes = 0.26
ITEM.flatElectricalRes = 3
ITEM.chemicalRes = 0.26
ITEM.flatChemicalRes = 3
ITEM.gravitationalRes = 0.26
ITEM.flatGravitationalRes = 3

ITEM.carryinc = 64.000
ITEM.exteriorSlots = 2
ITEM.interiorSlots = 3
ITEM.extraSlots = 2

ITEM.bodyGroups = {
	["Exoskeleton"] = 0,
}
ITEM.skincustom = ix.suitAppearance.SkinOptions(0, 36)
