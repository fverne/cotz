ITEM.name = "Mercenary NBC Suit"
ITEM.model ="models/kek1ch/stalker_outfit.mdl"
ITEM.newModel = "models/cotz/sectorfour/male_nbc_lone.mdl"
ITEM.newSkin = 46
ITEM.description= "An NBC Suit."
ITEM.longdesc = "This suit is a modified version of the standard Sunrise outfit, composed of a camouflaged CBRN suit with a Class II-a Kevlar vest. Favored by diggers and underground explorers."

ITEM.width = 2
ITEM.height = 3
ITEM.img = ix.util.GetMaterial("vgui/hud/nbc.png")
ITEM.overlayPath = "vgui/overlays/hud_gas"
ITEM.weight = 8.058
ITEM.baseSuit = "suit_nbc"
ITEM.suitVariant = "mercenary"

ITEM.price = 181500
ITEM.repairCost = ITEM.price/100*1 -- cost to repair from 0% durability
ITEM.fullRepairCost = 10970

ITEM.isGasmask = true
ITEM.filterType = "air_tank"
ITEM.isAirTank = true
ITEM.filterWearDivisor = 700
ITEM.isHelmet = true

ITEM.br = 0.104
ITEM.fbr = 1
ITEM.sr = 0.165
ITEM.fsr = 1
ITEM.impactRes = 0.15
ITEM.flatImpactRes = 2
ITEM.ar = 0.203
ITEM.far = 2
ITEM.thermalRes = 0.22
ITEM.flatThermalRes = 2
ITEM.electricalRes = 0.194
ITEM.flatElectricalRes = 2
ITEM.chemicalRes = 0.194
ITEM.flatChemicalRes = 2

ITEM.pr = 0.097
ITEM.fpr = 0
ITEM.radProt = 0.90
ITEM.flatRadProt = 0.02

ITEM.carryinc = 6.38
ITEM.exteriorSlots = 2
ITEM.interiorSlots = 1
ITEM.extraSlots = 0

ITEM.bodyGroups = {
	["Head"] = 1,
	["Hood"] = 0,
	["Gasmask"] = 1,
}
ITEM.skincustom = ix.suitAppearance.SkinOptions(0, 50)
