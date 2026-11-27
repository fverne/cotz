-- Run from the addon root: luatex --luaonly tests/mutant_flight_spec.lua
local fixture = dofile("tests/helpers/mutant_base.lua")
local checks = 0
local function check(value, message)
	checks = checks + 1
	assert(value, message)
end

local traces = 0
local blocker
util = {TraceHull = function(data)
	traces = traces + 1
	local output = data.output
	local hit = blocker and blocker(data.start, data.endpos)
	output.Hit = hit ~= nil
	output.Fraction = hit and hit.fraction or 1
	output.HitNormal = hit and hit.normal or Vector()
	output.HitPos = hit and data.start or data.endpos
	check(data.filter ~= nil and data.mask == MASK_NPCSOLID, "flight traces filter the flyer and use NPC solids")
end}

local base = fixture.LoadBase("sv_flight")
local SEQUENCES = {S_Idle = 1, S_Fly = 2}

local function newFlyer(extra)
	local flyer = fixture.Actor(base, {
		IdleSequence = "S_Idle", FlightMoveSequence = "S_Fly", MeleeAttackDistance = 16, sequence = 0,
		velocityCalls = 0,
		OBBMins = function() return Vector(-16, -16, 0) end,
		OBBMaxs = function() return Vector(16, 16, 32) end,
		CapabilitiesRemove = function(self, capability) self.removedCapability = capability end,
		SetAutomaticFrameAdvance = function() end,
		SetPos = function(self, position) self.position = position end,
		SetGroundEntity = function() end,
		SetMoveType = function(self, moveType) self.moveType = moveType end,
		LookupSequence = function(_, name) return SEQUENCES[name] or -1 end,
		GetSequence = function(self) return self.sequence end,
		ResetSequence = function(self, sequence) self.sequence = sequence end,
		SetAngles = function(self, angles) self.angles = angles end,
		SetLocalVelocity = function(self, velocity)
			self.velocity = velocity
			self.velocityCalls = self.velocityCalls + 1
		end,
		Visible = function(_, target) return not target.hidden end,
		GetEnemyLastKnownPos = function(_, target) return target.lastKnown end,
	})
	for key, value in pairs(extra or {}) do flyer[key] = value end
	flyer:STALKERNPCInitFlight()

	return flyer
end

local function update(flyer, seconds)
	fixture.now = fixture.now + seconds
	flyer:STALKERNPCUpdateFlight()
end

do
	fixture.now = 100
	local flyer = newFlyer()
	check(flyer.cotzFlying and flyer.moveType == MOVETYPE_FLY and flyer.removedCapability == CAP_MOVE_GROUND,
		"flyers drop ground movement and use fly movement")
	check(flyer.position.z == 24 and flyer.cotzFlightHome.z == 24, "flyers lift off their spawn point when clear")
	check(flyer.cotzFlightMoveSequence == 2 and flyer.cotzFlightIdleSequence == 1, "flight sequences are cached")
end

do
	fixture.now = 100
	local flyer = newFlyer()
	local target = fixture.Target(Vector(300, 0, 0), {player = true})
	flyer.position, flyer.enemy = Vector(), target
	update(flyer, 0)
	check(flyer.velocity.x > 0 and flyer.sequence == 2, "a visible enemy draws the flyer towards it")
	check(math.abs(flyer.velocity:Length() - flyer.FlightSpeed) < 0.001, "flight speed is capped")
	local calls = flyer.velocityCalls
	update(flyer, 0.05)
	check(flyer.velocityCalls == calls, "steering updates are throttled between intervals")

	target.position = Vector(2000, 0, 0)
	update(flyer, 0.2)
	check(flyer.velocity.z > 0, "flyers cruise above distant targets")

	target.position = Vector(40, 0, -36)
	update(flyer, 0.2)
	check(flyer.velocity:LengthSqr() == 0 and flyer.sequence == 1 and flyer.angles.y == 0,
		"flyers hold position and face the target within melee reach")
	calls = flyer.velocityCalls
	update(flyer, 0.2)
	check(flyer.velocityCalls == calls, "holding does not resend a zero velocity")
end

do
	fixture.now = 100
	local flyer = newFlyer()
	flyer.position = Vector()
	flyer.enemy = fixture.Target(Vector(500, 0, 0), {player = true, hidden = true, lastKnown = Vector(0, 400, 0)})
	update(flyer, 0)
	check(flyer.velocity.y > 0 and flyer.velocity.x == 0, "hidden enemies are pursued at their last known position")
	flyer.cotzPlayerVisible, flyer.cotzPlayerPosition = false, Vector(0, -400, 0)
	update(flyer, 0.2)
	check(flyer.velocity.y < 0, "COTZ player memory replaces the engine's last known position")
	flyer.enemy = nil
	update(flyer, 0.2)
	check(flyer.cotzFlightWander and flyer.cotzNextFlightUpdate == fixture.now + 0.5,
		"idle flyers wander near home at the slower idle interval")
end

do
	fixture.now = 100
	local flyer = newFlyer()
	flyer.position, flyer.enemy = Vector(), fixture.Target(Vector(300, 0, 0), {player = true})
	blocker = function(start, finish)
		if finish.z > start.z and finish.x == start.x then return end
		return {fraction = 0.5, normal = Vector(-1, 0, 0)}
	end
	update(flyer, 0)
	check(flyer.velocity:LengthSqr() > 0 and flyer.velocity.x == 0, "flyers slide along partial obstructions")
	blocker = function(start, finish)
		if finish.z > start.z and finish.x == start.x then return end
		return {fraction = 0.1, normal = Vector(-1, 0, 0)}
	end
	flyer.enemy.position = Vector(300, 0, -36)
	update(flyer, 0.2)
	check(flyer.velocity.z > 0 and flyer.velocity.x == 0, "flyers climb over walls that block the direct path")
	blocker = function() return {fraction = 0.1, normal = Vector(-1, 0, 0)} end
	update(flyer, 0.2)
	check(flyer.velocity:LengthSqr() == 0 and flyer.cotzFlightStopped, "fully blocked flyers stop instead of pushing")
	blocker = nil
end

do
	fixture.now = 100
	local flyer = newFlyer()
	flyer.position, flyer.enemy = Vector(), fixture.Target(Vector(300, 0, 0), {player = true})
	update(flyer, 0)
	flyer.PlayingAnimation = true
	update(flyer, 0.2)
	check(flyer.velocity:LengthSqr() == 0, "attack animations stop flight movement")
	flyer.PlayingAnimation = false
	flyer.cotzAbility = {definition = {ownsMovement = true}}
	local calls = flyer.velocityCalls
	update(flyer, 0.2)
	check(flyer.velocityCalls == calls, "abilities that own movement are not overridden")
end

print("mutant flight checks passed: " .. checks)
