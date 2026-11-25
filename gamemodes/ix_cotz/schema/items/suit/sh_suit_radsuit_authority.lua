ITEM.name = "PSZ-7p"
ITEM.model = "models/kek1ch/exolight_outfit.mdl"
ITEM.newModel = "models/cotz/sectorfour/male_exoskeleton.mdl"
ITEM.description= "A radsuit"
ITEM.longdesc = "A competently made western entry-man suit worn for high risk assaults. Bodysuit reinforced with plates can stop some assault rifle bullets, while heavy assault vest stops most ballistic threats on the battlefield. It's heavy weight makes it most useful in close quarters and a liability in open spaces."

ITEM.width = 2
ITEM.height = 3
ITEM.img = ix.util.GetMaterial("vgui/hud/radsuit.png")
ITEM.weight = 22.950
ITEM.newSkin = 14
ITEM.baseSuit = "suit_radsuit"
ITEM.suitVariant = "authority"

ITEM.price = 3301012
ITEM.repairCost = ITEM.price/100*1 -- cost to repair from 0% durability

ITEM.isGasmask = false
ITEM.isHelmet = false

ITEM.br = 0.39
ITEM.fbr = 4
ITEM.sr = 0.67
ITEM.fsr = 5
ITEM.ar = 0.29
ITEM.far = 2
ITEM.thermalRes = 0.29
ITEM.flatThermalRes = 2
ITEM.electricalRes = 0.29
ITEM.flatElectricalRes = 2
ITEM.chemicalRes = 0.29
ITEM.flatChemicalRes = 2
ITEM.gravitationalRes = 0.29
ITEM.flatGravitationalRes = 2

ITEM.carryinc = 18.36
ITEM.exteriorSlots = 2
ITEM.interiorSlots = 3
ITEM.extraSlots = 2

ITEM.bodyGroups = {
	["Exoskeleton"] = 1,
}
ITEM.skincustom = ix.suitAppearance.SkinOptions(0, 36)
