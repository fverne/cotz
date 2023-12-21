ITEM.name = "SSP-99"
ITEM.model = "models/kek1ch/ecolog_outfit_orange.mdl"
ITEM.newModel = "models/nasca/stalker/male_ssp_eco.mdl"
ITEM.description= "An SSP-99 Suit."
ITEM.longdesc = "A SSP-99 Scientific Research suit specially designed for the Zone conditions. It is used by scientific expeditions and the eco-stalkers who cooperate with them. It has an integrated air-filtering and air-conditioning system. It is heat and electricity resistant, provides good protection from radiation and biological anomalies. It is resistant to chemically aggressive environments. It is not designed for combat, so it provides neither bullet, nor splinter protection."

ITEM.width = 2
ITEM.height = 3
ITEM.img = ix.util.GetMaterial("vgui/hud/seva.png")
ITEM.overlayPath = "vgui/overlays/hud_sci"
ITEM.weight = 7.90
ITEM.newSkin = 0

ITEM.price = 146000
ITEM.repairCost = ITEM.price/100*1 -- cost to repair from 0% durability

ITEM.isGasmask = true
ITEM.isHelmet = true

ITEM.br = 0.01
ITEM.fbr = 1
ITEM.sr = 0.01
ITEM.fsr = 0
ITEM.ar = 0.80
ITEM.far = 5
ITEM.pr = 0.50
ITEM.fpr = 0
ITEM.radProt = 1

ITEM.carryinc = 8
ITEM.miscslots = 4

ITEM.skincustom[1] = {
	name = "Skin 0",
	skingroup = 0,
}
ITEM.skincustom[2] = {
	name = "Skin 1",
	skingroup = 1,
}