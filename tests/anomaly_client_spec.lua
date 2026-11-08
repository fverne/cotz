-- Run from the addon root: luatex --luaonly tests/anomaly_client_spec.lua
local checks = 0
local function check(value, message)
	checks = checks + 1
	assert(value, message)
end

local function read(path)
	local file = assert(io.open(path))
	local source = file:read("*a")
	file:close()

	return source
end

local function execute(path, environment)
	local source = read(path):gsub("/%*.-%*/", "")
	assert(load(source, "@" .. path, "t", environment))()
end

local vectorMeta = {}
vectorMeta.__index = vectorMeta
function vectorMeta:DistToSqr(other)
	return (self.x - other.x) ^ 2
end

local function vector(x)
	return setmetatable({x = x or 0}, vectorMeta)
end

local definitions = {
	{"anom_electra_anomaly", "electra_static", "electra_idle", "activation"},
	{"anom_electra_anomaly_type2", "electra", "electra_idle"},
	{"anom_gazirovka_anomaly", "gazirovka", "buzz_idle"},
	{"anom_kisel_anomaly", "kisel", "buzz_idle", "chemical"},
	{"anom_maysorubka_anomaly", "myasorubka", "myasorubka_idle", "activation"},
	{"anom_maysorubka_anomaly_type2", "tramplin_type2", "myasorubka_idle", "activation"},
	{"anom_voronka_anomaly", "voronka", "voronka_idle", "activation"},
	{"anom_tramplin_anomaly", "tramplin", "tramplin_idle", "activation"},
	{"anom_jarka", "jarka_inactive", "par_idle"},
	{"anom_par", "jarka_inactive", "par_idle"},
}

local function fixture(definition)
	local state = {now = 10, viewerX = 5000, starts = 0, stops = 0, sounds = 0, silences = 0, lights = 0}
	local view = {EyePos = function() return vector(state.viewerX) end}
	local client = {GetViewEntity = function()
		if state.noView then return end

		return view
	end}
	local options = {Get = function(key, default)
		check(key == "anomalyLights" and default == true, "lighting reads the Helix option with an enabled default")

		return state.lighting ~= false
	end}
	local environment = setmetatable({
		CLIENT = true, SERVER = false, ENT = {}, Vector = vector,
		Color = function(...) return {...} end, RENDERMODE_TRANSALPHA = 4,
		CHAN_STATIC = 1, PATTACH_ABSORIGIN_FOLLOW = 1,
		language = {Add = function() end}, sound = {Add = function() end},
		CurTime = function() return state.now end,
		LocalPlayer = function()
			if state.noPlayer then return end

			return client
		end,
		IsValid = function(value) return type(value) == "table" and value.valid ~= false end,
		ix = {option = options},
		CreateParticleSystem = function(_, name)
			check(name == definition[2], "each class retains its original particle")
			state.starts = state.starts + 1
			if state.failParticle then return end
			local particle = {valid = true, IsValid = function(self) return self.valid end}
			particle.StopEmission = function(self, infiniteOnly, removeAll)
				check(not infiniteOnly and removeAll, "sleep removes the owned particles immediately")
				state.stops = state.stops + 1
				self.valid = false
			end

			return particle
		end,
		DynamicLight = function()
			state.lights = state.lights + 1
			state.light = {}

			return state.light
		end,
	}, {__index = _G})
	local root = "lua/entities/" .. definition[1] .. "/"
	environment.include = function(path)
		execute(path == "shared.lua" and root .. path or "lua/" .. path, environment)
	end
	execute(root .. ((definition[1] == "anom_jarka" or definition[1] == "anom_par")
		and "shared.lua" or "cl_init.lua"), environment)
	local entity = setmetatable({
		GetPos = function() return vector(0) end,
		EntIndex = function() return 1 end,
		IsDormant = function() return state.dormant end,
		GetNWBool = function(_, key) return state[key] or false end,
		SetModel = function(self, model) self.model = model end,
		SetColor = function(self, color) self.color = color end,
		SetRenderMode = function(self, mode) self.mode = mode end,
		SetNextClientThink = function(_, deadline) state.deadline = deadline end,
		EmitSound = function(_, name)
			check(name == definition[3], "each class retains its original idle sound")
			state.sounds = state.sounds + 1
		end,
		StopSound = function() state.silences = state.silences + 1 end,
	}, {__index = environment.ENT})

	return entity, state, environment
end

for _, definition in ipairs(definitions) do
	local entity, state = fixture(definition)
	entity:Initialize()
	check(state.starts == 0, "initialization never starts distant effects")
	check(entity:Think() == true and state.deadline == 10.5, "sleeping thinks are scheduled at half-second intervals")
	check(state.starts == 0 and state.sounds == 0 and state.lights == 0, "distant anomalies do no effect work")
	state.viewerX = 2500
	entity:Think()
	check(state.starts == 1 and state.sounds == 1 and not entity.IsSleeping, "viewer proximity wakes each class")
	check(state.deadline == 10.1, "awake lifecycle checks run at ten Hz")
	entity:Think()
	check(state.starts == 1 and state.sounds == 1, "awake thinks reuse particles and sound")
	state.viewerX = 2600
	entity:Think()
	check(not entity.IsSleeping and state.stops == 0, "sleep margin keeps boundary movement stable")
	state.viewerX = 2751
	entity:Think()
	check(entity.IsSleeping and state.stops == 1 and state.silences == 1, "leaving range stops particles and sound")
	entity:Think()
	check(state.stops == 1 and state.silences == 1, "sleep cleanup only runs on live resources")
	state.viewerX = 2600
	entity:Think()
	check(state.starts == 1, "a sleeping anomaly does not wake inside the hysteresis band")
	state.viewerX = 2400
	entity:Think()
	check(state.starts == 2 and state.sounds == 2, "returning recreates exactly one idle effect")
	if entity.IdleRestartTranslucent then
		check(entity.color[4] == 0 and entity.mode == 4, "restart retains the original invisible proxy presentation")
	end
	if entity.IdleRestartModel then
		check(entity.model == entity.IdleRestartModel, "restart retains each class's existing proxy model")
	end
	state.StopParticle = true
	entity:Think()
	entity:Think()
	check(state.stops == 2 and state.starts == 2, "server cooldown suppresses idle particles without repeated cleanup")
	state.StopParticle = false
	entity:Think()
	check(state.starts == 3 and state.sounds == 2, "cooldown completion restores particles without duplicate sound")
	entity.particle.valid = false
	entity:Think()
	check(state.starts == 4, "engine-stopped particle handles are replaced")
	entity:OnRemove()
	check(state.stops == 3 and state.silences == 2, "removal frees the remaining resources")
	state.dormant = true
	entity:Think()
	check(state.starts == 4 and entity.IsSleeping, "dormant entities cannot restart effects")
end

local chemical, state = fixture(definitions[4])
chemical:Initialize()
state.viewerX = 0
chemical:Think()
check(state.lights == 1 and state.light.size == 128, "chemical anomaly requests one idle light")
state.Activated = true
chemical:Think()
check(state.lights == 2 and state.light.size == 170 and state.light.brightness == 4,
	"activation updates one light with the existing chemical strength")
state.lighting = false
chemical:Think()
check(state.light.size == 0 and state.light.brightness == 0, "lighting toggle clears a live light")
local count = state.lights
chemical:Think()
check(state.lights == count and state.starts == 1, "disabled lights do no further work and preserve hazard particles")
state.lighting = true
chemical:Think()
check(state.lights == count + 1, "lighting can be restored without respawning")
local standalone, standaloneState, standaloneEnvironment = fixture(definitions[4])
standaloneEnvironment.ix = nil
standaloneState.viewerX = 0
standalone:Initialize()
standalone:Think()
check(standaloneState.lights == 1, "lighting remains enabled outside Helix")
standaloneEnvironment.ix = {}
standalone:Think()
check(standaloneState.lights == 2, "lighting works before the Helix option library loads")

local electro, electroState = fixture(definitions[1])
electroState.viewerX = 0
electro:Initialize()
electroState.noPlayer = true
electro:Think()
check(electroState.starts == 0, "client initialization waits for a valid local viewer")
electroState.noPlayer = false
electroState.noView = true
electro:Think()
check(electroState.starts == 0, "missing view entities cannot start effects")
electroState.noView = false
electro:Think()
check(electroState.lights == 0, "inactive electrical anomalies never request invisible lights")
electroState.Activated = true
electro:Think()
check(electroState.lights == 1 and electroState.light.size == 1024, "activation creates one electrical light")
electroState.failParticle = true
electro.particle.valid = false
electro:Think()
electro:Think()
check(electro.particle == nil, "failed particle creation remains nil-safe on later thinks")

local entity, transmissionState, environment = fixture(definitions[1])
local transmissionHook
local distributed
local function loadAutorun(server)
	environment.SERVER = server
	environment.AddCSLuaFile = function(path) distributed = path end
	environment.game = {AddParticles = function() end}
	environment.PrecacheParticleSystem = function() end
	environment.hook = {Add = function(event, _, callback)
		check(event == "NotifyShouldTransmit", "transmission cleanup uses the engine event")
		transmissionHook = callback
	end}
	execute("lua/autorun/stalker_anomaly_particles.lua", environment)
end
loadAutorun(true)
check(distributed == "cotz/anomalies/cl_idle.lua", "server distributes the client helper")
loadAutorun(false)
transmissionState.viewerX = 0
entity:Initialize()
entity:Think()
transmissionHook(entity, false)
check(transmissionState.stops == 1 and entity.IsSleeping, "PVS exit frees resources before dormancy")
transmissionHook(entity, true)
check(transmissionState.deadline == transmissionState.now, "PVS reentry schedules immediate reevaluation")
entity:Think()
check(transmissionState.starts == 2, "PVS reentry recreates the idle effect")
transmissionHook({}, false)

print(string.format("PASS: %d anomaly client lifecycle checks", checks))
