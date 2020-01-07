ENT.Type = "anim"
ENT.Base = "base_entity"
ENT.PrintName = "AT4 Projectile"
ENT.Author = "L337N008"
ENT.Information = "A 40MM grenade modified to be launched from AT4"
ENT.Spawnable = false
ENT.AdminSpawnable = false

ENT.Editable = true

-- ENT.BlastDamage = 200
-- ENT.BlastRadius = 400

ENT.BlastDamage = 230
ENT.BlastRadius = 500 // 1000 is 2much

ENT.SpeedStarter = 4527.55
ENT.SpeedThruster = 11574.78
ENT.SpeedMax = 11574.78

ENT.safetyBypass = false

-- ENT.DontDestroy = true

function ENT:Initialize()
	if SERVER then
		self:SetModel(self.Model or "models/weapons/w_missile.mdl")
		self:PhysicsInitBox(Vector(-10, -1.5, -1.5), Vector(12, 1.5, 1.5))
		self:SetMoveType(MOVETYPE_VPHYSICS)
		self:SetSolid(SOLID_VPHYSICS)
		self:SetCollisionGroup(COLLISION_GROUP_PROJECTILE)

		local phys = self:GetPhysicsObject()

		if phys and phys:IsValid() then
			phys:SetMass(10)
			phys:Wake()
		end

		self:GetPhysicsObject():SetBuoyancyRatio(0)

		self.dt.State = self.States.initialized

		spd = physenv.GetPerformanceSettings()
		spd.MaxVelocity = 11574.78

		physenv.SetPerformanceSettings(spd)
	else
		self.Emitter = ParticleEmitter(self:GetPos())
	end

	local CT = CurTime()

	self.ArmTime = CT
	self.selfDestructTime = CT + 5.1
end

function ENT:SetupDataTables()
	self:NetworkVar("Int", 0, "State")
end

ENT.States = {
	initialized = 1,
	armed = 2,
	misfired = 3
}
