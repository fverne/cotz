local POLICY = include("cotz/attachment_policy.lua")
local ANOMALY_MODEL_PREFIX = "models/flaymi/anomaly/"
local RESKIN_CLASS_PREFIX = "cw_cotz_anomaly_"

local PROFILES = {
	-- Sight IDs used by Helix, including the two retained Anomaly scopes.
	sights = {
		"md_kobra", "md_microt1", "md_eotech", "md_aimpoint", "md_cmore", "md_reflex", "md_rmr",
		"md_schmidt_shortdot", "md_acog", "md_nightforce_nxs", "md_pso1", "cw_anomaly_1p29", "cw_anomaly_mosin",
	},
	weapons = {
		cw_9a91 = {suppressor = "md_pbs1", mount = "dovetail", optics = {"cw_anomaly_1p29"}},
		cw_aek971 = {anomalyModel = true, suppressor = "md_pbs1", mount = "dovetail", optics = {"cw_anomaly_1p29"}},
		cw_ak12 = {anomalyModel = true, suppressor = "md_pbs1", railOnly = true},
		cw_ak74 = {anomalyModel = true, suppressor = "md_pbs1", mount = "dovetail", optics = {"cw_anomaly_1p29"}},
		cw_akm = {anomalyModel = true, suppressor = "md_pbs1", mount = "dovetail", optics = {"cw_anomaly_1p29"}},
		cw_aks74u = {anomalyModel = true, suppressor = "md_pbs1", mount = "dovetail", optics = {"cw_anomaly_1p29"}},
		cw_an94k = {anomalyModel = true, suppressor = "md_pbs1", mount = "dovetail", optics = {"cw_anomaly_1p29"}},
		cw_anomaly_ace21_vmrecoil = {suppressor = "md_saker", railOnly = true},
		cw_anomaly_aek973_vmrecoil = {suppressor = "md_pbs1", mount = "dovetail"},
		cw_anomaly_ak101_vmrecoil = {suppressor = "md_saker", mount = "dovetail"},
		cw_anomaly_ak102_vmrecoil = {suppressor = "md_saker", mount = "dovetail"},
		cw_anomaly_ak103_vmrecoil = {suppressor = "md_pbs1", mount = "dovetail"},
		cw_anomaly_ak104_vmrecoil = {suppressor = "md_pbs1", mount = "dovetail"},
		cw_anomaly_ak105_vmrecoil = {suppressor = "md_pbs1", mount = "dovetail"},
		cw_anomaly_ak74m_vmrecoil = {suppressor = "md_pbs1", mount = "dovetail"},
		cw_anomaly_ak74u_snag_vmrecoil = {railOnly = true},
		cw_anomaly_ak_vmrecoil = {suppressor = "md_pbs1", railOnly = true},
		cw_anomaly_akms_vmrecoil = {suppressor = "md_pbs1", mount = "dovetail"},
		cw_anomaly_aks74_vmrecoil = {suppressor = "md_pbs1", mount = "dovetail"},
		cw_anomaly_aks_vmrecoil = {suppressor = "md_pbs1", railOnly = true},
		cw_anomaly_ash12_vmrecoil = {railOnly = true},
		cw_anomaly_aug_a3_vmrecoil = {suppressor = "md_saker", railOnly = true},
		cw_anomaly_cz75_auto_vmrecoil = {suppressor = "md_tundra9mm", family = "pistol"},
		cw_anomaly_cz75_vmrecoil = {suppressor = "md_tundra9mm", family = "pistol"},
		cw_anomaly_desert_eagle_nimble_vmrecoil = {suppressor = "md_tundra9mm", family = "pistol"},
		cw_anomaly_fn2000_nimble_vmrecoil = {suppressor = "md_saker", railOnly = true},
		cw_anomaly_fnc_vmrecoil = {suppressor = "md_saker", railOnly = true},
		cw_anomaly_fnp45_vmrecoil = {suppressor = "md_cobram2", family = "pistol"},
		cw_anomaly_fnx45_vmrecoil = {family = "pistol"},
		cw_anomaly_fort500_vmrecoil = {family = "shotgun", railOnly = true},
		cw_anomaly_g36_vmrecoil = {suppressor = "md_saker", railOnly = true},
		cw_anomaly_g3sg1_vmrecoil = {suppressor = "md_saker", family = "fixed"},
		cw_anomaly_g43_vmrecoil = {suppressor = "md_saker", family = "fixed"},
		cw_anomaly_galil_vmrecoil = {suppressor = "md_saker", railOnly = true},
		cw_anomaly_gauss_vmrecoil = {family = "fixed"},
		cw_anomaly_grach_vmrecoil = {suppressor = "md_tundra9mm", family = "pistol"},
		cw_anomaly_groza_nimble_vmrecoil = {suppressor = "md_pbs1", railOnly = true},
		cw_anomaly_groza_vmrecoil = {suppressor = "md_pbs1", railOnly = true},
		cw_anomaly_gsh18_vmrecoil = {suppressor = "md_tundra9mm", family = "pistol"},
		cw_anomaly_hk417_vmrecoil = {suppressor = "md_saker", railOnly = true},
		cw_anomaly_k98_vmrecoil = {suppressor = "md_saker", family = "period"},
		cw_anomaly_l85a2_vmrecoil = {suppressor = "md_saker", railOnly = true},
		cw_anomaly_m16a2_vmrecoil = {suppressor = "md_saker", railOnly = true},
		cw_anomaly_m249_vmrecoil = {suppressor = "md_saker", railOnly = true},
		cw_anomaly_m24_vmrecoil = {suppressor = "md_saker", family = "fixed"},
		cw_anomaly_m4_vmrecoil = {suppressor = "md_saker", railOnly = true},
		cw_anomaly_m4a1_vmrecoil = {suppressor = "md_saker", railOnly = true},
		cw_anomaly_m60_vmrecoil = {suppressor = "md_saker", railOnly = true},
		cw_anomaly_m79_vmrecoil = {family = "fixed"},
		cw_anomaly_m82_vmrecoil = {family = "fixed"},
		cw_anomaly_mp133_vmrecoil = {family = "shotgun", railOnly = true},
		cw_anomaly_mp412_vmrecoil = {suppressor = "md_tundra9mm", family = "revolver"},
		cw_anomaly_mp5_nimble_vmrecoil = {suppressor = "md_cobram2", railOnly = true},
		cw_anomaly_mp5sd_vmrecoil = {railOnly = true},
		cw_anomaly_mp7_vmrecoil = {suppressor = "md_tundra9mm", railOnly = true},
		cw_anomaly_oc33_vmrecoil = {suppressor = "md_tundra9mm", family = "pistol"},
		cw_anomaly_pb_vmrecoil = {family = "pistol"},
		cw_anomaly_pkm_zulus_vmrecoil = {suppressor = "md_pbs1", railOnly = true},
		cw_anomaly_pkp_vmrecoil = {suppressor = "md_pbs1", railOnly = true},
		cw_anomaly_pmm_vmrecoil = {suppressor = "md_tundra9mm", family = "pistol"},
		cw_anomaly_protecta_aim_vmrecoil = {family = "shotgun", railOnly = true},
		cw_anomaly_protecta_nimble_vmrecoil = {family = "shotgun", railOnly = true},
		cw_anomaly_rg6_vmrecoil = {family = "fixed"},
		cw_anomaly_rpd_vmrecoil = {suppressor = "md_pbs1", railOnly = true},
		cw_anomaly_rpg7_vmrecoil = {family = "fixed"},
		cw_anomaly_rpk74_vmrecoil = {suppressor = "md_pbs1", mount = "dovetail"},
		cw_anomaly_scar_vmrecoil = {suppressor = "md_saker", railOnly = true},
		cw_anomaly_sig220_vmrecoil = {suppressor = "md_cobram2", family = "pistol"},
		cw_anomaly_sig550_luckygun_vmrecoil = {suppressor = "md_saker", railOnly = true},
		cw_anomaly_sig550_sniper_vmrecoil = {suppressor = "md_saker", family = "fixed"},
		cw_anomaly_sig550_vmrecoil = {suppressor = "md_saker", railOnly = true},
		cw_anomaly_spas12_nimble_vmrecoil = {family = "shotgun", railOnly = true},
		cw_anomaly_spas12_vmrecoil = {family = "shotgun", railOnly = true},
		cw_anomaly_sr25_vmrecoil = {suppressor = "md_saker", family = "fixed"},
		cw_anomaly_svd_nimble_vmrecoil = {suppressor = "md_pbs1", family = "fixed"},
		cw_anomaly_toz34_mark4_vmrecoil = {family = "fixed"},
		cw_anomaly_type63_vmrecoil = {suppressor = "md_pbs1", railOnly = true},
		cw_anomaly_usas12_vmrecoil = {family = "shotgun", railOnly = true},
		cw_anomaly_usp_match_vmrecoil = {suppressor = "md_tundra9mm", family = "pistol"},
		cw_anomaly_usp_nimble_vmrecoil = {suppressor = "md_tundra9mm", family = "pistol"},
		cw_anomaly_usp_vmrecoil = {suppressor = "md_cobram2", family = "pistol"},
		cw_anomaly_val_sk1_vmrecoil = {mount = "dovetail"},
		cw_anomaly_vepr_vmrecoil = {family = "shotgun", mount = "dovetail"},
		cw_anomaly_vintorez_1pn93_vmrecoil = {family = "fixed"},
		cw_anomaly_vintorez_nimble_vmrecoil = {family = "fixed"},
		cw_anomaly_vsk94_vmrecoil = {mount = "dovetail"},
		cw_anomaly_wa2000_vmrecoil = {suppressor = "md_saker", family = "fixed"},
		cw_anomaly_walter_sk1_vmrecoil = {suppressor = "md_tundra9mm", family = "pistol"},
		cw_anomaly_xm8_vmrecoil = {suppressor = "md_saker", railOnly = true},
		cw_ar159mm = {suppressor = "md_tundra9mm"},
		cw_asval = {anomalyModel = true, mount = "dovetail", optics = {"cw_anomaly_1p29"}},
		cw_aug = {anomalyModel = true, suppressor = "md_saker", family = "fixed"},
		cw_barrettm98b = {anomalyModel = true, suppressor = "md_saker", family = "fixed"},
		cw_beretta92 = {anomalyModel = true, suppressor = "md_tundra9mm", family = "pistol"},
		cw_brhp = {anomalyModel = true, suppressor = "md_tundra9mm", family = "pistol"},
		cw_c96 = {suppressor = "md_tundra9mm", optics = {"md_rmr"}},
		cw_c96carbine = {suppressor = "md_tundra9mm", optics = {"md_rmr"}},
		cw_contender = {suppressor = "md_cobram2", family = "pistol"},
		cw_contender500 = {suppressor = "md_saker", family = "pistol"},
		cw_cz52 = {anomalyModel = true, suppressor = "md_tundra9mm"},
		cw_deagle = {anomalyModel = true, suppressor = "md_cobram2", family = "pistol"},
		cw_deagle44 = {anomalyModel = true, suppressor = "md_cobram2", family = "pistol"},
		cw_dp28 = {suppressor = "md_pbs1"},
		cw_dragunov = {anomalyModel = true, suppressor = "md_pbs1", mount = "dovetail", optics = {"cw_anomaly_1p29"}},
		cw_f2000 = {anomalyModel = true, suppressor = "md_saker", family = "fixed"},
		cw_famas = {anomalyModel = true, suppressor = "md_saker", railOnly = true},
		cw_fiveseven = {anomalyModel = true, suppressor = "md_tundra9mm", family = "pistol"},
		cw_fnfal = {anomalyModel = true, suppressor = "md_saker", railOnly = true},
		cw_fort12 = {anomalyModel = true, suppressor = "md_tundra9mm", family = "pistol"},
		cw_g36c = {anomalyModel = true, suppressor = "md_saker", family = "fixed"},
		cw_g3a3 = {anomalyModel = true, suppressor = "md_saker", railOnly = true},
		cw_gepardpdw = {suppressor = "md_tundra9mm"},
		cw_glock17 = {anomalyModel = true, suppressor = "md_tundra9mm", family = "pistol"},
		cw_glock18 = {anomalyModel = true, suppressor = "md_tundra9mm", family = "pistol"},
		cw_hk416 = {anomalyModel = true, suppressor = "md_saker", railOnly = true},
		cw_ij600 = {},
		cw_ithaca37 = {},
		cw_kiparis = {anomalyModel = true, suppressor = "md_tundra9mm", railOnly = true},
		cw_kp31 = {suppressor = "md_tundra9mm"},
		cw_l115 = {suppressor = "md_saker", family = "fixed"},
		cw_l85 = {suppressor = "md_saker", family = "fixed"},
		cw_lax410 = {suppressor = "md_cobram2"},
		cw_lax410s = {suppressor = "md_cobram2"},
		cw_lax44 = {suppressor = "md_cobram2"},
		cw_lr300 = {anomalyModel = true, suppressor = "md_saker", railOnly = true},
		cw_m14 = {anomalyModel = true, suppressor = "md_saker", railOnly = true},
		cw_m1887 = {},
		cw_m1911 = {anomalyModel = true, suppressor = "md_cobram2", family = "pistol"},
		cw_m1911chic = {suppressor = "md_cobram2"},
		cw_m1917 = {suppressor = "md_cobram2", optics = {"md_rmr"}},
		cw_m1928a1 = {suppressor = "md_cobram2"},
		cw_m3super90 = {optics = {"md_microt1", "md_eotech", "md_aimpoint"}},
		cw_m3supershort = {},
		cw_mac11 = {suppressor = "md_tundra9mm"},
		cw_makarov = {anomalyModel = true, suppressor = "md_tundra9mm", family = "pistol"},
		cw_mateba = {suppressor = "md_cobram2"},
		cw_model29 = {suppressor = "md_cobram2"},
		cw_mossberg500 = {anomalyModel = true, railOnly = true},
		cw_mp153 = {anomalyModel = true, railOnly = true},
		cw_mp18 = {suppressor = "md_pbs1"},
		cw_mp27 = {},
		cw_mp34 = {suppressor = "md_tundra9mm"},
		cw_mp40 = {suppressor = "md_tundra9mm"},
		cw_mp5 = {anomalyModel = true, suppressor = "md_tundra9mm", railOnly = true},
		cw_mp5k = {suppressor = "md_tundra9mm"},
		cw_mp9a1 = {suppressor = "md_tundra9mm"},
		cw_mr96 = {suppressor = "md_tundra9mm"},
		cw_nagantrev = {suppressor = "md_tundra9mm"},
		cw_ne700 = {},
		cw_obrez = {suppressor = "md_pbs1"},
		cw_obrezmalfunction = {},
		cw_p08 = {suppressor = "md_tundra9mm"},
		cw_p90 = {anomalyModel = true, suppressor = "md_tundra9mm", railOnly = true},
		cw_p99 = {anomalyModel = true, suppressor = "md_tundra9mm", family = "pistol"},
		cw_pkm = {anomalyModel = true, suppressor = "md_pbs1", railOnly = true},
		cw_pp19 = {anomalyModel = true, suppressor = "md_tundra9mm", mount = "dovetail", optics = {"cw_anomaly_1p29"}},
		cw_pp1901_vityaz = {anomalyModel = true, suppressor = "md_tundra9mm", railOnly = true},
		cw_pp2000 = {anomalyModel = true, suppressor = "md_tundra9mm", railOnly = true},
		cw_ppsh = {anomalyModel = true, suppressor = "md_tundra9mm"},
		cw_ptrs = {},
		cw_ragingbull = {suppressor = "md_cobram2"},
		cw_rem870ae = {anomalyModel = true, railOnly = true},
		cw_remmsr = {suppressor = "md_saker"},
		cw_rk95 = {suppressor = "md_pbs1"},
		cw_rpk = {anomalyModel = true, suppressor = "md_pbs1", mount = "dovetail", optics = {"cw_anomaly_1p29"}},
		cw_ruger1022 = {suppressor = "md_tundra9mm"},
		cw_rugermini14 = {suppressor = "md_saker"},
		cw_rugermk3 = {suppressor = "md_tundra9mm", family = "pistol"},
		cw_saiga12 = {anomalyModel = true, optics = {"cw_anomaly_1p29"}},
		cw_saiga410 = {},
		cw_saigasport = {suppressor = "md_pbs1", optics = {"md_pso1"}},
		cw_saigasport545 = {suppressor = "md_pbs1", optics = {"md_pso1"}},
		cw_sako85 = {suppressor = "md_saker"},
		cw_sako85nato = {suppressor = "md_saker"},
		cw_sako85varmint = {suppressor = "md_tundra9mm"},
		cw_sg552 = {anomalyModel = true, suppressor = "md_saker", railOnly = true},
		cw_skorpion = {anomalyModel = true, suppressor = "md_tundra9mm", railOnly = true},
		cw_sks = {anomalyModel = true, suppressor = "md_pbs1", railOnly = true, optics = {"cw_anomaly_mosin"}},
		cw_sr3m = {anomalyModel = true, suppressor = "md_pbs1", mount = "dovetail", optics = {"cw_anomaly_1p29"}},
		cw_stechaps = {anomalyModel = true, suppressor = "md_tundra9mm", family = "pistol"},
		cw_sten = {suppressor = "md_tundra9mm"},
		cw_sterling = {suppressor = "md_tundra9mm"},
		cw_stoegerdd = {optics = {"md_microt1", "md_eotech", "md_aimpoint", "md_rmr"}},
		cw_stoegerddshort = {optics = {"md_microt1", "md_eotech", "md_aimpoint", "md_rmr"}},
		cw_striker = {anomalyModel = true, railOnly = true},
		cw_sv98 = {anomalyModel = true, suppressor = "md_pbs1", family = "fixed"},
		cw_svt40 = {anomalyModel = true, suppressor = "md_pbs1", optics = {"cw_anomaly_mosin"}},
		cw_svu = {anomalyModel = true, suppressor = "md_pbs1", mount = "dovetail", optics = {"cw_anomaly_1p29"}},
		cw_sw500 = {suppressor = "md_saker"},
		cw_swr8 = {suppressor = "md_tundra9mm"},
		cw_taurusjudge = {suppressor = "md_cobram2"},
		cw_tkpd = {suppressor = "md_pbs1"},
		cw_tokarev = {anomalyModel = true, suppressor = "md_tundra9mm"},
		cw_toz106 = {suppressor = "md_cobram2"},
		cw_toz194 = {},
		cw_toz34 = {anomalyModel = true, railOnly = true},
		cw_toz34short = {anomalyModel = true, railOnly = true},
		cw_toz34special = {},
		cw_toz66 = {anomalyModel = true, railOnly = true},
		cw_toz66short = {anomalyModel = true, railOnly = true},
		cw_trg42 = {anomalyModel = true, suppressor = "md_saker", family = "fixed"},
		cw_ump45 = {anomalyModel = true, suppressor = "md_cobram2", railOnly = true},
		cw_uzi = {suppressor = "md_tundra9mm"},
		cw_uzi50ae = {suppressor = "md_cobram2"},
		cw_veresk = {suppressor = "md_tundra9mm"},
		cw_vss = {anomalyModel = true, mount = "dovetail", optics = {"cw_anomaly_1p29"}},
		cw_vssk = {family = "fixed"},
		cw_w1895 = {suppressor = "md_pbs1"},
		cw_w9422 = {suppressor = "md_tundra9mm"},
		cw_w9422357 = {suppressor = "md_tundra9mm"},
		cw_ws_m16a4 = {anomalyModel = true, suppressor = "md_saker", railOnly = true},
		cw_ws_mosin = {
			suppressor = "md_pbs1",
			optics = {"md_microt1", "md_eotech", "md_aimpoint", "md_cmore", "md_reflex", "md_schmidt_shortdot", "md_acog", "md_nightforce_nxs", "md_pso1", "cw_anomaly_mosin"},
		},
	},
}

function PROFILES.GetSourceClass(class)
	if class and string.StartWith(class, RESKIN_CLASS_PREFIX) then
		return "cw_" .. class:sub(#RESKIN_CLASS_PREFIX + 1)
	end

	return class
end

function PROFILES.GetForModel(class, model)
	local profile = PROFILES.weapons[PROFILES.GetSourceClass(class)]
	if not profile then return end

	-- Reskin placements and slots are calibrated for the Anomaly models.
	if profile.anomalyModel and not string.StartWith(model or "", ANOMALY_MODEL_PREFIX) then return end

	return profile
end

function PROFILES.GetSights(class)
	class = PROFILES.GetSourceClass(class)
	local profile = PROFILES.weapons[class]
	local family = POLICY.weapons[class] or profile.family or "rifle"
	local rules = POLICY.families[family]
	local mount = POLICY.mounts[class] or profile.mount
	local sights = {}

	if rules and (not rules.requiresMount or mount) then
		for _, id in ipairs(rules.sights) do
			local blockedMount = POLICY.dovetailSights[id] and mount ~= "dovetail"
			if not blockedMount and not (profile.railOnly and id == "md_kobra") then
				sights[#sights + 1] = id
			end
		end
	end

	for _, id in ipairs(profile.optics or {}) do
		if not table.HasValue(sights, id) then
			sights[#sights + 1] = id
		end
	end

	return sights
end

return PROFILES
