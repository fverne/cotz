ix.npctemplates = {}
ix.npctemplates.templates = {}
ix.npctemplates.soundtemplates = {}
ix.npctemplates.animtemplates = {}
ix.npctemplates.animtemplatestranslation = {}

ix.npctemplates.animtemplatestranslation[1] = "TestAnimations"
ix.npctemplates.animtemplatestranslation[2] = "Bartrader"
ix.npctemplates.animtemplatestranslation[3] = "Guard"
ix.npctemplates.animtemplatestranslation[4] = "sitchair"
ix.npctemplates.animtemplatestranslation[5] = "banditidle"
ix.npctemplates.animtemplatestranslation[6] = "monolithidle"
ix.npctemplates.animtemplatestranslation[7] = "idle_idle"

ix.util.Include("ix_cotz/plugins/vendor_adv/definitions/sh_cleaner.lua")

ix.util.Include("ix_cotz/plugins/vendor_adv/definitions/sh_technut.lua")

ix.util.Include("ix_cotz/plugins/vendor_adv/definitions/sh_old_timer.lua")

ix.util.Include("ix_cotz/plugins/vendor_adv/definitions/sh_spicy_lemon.lua")

ix.util.Include("ix_cotz/plugins/vendor_adv/definitions/sh_haggler.lua")

ix.util.Include("ix_cotz/plugins/vendor_adv/definitions/sh_mute.lua")

ix.util.Include("ix_cotz/plugins/vendor_adv/definitions/sh_egghead.lua")

ix.util.Include("ix_cotz/plugins/vendor_adv/definitions/sh_beanstalk.lua")

ix.util.Include("ix_cotz/plugins/vendor_adv/definitions/sh_intern.lua")

ix.util.Include("ix_cotz/plugins/vendor_adv/definitions/sh_quartermaster.lua")

ix.util.Include("ix_cotz/plugins/vendor_adv/definitions/sh_boss.lua")

ix.util.Include("ix_cotz/plugins/vendor_adv/definitions/sh_smartass.lua")

ix.util.Include("ix_cotz/plugins/vendor_adv/definitions/sh_rarity.lua")

ix.util.Include("ix_cotz/plugins/vendor_adv/definitions/sh_computer.lua")

ix.util.Include("ix_cotz/plugins/vendor_adv/definitions/sh_jitters.lua")

ix.util.Include("ix_cotz/plugins/vendor_adv/definitions/sh_the_original.lua")

ix.util.Include("ix_cotz/plugins/vendor_adv/definitions/sh_ccon.lua")

ix.util.Include("ix_cotz/plugins/vendor_adv/definitions/sh_arena_master.lua")

ix.util.Include("ix_cotz/plugins/vendor_adv/definitions/sh_rat.lua")

-- No sounds emitted
ix.npctemplates.soundtemplates["nosound"] = {
	"stalkersound/inv_nosound.mp3",
}

ix.npctemplates.soundtemplates["GenericHello"] = {
	"npc/beta/stalker_talk_1.ogg",
	"npc/beta/stalker_talk_2.ogg",
	"npc/beta/stalker_talk_3.ogg",
	"npc/beta/stalker_talk_4.ogg",
}

ix.npctemplates.soundtemplates["GenericIdle"] = {
	"npc/hunter/idle_12.ogg",
	"npc/hunter/idle_19.ogg",
	"npc/hunter/idle_17.ogg",
	"npc/hunter/idle_16.ogg",
}

ix.npctemplates.soundtemplates["GenericGuard"] = {
	"npc/bandit/meet_comander_start_1.ogg",
	"npc/bandit/meet_comander_start_2.ogg",
	"npc/bandit/meet_comander_start_3.ogg",
}

ix.npctemplates.soundtemplates["TraderHello"] = {
	"npc/barman/bar_barman_hello_1.ogg",
	"npc/barman/bar_barman_hello_2.ogg",
	"npc/barman/bar_barman_hello_3.ogg",
	"npc/barman/bar_barman_hello_4.ogg",
	"npc/barman/bar_barman_hello_5.ogg"
}

ix.npctemplates.soundtemplates["TutorialNpc"] = {
	"npc/shram/idle_16.ogg",
	"npc/shram/search_13.ogg",
	"npc/shram/idle_18.ogg",
	"npc/shram/idle_20.ogg",
	"npc/shram/idle_4.ogg"
}

ix.npctemplates.soundtemplates["CookNpc"] = {
	"npc/lesnik/red_forester_meet_hello_0.ogg",
	"npc/lesnik/red_forester_meet_hello_1.ogg",
	"npc/lesnik/red_forester_meet_hello_2.ogg",
	"npc/lesnik/red_forester_greet_1.ogg",
    "npc/lesnik/red_forester_hello_bye_0.ogg",
    "npc/lesnik/red_forester_hello_bye_1.ogg",
}

ix.npctemplates.soundtemplates["ecologistnpc"] = {
	"npc/doctor/idle_12.ogg",
	"npc/doctor/idle_13.ogg",
	"npc/doctor/idle_14.ogg",
	"npc/doctor/idle_15.ogg",
	"npc/doctor/idle_16.ogg",
	"npc/doctor/idle_17.ogg",
	"npc/doctor/idle_18.ogg",
	"npc/doctor/idle_19.ogg",
}

ix.npctemplates.soundtemplates["ecologistnpc2"] = {
	"npc/lebed/mar_csky_leader_meet_greet_1.ogg",
	"npc/lebed/mar_csky_leader_meet_greet_2.ogg",
	"npc/lebed/mar_csky_leader_meet_greet_3.ogg",
	"npc/lebed/mar_csky_leader_meet_greet_4.ogg",
}

ix.npctemplates.soundtemplates["ecologistnpc3"] = {
	"npc/ecolog/idle_2.ogg",
	"npc/ecolog/idle_3.ogg",
	"npc/ecolog/idle_4.ogg",
	"npc/ecolog/idle_5.ogg",
	"npc/ecolog/idle_6.ogg",
	"npc/ecolog/idle_7.ogg",
}

ix.npctemplates.soundtemplates["unisgnpc"] = {
	"npc/bariga/stalker_trade_1.ogg",
	"npc/bariga/stalker_trade_12.ogg",
	"npc/bariga/stalker_trade_13.ogg",
	"npc/bariga/stalker_trade_14.ogg",
	"npc/bariga/stalker_trade_15.ogg",
}

ix.npctemplates.soundtemplates["unisgnpc2"] = {
	"npc/beta/soldier_replics_1.ogg",
	"npc/beta/soldier_replics_2.ogg",
	"npc/beta/soldier_replics_3.ogg",
}

ix.npctemplates.soundtemplates["unisgnpc3"] = {
	"npc/digger_m/interes_1.ogg",
	"npc/digger_m/interes_2.ogg",
	"npc/digger_m/interes_5.ogg",
	"npc/digger_m/interes_6.ogg",
}

ix.npctemplates.soundtemplates["medicnpc"] = {
	"npc/suslov/mar_csky_doctor_hello_dialog_0.ogg",
	"npc/suslov/mar_csky_doctor_meet_greet_1.ogg",
	"npc/suslov/mar_csky_doctor_meet_greet_2.ogg",
	"npc/suslov/mar_csky_doctor_meet_greet_3.ogg",
}

ix.npctemplates.soundtemplates["technpc2"] = {
	"npc/suslov/mar_csky_tech_meet_greet_1.ogg",
	"npc/suslov/mar_csky_tech_meet_greet_2.ogg",
	"npc/suslov/mar_csky_tech_meet_greet_3.ogg",
}

ix.npctemplates.soundtemplates["computer_beep"] = {
	"ambient/levels/labs/equipment_beep_loop1.wav",
	"ambient/levels/canals/generator_ambience_loop1.wav",
}

ix.npctemplates.soundtemplates["cconnpc"] = {
	"monolith/monolith_call_1.ogg",
	"monolith/monolith_call_2.ogg",
	"monolith/monolith_call_3.ogg",
	"monolith/monolith_call_4.ogg",
	"monolith/monolith_call_5.ogg",
	"monolith/monolith_call_6.ogg",
	"monolith/monolith_call_7.ogg",
	"monolith/monolith_call_8.ogg",
}

ix.npctemplates.animtemplates["TestAnimations"] = {
	"bandit2_idle1",
	"bandit2_idle3",
}

ix.npctemplates.animtemplates["Bartrader"] = {
	"trader_idle2",
}

ix.npctemplates.animtemplates["ecotrader"] = {
	"bandit_idle2",
}

ix.npctemplates.animtemplates["Guard"] = {
	"hello_idle",
}

ix.npctemplates.animtemplates["sitchair"] = {
	"sidit2",
}

ix.npctemplates.animtemplates["banditidle"] = {
	"bandit2_idle1",
	"bandit2_idle3"
}

ix.npctemplates.animtemplates["monolithidle"] = {
	"trans_idle3",
}

ix.npctemplates.animtemplates["idle_idle"] = {
	"idle",
}

ix.util.Include("ix_cotz/plugins/vendor_adv/definitions/sh_atlas.lua")
ix.util.Include("ix_cotz/plugins/vendor_adv/definitions/sh_ballast.lua")
ix.util.Include("ix_cotz/plugins/vendor_adv/definitions/sh_brass.lua")
ix.util.Include("ix_cotz/plugins/vendor_adv/definitions/sh_carbon.lua")
ix.util.Include("ix_cotz/plugins/vendor_adv/definitions/sh_gasket.lua")
ix.util.Include("ix_cotz/plugins/vendor_adv/definitions/sh_latch.lua")
ix.util.Include("ix_cotz/plugins/vendor_adv/definitions/sh_ledger.lua")
ix.util.Include("ix_cotz/plugins/vendor_adv/definitions/sh_spool.lua")
ix.util.Include("ix_cotz/plugins/vendor_adv/definitions/sh_spoor.lua")
ix.util.Include("ix_cotz/plugins/vendor_adv/definitions/sh_suture.lua")
ix.util.Include("ix_cotz/plugins/vendor_adv/definitions/sh_vesper.lua")
ix.util.Include("ix_cotz/plugins/vendor_adv/definitions/sh_wake.lua")
