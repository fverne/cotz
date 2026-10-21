ITEM.name = "X-8 Scientific Suit"
ITEM.model = "models/kek1ch/scientific_outfit.mdl"
ITEM.newModel = "models/nasca/stalker/male_seva_mono.mdl"
ITEM.description= "A SEVA Suit."
ITEM.longdesc = "This suit was produced by one of Kiev's Defence Research institutes and represents a phenomenal alternative to stalker hand-made suits. It is an excellent combination of a bulletproof vest, a closed cycle breathing system and an integrated system of anomalous field suppression. Due to the perfect choice of materials, the suit is highly efficient and is often regarded as an excellent choice for veterans."

ITEM.width = 2
ITEM.height = 3
ITEM.img = ix.util.GetMaterial("vgui/hud/seva.png")
ITEM.overlayPath = "vgui/overlays/hud_sci"
ITEM.weight = 10.40
ITEM.baseSuit = "suit_seva"
-- ITEM.suitVariant = "fanatic"

ITEM.price = 588500
ITEM.repairCost = ITEM.price/100*1 -- cost to repair from 0% durability

ITEM.isGasmask = true
ITEM.isHelmet = true
ITEM.isBackpack = true

ITEM.br = 0.24
ITEM.fbr = 1
ITEM.sr = 0.36
ITEM.fsr = 2
ITEM.ar = 0.58
ITEM.far = 2

ITEM.pr = 0.52
ITEM.fpr = 0

ITEM.radProt = 0.98
ITEM.flatRadProt = 0.02

ITEM.carryinc = 22.65
ITEM.exteriorSlots = 2
ITEM.interiorSlots = 2
ITEM.extraSlots = 2

ITEM.skincustom[1] = {
	name = "Skin 0",
	skingroup = 0,
}
ITEM.skincustom[2] = {
	name = "Skin 1",
	skingroup = 1,
}
ITEM.skincustom[3] = {
	name = "Skin 2",
	skingroup = 2,
}