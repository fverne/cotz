AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

ENT.ExplodeRadius = 384
ENT.ExplodeDamage = 100
ENT.Model = "models/weapons/w_eq_smokegrenade_thrown.mdl"

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
	self:Kaboomboom()
end

function ENT:Fuse(t)
	// muhehe
end

PrecacheParticleSystem("doi_WPgrenade_explosion")
PrecacheParticleSystem("doi_grenade_explosion")
PrecacheParticleSystem("doi_frag_explosion")
PrecacheParticleSystem("doi_compB_explosion")
PrecacheParticleSystem("skybox_gunrun")

function ENT:Kaboomboom()
	local hitPos = self:GetPos()

	local smokeScreen = ents.Create("cw_smokescreen_impact")
	smokeScreen:SetPos(hitPos)
	smokeScreen:Spawn()

	local fx = ents.Create("cw_kk_ins2_particles")
	fx:processProjectile(self)
	fx:Spawn()

	SafeRemoveEntity(self)
end
