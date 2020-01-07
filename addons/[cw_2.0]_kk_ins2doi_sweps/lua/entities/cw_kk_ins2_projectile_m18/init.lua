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
	vel = physobj:GetVelocity()
	len = vel:Length()

	if len > 500 then -- let it roll
		physobj:SetVelocity(vel * 0.6) -- cheap as fuck, but it works
	end

	if len > 100 then
		CT = CurTime()

		if CT > self.NextImpact then
			self:EmitSound("CW_KK_INS2_SMOKE_ENT_BOUNCE", 75, 100)
			self.NextImpact = CT + 0.1
		end
	end
end

function ENT:Fuse(t)
	t = t or 3

	timer.Simple(t, function()
		if self:IsValid() then
			self.canDoAnother = CurTime() + 4

			local smokeScreen = ents.Create("cw_smokescreen_impact")
			smokeScreen:SetPos(self:GetPos())
			smokeScreen:Spawn()
			-- smokeScreen:CreateParticles()

			self:EmitSound("CW_KK_INS2_SMOKE_ENT_DETONATE", 100, 100)
			self:EmitSound("CW_KK_INS2_SMOKE_ENT_LOOP", 100, 100)

			timer.Simple(15, function()
				if IsValid(self) then
					self:StopSound("CW_KK_INS2_SMOKE_ENT_LOOP")
					self:EmitSound("CW_KK_INS2_SMOKE_ENT_END", 100, 100)
				end
			end)

			local fx = ents.Create("cw_kk_ins2_particles")
			fx:processProjectile(self)
			fx:Spawn()

			SafeRemoveEntityDelayed(self, 30)
		end
	end)
end

function ENT:Think()
	if self:GetVelocity():Length() < 40 then
		if not self.canDoAnother then return end
		if self.canDoAnother > CurTime() then return end

		self.canDoAnother = false

		local smokeScreen = ents.Create("cw_smokescreen_impact")
		smokeScreen:SetPos(self:GetPos())
		smokeScreen:Spawn()
		-- smokeScreen:CreateParticles()
	end
end
