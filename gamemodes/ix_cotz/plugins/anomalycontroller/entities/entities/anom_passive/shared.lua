ENT.Type = "anim"
ENT.Base = "base_anim"
 
ENT.PrintName		= "Anomaly Passive Damage"
ENT.Author			= ""
ENT.Contact			= ""
ENT.Purpose			= "Don't spawn"
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
