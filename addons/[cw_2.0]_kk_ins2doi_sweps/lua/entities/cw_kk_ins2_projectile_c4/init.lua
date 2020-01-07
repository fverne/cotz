AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

local phys, ef

function ENT:Initialize()
	self:SetModel("models/weapons/w_cw_kk_ins2_c4.mdl")
end

function ENT:InitPhys()
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetCollisionGroup(COLLISION_GROUP_NONE)
	self.NextImpact = 0
	phys = self:GetPhysicsObject()

	if phys and phys:IsValid() then
		phys:SetMass(6)
		phys:Wake()
	end

	self:GetPhysicsObject():SetBuoyancyRatio(0)
end

function ENT:OnRemove()
	constraint.RemoveConstraints(self, "Weld")
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
			self:EmitSound("CW_KK_INS2_C4_ENT_BOUNCE", 75, 100)
			self.NextImpact = CT + 0.1
		end
	end
end

function ENT:Fuse(t)
	if self.fusedAlready then
		return
	end

	self.fusedAlready = true

	util.BlastDamage(
		self,
		(self.dt.Detonator and self.dt.Detonator.Owner) or ents.GetByIndex(1),
		self:GetPos(),
		self.BlastRadius,
		self.BlastDamage
	)

	local fx = ents.Create("cw_kk_ins2_particles")
	fx:processProjectile(self)
	fx:Spawn()

	SafeRemoveEntity(self)
end

local td = {}

function ENT:verifyActivatorLOS(activator)
	td.filter = activator
	td.start = activator:EyePos()
	td.endpos = td.start + activator:EyeAngles():Forward() * 256

	local tr = util.TraceLine(td)

	return tr.Hit and tr.Entity == self
end

function ENT:Use(activator, caller)
	if SERVER then
		if not self:verifyActivatorLOS(activator) then
			return
		end

		local det = self.dt.Detonator

		if IsValid(det) and det.Owner == activator then
			activator:GiveAmmo(1, det.Primary.Ammo)
			self:Remove()
		end
	end
end

local curParent

function ENT:Think()
	if IsValid(self.Owner) and self:GetPos():Distance(self.Owner:GetShootPos()) > 30 then
		self:SetOwner()
	end

	curParent = self:GetParent()

	if curParent != self._lastParent and !IsValid(curParent) then
		self:SetMoveType(MOVETYPE_VPHYSICS)
		self:SetSolid(SOLID_VPHYSICS)
	end

	self._lastParent = curParent
end
