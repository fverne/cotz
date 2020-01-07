AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

ENT.ExplodeRadius = 600
ENT.ExplodeDamage = 200
ENT.Model = "models/weapons/w_cw_fraggrenade_thrown.mdl"

local phys, ef

function ENT:Initialize()
	self:SetModel(self.Model)
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetCollisionGroup(COLLISION_GROUP_NONE)
	self.NextImpact = 0
	phys = self:GetPhysicsObject()

	if phys and phys:IsValid() then
		phys:Wake()
	end

	self:GetPhysicsObject():SetBuoyancyRatio(0)
end

function ENT:Use(activator, caller)
	return false
end

function ENT:OnRemove()
	return false
end

local vel, len, CT

function ENT:PhysicsCollide(data, physobj)
	vel = physobj:GetVelocity()
	len = vel:Length()

	if len > 500 then -- let it roll
		physobj:SetVelocity(vel * 0.6) -- cheap as fuck, but it works
	end

	if len > 100 then
		CT = CurTime()

		if CT > self.NextImpact then
			self:EmitSound("CW_KK_INS2_DOI_C4_DE_ENT_BOUNCE", 75, 100)
			self.NextImpact = CT + 0.1
		end
	end
end

function ENT:Fuse(t)
	t = t or 3

	for i = 0, t / 6 do
		timer.Simple(i * 6, function()
			if IsValid(self) then
				self:EmitSound("CW_KK_INS2_DOI_C4_DE_FUSELOOP")
			end
		end)
		self.StopSounds = i
	end

	timer.Simple(t, function()
		if self:IsValid() then
			self:Kaboomboom()
		end
	end)
end

function ENT:Kaboomboom()
	if self.weDidThisAlready then
		return
	end

	self.weDidThisAlready = true

	self:StopParticles()

	for i = 0, (self.StopSounds or 0) + 2 do
		self:StopSound("CW_KK_INS2_DOI_C4_DE_FUSELOOP")
	end

	util.BlastDamage(self, self:GetOwner(), self:GetPos(), self.ExplodeRadius, self.ExplodeDamage)

	local fx = ents.Create("cw_kk_ins2_particles")
	fx:processProjectile(self)
	fx:Spawn()

	SafeRemoveEntity(self)
end

function ENT:OnTakeDamage(dmg)
	self:Kaboomboom()
end

function ENT:Think()
end
