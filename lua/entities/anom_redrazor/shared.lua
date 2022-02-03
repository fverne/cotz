ENT.Type = "anim"
ENT.Base = "base_anim"
 
ENT.PrintName		= "Red Razor Anomaly"
ENT.Author			= ""
ENT.Contact			= ""
ENT.Purpose			= "Cuts people who walk in it"
ENT.Category 		= "Anomalies"

ENT.Spawnable			= true
ENT.AdminSpawnable		= true

function ENT:OnRemove()
end

function ENT:PhysicsUpdate()
end

function ENT:PhysicsCollide(data,phys)

end
