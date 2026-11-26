ITEM.name = "Defender of Anarchists"
ITEM.model = "models/kek1ch/exolight_outfit.mdl"
ITEM.newModel = "models/cotz/sectorfour/male_exoskeleton.mdl"
ITEM.description= "An armored exoskeleton suit"
ITEM.longdesc = "The Defender of Anarchists fits its distinctive outer finish around an armoured exoskeleton frame. The supporting structure remains visible in the suit's broad joints and fitted sections. It is a complete body system, with separate arrangements still needed for the head and breathing equipment."

ITEM.width = 2
ITEM.height = 3
ITEM.img = ix.util.GetMaterial("vgui/hud/radsuit.png")
ITEM.weight = 32.50
ITEM.newSkin = 19
ITEM.baseSuit = "suit_exoskeleton"
ITEM.suitVariant = "anarchist"

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
ITEM.ar = 0.254
ITEM.far = 2
ITEM.thermalRes = 0.243
ITEM.flatThermalRes = 2
ITEM.electricalRes = 0.243
ITEM.flatElectricalRes = 2
ITEM.chemicalRes = 0.275
ITEM.flatChemicalRes = 2

ITEM.carryinc = 64.000
ITEM.exteriorSlots = 2
ITEM.interiorSlots = 3
ITEM.extraSlots = 3

ITEM.bodyGroups = {
	["Exoskeleton"] = 0,
}
ITEM.skincustom = ix.suitAppearance.SkinOptions(0, 36)
