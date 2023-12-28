ITEM.name = "Liberated Skat-10 Armored Suit"
ITEM.model = "models/kek1ch/military_outfit.mdl"
ITEM.newModel = "models/stalkerisaac/playermodel/male_01_skat.mdl"
ITEM.description= "A dated military-grade body armor"
ITEM.longdesc = "This dated military armoured suit is designed for assault operations in anomalous areas. Has a built-in compensation suit, and an anomalous protection bodysuit. The armour provides excellent protection against bullet and fragmentation damage, without greatly reducing the wearer’s mobility."

ITEM.width = 2
ITEM.height = 3
ITEM.img = ix.util.GetMaterial("vgui/hud/skat.png")
ITEM.weight = 16.80
ITEM.newSkin = 10

ITEM.price = 306200
ITEM.repairCost = ITEM.price/100*1 -- cost to repair from 0% durability

ITEM.isGasmask = false
ITEM.isHelmet = false

ITEM.br = 0.28
ITEM.fbr = 3
ITEM.sr = 0.45
ITEM.fsr = 3
ITEM.ar = 0.11
ITEM.far = 3

ITEM.carryinc = 20.000
ITEM.miscslots = 2


ITEM.skincustom[1] = {
	name = "Skin 0",
	skingroup = 0,
}
ITEM.skincustom[2] = {
	name = "Skin 1",
	skingroup = 1,
}
