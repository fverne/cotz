local PLUGIN = PLUGIN
PLUGIN.name = "EventController"
PLUGIN.author = "gumlefar"
PLUGIN.desc = (
	"Makes events occur randomly on your server - used more "
	.. "like a monster spawner now, more complex and intricate "
	.. "events are possible in eventcontrolleradv"
)

local LEGACY_LOCATION_TAGS = {
	[11] = "swamps_outside_easy",
	[12] = "swamps_outside_hard",
	[13] = "swamps_building",
	[14] = "swamps_sniperspot",
	[15] = "swamps_underground",
	[21] = "waystation_outside_easy",
	[22] = "waystation_outside_hard",
	[23] = "waystation_building",
	[24] = "waystation_sniperspot",
	[25] = "waystation_underground",
	[31] = "pripyat_outside_easy",
	[32] = "pripyat_outside_hard",
	[33] = "pripyat_building",
	[34] = "pripyat_sniperspot",
	[35] = "pripyat_underground",
}

local LOCATION_TAGS = {
	garbage_outside_easy = true,
	garbage_outside_hard = true,
	garbage_building = true,
	garbage_sniperspot = true,
	garbage_underground = true,
}
for _, locationTag in pairs(LEGACY_LOCATION_TAGS) do
	LOCATION_TAGS[locationTag] = true
end

PLUGIN.eventdefs = PLUGIN.eventdefs or {}
-- EVENTPOINT STRUCTURE table.insert( PLUGIN.eventpoints, { position, name, difficulty } )
PLUGIN.eventpoints = PLUGIN.eventpoints or {}

ix.util.Include("sh_eventdefs.lua")

PLUGIN.spawnradius = 750
PLUGIN.populateAmount = 7

PLUGIN.pdachatter = false
PLUGIN.pdachatterchance = 100

PLUGIN.saferadius = 1500

PLUGIN.spawnrate = 30

local icon = Material("vgui/icons/news.png")

ix.util.Include("sh_population.lua")
ix.util.Include("sv_spawnnodes.lua")
ix.util.Include("sv_spawnplacement.lua")

if SERVER then
	local spawntime = 1
	local populate = true

	function PLUGIN:IsClear(position)
		local currentdefs = {}
		local currentents = ents.FindInSphere(position, PLUGIN.saferadius)

		for _, j in pairs(currentents) do
			if j:IsPlayer() then
				return false
			elseif string.sub(j:GetClass(), 1, 4) == "npc_" then
				return false
			end
		end

		return true
	end

	function PLUGIN:SpawnEncounterEntity(class, origin, pack)
		local position = self:GetSpawnLocation(origin)
		if not position then return end
		if class:sub(1, 11) == "npc_mutant_" then
			if not self:CanPopulateMutant(position, true) then return end

			return self:QueueMutant(class, position, self.saferadius, true, pack, true)
		end

		local entity = ents.Create(class)
		if not IsValid(entity) then return end
		entity.cotzCombatPack = pack
		entity:SetPos(position)
		entity:Spawn()
		entity:DropToFloor()
		self:RegisterCombatActor(entity, pack)

		return entity
	end

	function PLUGIN:spawnEvent(eventpoint, spawn)
		if ix.eventController ~= self then return end
		local spawned = false
		-- spawnents
		if spawn.entities then
			local pack = self:CreateCombatPack(eventpoint[1])
			for k = 1, #spawn.entities do
				for _ = 1, spawn.entities[k][2] do
					local class = spawn.entities[k][1]
					local isMutant = class:sub(1, 11) == "npc_mutant_"
					if isMutant and not self:CanPopulateMutant(nil, true) then break end

					if self:SpawnEncounterEntity(class, eventpoint[1], pack) then spawned = true end
				end
			end
		end
		-- spawnitems
		if spawn.items then
			for k = 1, #spawn.items do
				local position = self:GetSpawnLocation(eventpoint[1])
				if not position then continue end
				local data = {}
				data.start = position
				data.endpos = position
				data.mins = Vector(-16, -16, 0)
				data.maxs = Vector(16, 16, 71)
				local trace = util.TraceHull(data)

				if trace.Entity:IsValid() then
					continue
				end
				ix.item.Spawn(spawn.items[k][1], position, nil, AngleRand(), spawn.items[k][2] or {})
				spawned = true
			end
		end

		-- spawn loot
		if spawn.loot then
			--[[for k = 1, #spawn.loot do
				for i = 1, spawn.loot[k][2] do
					local position = self:GetSpawnLocation(eventpoint[1])
					local data = {}
					data.start = position
					data.endpos = position
					data.mins = Vector(-16, -16, 0)
					data.maxs = Vector(16, 16, 71)
					local trace = util.TraceHull(data)
						
					if trace.Entity:IsValid() then
						continue
					end

					if math.random(100) <= spawn.lootChance then
						ix.item.Spawn(spawn.loot[k][1], position, nil, AngleRand(), spawn.loot[k][3] or {})
					end
				end
			end]]
		end

		return spawned
	end

	function PLUGIN:setSpawnTime(time)
		spawntime = time
	end

	function PLUGIN:setPopulate(bool)
		populate = bool
	end

	function PLUGIN:LoadData()
		self.eventpoints = self:GetData() or {}

		-- Migrate every stored map without changing positions or encounter assignments.
		for _, eventpoints in pairs(self.eventpoints) do
			for _, eventpoint in pairs(eventpoints) do
				eventpoint[3] = LEGACY_LOCATION_TAGS[eventpoint[3]] or eventpoint[3]
			end
		end

		self.eventpoints[game.GetMap()] = self.eventpoints[game.GetMap()] or {}
	end

	function PLUGIN:SaveData()
		self:SetData(self.eventpoints)
	end

	function PLUGIN:Think()
		if ix.eventController ~= self then return end
		self:UpdateMutantPerformance()
		if table.IsEmpty(self.eventpoints) then return end

		if populate then
			for _ = 1, self.populateAmount do
				local eventpoint = table.Random(self.eventpoints[game.GetMap()])
				local spawn = table.Random(self.eventdefs)

				if not eventpoint then
					return
				end

				local n = 0
				while table.Random(spawn.difficulty) ~= eventpoint[3] and n < 15 do
					spawn = table.Random(self.eventdefs)
					n = n + 1
				end

				if n == 15 then
					return
				end

				self:spawnEvent(eventpoint, spawn)
			end

			populate = false
		end

		if spawntime > CurTime() then
			return
		end
		spawntime = CurTime() + self.spawnrate

		if self:GetNumMutants(true) >= self:GetMutantTarget() then
			return
		end

		local eventpoint = table.Random(self.eventpoints[game.GetMap()])
		if not eventpoint then
			return
		end
		if not self:IsClear(eventpoint[1]) then
			return
		end

		local spawn = table.Random(self.eventdefs)
		local n = 0
		while table.Random(spawn.difficulty) ~= eventpoint[3] and n < 15 do
			spawn = table.Random(self.eventdefs)
			n = n + 1
		end

		if n == 15 then
			return
		end

		local spawned = self:spawnEvent(eventpoint, spawn)

		if spawned and math.Rand(1, 100) <= self.pdachatterchance then
			for _, ply in player.Iterator() do
				local character = ply:GetCharacter()
				if character and ix.townNPCs:CanReceiveMutantReports(character, game.GetMap()) then
					ix.chat.Send(
						ply,
						"eventpdainternal",
						Format(spawn.pdabroadcast, eventpoint[2]),
						true,
						{ ply }
					)
				end
			end
		end
	end

else
	netstream.Hook("nut_DisplaySpawnPoints", function(data)
		for _, v in pairs(data) do
			local emitter = ParticleEmitter(v[1])
			local smoke = emitter:Add("sprites/glow04_noz", v[1])
			smoke:SetVelocity(Vector(0, 0, 1))
			smoke:SetDieTime(10)
			smoke:SetStartAlpha(255)
			smoke:SetEndAlpha(255)
			smoke:SetStartSize(64)
			smoke:SetEndSize(64)
			smoke:SetColor(255, 186, 50)
			smoke:SetAirResistance(300)
		end
	end)
end

ix.command.Add("eventadd", {
	superAdminOnly = true,
	arguments = {
		ix.type.string,
		ix.type.text,
	},
	OnRun = function(self, client, spawngroup, location)
		if not LOCATION_TAGS[spawngroup] then
			return "Unknown location tag. Example: swamps_outside_easy. See eventcontroller/README.md."
		end

		local trace = client:GetEyeTraceNoCursor()
		local hitpos = trace.HitPos + trace.HitNormal * 5
		local mapName = game.GetMap()
		PLUGIN.eventpoints[mapName] = PLUGIN.eventpoints[mapName] or {}
		table.insert(PLUGIN.eventpoints[mapName], {hitpos, location, spawngroup})
		client:Notify("Event area '" .. location .. "' added with spawngroup " .. spawngroup)
	end,
})

ix.command.Add("eventremove", {
	superAdminOnly = true,
	OnRun = function(self, client, arguments)
		local trace = client:GetEyeTraceNoCursor()
		local hitpos = trace.HitPos + trace.HitNormal * 5
		local range = arguments[1] or 128
		local mt = 0
		for k, v in pairs(PLUGIN.eventpoints[game.GetMap()]) do
			local distance = v[1]:Distance(hitpos)
			if distance <= tonumber(range) then
				PLUGIN.eventpoints[game.GetMap()][k] = nil
				mt = mt + 1
			end
		end
		client:Notify(mt .. " event locations has been removed.")
	end,
})

ix.command.Add("eventdisplay", {
	adminOnly = true,
	OnRun = function(self, client, arguments)
		if SERVER then
			netstream.Start(client, "nut_DisplaySpawnPoints", PLUGIN.eventpoints[game.GetMap()])
			client:Notify("Displayed All Points for 10 secs.")
		end
	end,
})

ix.command.Add("eventforce", {
	adminOnly = true,
	OnRun = function(client, arguments)
		PLUGIN:setSpawnTime(1)
	end,
})

ix.command.Add("eventpopulate", {
	adminOnly = true,
	-- syntax = "<number amount>",
	OnRun = function(self, client, arguments)
		PLUGIN:setPopulate(true)
		-- local amount = tonumber(arguments[1]) or 5
		-- if isnumber(amount) then
		--	PLUGIN.populateAmount = arguments[1]
		-- else
		--	client:ChatPrint("Amount must be a number.")
		-- end
	end,
})
