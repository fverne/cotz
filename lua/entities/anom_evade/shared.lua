ENT.Type = "anim"
ENT.Base = "base_anim"
 
ENT.PrintName		= "Evade Anomaly"
ENT.Author			= ""
ENT.Contact			= ""
ENT.Purpose			= "Pushes objects & people away from it."
ENT.Category 		= "Anomalies"

ENT.Spawnable			= true
ENT.AdminSpawnable		= true

/*---------------------------------------------------------
   Name: OnRemove
   Desc: Called just before entity is deleted
---------------------------------------------------------*/
function ENT:OnRemove()
end

function ENT:PhysicsUpdate()
end

function ENT:PhysicsCollide(data,phys)

end
