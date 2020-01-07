AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

function ENT:Think()
	self:SetBodygroup(0,1)

	if self.dt.State == self.States.misfired then
		return
	end

	local CT = CurTime()

	if CT > self.selfDestructTime then
		if self.safetyBypass and self.missfiredArmTime then return end
		self:selfDestruct()
	elseif CT > self.ArmTime then
		self.dt.State = self.States.armed

		local phys = self:GetPhysicsObject()

		if IsValid(phys) then

			if not self.ArmDir or self.safetyBypass then
				self.ArmDir = phys:GetVelocity()
			end

			phys:SetVelocity((self.ArmDir:GetNormalized() * 5787.39) + VectorRand() * 10)

			local ang = self:GetAngles()
			ang:RotateAroundAxis(ang:Forward(), 10)
			self:SetAngles(ang)

		end

	end
end

function ENT:Use(activator, caller)
	return false
end

function ENT:OnRemove()
	return false
end

local vel, len

function ENT:Touch(ent)
	if !IsValid(ent) then return end
	if !ent:IsPlayer() and !ent:IsNPC() then return end

	if self.dt.State != self.States.misfired and CurTime() > self.ArmTime then
		self:selfDestruct()
	end
end

function ENT:PhysicsCollide(data, physobj)
	if self.dt.State == self.States.misfired then
		vel = physobj:GetVelocity()
		len = vel:Length()

		if len > 500 then
			physobj:SetVelocity(vel * 0.6)
		end

		return
	end

	if CurTime() > self.ArmTime then
		if self.safetyBypass and self.missfiredArmTime and (CurTime() < self.missfiredArmTime) then
			return
		end

		self:selfDestruct()
	else
		self:EmitSound("physics/metal/metal_grenade_impact_hard" .. math.random(1, 3) .. ".wav", 80, 100)
		if self.safetyBypass then
			self.missfiredArmTime = self.ArmTime + 0.75
		else
			self.dt.State = self.States.misfired
		end

		vel = physobj:GetVelocity()
		len = vel:Length()

		if len > 500 then
			physobj:SetVelocity(vel * 0.6)
		end
	end
end

function ENT:selfDestruct()
	if self.HadEnough then
		return
	end

	self.HadEnough = true

	if self.DontDestroy then return end

	util.BlastDamage(self, self.Owner, self:GetPos(), self.BlastRadius, self.BlastDamage)

	local fx = ents.Create("cw_kk_ins2_particles")
	fx:processProjectile(self)
	fx:Spawn()

	SafeRemoveEntity(self)
end

function ENT:OnTakeDamage(dmg)
	self:selfDestruct()
end
