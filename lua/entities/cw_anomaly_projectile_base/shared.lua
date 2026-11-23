AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_anim"
ENT.Spawnable = false
ENT.Damage = 0
ENT.Radius = 0
ENT.ContactExplosion = false
ENT.Gravity = true
ENT.Lifetime = 10

function ENT:Initialize()
	if CLIENT then return end
	self:SetModel(self.Model)
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetCollisionGroup(COLLISION_GROUP_PROJECTILE)
	self.ExpireAt = CurTime() + self.Lifetime
	local physics = self:GetPhysicsObject()

	if IsValid(physics) then
		physics:EnableGravity(self.Gravity)
		physics:EnableDrag(false)
		physics:Wake()
	end

	if self.Damage > 0 and not self.ContactExplosion then
		self.KaboomTime = self.KaboomTime or CurTime() + self.FuseTime
	end
end

function ENT:Explode()
	if not SERVER or self.AnomalyExploded then return end
	self.AnomalyExploded = true
	local owner = self:GetOwner()
	util.BlastDamage(self, IsValid(owner) and owner or self, self:GetPos(), self.Radius, self.Damage)
	local effect = EffectData()
	effect:SetOrigin(self:GetPos())
	util.Effect("Explosion", effect)
	self:Remove()
end

function ENT:PhysicsCollide(data)
	if not SERVER then return end

	if self.ContactExplosion then
		-- Physics callbacks must defer entity removal and blast effects until the callback finishes.
		self.AnomalyImpact = true
	elseif data.Speed > 220 then
		self:EmitSound("TFA_ANOMALY.GRENADE.PHYS")
	end
end

function ENT:Touch(entity)
	if not SERVER or self.Damage > 0 then return end
	local class = entity:GetClass()

	if class == "trigger_hurt" or class == "point_hurt" or string.find(class, "anomaly", 1, true) then
		self:EmitSound("ambient/fire/mtov_flame2.wav", 100, 90)
		SafeRemoveEntityDelayed(self, 0)
	end
end

function ENT:Think()
	if not SERVER then return end
	local now = CurTime()

	if self.AnomalyImpact or (self.KaboomTime and now >= self.KaboomTime) then
		self:Explode()
		return
	elseif now >= self.ExpireAt then
		self:Remove()
		return
	end

	self:NextThink(now)
	return true
end

function ENT:Draw()
	self:DrawModel()
end
