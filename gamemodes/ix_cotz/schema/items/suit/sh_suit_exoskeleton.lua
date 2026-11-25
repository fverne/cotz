ITEM.name = "Exoskeleton"
ITEM.model = "models/kek1ch/exolight_outfit.mdl"
ITEM.newModel = "models/cotz/sectorfour/male_exoskeleton.mdl"
ITEM.description= "An armored exoskeleton suit"
ITEM.longdesc = "The exoskeleton combines body armour with a substantial supporting frame. Braces, joints and attachment points turn the wearer into a much broader silhouette than an ordinary suit does. Its carrying allowance reflects that framework, with head and respiratory equipment still supplied separately."

ITEM.width = 2
ITEM.height = 3
ITEM.img = ix.util.GetMaterial("vgui/hud/radsuit.png")
ITEM.weight = 32.00
ITEM.newSkin = 0
ITEM.baseSuit = "suit_exoskeleton"

ITEM.price = 9999999999
ITEM.repairCost = ITEM.price/100*1 -- cost to repair from 0% durability

ITEM.isGasmask = false
ITEM.isHelmet = false
ITEM.isExoskeleton = true

ITEM.br = 0.45
ITEM.fbr = 5
ITEM.sr = 0.81
ITEM.fsr = 5
ITEM.ar = 0.25
ITEM.far = 2
ITEM.thermalRes = 0.25
ITEM.flatThermalRes = 2
ITEM.electricalRes = 0.25
ITEM.flatElectricalRes = 2
ITEM.chemicalRes = 0.25
ITEM.flatChemicalRes = 2
ITEM.gravitationalRes = 0.25
ITEM.flatGravitationalRes = 2

ITEM.carryinc = 64.000
ITEM.exteriorSlots = 2
ITEM.interiorSlots = 3
ITEM.extraSlots = 2

ITEM.bodyGroups = {
	["Exoskeleton"] = 0,
}
ITEM.skincustom = ix.suitAppearance.SkinOptions(0, 36)
