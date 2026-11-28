AddCSLuaFile("shared.lua")
AddCSLuaFile("cl_init.lua")
include("shared.lua")

local fx = include("cotz/anomalies/sv_fx.lua")

-- Explicit balancing parameters used by the spreadsheet export/import tool.
-- PsyHealth lost per tick at the centre; the edge deals EdgeDamage of it.
ENT.BalanceDamage = 4
ENT.BalanceCooldown = 1

ENT.EdgeDamage = 0.4
-- A pulse of voices every PulseMin-PulseMax seconds deals PulseDamage on top of the steady drain.
ENT.PulseMin = 8
ENT.PulseMax = 14
ENT.PulseDamage = 10

function ENT:Initialize()
	baseclass.Get("cotz_anomaly_base").Initialize(self)
	self.nextPulse = CurTime() + math.Rand(self.PulseMin, self.PulseMax)
end

-- PsyHealth only applies to players; DMG_SONIC would wound NPCs instead.
function ENT:Drain(amount)
	local origin = self:GetPos()
	for _, client in ipairs(ents.FindInSphere(origin, self.BalanceRadius)) do
		if client:IsPlayer() and fx.IsCreature(client) then
			local depth = 1 - math.min(client:GetPos():Distance(origin) / self.BalanceRadius, 1)
			fx.Damage(self, client, amount * (self.EdgeDamage + (1 - self.EdgeDamage) * depth), DMG_SONIC, origin)
		end
	end
end

function ENT:Pulse()
	self.nextPulse = CurTime() + math.Rand(self.PulseMin, self.PulseMax)
	self:EmitSound("cotz_psy_voices")
	fx.Burst("cotz_anom_psy_pulse", self:GetPos() + Vector(0, 0, 40))
	fx.Flash(self, 1.5)
	self:Drain(self.PulseDamage)
end

function ENT:Think()
	if not self:HasPlayerNear() then
		self:NextThink(CurTime() + 1)

		return true
	end

	self:Drain(self.BalanceDamage)
	if CurTime() >= self.nextPulse then
		self:Pulse()
	end
	self:NextThink(CurTime() + self.BalanceCooldown)

	return true
end

function ENT:OnRemove()
	self:StopSound("cotz_psy_voices")
	fx.Clear(self)
end
