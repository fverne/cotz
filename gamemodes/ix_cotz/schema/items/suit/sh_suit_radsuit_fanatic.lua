ITEM.name = "X-7 Radsuit"
ITEM.model = "models/kek1ch/exolight_outfit.mdl"
ITEM.newModel = "models/cotz/sectorfour/male_exoskeleton.mdl"
ITEM.description= "A radsuit"
ITEM.longdesc = "A competently made western entry-man suit worn for high risk assaults. Bodysuit reinforced with plates can stop some assault rifle bullets, while heavy assault vest stops most ballistic threats on the battlefield. It's heavy weight makes it most useful in close quarters and a liability in open spaces."

ITEM.width = 2
ITEM.height = 3
ITEM.img = ix.util.GetMaterial("vgui/hud/radsuit.png")
ITEM.weight = 22.500
ITEM.newSkin = 30
ITEM.baseSuit = "suit_radsuit"
ITEM.suitVariant = "fanatic"

ITEM.price = 3301012
ITEM.repairCost = ITEM.price/100*1 -- cost to repair from 0% durability

ITEM.isGasmask = false
ITEM.isHelmet = false

ITEM.br = 0.42
ITEM.fbr = 4
ITEM.sr = 0.60
ITEM.fsr = 4
ITEM.ar = 0.32
ITEM.far = 2
ITEM.thermalRes = 0.32
ITEM.flatThermalRes = 2
ITEM.electricalRes = 0.32
ITEM.flatElectricalRes = 2
ITEM.chemicalRes = 0.32
ITEM.flatChemicalRes = 2
ITEM.gravitationalRes = 0.32
ITEM.flatGravitationalRes = 2

ITEM.carryinc = 17.82
ITEM.exteriorSlots = 2
ITEM.interiorSlots = 3
ITEM.extraSlots = 2

ITEM.bodyGroups = {
	["Exoskeleton"] = 1,
}
ITEM.skincustom = ix.suitAppearance.SkinOptions(0, 36)
