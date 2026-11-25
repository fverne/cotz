ITEM.name = "Skat-9 Armored Suit"
ITEM.model = "models/kek1ch/military_outfit.mdl"
ITEM.newModel = "models/cotz/sectorfour/male_stingray9.mdl"
ITEM.description= "A military-grade body armor"
ITEM.longdesc = "This military armoured suit is designed for assault operations in anomalous areas. Has a built-in compensation suit, and an anomalous protection bodysuit. The armour provides excellent protection against bullet and fragmentation damage, without greatly reducing the wearer’s mobility."

ITEM.width = 2
ITEM.height = 3
ITEM.img = ix.util.GetMaterial("vgui/hud/skat.png")
ITEM.weight = 21.00
ITEM.newSkin = 1
ITEM.baseSuit = "suit_skat9"

ITEM.price = 1090000
ITEM.repairCost = ITEM.price/100*1 -- cost to repair from 0% durability

ITEM.isGasmask = false
ITEM.isHelmet = false

ITEM.br = 0.35
ITEM.fbr = 4
ITEM.sr = 0.51
ITEM.fsr = 3
ITEM.ar = 0.22
ITEM.far = 2
ITEM.thermalRes = 0.22
ITEM.flatThermalRes = 2
ITEM.electricalRes = 0.22
ITEM.flatElectricalRes = 2
ITEM.chemicalRes = 0.22
ITEM.flatChemicalRes = 2
ITEM.gravitationalRes = 0.22
ITEM.flatGravitationalRes = 2

ITEM.carryinc = 16.80
ITEM.exteriorSlots = 2
ITEM.interiorSlots = 3
ITEM.extraSlots = 1

ITEM.skincustom = ix.suitAppearance.SkinOptions(ix.suitAppearance.SKAT9_SKINS)
