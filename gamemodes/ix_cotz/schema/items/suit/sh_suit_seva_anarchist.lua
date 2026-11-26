ITEM.name = "Savior of Anarchists"
ITEM.model = "models/kek1ch/scientific_outfit.mdl"
ITEM.newModel = "models/cotz/sectorfour/male_seva.mdl"
ITEM.newSkin = 45
ITEM.description= "A SEVA Suit."
ITEM.longdesc = "This suit was produced by one of Kiev's Defence Research institutes and represents a phenomenal alternative to stalker hand-made suits. It is an excellent combination of a bulletproof vest, a closed cycle breathing system and an integrated system of anomalous field suppression. Due to the perfect choice of materials, the suit is highly efficient and is often regarded as an excellent choice for veterans."

ITEM.width = 2
ITEM.height = 3
ITEM.img = ix.util.GetMaterial("vgui/hud/seva.png")
ITEM.overlayPath = "vgui/overlays/hud_sci"
ITEM.weight = 10.504
ITEM.baseSuit = "suit_seva"
ITEM.suitVariant = "anarchist"

ITEM.price = 1650000
ITEM.repairCost = ITEM.price/100*1 -- cost to repair from 0% durability
ITEM.fullRepairCost = 16240

ITEM.isGasmask = true
ITEM.filterType = "air_tank"
ITEM.isAirTank = true
ITEM.filterWearDivisor = 700
ITEM.isHelmet = true
ITEM.isBackpack = true

ITEM.br = 0.213
ITEM.fbr = 1
ITEM.sr = 0.291
ITEM.fsr = 2
ITEM.impactRes = 0.228
ITEM.flatImpactRes = 2
ITEM.ar = 0.558
ITEM.far = 2
ITEM.thermalRes = 0.534
ITEM.flatThermalRes = 2
ITEM.electricalRes = 0.534
ITEM.flatElectricalRes = 2
ITEM.chemicalRes = 0.605
ITEM.flatChemicalRes = 2

ITEM.pr = 0.437
ITEM.fpr = 0

ITEM.radProt = 0.98
ITEM.flatRadProt = 0.02

ITEM.carryinc = 22.42
ITEM.exteriorSlots = 2
ITEM.interiorSlots = 2
ITEM.extraSlots = 3

ITEM.bodyGroups = {
	["Head"] = 0,
}
ITEM.skincustom = ix.suitAppearance.SkinOptions(0, 64)
