ITEM.name = "Kopach"
ITEM.model ="models/kek1ch/stalker_outfit.mdl"
ITEM.newModel ="models/nasca/stalker/male_nbc_lone.mdl"
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
ITEM.img = ix.util.GetMaterial("vgui/hud/nbc.png")

ITEM.weight = 9.800
ITEM.miscslots = 2

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