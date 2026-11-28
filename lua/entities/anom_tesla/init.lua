AddCSLuaFile("shared.lua")
AddCSLuaFile("cl_init.lua")
include("shared.lua")

local fx = include("cotz/anomalies/sv_fx.lua")

-- Explicit balancing parameters used by the spreadsheet export/import tool.
ENT.BalanceDamage = 45
ENT.BalanceCooldown = 9
ENT.BalanceRadius = 320
-- Entering this range starts the charge; it matches the idle effect, while the discharge reaches further.
ENT.DetectRadius = 150

-- Warning between the crackle and the discharge, long enough to reach cover.
ENT.ChargeTime = 2.5
-- Damage at the edge of the field, as a share of the full discharge.
ENT.EdgeDamage = 0.5
ENT.CoreHeight = 40

local SCAN_INTERVAL = 0.5

function ENT:Initialize()
	baseclass.Get("cotz_anomaly_base").Initialize(self)
	self.nextDischarge = 0
end

function ENT:GetCore()
	return self:GetPos() + Vector(0, 0, self.CoreHeight)
end

-- Cover between the core and a victim shields it from the discharge.
function ENT:IsExposed(victim, core)
	local trace = util.TraceLine({
		start = core,
		endpos = victim:WorldSpaceCenter(),
		mask = MASK_SOLID,
		filter = {self, victim},
	})

	return not trace.Hit
end

function ENT:FindVictims(radius)
	local victims = {}
	for _, entity in ipairs(ents.FindInSphere(self:GetPos(), radius)) do
		if fx.IsCreature(entity) then
			victims[#victims + 1] = entity
		end
	end

	return victims
end

function ENT:Discharge()
	local core = self:GetCore()
	self:EmitSound("cotz_tesla_blast")
	fx.Burst("cotz_anom_tesla_blast", core)

	for _, victim in ipairs(self:FindVictims(self.BalanceRadius)) do
		if self:IsExposed(victim, core) then
			local share = 1 - (1 - self.EdgeDamage) * math.min(victim:GetPos():Distance(core) / self.BalanceRadius, 1)
			fx.Damage(self, victim, self.BalanceDamage * share, DMG_SHOCK, core)
			fx.Hit(victim, "cotz_anom_electra_hit")
		end
	end

	self.charging = false
	self.nextDischarge = CurTime() + self.BalanceCooldown
end

function ENT:StartCharge()
	self.charging = true
	self:EmitSound("cotz_tesla_charge")
	fx.Burst("cotz_anom_tesla_charge", self:GetCore())
	fx.Flash(self, self.ChargeTime + 0.6)

	timer.Create("cotz/anomalies/tesla/" .. self:EntIndex(), self.ChargeTime, 1, function()
		if IsValid(self) then
			self:Discharge()
		end
	end)
end

function ENT:Think()
	if not self:HasPlayerNear() then
		self:NextThink(CurTime() + 1)

		return true
	end

	if not self.charging and CurTime() >= self.nextDischarge and #self:FindVictims(self.DetectRadius) > 0 then
		self:StartCharge()
	end
	self:NextThink(CurTime() + SCAN_INTERVAL)

	return true
end

function ENT:OnRemove()
	timer.Remove("cotz/anomalies/tesla/" .. self:EntIndex())
	self:StopSound("cotz_tesla_blast")
	fx.Clear(self)
end
