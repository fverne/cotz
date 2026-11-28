-- Server effects shared by the field anomalies. The particle systems come from particles/cotz_anomalies.pcf.
local GIB_PARTICLE = "wick_gore_bloodsplash_new"
local GIB_SOUNDS = {"anomaly/anomaly_body_tear_1.wav", "anomaly/anomaly_body_tear_2.wav"}
local ZERO_ANGLE = Angle(0, 0, 0)

local fx = {}

-- Raises the client light preset's activated state for a moment.
function fx.Flash(anomaly, duration)
	anomaly:SetNWBool("Activated", true)
	timer.Create("cotz/anomalies/flash/" .. anomaly:EntIndex(), duration, 1, function()
		if IsValid(anomaly) then
			anomaly:SetNWBool("Activated", false)
		end
	end)
end

-- Plays a one-shot system on a victim, following it while it lives.
function fx.Hit(victim, particle)
	if not IsValid(victim) then return end

	ParticleEffectAttach(particle, PATTACH_ABSORIGIN_FOLLOW, victim, 0)
end

function fx.Burst(particle, position)
	ParticleEffect(particle, position, ZERO_ANGLE)
end

-- Tears apart corpses and destroys dropped weapons, as the original field anomalies do.
function fx.Consume(entity)
	if not IsValid(entity) or entity:IsMarkedForDeletion() then return end

	if entity:IsRagdoll() and entity:GetNetVar("player") == nil then
		entity:EmitSound(GIB_SOUNDS[math.random(#GIB_SOUNDS)], 100, 98, 1, CHAN_AUTO)
		ParticleEffect(GIB_PARTICLE, entity:GetPos(), ZERO_ANGLE)
		entity:Remove()
	elseif entity.ixItemID and ix and ix.item.instances[entity.ixItemID]
		and ix.item.instances[entity.ixItemID].isWeapon then
		entity:Remove()
	end
end

function fx.Damage(anomaly, victim, amount, damageType, position)
	local damageInfo = DamageInfo()
	damageInfo:SetDamage(amount)
	damageInfo:SetDamageType(damageType)
	damageInfo:SetAttacker(anomaly)
	damageInfo:SetInflictor(anomaly)
	damageInfo:SetDamagePosition(position or victim:WorldSpaceCenter())
	victim:TakeDamageInfo(damageInfo)
end

-- Living things an anomaly can hurt: players, NPCs and NextBots.
function fx.IsCreature(entity)
	if entity:IsPlayer() then
		return entity:Alive() and entity:GetMoveType() ~= MOVETYPE_NOCLIP
	end

	return entity:IsNPC() or entity:IsNextBot()
end

function fx.Clear(anomaly)
	timer.Remove("cotz/anomalies/flash/" .. anomaly:EntIndex())
end

return fx
