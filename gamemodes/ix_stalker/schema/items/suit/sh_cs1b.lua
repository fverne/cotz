ITEM.name ="Sky-1b"
ITEM.model ="models/kek1ch/cs_light_outfit.mdl"
ITEM.replacements ="models/stalkerisaac/playermodel/male_01_cs3.mdl"
ITEM.description="A Sky-1b Suit"
ITEM.longdesc = "A pair of jeans, a rain jacket and a kevlar vest with lots of pouches. Another type of stalker 'uniform', made from off-the-shelf products. This one seems to have a reinforced jacket from a chemsuit."
ITEM.width = 2
ITEM.height = 3
ITEM.price = 22000
ITEM.busflag = "dev"
ITEM.br = 0.15
ITEM.fbr = 1
ITEM.ar = 0.18
ITEM.far = 1
ITEM.repairCost = ITEM.price/100*1
ITEM.ballisticlevels = {"0","ll-a","ll-a","0","0"}
ITEM.ballisticrpglevels = {["body"] = "8", ["limb"] = "2"}
ITEM.anomalousrpglevels = {"2","12","12","12","12"}
ITEM.artifactcontainers = {"2"}
ITEM.img = Material("vgui/hud/cs1.png")
ITEM.res = {
	["Bullet"] = 0.08,
	["Blast"] = 0.04,
	["Fall"] = 0.02,
	["Burn"] = 0.12,
	["Radiation"] = 0.12,
	["Chemical"] = 0.12,
	["Shock"] = 0.12,
	["Psi"] = 0,
}

ITEM.newSkin = 1
ITEM.bodygroup = {0}
ITEM.bodygroupsub = {0}


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