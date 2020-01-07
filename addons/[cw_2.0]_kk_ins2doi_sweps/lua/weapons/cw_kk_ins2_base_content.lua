if not CustomizableWeaponry then return end

AddCSLuaFile()

// SHARED SOUNDS
do
	CustomizableWeaponry:addRegularSound("CW_KK_INS2_UNIVERSAL_DRAW", {"weapons/universal/uni_weapon_draw_01.wav", "weapons/universal/uni_weapon_draw_02.wav", "weapons/universal/uni_weapon_draw_03.wav"})
	CustomizableWeaponry:addRegularSound("CW_KK_INS2_UNIVERSAL_HOLSTER", "weapons/universal/uni_weapon_holster.wav")

	CustomizableWeaponry:addRegularSound("CW_KK_INS2_UNIVERSAL_PISTOL_DRAW", {"weapons/universal/uni_pistol_draw_01.wav", "weapons/universal/uni_pistol_draw_02.wav", "weapons/universal/uni_pistol_draw_03.wav"})
	CustomizableWeaponry:addRegularSound("CW_KK_INS2_UNIVERSAL_PISTOL_HOLSTER", "weapons/universal/uni_pistol_holster.wav")

	CustomizableWeaponry:addRegularSound("CW_KK_INS2_UNIVERSAL_GRENADE_DRAW", {"weapons/universal/uni_grenade_draw_01.wav", "weapons/universal/uni_grenade_draw_02.wav", "weapons/universal/uni_grenade_draw_03.wav"})
	CustomizableWeaponry:addRegularSound("CW_KK_INS2_UNIVERSAL_GRENADE_HOLSTER", "weapons/universal/uni_grenade_holster.wav")

	CustomizableWeaponry:addRegularSound("CW_KK_INS2_UNIVERSAL_BIPOD_DEPLOYSTART", "weapons/universal/uni_bipoddeploy_start.wav")
	CustomizableWeaponry:addRegularSound("CW_KK_INS2_UNIVERSAL_BIPOD_DEPLOYEND", "weapons/universal/uni_bipoddeploy_end.wav")
	CustomizableWeaponry:addRegularSound("CW_KK_INS2_UNIVERSAL_BIPOD_RETRACT", "weapons/universal/uni_bipodretract.wav")
	CustomizableWeaponry:addRegularSound("CW_KK_INS2_UNIVERSAL_BIPOD_SWIVEL", {"weapons/universal/uni_bipod_swivel_01.wav", "weapons/universal/uni_bipod_swivel_02.wav", "weapons/universal/uni_bipod_swivel_03.wav", "weapons/universal/uni_bipod_swivel_04.wav", "weapons/universal/uni_bipod_swivel_05.wav"})

	CustomizableWeaponry:addRegularSound("CW_KK_INS2_UNIVERSAL_LEFTCRAWL", {"weapons/universal/uni_crawl_l_01.wav", "weapons/universal/uni_crawl_l_02.wav", "weapons/universal/uni_crawl_l_02.wav", "weapons/universal/uni_crawl_l_04.wav", "weapons/universal/uni_crawl_l_05.wav", "weapons/universal/uni_crawl_l_06.wav"})
	CustomizableWeaponry:addRegularSound("CW_KK_INS2_UNIVERSAL_RIGHTCRAWL", {"weapons/universal/uni_crawl_r_01.wav", "weapons/universal/uni_crawl_r_02.wav", "weapons/universal/uni_crawl_r_03.wav", "weapons/universal/uni_crawl_r_04.wav", "weapons/universal/uni_crawl_r_05.wav", "weapons/universal/uni_crawl_r_06.wav"})
	CustomizableWeaponry:addRegularSound("CW_KK_INS2_UNIVERSAL_LEANIN", { "weapons/universal/uni_lean_in_01.wav", "weapons/universal/uni_lean_in_02.wav", "weapons/universal/uni_lean_in_03.wav", "weapons/universal/uni_lean_in_04.wav"})
	CustomizableWeaponry:addRegularSound("CW_KK_INS2_UNIVERSAL_LEANOUT", { "weapons/universal/uni_lean_out_01.wav", "weapons/universal/uni_lean_out_02.wav", "weapons/universal/uni_lean_out_03.wav", "weapons/universal/uni_lean_out_04.wav"})
	CustomizableWeaponry:addRegularSound("CW_KK_INS2_UNIVERSAL_WEAPONLOWER", "weapons/universal/uni_weapon_lower_01.wav")

	CustomizableWeaponry:addFireSound("CW_KK_INS2_KNIFE", "weapons/knife/knife_slash_01.wav", 1, 70, CHAN_STATIC)

	CustomizableWeaponry:addReloadSound("CW_KK_INS2_GL_BEGINRELOAD", {"weapons/universal/uni_gl_beginreload_01.wav", "weapons/universal/uni_gl_beginreload_02.wav", "weapons/universal/uni_gl_beginreload_03.wav"})

	// M203
	CustomizableWeaponry:addFireSound("CW_KK_INS2_M203_FIRE", "weapons/m203/m203_fp.wav", 1, 105, CHAN_STATIC)
	CustomizableWeaponry:addReloadSound("CW_KK_INS2_M203_CLOSEBARREL", "weapons/m203/handling/m203_closebarrel.wav")
	CustomizableWeaponry:addReloadSound("CW_KK_INS2_M203_DESELECT", "weapons/m203/handling/m203_deselect.wav")
	CustomizableWeaponry:addReloadSound("CW_KK_INS2_M203_EMPTY", "weapons/m203/handling/m203_empty.wav")
	CustomizableWeaponry:addReloadSound("CW_KK_INS2_M203_INSERTGRENADE", {"weapons/m203/handling/m203_insertgrenade_01.wav", "weapons/m203/handling/m203_insertgrenade_02.wav"})
	CustomizableWeaponry:addReloadSound("CW_KK_INS2_M203_OPENBARREL", "weapons/m203/handling/m203_openbarrel.wav")
	CustomizableWeaponry:addReloadSound("CW_KK_INS2_M203_SELECT", "weapons/m203/handling/m203_select.wav")

	// GP30
	CustomizableWeaponry:addFireSound("CW_KK_INS2_GP30_FIRE", "weapons/gp30/gp30_fp.wav", 1, 105, CHAN_STATIC)
	CustomizableWeaponry:addReloadSound("CW_KK_INS2_GP30_DESELECT", "weapons/gp30/handling/gp30_deselect.wav")
	CustomizableWeaponry:addReloadSound("CW_KK_INS2_GP30_EMPTY", "weapons/gp30/handling/gp30_empty.wav")
	CustomizableWeaponry:addReloadSound("CW_KK_INS2_GP30_INSERTGRENADE", {"weapons/gp30/handling/gp30_insertgrenade_01.wav", "weapons/gp30/handling/gp30_insertgrenade_02.wav"})
	CustomizableWeaponry:addReloadSound("CW_KK_INS2_GP30_INSERTGRENADECLICK", "weapons/gp30/handling/gp30_insertgrenade_click.wav")
	CustomizableWeaponry:addReloadSound("CW_KK_INS2_GP30_SELECT", "weapons/gp30/handling/gp30_select.wav")

	CustomizableWeaponry:addReloadSound("CW_KK_INS2_SHELL_SPLASH", "cw_kk_ins2/bms/water_foot_exit1.wav")
end
// SHELLS
do
	CustomizableWeaponry:addRegularSound("CW_KK_INS2_SHELL_38", {"weapons/bullets/shells/concrete/38_shell_concrete_01.wav", "weapons/bullets/shells/concrete/38_shell_concrete_02.wav", "weapons/bullets/shells/concrete/38_shell_concrete_03.wav", "weapons/bullets/shells/concrete/38_shell_concrete_04.wav", "weapons/bullets/shells/concrete/38_shell_concrete_05.wav", "weapons/bullets/shells/concrete/38_shell_concrete_06.wav"}, 65)
	CustomizableWeaponry:addRegularSound("CW_KK_INS2_SHELL_9MM", {"weapons/bullets/shells/concrete/9mm_shell_concrete_01.wav", "weapons/bullets/shells/concrete/9mm_shell_concrete_02.wav", "weapons/bullets/shells/concrete/9mm_shell_concrete_03.wav", "weapons/bullets/shells/concrete/9mm_shell_concrete_04.wav", "weapons/bullets/shells/concrete/9mm_shell_concrete_05.wav", "weapons/bullets/shells/concrete/9mm_shell_concrete_06.wav"}, 65)
	CustomizableWeaponry:addRegularSound("CW_KK_INS2_SHELL_FLARE", {"weapons/bullets/shells/concrete/flare_shell_concrete_01.wav", "weapons/bullets/shells/concrete/flare_shell_concrete_02.wav", "weapons/bullets/shells/concrete/flare_shell_concrete_03.wav", "weapons/bullets/shells/concrete/flare_shell_concrete_04.wav"}, 65)
	CustomizableWeaponry:addRegularSound("CW_KK_INS2_SHELL_M203", {"weapons/bullets/shells/concrete/m203_shell_concrete_01.wav", "weapons/bullets/shells/concrete/m203_shell_concrete_02.wav", "weapons/bullets/shells/concrete/m203_shell_concrete_03.wav", "weapons/bullets/shells/concrete/m203_shell_concrete_04.wav"}, 65)
	CustomizableWeaponry:addRegularSound("CW_KK_INS2_SHELL_LINK", {"weapons/bullets/shells/concrete/m249_link_concrete_01.wav", "weapons/bullets/shells/concrete/m249_link_concrete_02.wav", "weapons/bullets/shells/concrete/m249_link_concrete_03.wav", "weapons/bullets/shells/concrete/m249_link_concrete_04.wav", "weapons/bullets/shells/concrete/m249_link_concrete_05.wav", "weapons/bullets/shells/concrete/m249_link_concrete_06.wav", "weapons/bullets/shells/concrete/m249_link_concrete_07.wav", "weapons/bullets/shells/concrete/m249_link_concrete_08.wav"}, 65)
	CustomizableWeaponry:addRegularSound("CW_KK_INS2_SHELL_12G", {"weapons/bullets/shells/concrete/shotgun_shell_concrete_01.wav", "weapons/bullets/shells/concrete/shotgun_shell_concrete_02.wav", "weapons/bullets/shells/concrete/shotgun_shell_concrete_03.wav", "weapons/bullets/shells/concrete/shotgun_shell_concrete_04.wav", "weapons/bullets/shells/concrete/shotgun_shell_concrete_05.wav", "weapons/bullets/shells/concrete/shotgun_shell_concrete_06.wav"}, 65)

	if CLIENT then
		local convertedSounds = {}
		local allMaterials = ""
/*
		hook.Add("InitPostEntity", "CW_KK_INS2_INIT_PHYSMAT", function()
			print("initializing physmats:", allMaterials)
			physenv.AddSurfaceData(allMaterials)
		end)
*/
		function CustomizableWeaponry.shells:addNew_KKINS2(name, model, sound, BBoxMins, BBoxMaxs)
/*			if not convertedSounds[sound] then

				allMaterials = [[
"]] .. sound .. [["
{
	"impacthard"	"]] .. sound .. [["
	"impactsoft"	"]] .. sound .. [["

	"audiohardnessfactor" "0.0"
	"audioroughnessfactor" "0.0"

	"scrapeRoughThreshold" "1.0"
	"impactHardThreshold" "1.0"
}

]] .. allMaterials

				convertedSounds[sound] = true
			end
*/
			self.cache[name] = {
				m = model,
				s = sound,
				bbmin = BBoxMins,
				bbmax = BBoxMaxs
			}
		end

		CustomizableWeaponry.shells:addNew_KKINS2("KK_INS2_12guage", "models/weapons/shells/12guage.mdl", "CW_KK_INS2_SHELL_12G", Vector(-0.4, -1.2, -0.4), Vector(0.4, 1.2, 0.4))
		CustomizableWeaponry.shells:addNew_KKINS2("KK_INS2_40mm", "models/weapons/shells/40mm.mdl", "CW_KK_INS2_SHELL_M203", Vector(-0.8, -0.8, 0), Vector(0.8, 0.8, 2))
		CustomizableWeaponry.shells:addNew_KKINS2("KK_INS2_45apc", "models/weapons/shells/45apc.mdl", "CW_KK_INS2_SHELL_38", Vector(-0.25, -0.5, -0.25), Vector(0.25, 0.5, 0.25))
		CustomizableWeaponry.shells:addNew_KKINS2("KK_INS2_545x39", "models/weapons/shells/545x39.mdl", "CW_KK_INS2_SHELL_38", Vector(-0.25, -1.15, -0.25), Vector(0.25, 1.15, 0.25))
		CustomizableWeaponry.shells:addNew_KKINS2("KK_INS2_556x45", "models/weapons/shells/556x45.mdl", "CW_KK_INS2_SHELL_38", Vector(-0.2, -1, -0.2), Vector(0.2, 1, 0.2))
		CustomizableWeaponry.shells:addNew_KKINS2("KK_INS2_556x45_link", "models/weapons/shells/556x45_link.mdl", "CW_KK_INS2_SHELL_LINK", Vector(-0.65, -0.5, -0.25), Vector(0.9, 0.55, 0.25))
		CustomizableWeaponry.shells:addNew_KKINS2("KK_INS2_762x33", "models/weapons/shells/762x33.mdl", "CW_KK_INS2_SHELL_38", Vector(-0.15, -0.5, -0.15), Vector(0.15, 0.5, 0.15))
		CustomizableWeaponry.shells:addNew_KKINS2("KK_INS2_762x39", "models/weapons/shells/762x39.mdl", "CW_KK_INS2_SHELL_38", Vector(-0.2, -0.9, -0.2), Vector(0.2, 0.9, 0.2))
		CustomizableWeaponry.shells:addNew_KKINS2("KK_INS2_762x51", "models/weapons/shells/762x51.mdl", "CW_KK_INS2_SHELL_38", Vector(-0.25, -1.25, -0.25), Vector(0.25, 1.25, 0.25))
		CustomizableWeaponry.shells:addNew_KKINS2("KK_INS2_762x54", "models/weapons/shells/762x54.mdl", "CW_KK_INS2_SHELL_38", Vector(-0.25, -1.25, -0.25), Vector(0.25, 1.25, 0.25))
		CustomizableWeaponry.shells:addNew_KKINS2("KK_INS2_9x19", "models/weapons/shells/9x19.mdl", "CW_KK_INS2_SHELL_38", Vector(-0.2, -0.4, -0.2), Vector(0.2, 0.4, 0.2))

		CustomizableWeaponry.shells:addNew_KKINS2("KK_INS2_SPOON", "models/weapons/w_gren_spoon.mdl", "CW_KK_INS2_SHELL_M203")

		CustomizableWeaponry.shells:addNew_KKINS2("KK_INS2_GARAND", "models/weapons/shells/garand_clip.mdl", "CW_KK_INS2_SHELL_M203", Vector(-0.55, -0.45, -0.85), Vector(0.55, 0.45, 0.85))
		CustomizableWeaponry.shells:addNew_KKINS2("KK_INS2_REVOLVER", "models/weapons/upgrades/a_speedloader_rev.mdl", "CW_KK_INS2_SHELL_12G", Vector(-0.8, -0.55, -0.55), Vector(0.25, 0.55, 0.55))

		// models/weapons/w_at4.mdl Vector(-33, -3, -1), Vector(9.5, 3, 5)

		CustomizableWeaponry:addRegularSound("CW_KK_CSS_SHELL_M72", "weapons/cw_kk_css_m72/law_shell.wav", 65)
		CustomizableWeaponry.shells:addNew_KKINS2("KK_CSS_M72", "models/weapons/w_cw_kk_css_m72.mdl", "CW_KK_CSS_SHELL_M72", Vector(-18.5, -1.7, -0.2), Vector(18, 1, 2.5))
	end
end
// AMMO
do
	CustomizableWeaponry:registerAmmo(".30 Carbine", ".30 Carbine Rounds", 7.62, 32.76)
	CustomizableWeaponry:registerAmmo(".38 Special", ".38 Special Rounds", 9.1, 29.3)
	CustomizableWeaponry:registerAmmo(".357 Magnum", ".357 Magnum Rounds", 9.1, 33)
	CustomizableWeaponry:registerAmmo(".380 ACP", ".380 ACP Rounds", 9, 17.3)

	CustomizableWeaponry:registerAmmo(".22 LR", ".22 LR Rounds", 5.6, 15)
	CustomizableWeaponry:registerAmmo("4.6x30MM", "4.6x30MM Rounds", 4.6, 30)

	CustomizableWeaponry:registerAmmo(".30-06", ".30-06 Springfield Rounds", 7.62, 63.3)
	CustomizableWeaponry:registerAmmo("7.92x57MM", "7.92x57MM Mauser Rounds", 7.92, 57)
	CustomizableWeaponry:registerAmmo("7.92x33MM", "7.92x33MM Kurz Rounds", 7.92, 33)

	CustomizableWeaponry:registerAmmo(".32 ACP", "7.65x17MMSR Browning Rounds", 7.65, 17)
	CustomizableWeaponry:registerAmmo("7.62x25MM", "7.62x25MM Tokarev Rounds", 7.62, 25)

	-- CustomizableWeaponry:registerAmmo(".30-06 Springfield", ".30-06 Springfield Rounds", 7.62, 63.3)
	-- CustomizableWeaponry:registerAmmo("7.92x57MM Mauser", "7.92x57MM Mauser Rounds", 7.92, 57)
	-- CustomizableWeaponry:registerAmmo("7.92x33MM Kurz", "7.92x33MM Kurz Rounds", 7.92, 33)

	CustomizableWeaponry:registerAmmo("PG-7VM Grenade", "PG-7VM Grenades", 0, 0)
	CustomizableWeaponry:registerAmmo("AT4 Launcher", "AT4 Rocket Launchers", 0, 0)
	CustomizableWeaponry:registerAmmo("M6A1 Rocket", "M6A1 Rockets", 0, 0)
	CustomizableWeaponry:registerAmmo("M10A1 Rocket", "M10A1 WP Rockets", 0, 0)
	CustomizableWeaponry:registerAmmo("Panzerfaust", "Panzerfaust Rocket Launchers", 0, 0)

	CustomizableWeaponry:registerAmmo("25MM Flare", "25MM Flares", 0, 0)
	CustomizableWeaponry:registerAmmo("C4", "C4 explosives", 0, 0)
	CustomizableWeaponry:registerAmmo("IED", "Improvised explosives", 0, 0)
	CustomizableWeaponry:registerAmmo("Incendiary", "Incendiary explosives", 0, 0)
	CustomizableWeaponry:registerAmmo("M213 Flare", "Emergency Flares", 0, 0)
end
// FIREMODES
do
	CustomizableWeaponry.firemodes:registerFiremode("single", "SINGLE-SHOT", true, 1, 1)
	-- CustomizableWeaponry.firemodes:registerFiremode("throw", "THROWABLE", true, 1, 1)
end
// KILLS
if CLIENT then
	local killCol = Color(255, 80, 0, 150)
	local white = Color(255, 255, 255, 150)

	killicon.AddFont("cw_kk_ins2_damage_melee",		"CW_KillIcons", "j", killCol)
	killicon.AddFont("cw_kk_ins2_damage_phys",		"HL2MPTypeDeath", "9", killCol)

	killicon.AddFont("cw_kk_ins2_mel_bayonet",		"CW_KillIcons", "j", killCol)
	killicon.AddFont("cw_kk_ins2_mel_gurkha",		"CW_KillIcons", "j", killCol)

	killicon.AddFont("cw_kk_ins2_m9",				"CW_KillIcons", "a", killCol)
	killicon.AddFont("cw_kk_ins2_m45",				"CW_KillIcons", "a", killCol)
	killicon.AddFont("cw_kk_ins2_m1911",			"CW_KillIcons", "a", killCol)
	killicon.AddFont("cw_kk_ins2_makarov",			"CW_KillIcons", "a", killCol)
	killicon.AddFont("cw_kk_ins2_revolver",			"HL2MPTypeDeath", ".", killCol)

	killicon.AddFont("cw_kk_ins2_mp5k",				"CW_KillIcons", "x", killCol)
	killicon.AddFont("cw_kk_ins2_mp40",				"CW_KillIcons", "x", killCol)
	killicon.AddFont("cw_kk_ins2_sterling",			"CW_KillIcons", "x", killCol)
	killicon.AddFont("cw_kk_ins2_ump45",			"CW_KillIcons", "q", killCol)

	killicon.AddFont("cw_kk_ins2_ak74",				"CW_KillIcons", "b", killCol)
	killicon.AddFont("cw_kk_ins2_akm",				"CW_KillIcons", "b", killCol)
	killicon.AddFont("cw_kk_ins2_aks74u",			"CW_KillIcons", "b", killCol)
	killicon.AddFont("cw_kk_ins2_fnfal",			"CW_KillIcons", "i", killCol)
	killicon.AddFont("cw_kk_ins2_galil",			"CW_KillIcons", "v", killCol)
	killicon.AddFont("cw_kk_ins2_l1a1",				"CW_KillIcons", "i", killCol)
	killicon.AddFont("cw_kk_ins2_m1a1",				"CW_KillIcons", "o", killCol)
	killicon.AddFont("cw_kk_ins2_m1a1_para",		"CW_KillIcons", "o", killCol)
	killicon.AddFont("cw_kk_ins2_m4a1",				"CW_KillIcons", "w", killCol)
	-- killicon.AddFont("cw_kk_ins2_m14",			"CW_KillIcons", "i", white)
	killicon.AddFont("cw_kk_ins2_m14",				"CW_HUD22", "[M14 EBR]", white)
	killicon.AddFont("cw_kk_ins2_m16a4",			"CW_KillIcons", "w", killCol)
	killicon.AddFont("cw_kk_ins2_m40a1",			"CW_KillIcons", "r", killCol)
	killicon.AddFont("cw_kk_ins2_m249",				"CW_KillIcons", "z", killCol)
	killicon.AddFont("cw_kk_ins2_m590",				"CW_KillIcons", "k", killCol)
	killicon.AddFont("cw_kk_ins2_mini14",			"CW_KillIcons", "o", killCol)
	killicon.AddFont("cw_kk_ins2_mk18",				"CW_KillIcons", "w", killCol)
	killicon.AddFont("cw_kk_ins2_mosin",			"CW_KillIcons", "r", killCol)
	killicon.AddFont("cw_kk_ins2_rpk",				"CW_KillIcons", "b", killCol)
	killicon.AddFont("cw_kk_ins2_sks",				"CW_KillIcons", "o", killCol)
	killicon.AddFont("cw_kk_ins2_toz",				"CW_KillIcons", "k", killCol)

	killicon.AddFont("cw_kk_ins2_at4",				"HL2MPTypeDeath", "3", killCol)
	killicon.AddFont("cw_kk_ins2_p2a1",				"CW_KillIcons", "a", killCol)
	killicon.AddFont("cw_kk_ins2_rpg",				"HL2MPTypeDeath", "3", killCol)
	killicon.AddFont("cw_kk_ins2_nade_c4",			"CW_KillIcons", "I", killCol)
	killicon.AddFont("cw_kk_ins2_nade_ied",			"CW_KillIcons", "I", killCol)

	killicon.AddFont("cw_kk_ins2_gp25",				"HL2MPTypeDeath", "7", killCol)
	killicon.AddFont("cw_kk_ins2_rpg_pro",			"CW_KillIcons", "a", killCol)

	killicon.AddFont("cw_kk_ins2_projectile_anm14",	"CW_KillIcons", "Q", killCol)
	killicon.AddFont("cw_kk_ins2_projectile_at4",	"HL2MPTypeDeath", "3", killCol)
	killicon.AddFont("cw_kk_ins2_projectile_c4",	"CW_KillIcons", "I", killCol)
	killicon.AddFont("cw_kk_ins2_projectile_flare",	"CW_KillIcons", "a", killCol)
	killicon.AddFont("cw_kk_ins2_projectile_frag",	"CW_KillIcons", "h", killCol)
	killicon.AddFont("cw_kk_ins2_projectile_ied",	"CW_KillIcons", "I", killCol)
	killicon.AddFont("cw_kk_ins2_projectile_m18",	"CW_KillIcons", "Q", killCol)
	killicon.AddFont("cw_kk_ins2_projectile_m84",	"CW_KillIcons", "P", killCol)
	killicon.AddFont("cw_kk_ins2_projectile_molotov",	"CW_KillIcons", "Q", killCol)
	killicon.AddFont("cw_kk_ins2_projectile_rpg",	"HL2MPTypeDeath", "3", killCol)

	// ao5
	-- killicon.AddFont("cw_kk_ins2_ao5_revolver",		"HL2MPTypeDeath", ".", killCol)
	killicon.AddFont("cw_kk_ins2_ao5_revolver",		"HL2MPTypeDeath", "8", killCol)
	killicon.AddFont("cw_kk_ins2_ao5_br99",			"CW_KillIcons", "w", killCol)
	killicon.AddFont("cw_kk_ins2_ao5_m39",			"CW_KillIcons", "i", white)
	killicon.AddFont("cw_kk_ins2_ao5_m79",			"HL2MPTypeDeath", "7", killCol)

	// WS pack
	killicon.AddFont("cw_kk_ins2_mel_cstm_ninjato",	"CW_KillIcons", "j", killCol)

	killicon.AddFont("cw_kk_ins2_cstm_cobra",		"HL2MPTypeDeath", ".", killCol)
	killicon.AddFont("cw_kk_ins2_cstm_g19",			"CW_KillIcons", "c", killCol)
	killicon.AddFont("cw_kk_ins2_cstm_mateba",		"HL2MPTypeDeath", ".", killCol)

	killicon.AddFont("cw_kk_ins2_cstm_kriss",		"CW_KillIcons", "x", killCol)
	killicon.AddFont("cw_kk_ins2_cstm_mp5a4",		"CW_KillIcons", "x", killCol)
	killicon.AddFont("cw_kk_ins2_cstm_mp7",			"CW_KillIcons", "x", killCol)
	killicon.AddFont("cw_kk_ins2_cstm_sten",		"CW_KillIcons", "x", killCol)
	killicon.AddFont("cw_kk_ins2_cstm_uzi",			"CW_KillIcons", "l", killCol)

	killicon.AddFont("cw_kk_ins2_cstm_aug",			"CW_KillIcons", "e", killCol)
	killicon.AddFont("cw_kk_ins2_cstm_colt",		"CW_KillIcons", "w", killCol)
	killicon.AddFont("cw_kk_ins2_cstm_famas",		"CW_KillIcons", "t", killCol)
	killicon.AddFont("cw_kk_ins2_cstm_g36c",		"CW_KillIcons", "o", killCol)
	killicon.AddFont("cw_kk_ins2_cstm_galil_ace",	"CW_KillIcons", "v", killCol)
	killicon.AddFont("cw_kk_ins2_cstm_ksg",			"CW_KillIcons", "k", killCol)
	killicon.AddFont("cw_kk_ins2_cstm_l85",			"CW_KillIcons", "e", killCol)
	killicon.AddFont("cw_kk_ins2_cstm_m14",			"CW_KillIcons", "i", killCol)
	killicon.AddFont("cw_kk_ins2_cstm_m500",		"CW_KillIcons", "k", killCol)
	killicon.AddFont("cw_kk_ins2_cstm_scar",		"CW_KillIcons", "i", killCol)
	killicon.AddFont("cw_kk_ins2_cstm_spas12",		"CW_KillIcons", "k", killCol)

	// WW2 pack
	killicon.AddFont("cw_kk_ins2_ww2_k98kknife",	"CW_KillIcons", "j", killCol)

	killicon.AddFont("cw_kk_ins2_ww2_luger",		"CW_KillIcons", "a", killCol)
	killicon.AddFont("cw_kk_ins2_ww2_p38",			"CW_KillIcons", "a", killCol)
	killicon.AddFont("cw_kk_ins2_ww2_ppk",			"CW_KillIcons", "a", killCol)
	killicon.AddFont("cw_kk_ins2_ww2_m1911",		"CW_KillIcons", "a", killCol)

	killicon.AddFont("cw_kk_ins2_ww2_mp40",			"CW_KillIcons", "x", killCol)
	killicon.AddFont("cw_kk_ins2_ww2_thom",			"CW_KillIcons", "q", killCol)

	killicon.AddFont("cw_kk_ins2_ww2_k98k",			"CW_KillIcons", "r", killCol)
	killicon.AddFont("cw_kk_ins2_ww2_spring",		"CW_KillIcons", "r", killCol)
	killicon.AddFont("cw_kk_ins2_ww2_bar",			"CW_KillIcons", "i", killCol)
	killicon.AddFont("cw_kk_ins2_ww2_g43",			"CW_KillIcons", "i", killCol)
	killicon.AddFont("cw_kk_ins2_ww2_garand",		"CW_KillIcons", "i", killCol)
	killicon.AddFont("cw_kk_ins2_ww2_stg44",		"CW_KillIcons", "o", killCol)
	killicon.AddFont("cw_kk_ins2_ww2_browning",		"CW_KillIcons", "z", killCol)
	killicon.AddFont("cw_kk_ins2_ww2_mg42",			"CW_KillIcons", "z", killCol)
	killicon.AddFont("cw_kk_ins2_ww2_m1",			"CW_KillIcons", "o", killCol)
	killicon.AddFont("cw_kk_ins2_ww2_pump",			"CW_KillIcons", "k", killCol)

	killicon.AddFont("cw_kk_ins2_ww2_bazoo",		"HL2MPTypeDeath", "3", killCol)
	killicon.AddFont("cw_kk_ins2_ww2_frag_de",		"CW_KillIcons", "e", killCol)
	killicon.AddFont("cw_kk_ins2_ww2_frag_us",		"CW_KillIcons", "e", killCol)
	killicon.AddFont("cw_kk_ins2_ww2_tankfist",		"HL2MPTypeDeath", "3", killCol)

	killicon.AddFont("cw_kk_ins2_projectile_m6a1",	"HL2MPTypeDeath", "3", killCol)
	killicon.AddFont("cw_kk_ins2_projectile_pf60",	"HL2MPTypeDeath", "3", killCol)

	killicon.AddFont("cw_kk_ins2_projectile_m84",	"CW_KillIcons", "Q", killCol)

	// NAM pack
	killicon.AddFont("cw_kk_ins2_nam_mel_ak",		"CW_KillIcons", "j", killCol)

	killicon.AddFont("cw_kk_ins2_nam_nambu",		"CW_KillIcons", "c", killCol)
	killicon.AddFont("cw_kk_ins2_nam_python",		"HL2MPTypeDeath", ".", killCol)
	killicon.AddFont("cw_kk_ins2_nam_sw39",			"CW_KillIcons", "a", killCol)
	killicon.AddFont("cw_kk_ins2_nam_tt33",			"CW_KillIcons", "a", killCol)

	killicon.AddFont("cw_kk_ins2_nam_mac10",		"CW_KillIcons", "l", killCol)
	killicon.AddFont("cw_kk_ins2_nam_mat49",		"CW_KillIcons", "d", killCol)
	killicon.AddFont("cw_kk_ins2_nam_ppsh",			"CW_KillIcons", "m", killCol)
	killicon.AddFont("cw_kk_ins2_nam_sterling",		"CW_KillIcons", "x", killCol)
	killicon.AddFont("cw_kk_ins2_nam_vz61",			"CW_KillIcons", "d", killCol)

	killicon.AddFont("cw_kk_ins2_nam_akm",			"CW_KillIcons", "b", killCol)
	killicon.AddFont("cw_kk_ins2_nam_dbs",			"CW_KillIcons", "k", killCol)
	killicon.AddFont("cw_kk_ins2_nam_ithaca",		"CW_KillIcons", "k", killCol)
	killicon.AddFont("cw_kk_ins2_nam_m4",			"CW_KillIcons", "w", killCol)
	killicon.AddFont("cw_kk_ins2_nam_m14",			"CW_KillIcons", "i", killCol)
	killicon.AddFont("cw_kk_ins2_nam_m16a1",		"CW_KillIcons", "w", killCol)
	killicon.AddFont("cw_kk_ins2_nam_m40",			"CW_KillIcons", "r", killCol)
	killicon.AddFont("cw_kk_ins2_nam_m60",			"CW_KillIcons", "z", killCol)
	killicon.AddFont("cw_kk_ins2_nam_s620",			"CW_KillIcons", "k", killCol)
	killicon.AddFont("cw_kk_ins2_nam_sks",			"CW_KillIcons", "i", killCol)
	killicon.AddFont("cw_kk_ins2_nam_svd",			"CW_KillIcons", "i", killCol)
	killicon.AddFont("cw_kk_ins2_nam_svt40",		"CW_KillIcons", "i", killCol)
	killicon.AddFont("cw_kk_ins2_nam_vz58",			"CW_KillIcons", "b", killCol)

	killicon.AddFont("cw_kk_ins2_nam_m72",			"HL2MPTypeDeath", "3", killCol)
	killicon.AddFont("cw_kk_ins2_nam_m79",			"HL2MPTypeDeath", "7", killCol)
end

if CLIENT then
	language.Add("cw_kk_ins2_damage_melee", "Melee attack")

	language.Add("cw_kk_ins2_projectile_at4", "AT4 rocket")
	language.Add("cw_kk_ins2_projectile_rpg", "PG-7VM grenade")
	language.Add("cw_kk_ins2_projectile_rpg_2", "PG-7VM grenade")
	language.Add("cw_kk_ins2_projectile_flare", "25MM Flare")

	language.Add("cw_kk_ins2_projectile_c4", "Thrown C4 charge")
	language.Add("cw_kk_ins2_projectile_ied", "Thrown IED")
	language.Add("cw_kk_ins2_projectile_frag", "Thrown Frag Grenade")
	language.Add("cw_kk_ins2_projectile_m84", "Thrown Stun Grenade")
	language.Add("cw_kk_ins2_projectile_m18", "Thrown Smoke Grenade")

	language.Add("cw_kk_ins2_projectile_anm14", "Thrown Thermate")
	language.Add("cw_kk_ins2_projectile_molotov", "Thrown Molotov")
end

// STATS
if CLIENT then
	CustomizableWeaponry_KK.ins2.statDisplay = CustomizableWeaponry_KK.ins2.statDisplay or {}
	CustomizableWeaponry_KK.ins2.statDisplay.tabs = CustomizableWeaponry_KK.ins2.statDisplay.tabs or {}

	function CustomizableWeaponry_KK.ins2.statDisplay:add()
		self._added = self._added or {}

		for k,v in pairs(self.tabs) do
			if not self._added[k] then
				self._added[k] = true
				CustomizableWeaponry.statDisplay:addStat(v)
			else
				v.desc = string.Explode("\n", v.desc)
			end
		end
	end
end

if CLIENT then
	local stat = CustomizableWeaponry_KK.ins2.statDisplay.tabs.WeaponLength or {}
	stat.varName = "WeaponLength"
	stat.display = "WEAPON LENGTH"
	stat.desc = "Minimal distance allowed between weapon and target.\nMoving closer to your target will holster your weapon.\nSuppressors and barrel modifications affect this stat."
	stat.reverse = true

	function stat:compare(wep)
		local var1, var2 = wep[self.varName], wep[self.origVarName]

		if !var1 or !var2 then
			return CustomizableWeaponry.textColors.REGULAR
		end

		if var1 < var2 then
			return CustomizableWeaponry.textColors.POSITIVE
		elseif var1 > var2 then
			return CustomizableWeaponry.textColors.NEGATIVE
		end
	end

	local out

	function stat:textFunc(wep)
		out = "N/A"

		if wep.WeaponLength then
			out = (math.Round(wep.WeaponLength * 0.0254, 2)) .. "M"
		end

		return out
	end

	function stat:origTextFunc(wep)
		out = "N/A"

		if wep.WeaponLength_Orig then
			out = (math.Round(wep.WeaponLength_Orig * 0.0254, 2)) .. "M"
		end

		return out
	end

	CustomizableWeaponry_KK.ins2.statDisplay.tabs.WeaponLength = stat
end

if CLIENT then
	local stat = CustomizableWeaponry_KK.ins2.statDisplay.tabs.HolsterTime or {}
	stat.varName = "HolsterTime"
	stat.display = "HOLSTER TIME"
	stat.desc = "Time it takes in seconds to have the weapon be safely stored in inventory after holstering."

	function stat:compare(wep)
		local var1, var2 = wep[self.varName], wep[self.origVarName]
		local mul1, mul2 = wep.HolsterSpeed or 1, wep.HolsterSpeed_Orig or 1

		if !var1 or !var2 then
			return CustomizableWeaponry.textColors.REGULAR
		end

		if var1 * mul1 > var2 * mul2 then
			return CustomizableWeaponry.textColors.POSITIVE
		elseif var1 * mul1 < var2 * mul2 then
			return CustomizableWeaponry.textColors.NEGATIVE
		end
	end

	local out, speed

	function stat:textFunc(wep)
		speed = wep.HolsterSpeed or 1
		out = math.Round(wep.HolsterTime / speed, 2) .. "s"

		return out
	end

	function stat:origTextFunc(wep)
		speed = wep.HolsterSpeed_Orig or 1
		out = math.Round(wep.HolsterTime_Orig / speed, 2) .. "s"

		return out
	end

	CustomizableWeaponry_KK.ins2.statDisplay.tabs.HolsterTime = stat
end

if CLIENT then
	// maximum overkill
	CustomizableWeaponry_KK.ins2.statDisplay:add()
end

// MAG SYSTEM
if CustomizableWeaponry.magSystem then
	CustomizableWeaponry.magSystem:registerMagType("lmgBox", " LMG belt", 2)
	CustomizableWeaponry.magSystem:registerMagType("revLoader", " Loader/Stripper clip", 6)
	CustomizableWeaponry.magSystem:registerMagType("m1Clip", " M1 Garand Clip", 6)
end
