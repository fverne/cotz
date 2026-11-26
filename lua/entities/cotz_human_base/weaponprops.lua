-- Right-hand placement for each loadout weapon, as a position and angle in the hand's (RHand) frame.
-- Each loadout weapon is shown as its closest Anomaly world model. Those models share one layout (barrel along +X,
-- top up, origin under the grip), so every gun uses the grip fitted to the HK416 (two-handed) or the PM (pistols),
-- which puts the grip in the closed hand with the receiver or slide just above the index finger.
-- pos is where the weapon model's origin goes and ang turns the model about that origin, so adjusting ang alone
-- turns a weapon in place.
-- model: the world model held by the NPC. hold: "pistol" for one-handed sidearms, "rifle" for two-handed firearms.
local RIFLE_HAND = {pos = {4.71, -1.32, 4.32}, ang = {11.6, 3.6, -176.1}}
local PISTOL_HAND = {pos = {4.57, -1.09, 0.52}, ang = {14.5, 3.7, -175.5}}

ENT.WeaponProps = {
	ak74 = {
		model = "models/flaymi/anomaly/weapons/w_models/wpn_ak74.mdl",
		hold = "rifle",
		hand = RIFLE_HAND,
	},
	aks74u = {
		model = "models/flaymi/anomaly/weapons/w_models/wpn_ak74u.mdl",
		hold = "rifle",
		hand = RIFLE_HAND,
	},
	beretta92 = {
		model = "models/flaymi/anomaly/weapons/w_models/wpn_beretta92fs.mdl",
		hold = "pistol",
		hand = PISTOL_HAND,
	},
	brhp = {
		model = "models/flaymi/anomaly/weapons/w_models/wpn_hpsa_w.mdl",
		hold = "pistol",
		hand = PISTOL_HAND,
	},
	fort12 = {
		model = "models/flaymi/anomaly/weapons/w_models/wpn_fort_w.mdl",
		hold = "pistol",
		hand = PISTOL_HAND,
	},
	ij600 = {
		model = "models/flaymi/anomaly/weapons/w_models/wpn_toz34_w.mdl",
		hold = "rifle",
		hand = RIFLE_HAND,
	},
	lax410s = {
		model = "models/flaymi/anomaly/weapons/w_models/wpn_winchester1300_w.mdl",
		hold = "rifle",
		hand = RIFLE_HAND,
	},
	lr300 = {
		model = "models/flaymi/anomaly/weapons/w_models/wpn_lr300_w.mdl",
		hold = "rifle",
		hand = RIFLE_HAND,
	},
	m1917 = {
		model = "models/flaymi/anomaly/weapons/w_models/wpn_mp412_w.mdl",
		hold = "pistol",
		hand = PISTOL_HAND,
	},
	m3supershort = {
		model = "models/flaymi/anomaly/weapons/w_models/wpn_spas12_w.mdl",
		hold = "rifle",
		hand = RIFLE_HAND,
	},
	makarov = {
		model = "models/flaymi/anomaly/weapons/w_models/wpn_pm_w.mdl",
		hold = "pistol",
		hand = PISTOL_HAND,
	},
	mp153 = {
		model = "models/flaymi/anomaly/weapons/w_models/wpn_mp153_w.mdl",
		hold = "rifle",
		hand = RIFLE_HAND,
	},
	mp18 = {
		model = "models/flaymi/anomaly/weapons/w_models/wpn_toz34_w.mdl",
		hold = "rifle",
		hand = RIFLE_HAND,
	},
	mp27 = {
		model = "models/flaymi/anomaly/weapons/w_models/wpn_toz34_w.mdl",
		hold = "rifle",
		hand = RIFLE_HAND,
	},
	mp5k = {
		model = "models/flaymi/anomaly/weapons/w_models/wpn_mp5_w.mdl",
		hold = "rifle",
		hand = RIFLE_HAND,
	},
	nagantrev = {
		model = "models/flaymi/anomaly/weapons/w_models/wpn_mp412_w.mdl",
		hold = "pistol",
		hand = PISTOL_HAND,
	},
	obrez = {
		model = "models/flaymi/anomaly/weapons/w_models/wpn_mosin_w.mdl",
		hold = "rifle",
		hand = RIFLE_HAND,
	},
	ppsh = {
		model = "models/flaymi/anomaly/weapons/w_models/wpn_ppsh41_w.mdl",
		hold = "rifle",
		hand = RIFLE_HAND,
	},
	ruger1022 = {
		model = "models/flaymi/anomaly/weapons/w_models/wpn_sks_w.mdl",
		hold = "rifle",
		hand = RIFLE_HAND,
	},
	rugermk3 = {
		model = "models/flaymi/anomaly/weapons/w_models/wpn_walter99_w.mdl",
		hold = "pistol",
		hand = PISTOL_HAND,
	},
	saiga410 = {
		model = "models/flaymi/anomaly/weapons/w_models/wpn_saiga12s_w.mdl",
		hold = "rifle",
		hand = RIFLE_HAND,
	},
	saigasemi545 = {
		model = "models/flaymi/anomaly/weapons/w_models/wpn_vepr_w.mdl",
		hold = "rifle",
		hand = RIFLE_HAND,
	},
	sako85 = {
		model = "models/flaymi/anomaly/weapons/w_models/wpn_trg_w.mdl",
		hold = "rifle",
		hand = RIFLE_HAND,
	},
	sako85nato = {
		model = "models/flaymi/anomaly/weapons/w_models/wpn_trg_w.mdl",
		hold = "rifle",
		hand = RIFLE_HAND,
	},
	skorpion = {
		model = "models/flaymi/anomaly/weapons/w_models/wpn_vz61_w.mdl",
		hold = "rifle",
		hand = RIFLE_HAND,
	},
	sv98 = {
		model = "models/flaymi/anomaly/weapons/w_models/wpn_sv98_w.mdl",
		hold = "rifle",
		hand = RIFLE_HAND,
	},
	swr8 = {
		model = "models/flaymi/anomaly/weapons/w_models/wpn_mp412_w.mdl",
		hold = "pistol",
		hand = PISTOL_HAND,
	},
	tokarev = {
		model = "models/flaymi/anomaly/weapons/w_models/wpn_tt33_w.mdl",
		hold = "pistol",
		hand = PISTOL_HAND,
	},
	toz106 = {
		model = "models/flaymi/anomaly/weapons/w_models/wpn_bm16_w.mdl",
		hold = "rifle",
		hand = RIFLE_HAND,
	},
	toz194 = {
		model = "models/flaymi/anomaly/weapons/w_models/wpn_winchester1300_w.mdl",
		hold = "rifle",
		hand = RIFLE_HAND,
	},
	toz34short = {
		model = "models/flaymi/anomaly/weapons/w_models/wpn_toz34_obrez_w.mdl",
		hold = "rifle",
		hand = RIFLE_HAND,
	},
	toz66short = {
		model = "models/flaymi/anomaly/weapons/w_models/wpn_bm16_w.mdl",
		hold = "rifle",
		hand = RIFLE_HAND,
	},
	uzi = {
		model = "models/flaymi/anomaly/weapons/w_models/wpn_mp7_w.mdl",
		hold = "rifle",
		hand = RIFLE_HAND,
	},
}
