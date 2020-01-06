AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

ENT.BurnDuration = 30

ENT.ExplodeRadius = 300
ENT.ExplodeDamage = 10

ENT.Model = "models/weapons/w_molotov.mdl"

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
	self:Detonate()
end

function ENT:Fuse(t)
	//muhehe
end

local dn = Vector(0,0, -64000)
local td = {mask = MASK_NPCWORLDSTATIC}
local tr, t

function ENT:Detonate()
	if self.wentBoomAlready then
		return
	end

	self.wentBoomAlready = true

	self:StopParticles()

	t = 60

	if self:WaterLevel() == 0 then
		local fx = ents.Create("cw_kk_ins2_particles")
		fx:processProjectile(self)
		fx:Spawn()

		fx:Ignite(self.BurnDuration, self.ExplodeRadius)

		-- local bn = ents.Create("cw_kk_ins2_burn")
		-- bn:processProjectile(self)
		-- bn:Spawn()

		self:SetNoDraw(true)

		td.start = self:GetPos()
		td.endpos = self:GetPos() + dn
		td.filter = self

		tr = util.TraceLine(td)

		if tr.Hit then
			self:SetPos(tr.HitPos)
		end

		t = 2
	end

	SafeRemoveEntityDelayed(self, t)
end

function ENT:Think()
	if self:WaterLevel() != 0 then
		self:Detonate()
	end
end
