ITEM.name = "Zenith STALKER Suit"
ITEM.model = "models/kek1ch/stalker_outfit.mdl"
ITEM.newModel = "models/stalkerisaac/playermodel/male_01_sunrise.mdl"
ITEM.description= "A STALKER suit."
ITEM.longdesc = "This DIY stalker bodysuit is a combination of twin-layered rubberised cloth with Plexiglas lining and built-in body armour. The vest stops slower, weaker pistol calibers. The suit enjoys great popularity due to its low cost and modification potential."

ITEM.width = 2
ITEM.height = 3
ITEM.img = ix.util.GetMaterial("vgui/hud/sunrise.png")
ITEM.weight = 6.262
ITEM.newSkin = 15
ITEM.baseSuit = "suit_sunrise"
ITEM.suitVariant = "anarchist"

ITEM.price = 52019
ITEM.repairCost = ITEM.price/100*1 -- cost to repair from 0% durability

ITEM.isGasmask = false
ITEM.isHelmet = false

ITEM.br = 0.10
ITEM.fbr = 1
ITEM.sr = 0.19
ITEM.fsr = 1
ITEM.ar = 0.12
ITEM.far = 1

ITEM.carryinc = 4.860
ITEM.exteriorSlots = 2
ITEM.interiorSlots = 1
ITEM.extraSlots = 0

ITEM.skincustom[16] = {
	name = "Skin 15",
	skingroup = 15,
}
ITEM.skincustom[25] = {
	name = "Skin 24",
	skingroup = 24,
}
