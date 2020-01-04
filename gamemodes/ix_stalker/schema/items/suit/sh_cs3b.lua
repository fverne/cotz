ITEM.name = "Sky-3b"
ITEM.model ="models/kek1ch/cs_heavy_outfit.mdl"
ITEM.replacements ="models/stalkerisaac/playermodel/male_01_cs4.mdl"
ITEM.description= "A Sky-3b suit."
ITEM.longdesc = "A home-made entry suit with CBRN liner, large assault vest protects torso and groin, while bodysuit protects from various hazards. Thick steel boots, theoretically, can protect from a landmine."
ITEM.width = 2
ITEM.height = 3
ITEM.price = 70000
ITEM.busflag = "dev"
ITEM.br = 0.5
ITEM.fbr = 5
ITEM.ar = 0.4
ITEM.far = 4
ITEM.repairCost = ITEM.price/100*1
ITEM.ballisticlevels = {"0","lV","lV","lll-a","lll-a"}
ITEM.ballisticrpglevels = {["body"] = "34", ["limb"] = "12"}
ITEM.anomalousrpglevels = {"0","20","20","20","20"}
ITEM.artifactcontainers = {"2"}
ITEM.maxAgi = 30
ITEM.Special = {"Heavy"}
ITEM.img = Material("vgui/hud/cs2.png")
ITEM.noBusiness = true
ITEM.res = {
	["Bullet"] = 0.34,
	["Blast"] = 0.17,
	["Fall"] = 0.0,
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