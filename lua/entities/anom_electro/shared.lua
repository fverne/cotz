ENT.Type = "anim"
ENT.Base = "base_anim"
 
ENT.PrintName		= "Electro Anomaly"
ENT.Author			= ""
ENT.Contact			= ""
ENT.Category 		= "Anomalies"

ENT.Spawnable			= true
ENT.AdminSpawnable		= true

/*---------------------------------------------------------
   Name: IsTranslucent
   Desc: Return whether object is translucent or opaque
---------------------------------------------------------*/
function ENT:IsTranslucent()
	return false
end

function ENT:OnRemove()
end

function ENT:PhysicsUpdate()
end

function ENT:PhysicsCollide(data,phys)
end