AddCSLuaFile("shared.lua")
AddCSLuaFile("cl_init.lua")
include("shared.lua")

local fx = include("cotz/anomalies/sv_fx.lua")

local mutantCapture = include("cotz/anomalies/sv_mutantcapture.lua")

-- Matches the burst inside cotz_anom_karusel_charge.
local BURST_TIME = 6.15
-- The charge never ends on its own. Stop it once the burst has emitted, before the idle effect returns.
local CHARGE_END_TIME = 6.5

hook.Add( "OnDamagedByExplosion", "DisableSound", function()
	return true
end )

sound.Add( {
	name = "tramplin_blast",
	channel = CHAN_STATIC,
	volume = 1,
	level = 100,
	pitch = 100,
	sound = "anomaly/tramplin_blast.wav"
} )

function ENT:Initialize()
	self:SetModel("models/props_junk/watermelon01.mdl")

	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)  
	self:SetSolid(SOLID_BBOX)	
	self:SetCollisionGroup(COLLISION_GROUP_WORLD)
	self:SetName("Tramplin Anomaly")
	self:SetTrigger(1)
	self:SetCollisionBounds( Vector( -90, -90, -5 ), Vector( 90, 90, 80 ) )
	self:SetNWBool("StopParticle", false)
	self.Active = true
	self:SetRenderMode( RENDERMODE_TRANSTEXTURE ) 
	self:SetColor(Color(0,0,0,0))

    local phys = self:GetPhysicsObject()
	if (phys:IsValid()) then
		phys:Sleep()
		phys:EnableMotion(false)
	end
end

function ENT:SpawnFunction( ply, tr, ClassName, activator )
	if ( !tr.Hit ) then return end
	local SpawnPos = tr.HitPos + Vector(0, 0, 4)
	local SpawnAng = tr.HitNormal:Angle()
	SpawnAng.p = SpawnAng.p +90
	local ent = ents.Create( ClassName )
	ent:SetPos( SpawnPos )
	ent:SetAngles( SpawnAng )
	ent:Spawn()
	ent:Activate()
	ent:SetTrigger( 1 )
	ent:SetColor( Color( 0, 0, 0, 0 ) )
	ent:SetRenderMode( RENDERMODE_TRANSALPHA ) 
	return ent
end

function ENT:Think()
	if ix and ix.eventController and not ix.eventController:HasPlayerNear(self:GetPos(), 2500) then
		self:NextThink(CurTime() + 1)

		return true
	end
	local core = self:GetPos() + Vector(0, 0, 300)
	mutantCapture.Update(self, core, 300, core, "tramplin_recharge" .. self:EntIndex(),
		function(ragdoll) self:StartBlastCycle(ragdoll) end)
	for _, v in ipairs(ents.FindInSphere(self:GetPos()+Vector(0,0,300),300)) do
		if v == self then return end
		if v:IsPlayer() then
			v:SetVelocity( (self:GetPos()+Vector(0,0,300) - v:GetPos()) * 1.5)
		end
	end
	self:NextThink(CurTime() + 0.2)

	return true
end

function ENT:StartTouch(ent)
	if not self.Active == true then self:StartBlastCycle(ent) end
end

function ENT:StartBlastCycle(ent)
	local restingActive = self.Active
	timer.Create("tramplin_activated_once" .. self:EntIndex(), 0.01, 1, function()
		if not IsValid(self) then return end
		self:EmitSound("tramplin_blast");
		self:StopParticles()
		ParticleEffectAttach("cotz_anom_karusel_charge", PATTACH_ABSORIGIN_FOLLOW, self, 0)
		ParticleEffectAttach("cotz_anom_karusel_swirl", PATTACH_ABSORIGIN_FOLLOW, self, 0)
		fx.Flash(self, 6.5)
		self:StopSound("tramplin_idle")
		self:SetNWBool("StopParticle", true)
		self.Active = true
	end)
	timer.Create("tramplin_stop_sound"..self:EntIndex(), 2, 1, function()
		if not IsValid(self) then return end
		self:StopSound("tramplin_idle")
	end)
	timer.Create("tramplin_recharge"..self:EntIndex(), 6.7, 1, function()
		if not IsValid(self) then return end
		self:SetNWBool("StopParticle", false)
		self.Active = restingActive
	end)
	timer.Create("tramplin_charge_end"..self:EntIndex(), CHARGE_END_TIME, 1, function()
		if IsValid(self) then self:StopParticles() end
	end)
	timer.Create("tramplin_activated"..self:EntIndex(), BURST_TIME, 1, function()
		if not IsValid(self) then return end
		local damageOrigin = self:GetPos() + Vector(50, 50, 300)
		local damageInfo = DamageInfo()
		damageInfo:SetDamage(400)
		damageInfo:SetDamageType(DMG_CRUSH)
		damageInfo:SetAttacker(self)
		damageInfo:SetInflictor(self)
		damageInfo:SetDamagePosition(damageOrigin)
		util.BlastDamageInfo(damageInfo, damageOrigin, 250)
		mutantCapture.Burst(self)
		if IsValid(ent) and ent:IsRagdoll() and ent:GetNetVar("player") == nil
			and not ent:IsMarkedForDeletion() then
			local bodyexplodesounds = {"anomaly/anomaly_body_tear_1.wav", "anomaly/anomaly_body_tear_2.wav"}
			ent:EmitSound(table.Random(bodyexplodesounds),100,98,1,CHAN_AUTO)
			ParticleEffect("wick_gore_bloodsplash_new" , ent:GetPos(), Angle( 0, 0, 0 ) )
			ent:Remove()
		elseif IsValid(ent) and ent.ixItemID and ix.item.instances[ent.ixItemID]
			and ix.item.instances[ent.ixItemID].isWeapon then
			ent:Remove()
		end
		--ply:TakeDamage(99999, self, self)
	end)
end

function ENT:OnRemove()
	timer.Remove("tramplin_activated_once" .. self:EntIndex())
	self.Timer = "tramplin_" .. self:EntIndex()
	self:StopSound("tramplin_idle")
	timer.Remove(self.Timer)
	timer.Remove("tramplin_recharge"..self:EntIndex())
	timer.Remove("tramplin_activated"..self:EntIndex())
	timer.Remove("tramplin_stop_sound"..self:EntIndex())
	timer.Remove("tramplin_charge_end"..self:EntIndex())
	fx.Clear(self)
end
