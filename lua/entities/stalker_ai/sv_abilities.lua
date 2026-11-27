-- Declarative mutant abilities. A class lists them in ENT.Abilities; see docs/mutant-base.md.
-- Phases advance from Think by timestamp comparison, so abilities create no timers and no per-tick tables.
local DEFAULT_CHECK_INTERVAL = 0.2
local DEFAULT_LANDING_TIMEOUT = 3
local MELEE_IN_RANGE = 2

local validatedDefinitions = setmetatable({}, {__mode = "k"})

local function reportInvalid(actor, message)
	ErrorNoHalt(string.format("[COTZ mutant abilities] %s: %s\n", actor:GetClass(), message))
end

local function validPhaseDuration(duration)
	if isnumber(duration) then return duration >= 0 end

	return istable(duration) and isnumber(duration[1]) and isnumber(duration[2])
		and duration[1] >= 0 and duration[2] >= duration[1]
end

local function validateDefinitions(actor, abilities)
	local names = {}
	for index, ability in ipairs(abilities) do
		if not isstring(ability.name) or names[ability.name] then
			return false, "ability " .. index .. " needs a unique name"
		end
		names[ability.name] = true
		if not istable(ability.phases) or #ability.phases == 0 then
			return false, ability.name .. " needs at least one phase"
		end
		for phaseIndex, phase in ipairs(ability.phases) do
			if not validPhaseDuration(phase.duration) then
				return false, ability.name .. " phase " .. phaseIndex .. " needs a duration or {min, max}"
			end
		end
	end

	return true
end

local function phaseDuration(phase)
	local duration = phase.duration
	if isnumber(duration) then return duration end

	return math.Rand(duration[1], duration[2])
end

-- Callbacks are method names so subclasses can override them; plain functions are accepted too.
local function runCallback(actor, callback, ...)
	if not callback then return end
	if isstring(callback) then
		local method = actor[callback]
		if not method then
			reportInvalid(actor, "missing ability method " .. callback)
			return
		end

		return method(actor, ...)
	end

	return callback(actor, ...)
end

local function currentEnemy(actor)
	local enemy = actor:GetEnemy()
	if IsValid(enemy) then return enemy end
end

function ENT:STALKERNPCInitAbilities()
	local abilities = self.Abilities
	local validated = validatedDefinitions[abilities]
	if validated == nil then
		local valid, message = validateDefinitions(self, abilities)
		if not valid then reportInvalid(self, message) end
		validated = valid
		validatedDefinitions[abilities] = valid
	end
	if not validated then
		-- Shadow the class list so a broken definition disables abilities instead of erroring every tick.
		self.Abilities = nil
		return
	end

	local now = CurTime()
	self.cotzAbilityReady = {}
	self.cotzAbilityByName = {}
	for _, ability in ipairs(abilities) do
		self.cotzAbilityReady[ability.name] = now + (ability.initialCooldown or 0)
		self.cotzAbilityByName[ability.name] = ability
	end
end

function ENT:STALKERNPCCanStartAbility(ability, enemy, distanceSqr, meleeRange, now)
	if ability.triggerOnly or self.cotzAbilityReady[ability.name] > now then return false end
	if ability.meleeRange == "outside" and meleeRange == MELEE_IN_RANGE then return false end
	if ability.meleeRange == "inside" and meleeRange ~= MELEE_IN_RANGE then return false end
	if ability.minRange and distanceSqr < ability.minRange ^ 2 then return false end
	if ability.maxRange and distanceSqr > ability.maxRange ^ 2 then return false end
	if ability.chance and math.random() >= ability.chance then return false end
	if ability.canUse and not runCallback(self, ability.canUse, enemy, ability) then return false end

	return true
end

-- Called from Think only while the enemy is visible and no animation or ability is running.
function ENT:STALKERNPCTryAbilities(enemy, meleeRange)
	local now = CurTime()
	if now < (self.cotzNextAbilityCheck or 0) then return false end
	self.cotzNextAbilityCheck = now + (self.AbilityCheckInterval or DEFAULT_CHECK_INTERVAL)
	if (self.NextAbilityTime or 0) > now then return false end

	local distanceSqr = self:GetPos():DistToSqr(enemy:GetPos())
	for _, ability in ipairs(self.Abilities) do
		if self:STALKERNPCCanStartAbility(ability, enemy, distanceSqr, meleeRange, now) then
			return self:STALKERNPCStartAbility(ability, enemy)
		end
	end

	return false
end

-- Starts a named ability outside normal selection, for example from damage. Cooldowns still apply.
function ENT:STALKERNPCTriggerAbility(name)
	if not self.Abilities or self.IsAlive == false or self.cotzSleeping then return false end
	local ability = self.cotzAbilityByName[name]
	if not ability or self.cotzAbilityReady[name] > CurTime() then return false end
	if not ability.interrupts and (self.cotzAbility or self.PlayingAnimation) then return false end

	return self:STALKERNPCStartAbility(ability, currentEnemy(self))
end

function ENT:STALKERNPCStartAbility(ability, enemy)
	if self.cotzAbility or self.PlayingAnimation then
		if not ability.interrupts then return false end
		self:STALKERNPCFinishAbility(true)
		-- Pending melee hits belong to the interrupted animation.
		self.meleeAttackTimers = {}
		self:STALKERNPCStopAllTimers()
		if self.PlayingAnimation then self:STALKERNPCClearAnimation() end
	end

	local now = CurTime()
	self.cotzAbilityReady[ability.name] = now + (ability.cooldown or 0)
	local state = {definition = ability, enemy = enemy, phase = 0}
	self.cotzAbility = state
	self:STALKERNPCSetAbilityPhase(state, 1, now)

	return true
end

function ENT:STALKERNPCSetAbilityPhase(state, index, start)
	local phase = state.definition.phases[index]
	state.phase = index
	state.phaseStart = start
	state.phaseEnd = start + phaseDuration(phase)
	if phase.animation then
		state.animated = true
		self:STALKERNPCPlayAnimation(phase.animation, 1)
	end
	runCallback(self, phase.method, currentEnemy(self), state)
end

function ENT:STALKERNPCUpdateAbility()
	local state = self.cotzAbility
	local now = CurTime()
	-- Idle think intervals can skip past several short phases; run each phase's method in order.
	while self.cotzAbility == state and now >= state.phaseEnd do
		local phases = state.definition.phases
		local phase = phases[state.phase]
		local start = state.phaseEnd
		if phase.untilGrounded then
			local landingTimeout = state.phaseStart + (phase.maxDuration or DEFAULT_LANDING_TIMEOUT)
			if not self:IsOnGround() and now < landingTimeout then return end
			start = now
		end
		if state.phase >= #phases then
			self:STALKERNPCFinishAbility(false)
			return
		end
		self:STALKERNPCSetAbilityPhase(state, state.phase + 1, start)
	end
end

function ENT:STALKERNPCFinishAbility(cancelled)
	local state = self.cotzAbility
	if not state then return end

	self.cotzAbility = nil
	local ability = state.definition
	runCallback(self, ability.onFinish, state, cancelled)
	if state.animated and self.IsAlive ~= false then
		self:STALKERNPCStopAllTimers()
		self:STALKERNPCClearAnimation()
	end
	if ability.recovery then
		self.NextAbilityTime = math.max(self.NextAbilityTime or 0, CurTime() + ability.recovery)
	end
end

-- Only the first phase is a windup. Later phases have already acted and finish their recovery.
function ENT:STALKERNPCCancelAbilityWindup()
	local state = self.cotzAbility
	if not state or state.phase ~= 1 or state.definition.cancelOnTargetLoss == false then return end

	self:STALKERNPCFinishAbility(true)
end

function ENT:STALKERNPCAbilityLaunchProjectile(class, enemy, speed, offset)
	local origin = self:GetPos() + self:GetForward() * offset.x + self:GetRight() * offset.y
		+ self:GetUp() * offset.z
	local target = enemy and enemy:WorldSpaceCenter() or origin + self:GetForward() * speed
	local direction = (target - origin):GetNormalized()

	local projectile = ents.Create(class)
	if not IsValid(projectile) then return end
	projectile:SetPos(origin)
	projectile:SetAngles(direction:Angle())
	projectile:Spawn()
	projectile:SetOwner(self)
	local physics = projectile:GetPhysicsObject()
	if IsValid(physics) then physics:SetVelocity(direction * speed) end

	return projectile
end

-- One sphere query per pulse; only living players and NPCs this mutant may attack are hit.
function ENT:STALKERNPCAbilityPulse(radius, damage, damageType, requireVisible)
	local origin = self:WorldSpaceCenter()
	local hits = 0
	for _, target in ipairs(ents.FindInSphere(origin, radius)) do
		if target ~= self and (target:IsPlayer() or target:IsNPC()) and target:Health() > 0
			and self:STALKERNPCCanAttackThis(target) and (not requireVisible or self:Visible(target)) then
			local info = DamageInfo()
			info:SetDamage(damage)
			info:SetDamageType(damageType)
			info:SetAttacker(self)
			info:SetInflictor(self)
			info:SetDamagePosition(target:WorldSpaceCenter())
			target:TakeDamageInfo(info)
			hits = hits + 1
		end
	end

	return hits
end

function ENT:STALKERNPCAbilityLeap(enemy, aimHeight, speedScale)
	if not enemy then return false end

	local position = self:GetPos()
	local target = enemy:GetPos()
	local aim = Vector(target.x, target.y, target.z + aimHeight) + self:OBBCenter()
	local direction = (aim - position):GetNormalized()
	self:SetVelocity(direction * position:Distance(target) * speedScale)

	return true
end
