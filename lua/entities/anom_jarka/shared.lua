ENT.Base = "base_anim"
ENT.Type = "anim"  
ENT.PrintName		= "Jarka Anomaly" 
ENT.SetName		= "Jarka Anomaly" 
ENT.Spawnable		= true
ENT.AdminSpawnable	= true
ENT.Category		= "S.T.A.L.K.E.R. Anomalies"
ENT.Author			= "ThatYellowPicturePony"
ENT.AutomaticFrameAdvance = true

if CLIENT then
	language.Add("jarka", "Jarka Anomaly")

	sound.Add({
		name = "par_idle",
		channel = CHAN_STATIC,
		volume = 0.1,
		level = 70,
		pitch = 100,
		sound = "anomaly/par_idle.wav",
	})

	ENT.IdleParticle = "jarka_inactive"
	ENT.IdleSound = "par_idle"

	include("cotz/anomalies/cl_idle.lua")
end
