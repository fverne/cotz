ITEM.name = "SSP-99"
ITEM.model = "models/kek1ch/ecolog_outfit_orange.mdl"
ITEM.newModel = "models/cotz/sectorfour/male_ssp99.mdl"
ITEM.description= "An SSP-99 Suit."
ITEM.longdesc = "A SSP-99 Scientific Research suit specially designed for the Zone conditions. It is used by scientific expeditions and the eco-stalkers who cooperate with them. It has an integrated air-filtering and air-conditioning system. It is heat and electricity resistant, provides good protection from radiation and biological anomalies. It is resistant to chemically aggressive environments. It is not designed for combat, so it provides neither bullet, nor splinter protection."

ITEM.width = 2
ITEM.height = 3
ITEM.img = ix.util.GetMaterial("vgui/hud/ssp99.png")
ITEM.overlayPath = "vgui/overlays/hud_sci"
ITEM.weight = 2.900
ITEM.baseSuit = "suit_ssp99"
ITEM.newSkin = 1

ITEM.price = 143000
ITEM.repairCost = ITEM.price/100*1 -- cost to repair from 0% durability
ITEM.fullRepairCost = 9160

ITEM.isGasmask = true
ITEM.filterType = "air_tank"
ITEM.isAirTank = true
ITEM.filterWearDivisor = 700
ITEM.isHelmet = true
ITEM.isBackpack = true

ITEM.br = 0.01
ITEM.fbr = 1
ITEM.sr = 0.01
ITEM.fsr = 0
ITEM.impactRes = 0.01
ITEM.flatImpactRes = 5
ITEM.ar = 0.70
ITEM.far = 5
ITEM.thermalRes = 0.70
ITEM.flatThermalRes = 5
ITEM.electricalRes = 0.70
ITEM.flatElectricalRes = 5
ITEM.chemicalRes = 0.70
ITEM.flatChemicalRes = 5

ITEM.pr = 0.50
ITEM.fpr = 0

ITEM.radProt = 0.99
ITEM.flatRadProt = 0.02

ITEM.carryinc = 2.61
ITEM.exteriorSlots = 1
ITEM.interiorSlots = 1
ITEM.extraSlots = 1

ITEM.bodyGroups = {
	["Head"] = 1,
	["Neck"] = 1,
}
ITEM.skincustom = ix.suitAppearance.SkinOptions(0, 14)
