local PLUGIN = PLUGIN
local active = {}
local TICK_INTERVAL = 1

local function isFinite(value)
	return type(value) == "number" and value == value and value > -math.huge and value < math.huge
end

local function normalize(value)
	if not isFinite(value) then return 0 end

	return math.Clamp(value, 0, ix.config.Get("bleedingMaximum", 100))
end

local function synchronize(client, severity)
	local display = math.ceil(severity)
	if client:GetLocalVar("bleedingSeverity", 0) ~= display then
		client:SetLocalVar("bleedingSeverity", display)
	end
end

function PLUGIN:GetBleeding(client)
	local character = client:GetCharacter()

	return character and normalize(character:GetData("bleedingSeverity", 0)) or 0
end

function PLUGIN:SetBleedingSeverity(client, severity)
	local character = client:GetCharacter()
	if not character then return end

	severity = normalize(severity)
	character:SetData("bleedingSeverity", severity, true)
	synchronize(client, severity)

	if severity <= 0 then
		active[client] = nil
	elseif not active[client] or active[client].character ~= character then
		active[client] = {character = character, nextTick = CurTime() + TICK_INTERVAL, fraction = 0}
	end
end

function PLUGIN:AddBleeding(client, amount)
	if not isFinite(amount) or amount <= 0 or not client:Alive() then return end

	self:SetBleedingSeverity(client, self:GetBleeding(client) + amount)
end

function PLUGIN:HealBleeding(client, amount)
	if not isFinite(amount) or amount <= 0 then return end

	self:SetBleedingSeverity(client, self:GetBleeding(client) - amount)
end

function PLUGIN:PostEntityTakeDamage(entity, damageInfo, wasDamageTaken)
	if not wasDamageTaken or not entity:IsPlayer() or not entity:Alive() or not entity:GetCharacter() then
		return
	end

	if not damageInfo:IsDamageType(DMG_BULLET) and not damageInfo:IsDamageType(DMG_SLASH) then return end

	local damage = damageInfo:GetDamage()
	if not isFinite(damage) or damage <= 0 then return end

	local scale = ix.config.Get("bleedingChanceScale", 100)
	local exponent = ix.config.Get("bleedingChanceExponent", 2)
	local chance = math.min(damage / scale, 1) ^ exponent
	local result = math.Rand(0, 1)
	if chance >= 1 or result < chance then
		self:AddBleeding(entity, damage)
	end
end

function PLUGIN:ProcessBleeding()
	local now = CurTime()
	for client, state in pairs(active) do
		if not IsValid(client) or client:GetCharacter() ~= state.character then
			active[client] = nil
		elseif now >= state.nextTick then
			self:TickBleeding(client, state, now)
		end
	end
end

function PLUGIN:TickBleeding(client, state, now)
	-- Never catch up missed ticks after a stall, spawn, or character transition.
	state.nextTick = now + TICK_INTERVAL
	if not client:Alive() then return end

	local severity = self:GetBleeding(client)
	state.fraction = state.fraction + severity * ix.config.Get("bleedingDamageScale", 0.04)
	local damage = math.floor(state.fraction)
	state.fraction = state.fraction - damage
	self:SetBleedingSeverity(client, severity - ix.config.Get("bleedingClotRate", 1))

	if damage > 0 then
		local damageInfo = DamageInfo()
		damageInfo:SetDamage(damage)
		damageInfo:SetDamageType(DMG_GENERIC)
		damageInfo:SetAttacker(game.GetWorld())
		damageInfo:SetInflictor(game.GetWorld())
		client:TakeDamageInfo(damageInfo)
	end
end

function PLUGIN:RestoreBleeding(client)
	active[client] = nil
	self:SetBleedingSeverity(client, self:GetBleeding(client))
end

function PLUGIN:StopBleeding(client)
	active[client] = nil
end
