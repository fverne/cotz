AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

ENT.BurnDuration = 20

ENT.ExplodeRadius = 300
ENT.ExplodeDamage = 20
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
	self.destroyPhys = true
	self:Kaboomboom()
end

function ENT:Fuse(t)
	// muhehe
end

function ENT:Kaboomboom()
	if self.wentBoomAlready then
		return
	end

	self.wentBoomAlready = true

	if self:WaterLevel() == 0 then
		local hitPos = self:GetPos()

		local smokeScreen = ents.Create("cw_smokescreen_impact")
		smokeScreen:SetPos(hitPos)
		smokeScreen:Spawn()

		local fx = ents.Create("cw_kk_ins2_particles")
		fx:processProjectile(self)
		fx:Spawn()

		fx:Ignite(self.BurnDuration, self.ExplodeRadius)

		-- local bn = ents.Create("cw_kk_ins2_burn")
		-- bn:processProjectile(self)
		-- bn:Spawn()
	end

	self:SetNoDraw(true)

	SafeRemoveEntityDelayed(self, 30)
end

function ENT:Think()
	if self.destroyPhys then
		self.destroyPhys = false
		self:PhysicsDestroy()
	end
end
