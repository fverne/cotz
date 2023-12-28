ITEM.name = "STS-N Body Armor"
ITEM.model = "models/kek1ch/military_outfit.mdl"
ITEM.newModel = "models/stalkerisaac/playermodel/male_01_skat.mdl"
ITEM.description= "A dated military-grade body armor"
ITEM.longdesc = "This dated military armoured suit is designed for assault operations in anomalous areas. Has a built-in compensation suit, and an anomalous protection bodysuit. The armour provides excellent protection against bullet and fragmentation damage, without greatly reducing the wearer’s mobility."

ITEM.width = 2
ITEM.height = 3
ITEM.img = ix.util.GetMaterial("vgui/hud/skat.png")
ITEM.weight = 16.90
ITEM.newSkin = 11

ITEM.price = 306200
ITEM.repairCost = ITEM.price/100*1 -- cost to repair from 0% durability

ITEM.isGasmask = false
ITEM.isHelmet = false

ITEM.br = 0.30
ITEM.fbr = 4
ITEM.sr = 0.45
ITEM.fsr = 3
ITEM.ar = 0.09
ITEM.far = 2

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
