-- Right-hand placement for each loadout weapon, as a position and angle in the hand's (RHand) frame, with the
-- barrel along the aim, the top up and the grip in the palm. Generated from the weapon models by
-- cotz_content_work/packs/bandit_anomaly_anims/tools/weapon_placement.
-- pos is where the weapon model's origin goes and ang turns the model about that origin, so adjusting ang alone
-- turns a weapon in place.
-- model: the world model players see. hold: "pistol" for one-handed sidearms, "rifle" for two-handed firearms.
-- The server cannot read the models' world offsets from the SWEPs because they are only defined clientside.
ENT.WeaponProps = {
	ak74 = {
		model = "models/weapons/w_ops_ak74.mdl",
		hold = "rifle",
		hand = {pos = {-0.65, 0.05, -1.38}, ang = {11.6, 3.6, -176.1}},
	},
	aks74u = {
		model = "models/weapons/w_smg_aks.mdl",
		hold = "rifle",
		hand = {pos = {8.96, 1.83, -4.49}, ang = {4.9, 5.7, -176}},
	},
	beretta92 = {
		model = "models/weapons/w_m92f_p228.mdl",
		hold = "pistol",
		hand = {pos = {-1.42, 0.45, 0.4}, ang = {14.5, 3.7, -175.6}},
	},
	brhp = {
		model = "models/weapons/w_pist_brhp.mdl",
		hold = "pistol",
		hand = {pos = {4.59, 0.41, -6.07}, ang = {-4.3, 92.2, -179.4}},
	},
	fort12 = {
		model = "models/srp/weapons/w_fort12.mdl",
		hold = "pistol",
		hand = {pos = {-1.63, 0.79, -2.46}, ang = {0.4, 2.2, -175.7}},
	},
	ij600 = {
		model = "models/weapons/w_sv10.mdl",
		hold = "rifle",
		hand = {pos = {14.73, 1.04, -4.6}, ang = {-7.8, -176.7, 176.2}},
	},
	lax410s = {
		model = "models/weapons/w_bocw_ironhides.mdl",
		hold = "rifle",
		hand = {pos = {-3.86, -0.07, -1.81}, ang = {-3.8, 92.8, -168.4}},
	},
	lr300 = {
		model = "models/weapons/w_lr300.mdl",
		hold = "rifle",
		hand = {pos = {13.7, 0.73, -0.1}, ang = {8.5, 3.2, -176.2}},
	},
	m1917 = {
		model = "models/khrcw2/doipack/w_sw1917.mdl",
		hold = "pistol",
		hand = {pos = {2.66, 0.43, -3.97}, ang = {14.5, 3.7, -175.6}},
	},
	m3supershort = {
		model = "models/weapons/w_shot_shortygun.mdl",
		hold = "rifle",
		hand = {pos = {2.93, 2.26, -7.4}, ang = {11.6, 3.6, -176.1}},
	},
	makarov = {
		model = "models/cw2/pistols/w_makarov.mdl",
		hold = "pistol",
		hand = {pos = {1.48, -0.14, -0.27}, ang = {14.5, 3.7, -175.6}},
	},
	mp153 = {
		model = "models/wick/weapons/stalker/stcopwep/w_mp153_model.mdl",
		hold = "rifle",
		hand = {pos = {-2.51, -0.16, -1.93}, ang = {-11.6, -176.4, 176.1}},
	},
	mp18 = {
		model = "models/weapons/arc9/darsu_eft/w_mp18.mdl",
		hold = "rifle",
		hand = {pos = {-12.91, -4.82, -3.62}, ang = {11.6, 3.6, -176.1}},
	},
	mp27 = {
		model = "models/weapons/tfa_ins2/wpn_mp27_w.mdl",
		hold = "rifle",
		hand = {pos = {0.44, -0.05, 0.97}, ang = {11.6, 3.6, -176.1}},
	},
	mp5k = {
		model = "models/weapons/w_tfa_dmm5k.mdl",
		hold = "rifle",
		hand = {pos = {2.36, -0.25, 3.73}, ang = {12.3, 3.7, -176.1}},
	},
	nagantrev = {
		model = "models/weapons/tfa_ins2/wpn_m1895_w.mdl",
		hold = "pistol",
		hand = {pos = {4.78, 0.21, 0.06}, ang = {14.5, 3.7, -175.6}},
	},
	obrez = {
		model = "models/weapons3/mosina.mdl",
		hold = "rifle",
		hand = {pos = {-7.97, 1.01, -17.22}, ang = {20.7, 18.8, -171.8}},
	},
	ppsh = {
		model = "models/weapons/w_grub_ppsh_stick.mdl",
		hold = "rifle",
		hand = {pos = {0.29, -2.9, 7.94}, ang = {79.6, 161.4, -106}},
	},
	ruger1022 = {
		model = "models/weapons/tfa_nmrih/w_fa_ruger1022.mdl",
		hold = "rifle",
		hand = {pos = {1.94, 0.28, -2.78}, ang = {11.6, 3.6, -176.1}},
	},
	rugermk3 = {
		model = "models/weapons/w_pist_ruger23a1.mdl",
		hold = "pistol",
		hand = {pos = {4.3, 0.6, -5.99}, ang = {0.1, -178.2, 175.7}},
	},
	saiga410 = {
		model = "models/cw2/weapons/w_saiga_chan.mdl",
		hold = "rifle",
		hand = {pos = {0.37, 0.11, -1.59}, ang = {11.6, 3.6, -176.1}},
	},
	saigasemi545 = {
		model = "models/weapons/w_bfh_saiga308.mdl",
		hold = "rifle",
		hand = {pos = {-1.7, -0.02, -1.16}, ang = {11.6, 3.6, -176.1}},
	},
	sako85 = {
		model = "models/weapons/tfa_nmrih/w_fa_sako85_ironsights.mdl",
		hold = "rifle",
		hand = {pos = {1.24, 0.2, -2.15}, ang = {11.6, 3.6, -176.1}},
	},
	sako85nato = {
		model = "models/weapons/tfa_nmrih/w_fa_sako85_ironsights.mdl",
		hold = "rifle",
		hand = {pos = {1.24, 0.2, -2.15}, ang = {11.6, 3.6, -176.1}},
	},
	skorpion = {
		model = "models/weapons/w_smg_skorp.mdl",
		hold = "rifle",
		hand = {pos = {13.12, 2.04, -5.55}, ang = {3.6, 6.2, -176}},
	},
	sv98 = {
		model = "models/weapons/w_sv98_scopeless.mdl",
		hold = "rifle",
		hand = {pos = {12.17, 0.91, -2.86}, ang = {-11.6, -176.4, 176.1}},
	},
	swr8 = {
		model = "models/weapons/w_revolver_r8.mdl",
		hold = "pistol",
		hand = {pos = {-0.57, 0.53, 0.83}, ang = {14.5, 3.7, -175.6}},
	},
	tokarev = {
		model = "models/weapons/w_pist_tt38.mdl",
		hold = "pistol",
		hand = {pos = {4.13, 0.42, -5.05}, ang = {-8.9, -176.4, 175.5}},
	},
	toz106 = {
		model = "models/weapons/arc9/darsu_eft/w_toz106.mdl",
		hold = "rifle",
		hand = {pos = {-11.47, -4.49, -5.35}, ang = {11.6, 3.6, -176.1}},
	},
	toz194 = {
		model = "models/khrcw2/w_khri_khrtoz194.mdl",
		hold = "rifle",
		hand = {pos = {-10.55, -0.39, 3.16}, ang = {11.6, 3.6, -176.1}},
	},
	toz34short = {
		model = "models/weapons/w_sv10s.mdl",
		hold = "rifle",
		hand = {pos = {-2.8, -15.91, -3.24}, ang = {4.9, -163.3, 87.3}},
	},
	toz66short = {
		model = "models/dobytchick/weapons/gmzone/deadair/w_toz66_obrez.mdl",
		hold = "rifle",
		hand = {pos = {-1.44, 0.06, -1.12}, ang = {-11.6, -176.4, 176.1}},
	},
	uzi = {
		model = "models/weapons/w_uzi.mdl",
		hold = "rifle",
		hand = {pos = {14.03, 1.14, -3.32}, ang = {-11.6, -176.4, 176.1}},
	},
}
