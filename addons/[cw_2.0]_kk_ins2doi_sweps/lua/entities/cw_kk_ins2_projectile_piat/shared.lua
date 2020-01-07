ENT.Type = "anim"
ENT.Base = "base_entity"
ENT.PrintName = "Panzerfaust60 projectile"
ENT.Author = "L337N008"
ENT.Information = "A 40MM grenade modified to be launched from Panzerfaust 60"
ENT.Spawnable = false
ENT.AdminSpawnable = false

-- ENT.BlastDamage = 200
-- ENT.BlastRadius = 400

ENT.BlastDamage = 160
ENT.BlastRadius = 500 // 1000

function ENT:Initialize()
	if SERVER then
		self:SetModel(self.Model or "models/weapons/w_bazooka_projectile.mdl")
		self:PhysicsInitBox(Vector(-6,-2,-2), Vector(4.5,2,2))
		self:SetMoveType(MOVETYPE_VPHYSICS)
		self:SetSolid(SOLID_VPHYSICS)
		self:SetCollisionGroup(COLLISION_GROUP_PROJECTILE)

		local phys = self:GetPhysicsObject()

		if phys and phys:IsValid() then
			phys:SetMass(10)
			phys:Wake()
		end

		self:GetPhysicsObject():SetBuoyancyRatio(0)

		spd = physenv.GetPerformanceSettings()
		spd.MaxVelocity = 5000

		physenv.SetPerformanceSettings(spd)
	else
		self.Emitter = ParticleEmitter(self:GetPos())
		self.LunchTime = CurTime()
	end
end
