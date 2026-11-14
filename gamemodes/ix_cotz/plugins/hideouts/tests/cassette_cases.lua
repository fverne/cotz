local previousTimer = timer
local previousSound = CreateSound
local previousRandom = table.Random
local active = {}
timer = {
	Remove = function(id) active[id] = nil end,
	Create = function(id, duration, repetitions, callback) active[id] = callback end,
}
CreateSound = function()
	return setmetatable({
		Stop = function(self) self.stopped = true end,
		Play = function() end,
		SetSoundLevel = function() end,
	}, {__tostring = function() return string.rep("x", 13) .. "track" end})
end
table.Random = function(values) return values[1] end

Test("cassette playback timers are independent across rooms and clean up per entity", function()
	local function player(id)
		return setmetatable({
			sound = CreateSound(),
			EntIndex = function() return id end,
			EmitSound = function() end,
		}, {__index = ENT})
	end
	local first, second = player(101), player(102)
	first:Repeat({track = {dur = 10}})
	second:Repeat({track = {dur = 10}})
	assert(active["cotz/cassette/101"] and active["cotz/cassette/102"])
	active["cotz/cassette/101"]()
	assert(active["cotz/cassette/101"] and active["cotz/cassette/102"])
	first:Use()
	assert(not active["cotz/cassette/101"] and active["cotz/cassette/102"])
	second:OnRemove()
	assert(not active["cotz/cassette/102"] and second.sound.stopped)
end)

timer, CreateSound, table.Random = previousTimer, previousSound, previousRandom
