ENT.Base = "base_gmodentity"
ENT.Type = "anim"  
ENT.PrintName		= "Steam Anomaly" 
ENT.SetName		= "Steam Anomaly" 
ENT.Spawnable		= true
ENT.AdminSpawnable	= true
ENT.Category		= "S.T.A.L.K.E.R. Anomalies"
ENT.Author			= "ThatYellowPicturePony"
ENT.AutomaticFrameAdvance = true

if CLIENT then
	language.Add("par", "Steam Anomaly")

	ENT.IdleParticle = "jarka_inactive"
	ENT.IdleSound = "par_idle"
	ENT.IdleRestartTranslucent = true

	include("cotz/anomalies/cl_idle.lua")
end
