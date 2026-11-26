ITEM.name = "IO7a Suit"
ITEM.model = "models/kek1ch/merc_outfit.mdl"
ITEM.newModel = "models/cotz/sectorfour/male_hawk.mdl"
ITEM.description= "A uniform with a ballistics vest"
ITEM.longdesc = "One of the more common uniforms seen around the zone. The IO7a is a popular use by many factions, thanks to it's great ability to deflect and or stop most calibers on it's armour. The IO7a itself is a uniform adapted from outside the zone, a tactical force uniform, sadly the tactical force itself is unknown, due to the secretive, and covered up operations. The suit is popular with mercenaries, who very often engage in firefights to maintain their quality. It's also a popular choice with bandits, as the cheap price allows the common bandit to supply their rather cheap setup. The suit is the best low-class for good ballistic protection."

ITEM.width = 2
ITEM.height = 3
ITEM.img = ix.util.GetMaterial("vgui/hud/io7a.png")
ITEM.weight = 9.000
ITEM.newSkin = 0
ITEM.baseSuit = "suit_io7a"

ITEM.price = 48700
ITEM.repairCost = ITEM.price/100*1 -- cost to repair from 0% durability
ITEM.fullRepairCost = 7300

ITEM.isGasmask = false
ITEM.isHelmet = false

ITEM.br = 0.117
ITEM.fbr = 2
ITEM.sr = 0.171
ITEM.fsr = 1
ITEM.impactRes = 0.144
ITEM.flatImpactRes = 1
ITEM.ar = 0.054
ITEM.far = 1
ITEM.thermalRes = 0.054
ITEM.flatThermalRes = 1
ITEM.electricalRes = 0.054
ITEM.flatElectricalRes = 1
ITEM.chemicalRes = 0.054
ITEM.flatChemicalRes = 1

ITEM.carryinc = 7.200
ITEM.exteriorSlots = 1
ITEM.interiorSlots = 1
ITEM.extraSlots = 0

ITEM.skincustom = ix.suitAppearance.SkinOptions(0, 39)
