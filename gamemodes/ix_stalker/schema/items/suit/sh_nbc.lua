ITEM.name = "Kopach"
ITEM.model ="models/kek1ch/stalker_outfit.mdl"
ITEM.replacements ="models/nasca/stalker/male_nbc_lone.mdl"
ITEM.description= "Kopach suit."
ITEM.longdesc = "This suit is a modified version of the standard Sunrise outfit, composed of a camouflaged CBRN suit with a Class III-a Kevlar vest. Favored by diggers and underground explorers."
ITEM.width = 2
ITEM.height = 3
ITEM.price = 30000
ITEM.busflag = "dev"
ITEM.br = 0.15
ITEM.fbr = 6
ITEM.ar = 0.4
ITEM.far = 3
ITEM.isHelmet = false
ITEM.isGasmask = true
ITEM.radProt = 0.5
ITEM.repairCost = ITEM.price/100*1
ITEM.overlayPath = "vgui/overlays/hud_gas"
ITEM.ballisticlevels = {"0","ll-a","ll-a","0","0"}
ITEM.ballisticrpglevels = {["body"] = "8", ["limb"] = "2"}
ITEM.anomalousrpglevels = {"2","25","25","25","25"}
ITEM.artifactcontainers = {"2"}
ITEM.maxAgi = 50
ITEM.img = Material("vgui/hud/nbc.png")
ITEM.res = {
	["Bullet"] = 0.08,
	["Blast"] = 0.04,
	["Fall"] = 0.02,
	["Burn"] = 0.25,
	["Radiation"] = 0.25,
	["Chemical"] = 0.25,
	["Shock"] = 0.25,
	["Psi"] = 0,
}


ITEM.newSkin = 0
ITEM.bodyGroups = {
	["Hood"] = 1,
}

ITEM.skincustom[1] = {
	name = "Loner",
	skingroup = 0,
	modelOverride = "models/nasca/stalker/male_nbc_lone.mdl",
}
ITEM.skincustom[2] = {
	name = "Loner 2",
	skingroup = 1,
	modelOverride = "models/nasca/stalker/male_nbc_lone.mdl",
}
ITEM.skincustom[3] = {
	name = "Duty",
	skingroup = 0,
	modelOverride = "models/nasca/stalker/male_nbc_duty.mdl",
}
ITEM.skincustom[4] = {
	name = "Freedom",
	skingroup = 0,
	modelOverride = "models/nasca/stalker/male_nbc_free.mdl",
}
ITEM.skincustom[5] = {
	name = "Ecologist",
	skingroup = 0,
	modelOverride = "models/nasca/stalker/male_nbc_mono.mdl",
}
ITEM.skincustom[6] = {
	name = "Monolith",
	skingroup = 0,
	modelOverride = "models/nasca/stalker/male_nbc_mono.mdl",
}