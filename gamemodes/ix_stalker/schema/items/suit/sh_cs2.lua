ITEM.name = "Sky-2"
ITEM.model ="models/kek1ch/cs_heavy_outfit.mdl"
ITEM.replacements ="models/stalkerisaac/playermodel/male_01_cs2.mdl"
ITEM.description= "Sky-2 Suit"
ITEM.longdesc = "A pair of jeans, nomex jacket, with Russian class-3 vest and load bearing gear. Combined with a helmet, it is useful for low intensity conflicts within the zone. Worn by the kinds of people who'd walk far just to shoot somebody."
ITEM.width = 2
ITEM.height = 3
ITEM.price = 50000
ITEM.busflag = "dev"
ITEM.br = 0.28
ITEM.fbr = 8
ITEM.ar = 0.20
ITEM.far = 3
ITEM.repairCost = ITEM.price/100*1
ITEM.ballisticlevels = {"0","lll-a","lll-a","0","0"}
ITEM.ballisticrpglevels = {["body"] = "18", ["limb"] = "2"}
ITEM.anomalousrpglevels = {"5","15","15","15","15"}
ITEM.artifactcontainers = {"2"}
ITEM.img = Material("vgui/hud/cs2.png")
ITEM.weight = 10
ITEM.res = {
	["Bullet"] = 0.18,
	["Blast"] = 0.09,
	["Fall"] = 0.05,
	["Burn"] = 0.15,
	["Radiation"] = 0.15,
	["Chemical"] = 0.15,
	["Shock"] = 0.15,
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
