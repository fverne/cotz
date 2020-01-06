if not CustomizableWeaponry then return end

ENT.Type = "anim"
ENT.Base = "base_entity"
ENT.PrintName = "attach point for particles"
ENT.Author = "KK"
ENT.Information = "attach point for particles"
ENT.Spawnable = false
ENT.AdminSpawnable = false

// INS2

CustomizableWeaponry:addFireSound("CW_KK_INS2_FRAG_ENT_DETONATE", {"weapons/m67/m67_detonate_01.wav", "weapons/m67/m67_detonate_02.wav", "weapons/m67/m67_detonate_03.wav"})
CustomizableWeaponry:addFireSound("CW_KK_INS2_FRAG_ENT_DETONATE_D1", {"weapons/m67/m67_detonate_dist_01.wav", "weapons/m67/m67_detonate_dist_02.wav", "weapons/m67/m67_detonate_dist_03.wav"})
CustomizableWeaponry:addFireSound("CW_KK_INS2_FRAG_ENT_DETONATE_D2", {"weapons/m67/m67_detonate_far_dist_01.wav", "weapons/m67/m67_detonate_far_dist_02.wav", "weapons/m67/m67_detonate_far_dist_03.wav"})
CustomizableWeaponry:addFireSound("CW_KK_INS2_FRAG_ENT_DETONATE_WATER", {"weapons/m67/water/m67_water_detonate_01.wav", "weapons/m67/water/m67_water_detonate_02.wav", "weapons/m67/water/m67_water_detonate_03.wav"})
CustomizableWeaponry:addFireSound("CW_KK_INS2_FRAG_ENT_DETONATE_WATER_D1", {"weapons/m67/water/m67_water_detonate_dist_01.wav", "weapons/m67/water/m67_water_detonate_dist_02.wav", "weapons/m67/water/m67_water_detonate_dist_03.wav"})

CustomizableWeaponry:addFireSound("CW_KK_INS2_M84_ENT_DETONATE", "weapons/m84/m84_detonate.wav")
CustomizableWeaponry:addFireSound("CW_KK_INS2_M84_ENT_DETONATE_D1", "weapons/m84/m84_detonate_dist.wav")
CustomizableWeaponry:addFireSound("CW_KK_INS2_M84_ENT_DETONATE_D2", "weapons/m84/m84_detonate_far_dist.wav")

-- CustomizableWeaponry:addFireSound("CW_KK_INS2_ANM14_ENT_DETONATE", "weapons/anm14/an_m14_detonate.wav")
CustomizableWeaponry:addFireSound("CW_KK_INS2_ANM14_ENT_DETONATE", "weapons/anm14/an_m14_burn.wav")

-- CustomizableWeaponry:addFireSound("CW_KK_INS2_MOLOTOV_ENT_DETONATE", "weapons/molotov/molotov_detonate.wav")
CustomizableWeaponry:addFireSound("CW_KK_INS2_MOLOTOV_ENT_DETONATE", "weapons/molotov/molotov_burn.wav")
-- CustomizableWeaponry:addFireSound("CW_KK_INS2_MOLOTOV_ENT_DETONATE_D1", "weapons/molotov/molotov_burn_loop.wav")
-- CustomizableWeaponry:addFireSound("CW_KK_INS2_MOLOTOV_ENT_DETONATE_D2", "weapons/molotov/molotov_burn_loop_end.wav")

CustomizableWeaponry:addFireSound("CW_KK_INS2_M18_ENT_DETONATE", "weapons/m18/m18_detonate.wav")

CustomizableWeaponry:addFireSound("CW_KK_INS2_RPG_ENT_DETONATE", {"weapons/at4/at4rpg_detonate_01.wav", "weapons/at4/at4rpg_detonate_02.wav", "weapons/at4/at4rpg_detonate_03.wav"}, 1, 100, CHAN_STATIC)
CustomizableWeaponry:addFireSound("CW_KK_INS2_RPG_ENT_DETONATE_D1", {"weapons/at4/at4rpg_detonate_dist_01.wav", "weapons/at4/at4rpg_detonate_dist_02.wav", "weapons/at4/at4rpg_detonate_dist_03.wav"}, 1, 100, CHAN_STATIC)
CustomizableWeaponry:addFireSound("CW_KK_INS2_RPG_ENT_DETONATE_D2", {"weapons/at4/at4rpg_detonate_far_dist_01.wav", "weapons/at4/at4rpg_detonate_far_dist_02.wav", "weapons/at4/at4rpg_detonate_far_dist_03.wav"}, 1, 100, CHAN_STATIC)
CustomizableWeaponry:addFireSound("CW_KK_INS2_RPG_ENT_DETONATE_WATER", {"weapons/at4/water/at4rpg_water_detonate_01.wav", "weapons/at4/water/at4rpg_water_detonate_02.wav", "weapons/at4/water/at4rpg_water_detonate_03.wav"}, 1, 100, CHAN_STATIC)
CustomizableWeaponry:addFireSound("CW_KK_INS2_RPG_ENT_DETONATE_WATER_D1", {"weapons/at4/water/at4rpg_water_detonate_dist_01.wav", "weapons/at4/water/at4rpg_water_detonate_dist_02.wav", "weapons/at4/water/at4rpg_water_detonate_dist_03.wav"}, 1, 100, CHAN_STATIC)

CustomizableWeaponry:addFireSound("CW_KK_INS2_C4_ENT_DETONATE", {"weapons/c4/c4_detonate_01.wav", "weapons/c4/c4_detonate_02.wav", "weapons/c4/c4_detonate_03.wav"})
CustomizableWeaponry:addFireSound("CW_KK_INS2_C4_ENT_DETONATE_D1", {"weapons/c4/c4_detonate_dist_01.wav", "weapons/c4/c4_detonate_dist_02.wav", "weapons/c4/c4_detonate_dist_03.wav"})
CustomizableWeaponry:addFireSound("CW_KK_INS2_C4_ENT_DETONATE_D2", {"weapons/c4/c4_detonate_far_dist_01.wav", "weapons/c4/c4_detonate_far_dist_02.wav", "weapons/c4/c4_detonate_far_dist_03.wav"})
CustomizableWeaponry:addFireSound("CW_KK_INS2_C4_ENT_DETONATE_WATER", {"weapons/c4/water/c4_water_detonate_01.wav", "weapons/c4/water/c4_water_detonate_02.wav", "weapons/c4/water/c4_water_detonate_03.wav"})
CustomizableWeaponry:addFireSound("CW_KK_INS2_C4_ENT_DETONATE_WATER_D1", {"weapons/c4/water/c4_water_detonate_dist_01.wav", "weapons/c4/water/c4_water_detonate_dist_02.wav", "weapons/c4/water/c4_water_detonate_dist_03.wav"})

CustomizableWeaponry:addFireSound("CW_KK_INS2_IED_ENT_DETONATE", {"weapons/ied/ied_detonate_01.wav", "weapons/ied/ied_detonate_02.wav", "weapons/ied/ied_detonate_03.wav"})
CustomizableWeaponry:addFireSound("CW_KK_INS2_IED_ENT_DETONATE_D1", {"weapons/ied/ied_detonate_dist_01.wav", "weapons/ied/ied_detonate_dist_02.wav", "weapons/ied/ied_detonate_dist_03.wav"})
CustomizableWeaponry:addFireSound("CW_KK_INS2_IED_ENT_DETONATE_D2", {"weapons/ied/ied_detonate_far_dist_01.wav", "weapons/ied/ied_detonate_far_dist_02.wav", "weapons/ied/ied_detonate_far_dist_03.wav"})
CustomizableWeaponry:addFireSound("CW_KK_INS2_IED_ENT_DETONATE_WATER", {"weapons/ied/water/ied_water_detonate_01.wav", "weapons/ied/water/ied_water_detonate_02.wav", "weapons/ied/water/ied_water_detonate_03.wav"})
CustomizableWeaponry:addFireSound("CW_KK_INS2_IED_ENT_DETONATE_WATER_D1", {"weapons/ied/water/ied_water_detonate_dist_01.wav", "weapons/ied/water/ied_water_detonate_dist_02.wav", "weapons/ied/water/ied_water_detonate_dist_03.wav"})

// DOI

CustomizableWeaponry:addFireSound("CW_KK_INS2_DOI_MILLS_ENT_DETONATE", {"weapons/millsbomb/mills_detonate_01.wav", "weapons/millsbomb/mills_detonate_02.wav", "weapons/millsbomb/mills_detonate_03.wav"})
CustomizableWeaponry:addFireSound("CW_KK_INS2_DOI_MILLS_ENT_DETONATE_D1", {"weapons/millsbomb/mills_detonate_dist_01.wav", "weapons/millsbomb/mills_detonate_dist_02.wav", "weapons/millsbomb/mills_detonate_dist_03.wav"})
CustomizableWeaponry:addFireSound("CW_KK_INS2_DOI_MILLS_ENT_DETONATE_D2", {"weapons/millsbomb/mills_detonate_far_dist_01.wav", "weapons/millsbomb/mills_detonate_far_dist_02.wav", "weapons/millsbomb/mills_detonate_far_dist_03.wav"})
CustomizableWeaponry:addFireSound("CW_KK_INS2_DOI_MILLS_ENT_DETONATE_WATER", {"weapons/millsbomb/water/mills_water_detonate_01.wav", "weapons/millsbomb/water/mills_water_detonate_02.wav", "weapons/millsbomb/water/mills_water_detonate_03.wav"})
CustomizableWeaponry:addFireSound("CW_KK_INS2_DOI_MILLS_ENT_DETONATE_WATER_D1", {"weapons/millsbomb/water/mills_water_detonate_dist_01.wav", "weapons/millsbomb/water/mills_water_detonate_dist_02.wav", "weapons/millsbomb/water/mills_water_detonate_dist_03.wav"})

CustomizableWeaponry:addFireSound("CW_KK_INS2_DOI_MK2_ENT_DETONATE", {"weapons/mk2/mk2_detonate_01.wav", "weapons/mk2/mk2_detonate_02.wav", "weapons/mk2/mk2_detonate_03.wav"})
CustomizableWeaponry:addFireSound("CW_KK_INS2_DOI_MK2_ENT_DETONATE_D1", {"weapons/mk2/mk2_detonate_dist_01.wav", "weapons/mk2/mk2_detonate_dist_02.wav", "weapons/mk2/mk2_detonate_dist_03.wav"})
CustomizableWeaponry:addFireSound("CW_KK_INS2_DOI_MK2_ENT_DETONATE_D2", {"weapons/mk2/mk2_detonate_far_dist_01.wav", "weapons/mk2/mk2_detonate_far_dist_02.wav", "weapons/mk2/mk2_detonate_far_dist_03.wav"})
CustomizableWeaponry:addFireSound("CW_KK_INS2_DOI_MK2_ENT_DETONATE_WATER", {"weapons/mk2/water/mk2_water_detonate_01.wav", "weapons/mk2/water/mk2_water_detonate_02.wav", "weapons/mk2/water/mk2_water_detonate_03.wav"})
CustomizableWeaponry:addFireSound("CW_KK_INS2_DOI_MK2_ENT_DETONATE_WATER_D1", {"weapons/mk2/water/mk2_water_detonate_dist_01.wav", "weapons/mk2/water/mk2_water_detonate_dist_02.wav", "weapons/mk2/water/mk2_water_detonate_dist_03.wav"})

CustomizableWeaponry:addFireSound("CW_KK_INS2_DOI_N69_ENT_DETONATE", {"weapons/no69/no69_detonate_01.wav", "weapons/no69/no69_detonate_02.wav", "weapons/no69/no69_detonate_03.wav"})
CustomizableWeaponry:addFireSound("CW_KK_INS2_DOI_N69_ENT_DETONATE_D1", {"weapons/no69/no69_detonate_dist_01.wav", "weapons/no69/no69_detonate_dist_02.wav", "weapons/no69/no69_detonate_dist_03.wav"})
CustomizableWeaponry:addFireSound("CW_KK_INS2_DOI_N69_ENT_DETONATE_D2", {"weapons/no69/no69_detonate_far_dist_01.wav", "weapons/no69/no69_detonate_far_dist_02.wav", "weapons/no69/no69_detonate_far_dist_03.wav"})
CustomizableWeaponry:addFireSound("CW_KK_INS2_DOI_N69_ENT_DETONATE_WATER", {"weapons/no69/water/no69_water_detonate_01.wav", "weapons/no69/water/no69_water_detonate_02.wav", "weapons/no69/water/no69_water_detonate_03.wav"})
CustomizableWeaponry:addFireSound("CW_KK_INS2_DOI_N69_ENT_DETONATE_WATER_D1", {"weapons/no69/water/no69_water_detonate_dist_01.wav", "weapons/no69/water/no69_water_detonate_dist_02.wav", "weapons/no69/water/no69_water_detonate_dist_03.wav"})

CustomizableWeaponry:addFireSound("CW_KK_INS2_DOI_N76_ENT_DETONATE", "weapons/no76/no76_burn.wav")

CustomizableWeaponry:addFireSound("CW_KK_INS2_DOI_N77_ENT_DETONATE", "weapons/no77/no77_detonate_smoke_near_01.wav")

CustomizableWeaponry:addFireSound("CW_KK_INS2_DOI_M6A1_ENT_DETONATE", {"weapons/bazooka/bazooka_detonate_01.wav", "weapons/bazooka/bazooka_detonate_02.wav", "weapons/bazooka/bazooka_detonate_03.wav"})
CustomizableWeaponry:addFireSound("CW_KK_INS2_DOI_M6A1_ENT_DETONATE_D1", {"weapons/bazooka/bazooka_detonate_dist_01.wav", "weapons/bazooka/bazooka_detonate_dist_02.wav", "weapons/bazooka/bazooka_detonate_dist_03.wav"})
CustomizableWeaponry:addFireSound("CW_KK_INS2_DOI_M6A1_ENT_DETONATE_D2", {"weapons/bazooka/bazooka_detonate_far_dist_01.wav", "weapons/bazooka/bazooka_detonate_far_dist_02.wav", "weapons/bazooka/bazooka_detonate_far_dist_03.wav"})
CustomizableWeaponry:addFireSound("CW_KK_INS2_DOI_M6A1_ENT_DETONATE_WATER", {"weapons/bazooka/water/bazooka_water_detonate_01.wav", "weapons/bazooka/water/bazooka_water_detonate_02.wav", "weapons/bazooka/water/bazooka_water_detonate_03.wav"})
CustomizableWeaponry:addFireSound("CW_KK_INS2_DOI_M6A1_ENT_DETONATE_WATER_D1", {"weapons/bazooka/water/bazooka_water_detonate_dist_01.wav", "weapons/bazooka/water/bazooka_water_detonate_dist_02.wav", "weapons/bazooka/water/bazooka_water_detonate_dist_03.wav"})

CustomizableWeaponry:addFireSound("CW_KK_INS2_DOI_M10A1_ENT_DETONATE", {"weapons/bazooka/wp/bazooka_detonate_wp_01.wav", "weapons/bazooka/wp/bazooka_detonate_wp_02.wav", "weapons/bazooka/wp/bazooka_detonate_wp_03.wav"})
CustomizableWeaponry:addFireSound("CW_KK_INS2_DOI_M10A1_ENT_DETONATE_D1", {"weapons/bazooka/wp/bazooka_detonate_wp_dist_01.wav", "weapons/bazooka/wp/bazooka_detonate_wp_dist_02.wav", "weapons/bazooka/wp/bazooka_detonate_wp_dist_03.wav"})
CustomizableWeaponry:addFireSound("CW_KK_INS2_DOI_M10A1_ENT_DETONATE_D2", {"weapons/bazooka/wp/bazooka_detonate_wp_far_dist_01.wav", "weapons/bazooka/wp/bazooka_detonate_wp_far_dist_02.wav", "weapons/bazooka/wp/bazooka_detonate_wp_far_dist_03.wav"})

CustomizableWeaponry:addFireSound("CW_KK_INS2_DOI_PANZERFAUST_ENT_DETONATE", {"weapons/panzerfaust/panzerfaust_detonate_01.wav", "weapons/panzerfaust/panzerfaust_detonate_02.wav", "weapons/panzerfaust/panzerfaust_detonate_03.wav"})
CustomizableWeaponry:addFireSound("CW_KK_INS2_DOI_PANZERFAUST_ENT_DETONATE_D1", {"weapons/panzerfaust/panzerfaust_detonate_dist_01.wav", "weapons/panzerfaust/panzerfaust_detonate_dist_02.wav", "weapons/panzerfaust/panzerfaust_detonate_dist_03.wav"})
CustomizableWeaponry:addFireSound("CW_KK_INS2_DOI_PANZERFAUST_ENT_DETONATE_D2", {"weapons/panzerfaust/panzerfaust_detonate_far_dist_01.wav", "weapons/panzerfaust/panzerfaust_detonate_far_dist_02.wav", "weapons/panzerfaust/panzerfaust_detonate_far_dist_03.wav"})
CustomizableWeaponry:addFireSound("CW_KK_INS2_DOI_PANZERFAUST_ENT_DETONATE_WATER", {"weapons/panzerfaust/water/panzerfaust_water_detonate_01.wav", "weapons/panzerfaust/water/panzerfaust_water_detonate_02.wav", "weapons/panzerfaust/water/panzerfaust_water_detonate_03.wav"})
CustomizableWeaponry:addFireSound("CW_KK_INS2_DOI_PANZERFAUST_ENT_DETONATE_WATER_D1", {"weapons/panzerfaust/water/panzerfaust_water_detonate_dist_01.wav", "weapons/panzerfaust/water/panzerfaust_water_detonate_dist_02.wav", "weapons/panzerfaust/water/panzerfaust_water_detonate_dist_03.wav"})

CustomizableWeaponry:addFireSound("CW_KK_INS2_DOI_SHREK_ENT_DETONATE", {"weapons/panzerschreck/panzerschreck_detonate_01.wav", "weapons/panzerschreck/panzerschreck_detonate_02.wav", "weapons/panzerschreck/panzerschreck_detonate_03.wav"})
CustomizableWeaponry:addFireSound("CW_KK_INS2_DOI_SHREK_ENT_DETONATE_D1", {"weapons/panzerschreck/panzerschreck_detonate_dist_01.wav", "weapons/panzerschreck/panzerschreck_detonate_dist_02.wav", "weapons/panzerschreck/panzerschreck_detonate_dist_03.wav"})
CustomizableWeaponry:addFireSound("CW_KK_INS2_DOI_SHREK_ENT_DETONATE_D2", {"weapons/panzerschreck/panzerschreck_detonate_far_dist_01.wav", "weapons/panzerschreck/panzerschreck_detonate_far_dist_02.wav", "weapons/panzerschreck/panzerschreck_detonate_far_dist_03.wav"})
CustomizableWeaponry:addFireSound("CW_KK_INS2_DOI_SHREK_ENT_DETONATE_WATER", {"weapons/panzerschreck/water/panzerschreck_water_detonate_01.wav", "weapons/panzerschreck/water/panzerschreck_water_detonate_02.wav", "weapons/panzerschreck/water/panzerschreck_water_detonate_03.wav"})
CustomizableWeaponry:addFireSound("CW_KK_INS2_DOI_SHREK_ENT_DETONATE_WATER_D1", {"weapons/panzerschreck/water/panzerschreck_water_detonate_dist_01.wav", "weapons/panzerschreck/water/panzerschreck_water_detonate_dist_02.wav", "weapons/panzerschreck/water/panzerschreck_water_detonate_dist_03.wav"})

CustomizableWeaponry:addFireSound("CW_KK_INS2_DOI_PIAT_ENT_DETONATE", {"weapons/piat/piat_detonate_01.wav", "weapons/piat/piat_detonate_02.wav", "weapons/piat/piat_detonate_03.wav"})
CustomizableWeaponry:addFireSound("CW_KK_INS2_DOI_PIAT_ENT_DETONATE_D1", {"weapons/piat/piat_detonate_dist_01.wav", "weapons/piat/piat_detonate_dist_02.wav", "weapons/piat/piat_detonate_dist_03.wav"})
CustomizableWeaponry:addFireSound("CW_KK_INS2_DOI_PIAT_ENT_DETONATE_D2", {"weapons/piat/piat_detonate_far_dist_01.wav", "weapons/piat/piat_detonate_far_dist_02.wav", "weapons/piat/piat_detonate_far_dist_03.wav"})
CustomizableWeaponry:addFireSound("CW_KK_INS2_DOI_PIAT_ENT_DETONATE_WATER", {"weapons/piat/water/piat_water_detonate_01.wav", "weapons/piat/water/piat_water_detonate_02.wav", "weapons/piat/water/piat_water_detonate_03.wav"})
CustomizableWeaponry:addFireSound("CW_KK_INS2_DOI_PIAT_ENT_DETONATE_WATER_D1", {"weapons/piat/water/piat_water_detonate_dist_01.wav", "weapons/piat/water/piat_water_detonate_dist_02.wav", "weapons/piat/water/piat_water_detonate_dist_03.wav"})

CustomizableWeaponry:addFireSound("CW_KK_INS2_DOI_C4_DE_ENT_DETONATE", {"weapons/tnt/tnt_detonate_01.wav", "weapons/tnt/tnt_detonate_02.wav", "weapons/tnt/tnt_detonate_03.wav"})
CustomizableWeaponry:addFireSound("CW_KK_INS2_DOI_C4_DE_ENT_DETONATE_D1", {"weapons/tnt/tnt_detonate_dist_01.wav", "weapons/tnt/tnt_detonate_dist_02.wav", "weapons/tnt/tnt_detonate_dist_03.wav"})
CustomizableWeaponry:addFireSound("CW_KK_INS2_DOI_C4_DE_ENT_DETONATE_D2", {"weapons/tnt/tnt_detonate_far_dist_01.wav", "weapons/tnt/tnt_detonate_far_dist_02.wav", "weapons/tnt/tnt_detonate_far_dist_03.wav"})
CustomizableWeaponry:addFireSound("CW_KK_INS2_DOI_C4_DE_ENT_DETONATE_WATER", {"weapons/tnt/water/tnt_water_detonate_01.wav", "weapons/tnt/water/tnt_water_detonate_02.wav", "weapons/tnt/water/tnt_water_detonate_03.wav"})
CustomizableWeaponry:addFireSound("CW_KK_INS2_DOI_C4_DE_ENT_DETONATE_WATER_D1", {"weapons/tnt/water/tnt_water_detonate_dist_01.wav", "weapons/tnt/water/tnt_water_detonate_dist_02.wav", "weapons/tnt/water/tnt_water_detonate_dist_03.wav"})

CustomizableWeaponry:addFireSound("CW_KK_INS2_DOI_C4_US_ENT_DETONATE", {"weapons/compositonb/compositonb_detonate_01.wav", "weapons/compositonb/compositonb_detonate_02.wav", "weapons/compositonb/compositonb_detonate_03.wav"})
CustomizableWeaponry:addFireSound("CW_KK_INS2_DOI_C4_US_ENT_DETONATE_D1", {"weapons/compositonb/compositonb_detonate_dist_01.wav", "weapons/compositonb/compositonb_detonate_dist_02.wav", "weapons/compositonb/compositonb_detonate_dist_03.wav"})
CustomizableWeaponry:addFireSound("CW_KK_INS2_DOI_C4_US_ENT_DETONATE_D2", {"weapons/compositonb/compositonb_detonate_far_dist_01.wav", "weapons/compositonb/compositonb_detonate_far_dist_02.wav", "weapons/compositonb/compositonb_detonate_far_dist_03.wav"})
CustomizableWeaponry:addFireSound("CW_KK_INS2_DOI_C4_US_ENT_DETONATE_WATER", {"weapons/compositonb/water/compositonb_water_detonate_01.wav", "weapons/compositonb/water/compositonb_water_detonate_02.wav", "weapons/compositonb/water/compositonb_water_detonate_03.wav"})
CustomizableWeaponry:addFireSound("CW_KK_INS2_DOI_C4_US_ENT_DETONATE_WATER_D1", {"weapons/compositonb/water/compositonb_water_detonate_dist_01.wav", "weapons/compositonb/water/compositonb_water_detonate_dist_02.wav", "weapons/compositonb/water/compositonb_water_detonate_dist_03.wav"})

ENT.db = {
	cw_kk_ins2_projectile_at4 = {
		effectClass = "cw_kk_ins2_explosion_rpg",
		explosionSound0 = "CW_KK_INS2_RPG_ENT_DETONATE",
		explosionSound1 = "CW_KK_INS2_RPG_ENT_DETONATE_D1",
		explosionSound2 = "CW_KK_INS2_RPG_ENT_DETONATE_D2",
		explosionSoundW0 = "CW_KK_INS2_RPG_ENT_DETONATE_WATER",
		explosionSoundW1 = "CW_KK_INS2_RPG_ENT_DETONATE_WATER_D1",
		explosionParticles = {
			-- "ins_rpg_explosion", // too much nearglow

			"ins_grenade_explosion_shockwave",
			"ins_rpg_explosion_smoke_c",
			"generic_crater_smoke",
			"ins_rpg_explosion_debris",
			"ins_rpg_explosion_smoke",
			"ins_rpg_inner_explosion",
			"ins_rpg_explosion_spikes",
			"ins_rpg_explosion_smoke_b",
			"ins_rpg_explosion_sparks",
			"ins_rpg_explosion_debris",
			"ins_grenade_explosion_smoke_ground_c",
			"ins_grenade_inner_explosion_debris",
			"ins_rpg_flash",
			"ins_rpg_flash_b",
			-- "generic_nearglow",
			"ins_rpg_explosion_flames",
			"ins_rpg_glow",
			"ins_c4_explosion_sparks_burst",
		},
		explosionParticlesWater = {
			"ins_Water_explosion"
		}
	},

	cw_kk_ins2_projectile_c4 = {
		effectClass = "cw_kk_ins2_explosion_c4",
		explosionSound0 = "CW_KK_INS2_C4_ENT_DETONATE",
		explosionSound1 = "CW_KK_INS2_C4_ENT_DETONATE_D1",
		explosionSound2 = "CW_KK_INS2_C4_ENT_DETONATE_D2",
		explosionSoundW0 = "CW_KK_INS2_C4_ENT_DETONATE_WATER",
		explosionSoundW1 = "CW_KK_INS2_C4_ENT_DETONATE_WATER_D1",
		explosionParticles = {
			-- "ins_c4_explosion", // too much generic_nearglow

			"generic_crater_smoke_big",
			"ins_c4_explosion_shockwave",
			"ins_grenade_explosion_smoke",
			"ins_c4_explosion_smoke_d",
			"ins_c4_explosion_debris",
			"ins_c4_explosion_smoke_c",
			"ins_c4_explosion_spikes",
			"ins_c4_explosion_flames_b",
			"ins_c4_explosion_spikes_d",
			"ins_c4_explosion_smoke_thin",
			"ins_c4_explosion_debris",
			"ins_c4_flash",
			-- "generic_nearglow",
			"ins_c4_explosion_smoke_thin_b",
			"ins_c4_explosion_smoke_ground_c",
			"ins_c4_explosion_flames",
			"ins_c4_inner_explosion",
			"ins_c4_explosion_sparks_b",
			"ins_c4_explosion_sparks",
		},
		explosionParticlesWater = {
			"ins_Water_explosion"
		}
	},

	cw_kk_ins2_projectile_frag = {
		effectClass = "cw_kk_ins2_explosion_frag",
		explosionSound0 = "CW_KK_INS2_FRAG_ENT_DETONATE",
		explosionSound1 = "CW_KK_INS2_FRAG_ENT_DETONATE_D1",
		explosionSound2 = "CW_KK_INS2_FRAG_ENT_DETONATE_D2",
		explosionSoundW0 = "CW_KK_INS2_FRAG_ENT_DETONATE_WATER",
		explosionSoundW1 = "CW_KK_INS2_FRAG_ENT_DETONATE_WATER_D1",
		explosionParticles = {
			-- "ins_grenade_explosion", // consists of all below

			"generic_crater_smoke",
			"ins_grenade_explosion_shockwave",
			"ins_grenade_explosion_spikes_b",
			"ins_grenade_explosion_spikes",
			"ins_grenade_explosion_smoke",
			"ins_grenade_explosion_smoke_thick",
			"ins_grenade_explosion_smoke_thick_b",
			"ins_grenade_explosion_spikes_b",
			"ins_grenade_inner_explosion",
			"ins_grenade_explosion_flames_b",
			"ins_grenade_explosion_smoke_ground_c",
			"ins_grenade_explosion_sparks",
			"ins_grenade_inner_explosion_debris",
			"ins_grenade_explosion_flames",
			"ins_grenade_flash",
			-- "generic_nearglow", // looks orange in GM
		},
		explosionParticlesWater = {
			"ins_water_explosion"
		}
	},

	cw_kk_ins2_projectile_m84 = {
		effectClass = "cw_kk_ins2_explosion_flash",
		explosionSound0 = "CW_KK_INS2_M84_ENT_DETONATE",
		explosionSound1 = "CW_KK_INS2_M84_ENT_DETONATE_D1",
		explosionSound2 = "CW_KK_INS2_M84_ENT_DETONATE_D2",
		explosionSoundW0 = "",
		explosionSoundW1 = "",
		explosionParticles = {
			-- "ins_flashbang_explosion", // too much nearglow

			"ins_flashbang_explosion_smoke",
			"ins_flashbang_explosion_sparks",
			"ins_flashbang_inner_explosion",
			"ins_flashbang_explosion_sparks_b",
			"ins_flashbang_flash",
			"generic_nearglow",
			-- "generic_nearglow_b",
		},
		explosionParticlesWater = {
			"ins_water_explosion",
		}
	},

	cw_kk_ins2_projectile_molotov = {
		followProjectile = true,
		effectClass = "cw_kk_ins2_explosion_molotov",
		explosionSound0 = "CW_KK_INS2_MOLOTOV_ENT_DETONATE",
		explosionSound1 = "",
		explosionSound2 = "",
		explosionSoundW0 = "",
		explosionSoundW1 = "",
		explosionParticles = {
			-- "doi_wpgrenade_explosion",
			-- "doi_smoke_artillery",
			-- "ins_molotov_explosion",

			"ins_molotov_smoke",
			"ins_molotov_flame_b",
			"ins_molotov_flamewave",
			"ins_molotov_burst_b",
			"ins_molotov_burst_glass",
			"ins_molotov_trailers",
			"ins_molotov_burst_flame",
			"ins_molotov_burst",
			"ins_molotov_trails",
			// "ins_molotov_glow",
			"ins_molotov_flash",
		},
		explosionParticlesWater = {
			"ins_molotov_explosion",
		}
	},

	cw_kk_ins2_projectile_anm14 = {
		followProjectile = true,
		effectClass = "cw_kk_ins2_explosion_molotov",
		explosionSound0 = "CW_KK_INS2_ANM14_ENT_DETONATE",
		explosionSound1 = "",
		explosionSound2 = "",
		explosionSoundW0 = "",
		explosionSoundW1 = "",
		explosionParticles = {
			-- "ins_thermite_explosion", // too pink

			"ins_thermite_smoke_c",
			"ins_thermite_smoke_b",
			"ins_thermite_smoke",
			"ins_thermite_flame_c",
			"ins_thermite_sparks_b",
			"ins_thermite_burst",
			// "ins_thermite_glow",
			"ins_thermite_flame_sparks",

		},
		explosionParticlesWater = {
			"ins_thermite_smoke_c",
			"ins_thermite_smoke_b",
			"ins_thermite_smoke",
			"ins_thermite_flame_c",
			"ins_thermite_sparks_b",
			"ins_thermite_burst",
			-- "ins_thermite_glow",
			"ins_thermite_flame_sparks",
		}
	},

	cw_kk_ins2_projectile_m18 = {
		followProjectile = true,
		effectClass = "cw_kk_ins2_explosion_smoke",
		explosionSound0 = "CW_KK_INS2_M18_ENT_DETONATE",
		explosionSound1 = "",
		explosionSound2 = "",
		explosionSoundW0 = "",
		explosionSoundW1 = "",
		explosionParticles = {
			"ins_smokegrenade",
		},
		explosionParticlesWater = {}
	},

	// DOI

	cw_kk_ins2_projectile_m6a1 = {
		effectClass = "cw_kk_ins2_explosion_rpg",
		explosionSound0 = "CW_KK_INS2_DOI_M6A1_ENT_DETONATE",
		explosionSound1 = "CW_KK_INS2_DOI_M6A1_ENT_DETONATE_D1",
		explosionSound2 = "CW_KK_INS2_DOI_M6A1_ENT_DETONATE_D2",
		explosionSoundW0 = "CW_KK_INS2_DOI_M6A1_ENT_DETONATE_WATER",
		explosionSoundW1 = "CW_KK_INS2_DOI_M6A1_ENT_DETONATE_WATER_D1",
	},

	cw_kk_ins2_projectile_m10 = {
		effectClass = "cw_kk_ins2_explosion_smoke",
		explosionSound0 = "CW_KK_INS2_DOI_M10A1_ENT_DETONATE",
		explosionSound1 = "CW_KK_INS2_DOI_M10A1_ENT_DETONATE_D1",
		explosionSound2 = "CW_KK_INS2_DOI_M10A1_ENT_DETONATE_D2",
		explosionSoundW0 = "CW_KK_INS2_DOI_M6A1_ENT_DETONATE_WATER",
		explosionSoundW1 = "CW_KK_INS2_DOI_M6A1_ENT_DETONATE_WATER_D1",
		explosionParticles = {
			"doi_wpgrenade_explosion",
		},
		explosionParticlesWater = {}
	},

	cw_kk_ins2_projectile_piat = {
		effectClass = "cw_kk_ins2_explosion_rpg",
		explosionSound0 = "CW_KK_INS2_DOI_PIAT_ENT_DETONATE",
		explosionSound1 = "CW_KK_INS2_DOI_PIAT_ENT_DETONATE_D1",
		explosionSound2 = "CW_KK_INS2_DOI_PIAT_ENT_DETONATE_D2",
		explosionSoundW0 = "CW_KK_INS2_DOI_PIAT_ENT_DETONATE_WATER",
		explosionSoundW1 = "CW_KK_INS2_DOI_PIAT_ENT_DETONATE_WATER_D1"
	},

	cw_kk_ins2_projectile_pf60 = {
		effectClass = "cw_kk_ins2_explosion_rpg",
		explosionSound0 = "CW_KK_INS2_DOI_PANZERFAUST_ENT_DETONATE",
		explosionSound1 = "CW_KK_INS2_DOI_PANZERFAUST_ENT_DETONATE_D1",
		explosionSound2 = "CW_KK_INS2_DOI_PANZERFAUST_ENT_DETONATE_D2",
		explosionSoundW0 = "CW_KK_INS2_DOI_PANZERFAUST_ENT_DETONATE_WATER",
		explosionSoundW1 = "CW_KK_INS2_DOI_PANZERFAUST_ENT_DETONATE_WATER_D1"
	},

	cw_kk_ins2_projectile_shrek = {
		effectClass = "cw_kk_ins2_explosion_rpg",
		explosionSound0 = "CW_KK_INS2_DOI_SHREK_ENT_DETONATE",
		explosionSound1 = "CW_KK_INS2_DOI_SHREK_ENT_DETONATE_D1",
		explosionSound2 = "CW_KK_INS2_DOI_SHREK_ENT_DETONATE_D2",
		explosionSoundW0 = "CW_KK_INS2_DOI_SHREK_ENT_DETONATE_WATER",
		explosionSoundW1 = "CW_KK_INS2_DOI_SHREK_ENT_DETONATE_WATER_D1"
	},

	cw_kk_ins2_projectile_n69 = {
		effectClass = "cw_kk_ins2_explosion_frag",
		explosionSound0 = "CW_KK_INS2_DOI_N69_ENT_DETONATE",
		explosionSound1 = "CW_KK_INS2_DOI_N69_ENT_DETONATE_D1",
		explosionSound2 = "CW_KK_INS2_DOI_N69_ENT_DETONATE_D2",
		explosionSoundW0 = "CW_KK_INS2_DOI_N69_ENT_DETONATE_WATER",
		explosionSoundW1 = "CW_KK_INS2_DOI_N69_ENT_DETONATE_WATER_D1",
		explosionParticles = {
			"doi_grenade_explosion",
			-- "doi_frag_explosion",
			-- "doi_mortar_explosion",
		},
		explosionParticlesWater = {
			"ins_water_explosion"
		}
	},

	cw_kk_ins2_projectile_n76 = {
		followProjectile = true,
		effectClass = "cw_kk_ins2_explosion_smoke",
		explosionSound0 = "CW_KK_INS2_DOI_N76_ENT_DETONATE",
		explosionSound1 = "",
		explosionSound2 = "",
		explosionSoundW0 = "",
		explosionSoundW1 = "",
		explosionParticles = {
			"doi_wpgrenade_explosion",
		},
		explosionParticlesWater = {}
	},

	cw_kk_ins2_projectile_n77 = {
		effectClass = "cw_kk_ins2_explosion_smoke",
		explosionSound0 = "CW_KK_INS2_DOI_N77_ENT_DETONATE",
		explosionSound1 = "",
		explosionSound2 = "",
		explosionSoundW0 = "",
		explosionSoundW1 = "",
		explosionParticles = {
			"ins_smokegrenade",
		},
		explosionParticlesWater = {}
	},

	cw_kk_ins2_projectile_ied = {
		effectClass = "cw_kk_ins2_explosion_c4",
		explosionSound0 = "CW_KK_INS2_IED_ENT_DETONATE",
		explosionSound1 = "CW_KK_INS2_IED_ENT_DETONATE_D1",
		explosionSound2 = "CW_KK_INS2_IED_ENT_DETONATE_D2",
		explosionSoundW0 = "CW_KK_INS2_IED_ENT_DETONATE_WATER",
		explosionSoundW1 = "CW_KK_INS2_IED_ENT_DETONATE_WATER_D1",
		explosionParticles = {
			-- "ins_c4_explosion", // too much generic_nearglow

			"generic_crater_smoke_big",
			"ins_c4_explosion_shockwave",
			"ins_grenade_explosion_smoke",
			"ins_c4_explosion_smoke_d",
			"ins_c4_explosion_debris",
			"ins_c4_explosion_smoke_c",
			"ins_c4_explosion_spikes",
			"ins_c4_explosion_flames_b",
			"ins_c4_explosion_spikes_d",
			"ins_c4_explosion_smoke_thin",
			"ins_c4_explosion_debris",
			"ins_c4_flash",
			-- "generic_nearglow",
			"ins_c4_explosion_smoke_thin_b",
			"ins_c4_explosion_smoke_ground_c",
			"ins_c4_explosion_flames",
			"ins_c4_inner_explosion",
			"ins_c4_explosion_sparks_b",
			"ins_c4_explosion_sparks",
		},
		explosionParticlesWater = {
			"ins_Water_explosion"
		}
	},

	cw_kk_ins2_projectile_ww2_c4_de = {
		effectClass = "cw_kk_ins2_explosion_c4",
		explosionSound0 = "CW_KK_INS2_DOI_C4_DE_ENT_DETONATE",
		explosionSound1 = "CW_KK_INS2_DOI_C4_DE_ENT_DETONATE_D1",
		explosionSound2 = "CW_KK_INS2_DOI_C4_DE_ENT_DETONATE_D2",
		explosionSoundW0 = "CW_KK_INS2_DOI_C4_DE_ENT_DETONATE_WATER",
		explosionSoundW1 = "CW_KK_INS2_DOI_C4_DE_ENT_DETONATE_WATER_D1",
		explosionParticles = {
			"doi_compB_explosion",
		},
		explosionParticlesWater = {
			"ins_Water_explosion"
		}
	},

	cw_kk_ins2_projectile_ww2_c4_us = {
		effectClass = "cw_kk_ins2_explosion_c4",
		explosionSound0 = "CW_KK_INS2_DOI_C4_US_ENT_DETONATE",
		explosionSound1 = "CW_KK_INS2_DOI_C4_US_ENT_DETONATE_D1",
		explosionSound2 = "CW_KK_INS2_DOI_C4_US_ENT_DETONATE_D2",
		explosionSoundW0 = "CW_KK_INS2_DOI_C4_US_ENT_DETONATE_WATER",
		explosionSoundW1 = "CW_KK_INS2_DOI_C4_US_ENT_DETONATE_WATER_D1",
		explosionParticles = {
			"doi_compB_explosion",
		},
		explosionParticlesWater = {
			"ins_Water_explosion"
		}
	},

	cw_kk_ins2_projectile_molotov_doi = {
		followProjectile = true,
		effectClass = "cw_kk_ins2_explosion_molotov",
		explosionSound0 = "CW_KK_INS2_ANM14_ENT_DETONATE",
		explosionSound1 = "",
		explosionSound2 = "",
		explosionSoundW0 = "",
		explosionSoundW1 = "",
		explosionParticles = {
			-- "doi_wpgrenade_explosion",
			-- "doi_smoke_artillery",
			-- "ins_molotov_explosion",

			"ins_molotov_smoke",
			"ins_molotov_flame_b",
			"ins_molotov_flamewave",
			"ins_molotov_burst_b",
			"ins_molotov_burst_glass",
			"ins_molotov_trailers",
			"ins_molotov_burst_flame",
			"ins_molotov_burst",
			"ins_molotov_trails",
			// "ins_molotov_glow",
			"ins_molotov_flash",
		},
		explosionParticlesWater = {
			"ins_molotov_explosion",
		}
	},
}

ENT.db.cw_kk_ins2_projectile_rpg = ENT.db.cw_kk_ins2_projectile_at4

ENT.db.cw_kk_ins2_projectile_m6a1.explosionParticles = ENT.db.cw_kk_ins2_projectile_at4.explosionParticles
ENT.db.cw_kk_ins2_projectile_m6a1.explosionParticlesWater = ENT.db.cw_kk_ins2_projectile_at4.explosionParticlesWater

ENT.db.cw_kk_ins2_projectile_piat.explosionParticles = ENT.db.cw_kk_ins2_projectile_at4.explosionParticles
ENT.db.cw_kk_ins2_projectile_piat.explosionParticlesWater = ENT.db.cw_kk_ins2_projectile_at4.explosionParticlesWater

ENT.db.cw_kk_ins2_projectile_pf60.explosionParticles = ENT.db.cw_kk_ins2_projectile_at4.explosionParticles
ENT.db.cw_kk_ins2_projectile_pf60.explosionParticlesWater = ENT.db.cw_kk_ins2_projectile_at4.explosionParticlesWater

ENT.db.cw_kk_ins2_projectile_shrek.explosionParticles = ENT.db.cw_kk_ins2_projectile_at4.explosionParticles
ENT.db.cw_kk_ins2_projectile_shrek.explosionParticlesWater = ENT.db.cw_kk_ins2_projectile_at4.explosionParticlesWater

function ENT:SetupDataTables()
	self:NetworkVar("Int", 0, "ProjectileClass")
end

local i = 1
ENT._dbInt2str = {}
ENT._dbStr2int = {}

local pcft = {"explosionParticles", "explosionParticlesWater"}

for class,tweakData in pairs(ENT.db) do
	ENT._dbInt2str[i] = class
	ENT._dbStr2int[class] = i
	i = i + 1

	for _,pcfs in pairs(pcft) do
		for _,p in pairs(tweakData[pcfs]) do
			PrecacheParticleSystem(p)
		end
	end
end

function ENT:getTweakData()
	local i = self:GetProjectileClass()
	local class = self._dbInt2str[i]

	return self.db[class]
end

function ENT:OnRemove()
	self:StopParticles()
	return false
end
