ITEM.name = "ISRIT Universal Scientific Suit"
ITEM.model = "models/kek1ch/scientific_outfit.mdl"
ITEM.newModel = "models/nasca/stalker/male_seva_eco.mdl"
ITEM.description= "A SEVA Suit."
ITEM.longdesc = "This suit was produced by one of Kiev's Defence Research institutes and represents a phenomenal alternative to stalker hand-made suits. It is an excellent combination of a bulletproof vest, a closed cycle breathing system and an integrated system of anomalous field suppression. Due to the perfect choice of materials, the suit is highly efficient and is often regarded as an excellent choice for veterans."

ITEM.width = 2
ITEM.height = 3
ITEM.img = ix.util.GetMaterial("vgui/hud/seva.png")
ITEM.overlayPath = "vgui/overlays/hud_sci"
ITEM.weight = 10.50
ITEM.baseSuit = "suit_seva"
ITEM.suitVariant = "ecologist"

ITEM.price = 239000
ITEM.repairCost = ITEM.price/100*1 -- cost to repair from 0% durability

ITEM.isGasmask = true
ITEM.isHelmet = true
ITEM.isBackpack = true

ITEM.br = 0.22
ITEM.fbr = 1
ITEM.sr = 0.32
ITEM.fsr = 2
ITEM.ar = 0.45
ITEM.far = 2
ITEM.pr = 0.45
ITEM.fpr = 0
ITEM.percentageRadProt = 0.97
ITEM.flatRadProt = 0.02

ITEM.carryinc = 29.000
ITEM.miscslots = 5

ITEM.skincustom[1] = {
	name = "Skin 0",
	skingroup = 0,
}
