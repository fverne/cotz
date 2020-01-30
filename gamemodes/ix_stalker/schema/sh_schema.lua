
-- The shared init file. You'll want to fill out the info for your schema and include any other files that you need.

-- Schema info
Schema.name = "Call of the Zone"
Schema.author = "faggot, verne"
Schema.description = "A STALKER Roleplaying gamemode with tabletop elements."
--Schema.logo = "vgui/background/wallpaper.jpg"


ix.util.Include("libs/thirdparty/sh_netstream2.lua")

-- Additional files that aren't auto-included should be included here. Note that ix.util.Include will take care of properly
-- using AddCSLuaFile, given that your files have the proper naming scheme.

-- You could technically put most of your schema code into a couple of files, but that makes your code a lot harder to manage -
-- especially once your project grows in size. The standard convention is to have your miscellaneous functions that don't belong
-- in a library reside in your cl/sh/sv_schema.lua files. Your gamemode hooks should reside in cl/sh/sv_hooks.lua. Logical
-- groupings of functions should be put into their own libraries in the libs/ folder. Everything in the libs/ folder is loaded
-- automatically.
ix.util.Include("cl_schema.lua")
ix.util.Include("sv_schema.lua")

ix.util.Include("cl_skin.lua")

ix.util.Include("cl_hooks.lua")
ix.util.Include("sh_hooks.lua")
ix.util.Include("sv_hooks.lua")

-- You'll need to manually include files in the meta/ folder, however.
ix.util.Include("meta/sh_character.lua")
ix.util.Include("meta/sh_player.lua")
ix.util.Include("meta/sh_inventory.lua")

ix.flag.Add("1", "Trader.")
ix.flag.Add("A", "Admin")
ix.flag.Add("N", "Event/Customization")

ALWAYS_RAISED["weapon_flashlight"] = true
ALWAYS_RAISED["stalker_bolt"] = true
ALWAYS_RAISED["detector_bear"] = true
ALWAYS_RAISED["detector_veles"] = true
ALWAYS_RAISED["detector_echo"] = true
ALWAYS_RAISED["guitar"] = true

ix.currency.symbol = "₽"
ix.currency.singular = "ruble"
ix.currency.plural = "rubles"

-- We will use this better later
local stalker_models = { 	
	["models/player/stalker/compiled 0.34/coprookie.mdl"] = true,
	["models/stalker/nauch2.mdl"] = true,
	["models/player/stalker/compiled 0.34/ecologist.mdl"] = true,
	["models/player/stalker/compiled 0.34/mercmask.mdl"] = true,
	["models/player/stalker/compiled 0.34/militaryberet.mdl"] = true,
	["models/player/stalker/compiled 0.34/pszface.mdl"] = true,
	["models/player/stalker/compiled 0.34/radsuit.mdl"] = true,
	["models/player/stalker/compiled 0.34/radsuitmonolith.mdl"] = true,
	["models/player/stalker/compiled 0.34/sevasuit.mdl"] = true,
	["models/player/stalker/compiled 0.34/skatman.mdl"] = true,
	["models/player/stalker/compiled 0.34/soldier.mdl"] = true,
	["models/player/stalker/compiled 0.34/soldierbandana.mdl"] = true,
	["models/player/stalker/compiled 0.34/sunrise.mdl"] = true,
	["models/player/stalker/compiled 0.34/sunrise2.mdl"] = true,
	["models/player/stalker/compiled 0.34/sunrisefreedom2.mdl"] = true,
	["models/player/stalker/compiled 0.34/sunrisenormal.mdl"] = true,
	["models/player/stalker/compiled 0.34/trenchbandit.mdl"] = true,
	["models/player/stalker/compiled 0.34/clearsky3.mdl"] = true,
	["models/player/stalker/compiled 0.34/clearsky3a.mdl"] = true,
	["models/player/stalker/compiled 0.34/clearskygeneric.mdl"] = true,
	["models/player/stalker/compiled 0.34/dutyarmor.mdl"] = true,
	["models/nasca/etherealsrp/anorak.mdl"] = true,
	["models/nasca/etherealsrp/army_uniform.mdl"] = true,
	["models/nasca/etherealsrp/mili_berill-5m.mdl"] = true,
	["models/nasca/etherealsrp/cs-1.mdl"] = true,
	["models/nasca/etherealsrp/cs-1b.mdl"] = true,
	["models/nasca/etherealsrp/cs-2.mdl"] = true,
	["models/nasca/etherealsrp/cs-3a.mdl"] = true,
	["models/nasca/etherealsrp/cs-3b.mdl"] = true,
	["models/nasca/etherealsrp/exo_anorak.mdl"] = true,
	["models/nasca/etherealsrp/loner_exo_old.mdl"] = true,
	["models/nasca/etherealsrp/duty_exo_old.mdl"] = true,
	["models/nasca/etherealsrp/freedom_exo_old.mdl"] = true,
	["models/nasca/etherealsrp/mono_exo_old.mdl"] = true,
	["models/nasca/etherealsrp/exoskeleton_prototype.mdl"] = true,
	["models/nasca/etherealsrp/expedition_suit.mdl"] = true,
	["models/nasca/etherealsrp/expedition_suit_female.mdl"] = true,
	["models/nasca/etherealsrp/final_scout.mdl"] = true,
	["models/nasca/etherealsrp/final_soldier.mdl"] = true,
	["models/nasca/etherealsrp/final_tank.mdl"] = true,
	["models/nasca/etherealsrp/jupiter_suit.mdl"] = true,
	["models/nasca/etherealsrp/mecheniy.mdl"] = true,
	["models/nasca/etherealsrp/mercenary_suit.mdl"] = true,
	["models/nasca/etherealsrp/mercenary_suit_heavy.mdl"] = true,
	["models/nasca/etherealsrp/monolith_suit.mdl"] = true,
	["models/nasca/etherealsrp/monolith_suit_female.mdl"] = true,
	["models/nasca/etherealsrp/nbc_suit.mdl"] = true,
	["models/nasca/etherealsrp/duty_ps5m.mdl"] = true,
	["models/nasca/etherealsrp/ps5m_duty_female.mdl"] = true,
	["models/nasca/etherealsrp/ps5m_freedom_female.mdl"] = true,
	["models/nasca/etherealsrp/loner_midnight.mdl"] = true,
	["models/nasca/etherealsrp/ps5m_loner_female.mdl"] = true,
	["models/nasca/etherealsrp/duty_psz9d.mdl"] = true,
	["models/nasca/etherealsrp/loner_radsuit.mdl"] = true,
	["models/nasca/etherealsrp/duty_radsuit.mdl"] = true,
	["models/nasca/etherealsrp/free_radsuit.mdl"] = true,
	["models/nasca/etherealsrp/mono_radsuit.mdl"] = true,
	["models/nasca/etherealsrp/rs-1.mdl"] = true,
	["models/nasca/etherealsrp/rs-2.mdl"] = true,
	["models/nasca/etherealsrp/rs-3a.mdl"] = true,
	["models/nasca/etherealsrp/rs-3b.mdl"] = true,
	["models/nasca/etherealsrp/loner_seva.mdl"] = true,
	["models/nasca/etherealsrp/duty_seva.mdl"] = true,
	["models/nasca/etherealsrp/eco_seva.mdl"] = true,
	["models/nasca/etherealsrp/free_seva.mdl"] = true,
	["models/nasca/etherealsrp/mono_scientific.mdl"] = true,
	["models/nasca/etherealsrp/seva_suit_monolith.mdl"] = true,
	["models/nasca/etherealsrp/ssp_suit.mdl"] = true,
	["models/nasca/etherealsrp/mili_stingray-9.mdl"] = true,
	["models/nasca/etherealsrp/stingray-9m.mdl"] = true,
	["models/nasca/etherealsrp/sunrise_bandit.mdl"] = true,
	["models/nasca/etherealsrp/sunrise_bandit_female.mdl"] = true,
	["models/nasca/etherealsrp/loner_sunrise.mdl"] = true,
	["models/nasca/etherealsrp/sunrise_suit_female.mdl"] = true,
	["models/nasca/etherealsrp/sunset_body_armor.mdl"] = true,
	["models/nasca/etherealsrp/trenchcoat.mdl"] = true,
	["models/nasca/etherealsrp/wind_free.mdl"] = true,
	["models/nasca/etherealsrp/wind_free_female.mdl"] = true,
	["models/stalkerisaac/playermodel/male_01_anorak.mdl"] = true,
	["models/stalkerisaac/playermodel/male_01_io7a.mdl"] = true,
	["models/stalkerisaac/playermodel/male_01_sunrise.mdl"] = true,
	["models/stalkerisaac/playermodel/male_01_sunrise_1.mdl"] = true,
	["models/stalkerisaac/playermodel/male_01_sunset.mdl"] = true,
	["models/stalkerisaac/playermodel/male_01_wind.mdl"] = true,
	["models/stalkerisaac/playermodel/male_01_berill.mdl"] = true,
	["models/stalkerisaac/playermodel/male_01_radsuit.mdl"] = true,
	["models/stalkerisaac/playermodel/male_01_skat.mdl"] = true,
	["models/stalkerisaac/playermodel/male_01_cs2.mdl"] = true,
	["models/stalkerisaac/playermodel/male_01_cs3.mdl"] = true,
	["models/stalkerisaac/playermodel/male_01_cs4.mdl"] = true,
	["models/nasca/stalker/male_berill1.mdl"] = true,
	["models/nasca/stalker/male_sunset_lone.mdl"] = true,
	["models/nasca/stalker/male_ssp_eco.mdl"] = true,
	["models/nasca/stalker/male_eagle_lone.mdl"] = true,
	["models/nasca/stalker/male_expedition.mdl"] = true,
	

}

for k, v in pairs(stalker_models) do
	player_manager.AddValidModel("stalker_default", k)
	util.PrecacheModel(k)
end

player_manager.AddValidHands( "stalker_default", "models/arms/c_arms_stalker.mdl", 0, 0 )