-- Server helper for anomalies that pull: a mutant or human NPC in reach dies at once, its corpse is dragged
-- into the anomaly's core, and the next blast gibs it.
local MUTANT_PREFIX = "npc_mutant_"
local HUMAN_PREFIX = "npc_human_"
-- Too heavy to be pulled in. They only take the blast's ordinary damage.
local IMMUNE_CLASSES = {
	["npc_mutant_bear"] = true,
	["npc_mutant_pseudogiant_fast"] = true,
	["npc_mutant_pseudogiant_slow"] = true,
}
local SCAN_INTERVAL = 0.1
local HOLD_INTERVAL = 0.05
local PULL_RATE = 4 -- speed per unit of distance to the core
local MAX_PULL_SPEED = 700
local SPIN_RATE = 2.5 -- radians per second around the corpse's own upright axis
local SPIN_AXIS = Vector(0, 0, 1)
local GIB_PARTICLE = "wick_gore_bloodsplash_new"
local GIB_SOUNDS = {"anomaly/anomaly_body_tear_1.wav", "anomaly/anomaly_body_tear_2.wav"}

local capture = {}
local captives = setmetatable({}, {__mode = "k"})

local function isLiveMutant(entity)
	if entity.IsSTALKERNPC ~= true or entity.IsAlive ~= true then return false end
	local class = entity:GetClass()

	return class:sub(1, #MUTANT_PREFIX) == MUTANT_PREFIX and not IMMUNE_CLASSES[class]
end

-- cotz_human_base has no IsAlive flag. It sets dead and removes itself at the end of the tick.
local function isLiveHuman(entity)
	return entity.IsSTALKERNPC == true and not entity.dead
		and entity:GetClass():sub(1, #HUMAN_PREFIX) == HUMAN_PREFIX
end

local function setGravity(ragdoll, enabled)
	for index = 0, ragdoll:GetPhysicsObjectCount() - 1 do
		local physics = ragdoll:GetPhysicsObjectNum(index)
		if IsValid(physics) then
			physics:EnableGravity(enabled)
			physics:Wake()
		end
	end
end

local function pull(ragdoll, core)
	local center = ragdoll:WorldSpaceCenter()
	for index = 0, ragdoll:GetPhysicsObjectCount() - 1 do
		local physics = ragdoll:GetPhysicsObjectNum(index)
		if IsValid(physics) then
			local velocity = (core - physics:GetPos()) * PULL_RATE
			local speed = velocity:Length()
			if speed > MAX_PULL_SPEED then velocity = velocity * (MAX_PULL_SPEED / speed) end

			physics:Wake()
			-- Added after the clamp so a distant corpse spins while it is dragged in.
			physics:SetVelocity(velocity + SPIN_AXIS:Cross(physics:GetPos() - center) * SPIN_RATE)
		end
	end
end

local function hold(anomaly, ragdoll, core)
	local identifier = "cotz/anomalies/hold-corpse/" .. ragdoll:GetCreationID()
	setGravity(ragdoll, false)
	timer.Create(identifier, HOLD_INTERVAL, 0, function()
		if not IsValid(ragdoll) then
			timer.Remove(identifier)
			return
		end
		if not IsValid(anomaly) then
			setGravity(ragdoll, true)
			timer.Remove(identifier)
			return
		end

		pull(ragdoll, core)
	end)

	captives[anomaly] = captives[anomaly] or {}
	table.insert(captives[anomaly], ragdoll)
end

local function lethalDamage(anomaly, victim)
	local damage = DamageInfo()
	damage:SetDamage(victim:Health())
	damage:SetDamageType(DMG_CRUSH)
	damage:SetAttacker(anomaly)
	damage:SetInflictor(anomaly)
	damage:SetDamagePosition(victim:WorldSpaceCenter())

	return damage
end

local function killMutant(anomaly, mutant)
	local damage = lethalDamage(anomaly, mutant)

	-- Bypasses damage multipliers and immunities, then mirrors the base's lethal damage path.
	mutant:SetHealth(0)
	mutant:STALKERNPCKill(damage)
	mutant.cotzApplyingDeathEffect = true
	mutant:STALKERNPCOnDeath()
	mutant.cotzApplyingDeathEffect = nil
end

local function killHuman(anomaly, human)
	local damage = lethalDamage(anomaly, human)

	-- Bypasses resistances, then mirrors the human base's lethal damage path.
	human:SetHealth(0)
	human.dead = true
	human:KilledDan(damage)
end

local function captureVictim(anomaly, victim, core, kill)
	kill(anomaly, victim)

	-- Victims without a ragdoll have nothing to hold.
	if IsValid(victim.cotzRagdoll) then hold(anomaly, victim.cotzRagdoll, core) end
end

local function hasCaptives(anomaly)
	local held = captives[anomaly]
	if not held then return false end

	for index = #held, 1, -1 do
		if not IsValid(held[index]) then table.remove(held, index) end
	end

	return #held > 0
end

-- Call from the anomaly's Think. startCycle(ragdoll) runs while corpses wait and the anomaly is ready,
-- so a corpse caught during a recharge gets the following blast.
function capture.Update(anomaly, center, radius, core, cycleTimer, startCycle)
	local now = CurTime()
	if now < (anomaly.cotzNextCapture or 0) then return end
	anomaly.cotzNextCapture = now + SCAN_INTERVAL

	for _, entity in ipairs(ents.FindInSphere(center, radius)) do
		if isLiveMutant(entity) then
			captureVictim(anomaly, entity, core, killMutant)
		elseif isLiveHuman(entity) then
			captureVictim(anomaly, entity, core, killHuman)
		end
	end

	if hasCaptives(anomaly) and not timer.Exists(cycleTimer) then startCycle(captives[anomaly][1]) end
end

function capture.Burst(anomaly)
	if not hasCaptives(anomaly) then return end

	for _, ragdoll in ipairs(captives[anomaly]) do
		ragdoll:EmitSound(GIB_SOUNDS[math.random(#GIB_SOUNDS)], 100, 98, 1, CHAN_AUTO)
		ParticleEffect(GIB_PARTICLE, ragdoll:WorldSpaceCenter(), angle_zero)
		ragdoll:Remove()
	end
	captives[anomaly] = nil
end

return capture
