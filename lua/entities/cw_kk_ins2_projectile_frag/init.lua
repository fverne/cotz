AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

ENT.ExplodeRadius = 384
ENT.ExplodeDamage = 100
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

	--self:GetPhysicsObject():SetBuoyancyRatio(0)

	self.dangerSound = ents.Create("ai_sound")

	self.dangerSound:SetKeyValue("duration", 10)
	self.dangerSound:SetKeyValue("soundtype", 8)
	self.dangerSound:SetKeyValue("volume", 200)

	self.NextDanger = CurTime()
end

function ENT:OnRemove()
	SafeRemoveEntity(self.dangerSound)
	return false
end

local vel, len, CT

function ENT:PhysicsCollide(data, physobj)
	if IsValid(self.dangerSound) and CurTime() > self.NextDanger then
		self.dangerSound:SetPos(self:GetPos())
		self.dangerSound:Fire("EmitAISound", 0)

		self.NextDanger = CurTime() + 1
	end

	if not self:IsHeldPotato() then
		self.prepareNextPickup = true
	end

	vel = physobj:GetVelocity()
	len = vel:Length()

	if len > 500 then
		physobj:SetVelocity(vel * 0.6)
	end

	if len > 100 then
		CT = CurTime()

		if CT > self.NextImpact then
			self:EmitSound("CW_KK_INS2_FRAG_ENT_BOUNCE", 75, 100)

			self.NextImpact = CT + 0.1
		end
	end
end

function ENT:Fuse(t)
	local p = self:GetOwner()
	self.fuser = IsValid(p) and p or self
	-- self.kaboomboom = CurTime() + (t or 3)

	timer.Simple((t or 3), function()
		if IsValid(self) then
			util.BlastDamage(self, self.fuser, self:GetPos(), self.ExplodeRadius, self.ExplodeDamage)

			local fx = ents.Create("cw_kk_ins2_particles")
			if IsValid(fx) then
				fx:processProjectile(self)
				fx:Spawn()
			end

			local sfx = ents.Create("env_explosion")
			if IsValid(sfx) then
				sfx:SetPos(self:GetPos())
				sfx:SetKeyValue("spawnflags", bit.bor(1,4,8,32,512,1024))
				sfx:SetKeyValue("waterlevel", self:WaterLevel())
				sfx:Fire("eXpLOde")
				SafeRemoveEntityDelayed(sfx, 3)
			end

			SafeRemoveEntity(self)
		end
	end)
end

function ENT:Use(activator, caller)
	if not CustomizableWeaponry_KK.HOME then
		return false
	end

	if IsValid(activator) and activator:IsPlayer() then
		CustomizableWeaponry_KK.ins2.hotPotato:attemptPickUp(activator, self)
	end
end

function ENT:IsHeldPotato()
	return IsValid(self.heldBy) and self.heldBy.dt.Potato == self
end

function ENT:Think()
	-- for _,v in pairs(ents.GetAll()) do
		-- if IsValid(v) and v.IsNPC and v:IsNPC() then
			-- if v:GetPos():Distance(self:GetPos()) < 400 then
				-- v:AddEntityRelationship(self, D_FR, 9999)
			-- end
		-- end
	-- end

	if self.prepareNextPickup then
		self.prepareNextPickup = false

		self:SetCollisionGroup(COLLISION_GROUP_WEAPON)
		self:SetOwner()
	end

	-- if self.kaboomboom and CurTime() > self.kaboomboom then
		-- self.kaboomboom = nil

		-- util.BlastDamage(self, self.fuser, self:GetPos(), self.ExplodeRadius, self.ExplodeDamage)

		-- local fx = ents.Create("cw_kk_ins2_particles")
		-- fx:processProjectile(self)
		-- fx:Spawn()

		-- SafeRemoveEntity(self)
	-- end
end