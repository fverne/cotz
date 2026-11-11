-- Run from the addon root: luatex --luaonly tests/anomaly_damage_spec.lua
local checks = 0
local function check(condition, message)
	checks = checks + 1
	assert(condition, message)
end

local vectorMeta = {}
vectorMeta.__index = vectorMeta
local function vector(x, y, z)
	return setmetatable({x = x or 0, y = y or 0, z = z or 0}, vectorMeta)
end
vectorMeta.__add = function(first, second)
	return vector(first.x + second.x, first.y + second.y, first.z + second.z)
end

local function damageInfo()
	local info = {}
	function info:SetDamage(value) self.amount = value end
	function info:SetDamageType(value) self.damageType = value end
	function info:SetAttacker(value) self.attacker = value end
	function info:SetInflictor(value) self.inflictor = value end
	function info:SetDamagePosition(value) self.position = value end

	return info
end

local definitions = {
	{class = "anom_jarka", damageType = 8, amount = 30},
	{class = "anom_par", damageType = 8, amount = 30},
	{class = "anom_gazirovka_anomaly", damageType = 1048576, amount = 40},
	{class = "anom_kisel_anomaly", damageType = 1048576, amount = 40},
	{class = "anom_maysorubka_anomaly", damageType = 1, amount = 75},
	{class = "anom_maysorubka_anomaly_type2", damageType = 1, amount = 75},
	{class = "anom_electra_anomaly", damageType = 256, amount = 70},
	{class = "anom_electra_anomaly_type2", damageType = 256, amount = 70},
	{class = "anom_voronka_anomaly", damageType = 1, amount = 150, delay = 2, radius = 120},
	{class = "anom_tramplin_anomaly", damageType = 1, amount = 400, delay = 6, radius = 250},
}

for _, definition in ipairs(definitions) do
	local timers, received = {}, {}
	local target = {
		EntIndex = function() return 20 end,
		IsRagdoll = function() return false end,
		TakeDamageInfo = function(_, info) received[#received + 1] = info end,
	}
	local meta = {}
	local origin = vector(100, 200, 300)
	local entity = setmetatable({Active = true, ActiveOnce = true}, {__index = meta})
	entity.EntIndex = function() return 10 end
	entity.GetPos = function() return origin end
	entity.EmitSound = function() end
	entity.StopSound = function() end
	entity.StopParticles = function() end
	entity.SetNWBool = function() end
	if definition.class == "anom_tramplin_anomaly" then entity.Active = false end
	local environment = setmetatable({
		ENT = meta, DMG_BURN = 8, DMG_ACID = 1048576, DMG_CRUSH = 1, DMG_SHOCK = 256,
		AddCSLuaFile = function() end, include = function() end,
		hook = {Add = function() end}, sound = {Add = function() end},
		DamageInfo = damageInfo, IsValid = function(value) return value ~= nil end,
		Vector = vector, Angle = function() end,
		ParticleEffect = function() end, ParticleEffectAttach = function() end,
		timer = {
			Exists = function(name) return timers[name] ~= nil end,
			Create = function(name, delay, repetitions, callback)
				timers[name] = {delay = delay, repetitions = repetitions, callback = callback}
			end,
		},
		util = {BlastDamageInfo = function(info, position, radius)
			received[#received + 1] = info
			info.origin, info.radius = position, radius
		end},
	}, {__index = _G})
	local path = "lua/entities/" .. definition.class .. "/init.lua"
	local file = assert(io.open(path))
	local source = file:read("*a"):gsub("!=", "~="):gsub("!", "not ")
	file:close()
	assert(load(source, "@" .. path, "t", environment))()
	if definition.radius then
		entity:StartTouch(target)
	else
		entity:Touch(target)
	end
	check(#received == 0, definition.class .. " damage waits for its activation timer")
	for _, timerState in pairs(timers) do
		if timerState.delay == (definition.delay or 0) then timerState.callback() end
	end
	check(#received == 1, definition.class .. " activation damages once")
	local info = received[1]
	check(info.damageType == definition.damageType, definition.class .. " applies its intended damage type")
	check(info.amount == definition.amount, definition.class .. " retains its damage amount")
	check(info.attacker == entity and info.inflictor == entity, definition.class .. " retains anomaly attribution")
	if definition.radius then
		local expectedOrigin = definition.radius == 250 and origin + vector(50, 50, 300) or origin
		check(info.radius == definition.radius, definition.class .. " retains its area damage radius")
		check(info.origin.x == expectedOrigin.x and info.origin.y == expectedOrigin.y
			and info.origin.z == expectedOrigin.z, definition.class .. " retains its area damage origin")
		check(info.position == info.origin, definition.class .. " supplies the area origin as damage position")
	else
		entity:Touch(target)
		check(#received == 1, definition.class .. " inactive contact cannot damage again")
	end
end

print("anomaly_damage_spec: " .. checks .. " checks passed")
