ITEM.name = "SSP-99M"
ITEM.model = "models/kek1ch/ecolog_outfit_green.mdl"
ITEM.newModel = "models/nasca/stalker/male_ssp_eco.mdl"
ITEM.description= "An SSP-99M Suit."
ITEM.longdesc = "High quality modified SSP-99 Scientific Research Suit. It provides increased body protection from bullet and splinter damage. It is designed for the guards working with scientific expeditions. It provides good protection from radiation and biological anomalies. It is resistant to chemically aggressive environments and other effects dangerous to the body."

ITEM.width = 2
ITEM.height = 3
ITEM.img = ix.util.GetMaterial("vgui/hud/seva.png")
ITEM.overlayPath = "vgui/overlays/hud_sci"
ITEM.weight = 9.90
ITEM.newSkin = 1

ITEM.price = 225500
ITEM.repairCost = ITEM.price/100*1 -- cost to repair from 0% durability

ITEM.isGasmask = true
ITEM.isHelmet = true

ITEM.br = 0.10
ITEM.fbr = 0
ITEM.sr = 0.13
ITEM.fsr = 0
ITEM.ar = 0.80
ITEM.far = 5
ITEM.pr = 0.50
ITEM.fpr = 0
ITEM.radProt = 1

ITEM.carryinc = 9
ITEM.miscslots = 4

ITEM.skincustom[1] = {
	name = "Skin 0",
	skingroup = 0,
}
ITEM.skincustom[2] = {
	name = "Skin 1",
	skingroup = 1,
}