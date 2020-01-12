ITEM.name = "Sky-3a"
ITEM.model ="models/kek1ch/cs_heavy_outfit.mdl"
ITEM.replacements ="models/stalkerisaac/playermodel/male_01_cs4.mdl"
ITEM.description= "A Sky-3a suit."
ITEM.longdesc = "A pair of reinforced tactical pants, comfortable nomex jacket and a plate carrier with pouches, it's a bare minimum of equipment for a seasoned merc, faction soldier or professional bandit."
ITEM.width = 2
ITEM.height = 3
ITEM.price = 58000
ITEM.busflag = "dev"
ITEM.br = 0.38
ITEM.fbr = 9
ITEM.ar = 0.4
ITEM.far = 4
ITEM.repairCost = ITEM.price/100*1
ITEM.ballisticlevels = {"0","lll","lll","l","l"}
ITEM.ballisticrpglevels = {["body"] = "28", ["limb"] = "5"}
ITEM.anomalousrpglevels = {"10","20","20","20","20"}
ITEM.artifactcontainers = {"1"}
ITEM.maxAgi = 40
ITEM.Special = {"Heavy"}
ITEM.img = Material("vgui/hud/cs2.png")
ITEM.noBusiness = true
ITEM.weight = 14
ITEM.res = {
	["Bullet"] = 0.28,
	["Blast"] = 0.14,
	["Fall"] = 0.1,
	["Burn"] = 0.2,
	["Radiation"] = 0.2,
	["Chemical"] = 0.2,
	["Shock"] = 0.2,
	["Psi"] = 0,
}


ITEM.newSkin = 0
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