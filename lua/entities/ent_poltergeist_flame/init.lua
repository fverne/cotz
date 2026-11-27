AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

ENT.WarningSeconds = 1.1
ENT.BurnSeconds = 2.4
ENT.PulseInterval = 0.5
ENT.BurnRadius = 72
ENT.BurnHeight = 96
ENT.BurnDamage = 8

local CARRIER_MODEL = "models/hunter/misc/sphere025x025.mdl"
local WARNING_SOUND = "npc/poltergeist/fire_idle_0.ogg"
local ERUPTION_SOUND = "npc/poltergeist/attack_hit_flame.ogg"
local FEET_TOLERANCE = 32

function ENT:Initialize()
	self:SetModel(CARRIER_MODEL)
	self:SetMoveType(MOVETYPE_NONE)
	self:SetSolid(SOLID_NONE)
	self:DrawShadow(false)
	self.cotzEruptAt = CurTime() + self.WarningSeconds
	self:EmitSound(WARNING_SOUND, 75)
end

-- A cylinder, so players on another floor are not burned through it.
function ENT:BurnPulse()
	local owner = self:GetOwner()
	local origin = self:GetPos()
	local radiusSqr = self.BurnRadius ^ 2
	for _, victim in ipairs(ents.FindInSphere(origin, self.BurnRadius + self.BurnHeight)) do
		local offset = victim:GetPos() - origin
		local inside = offset.x ^ 2 + offset.y ^ 2 <= radiusSqr
			and offset.z >= -FEET_TOLERANCE and offset.z <= self.BurnHeight
		if inside and victim ~= owner and (victim:IsPlayer() or victim:IsNPC()) and victim:Health() > 0
			and owner:STALKERNPCCanAttackThis(victim) then
			local info = DamageInfo()
			info:SetDamage(self.BurnDamage)
			info:SetDamageType(DMG_BURN)
			info:SetAttacker(owner)
			info:SetInflictor(self)
			info:SetDamagePosition(victim:WorldSpaceCenter())
			victim:TakeDamageInfo(info)
		end
	end
end

function ENT:Think()
	local owner = self:GetOwner()
	if not IsValid(owner) or owner.IsAlive == false then
		self:Remove()
		return
	end

	local now = CurTime()
	if not self:GetErupting() then
		if now >= self.cotzEruptAt then
			self:SetErupting(true)
			self:EmitSound(ERUPTION_SOUND, 80)
			self.cotzBurnUntil = now + self.BurnSeconds
			self.cotzNextPulse = now
		end
	elseif now >= self.cotzBurnUntil then
		self:Remove()
		return
	end

	if self:GetErupting() and now >= self.cotzNextPulse then
		self.cotzNextPulse = now + self.PulseInterval
		self:BurnPulse()
	end
	self:NextThink(now + 0.1)

	return true
end

function ENT:OnRemove()
	self:StopSound(WARNING_SOUND)
end
