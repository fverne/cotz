ENT.Type = "anim"
ENT.Base = "base_entity"
ENT.PrintName = "Flare Projectile"
ENT.Author = "L337N008"
ENT.Information = "A 40MM grenade modified to be launched from flare gun."
ENT.Spawnable = false
ENT.AdminSpawnable = false

ENT.TimeToLive = 90
ENT.AfterBurn = 5
ENT.BurnRadius = 64

if CLIENT then
	ENT.LightColor = Color(255,100,100,255)
end

local mins, maxs = Vector(-1, -1, -1), Vector(1, 1, 1)

function ENT:Initialize()
	if SERVER then
		self:SetModel("models/weapons/w_flare_projectile.mdl")
		-- self:PhysicsInit(SOLID_VPHYSICS)
		self:PhysicsInitBox(mins, maxs)
		self:SetMoveType(MOVETYPE_VPHYSICS)
		self:SetSolid(SOLID_VPHYSICS)
		self:SetCollisionGroup(COLLISION_GROUP_NONE) // HL2 racket

		local phys = self:GetPhysicsObject()

		if phys and phys:IsValid() then
			phys:Wake()
		end

		self:GetPhysicsObject():SetBuoyancyRatio(0)

		spd = physenv.GetPerformanceSettings()
		spd.MaxVelocity = 11574.78

		physenv.SetPerformanceSettings(spd)
	else
		self.Emitter = ParticleEmitter(self:GetPos())
	end

	self._timeToLive = CurTime() + self.TimeToLive
end
