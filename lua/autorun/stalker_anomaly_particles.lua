if SERVER then
	AddCSLuaFile("cotz/anomalies/cl_idle.lua")
	AddCSLuaFile("cotz/anomalies/cl_psy.lua")
else
	-- These resource entities also run outside Helix, so use the engine hook dispatcher.
	hook.Add("NotifyShouldTransmit", "cotz/anomalies/idle-transmission", function(entity, shouldTransmit)
		if not entity.StopAnomalyIdleEffects then return end

		if not shouldTransmit then
			entity:StopAnomalyIdleEffects()
			entity.IsSleeping = true
		else
			entity:SetNextClientThink(CurTime())
		end
	end)
end

-- Field anomaly effects, built from the cotz_general particle packs by tools/anomaly_pcf.py.
game.AddParticles("particles/cotz_anomalies.pcf")
game.AddParticles("particles/anarchycell_bloodspash.pcf")
for _, name in ipairs({
	"cotz_anom_burner_idle", "cotz_anom_burner_flame", "cotz_anom_steam_idle", "cotz_anom_steam_jet",
	"cotz_anom_electra_idle", "cotz_anom_electra_idle_2", "cotz_anom_electra_blast", "cotz_anom_electra_blast_2",
	"cotz_anom_electra_hit", "cotz_anom_fruitpunch_idle", "cotz_anom_kisel_idle", "cotz_anom_acid_burst",
	"cotz_anom_bubble_idle", "cotz_anom_bubble_idle_2", "cotz_anom_gravity_shield", "cotz_anom_vortex_idle", "cotz_anom_vortex_blast",
	"cotz_anom_karusel_idle", "cotz_anom_karusel_charge", "cotz_anom_karusel_swirl", "cotz_anom_springboard_idle",
	"cotz_anom_tramplin_blast", "cotz_anom_tesla_idle", "cotz_anom_tesla_charge", "cotz_anom_tesla_blast",
	"cotz_anom_psy_idle", "cotz_anom_psy_glow", "cotz_anom_psy_pulse", "cotz_anom_zone_fire", "cotz_anom_zone_acid",
	"cotz_anom_zone_electro", "cotz_anom_comet_fire", "cotz_anom_comet_electra", "wick_gore_bloodsplash_new",
}) do
	PrecacheParticleSystem(name)
end

game.AddParticles("particles/stalker_anomaly.pcf")
PrecacheParticleSystem("electra")
PrecacheParticleSystem("electra_activated")
PrecacheParticleSystem("electra_static")
PrecacheParticleSystem("electra_static_electra")
PrecacheParticleSystem("gazirovka")
PrecacheParticleSystem("gazirovka_activated")
PrecacheParticleSystem("gazirovka_activated_particles")
PrecacheParticleSystem("jarka_activated")
PrecacheParticleSystem("jarka_inactive")
PrecacheParticleSystem("kisel")
PrecacheParticleSystem("kisel_static")
PrecacheParticleSystem("kisel_static2")
PrecacheParticleSystem("kisel_static3")
PrecacheParticleSystem("kometa")
PrecacheParticleSystem("kometa_electra")
PrecacheParticleSystem("kometa_electra_plazma")
PrecacheParticleSystem("kometa_electra_sparks")
PrecacheParticleSystem("kometa_kisel")
PrecacheParticleSystem("kometa_kisel_trail")
PrecacheParticleSystem("kometa_kisel_trail_footsteps")
PrecacheParticleSystem("kometa_trail")
PrecacheParticleSystem("myasorubka")
PrecacheParticleSystem("myasorubka_activated")
PrecacheParticleSystem("par_anomaly")
PrecacheParticleSystem("tramplin")
PrecacheParticleSystem("tramplin_activated")
PrecacheParticleSystem("tramplin_blast")
PrecacheParticleSystem("tramplin_activated_blast")
PrecacheParticleSystem("tramplin_activated_cloud2")
PrecacheParticleSystem("tramplin_activated_force")
PrecacheParticleSystem("tramplin_activated_force2")
PrecacheParticleSystem("tramplin_activated_force3")
PrecacheParticleSystem("tramplin_activated_sprite")
PrecacheParticleSystem("tramplin_scale")
PrecacheParticleSystem("tramplin_sprite")
PrecacheParticleSystem("tramplin_static")
PrecacheParticleSystem("voronka")
PrecacheParticleSystem("voronka_activated")
PrecacheParticleSystem("voronka_activated2")
PrecacheParticleSystem("voronka_activated3")
PrecacheParticleSystem("voronka_activated4")
PrecacheParticleSystem("voronka_activated5")
PrecacheParticleSystem("voronka_activated6")
PrecacheParticleSystem("voronka_activated_sprite")
PrecacheParticleSystem("voronka_activated_sprite2")
PrecacheParticleSystem("voronka_blast")
PrecacheParticleSystem("voronka_blast_sprite")
PrecacheParticleSystem("voronka_scale")
PrecacheParticleSystem("voronka_sprite")
PrecacheParticleSystem("bubble")
PrecacheParticleSystem("teleport")
PrecacheParticleSystem("tramplin_type2")

/*
duplicator.Allow("anom_electra_anomaly")
duplicator.Allow("anom_electra_anomaly_type2")
duplicator.Allow("anom_gazirovka_anomaly")
duplicator.Allow("anom_jarka")
duplicator.Allow("anom_kisel_anomaly")
duplicator.Allow("kometa")
duplicator.Allow("kometa_electra")
duplicator.Allow("kometa_kisel")
duplicator.Allow("anom_maysorubka_anomaly")
duplicator.Allow("anom_maysorubka_anomaly_type2")
duplicator.Allow("anom_par")
duplicator.Allow("anom_space_anomaly")
duplicator.Allow("anom_teleport")
duplicator.Allow("anom_tramplin_anomaly")
duplicator.Allow("anom_voronka_anomaly")
*/
