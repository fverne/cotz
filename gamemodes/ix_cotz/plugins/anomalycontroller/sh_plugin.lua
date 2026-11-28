local PLUGIN = PLUGIN
PLUGIN.name = "Anomaly Controller"
PLUGIN.author = "gumlefar"
PLUGIN.desc = "Allows for randomly spawning anomaly entities"

PLUGIN.anomalydefs = PLUGIN.anomalydefs or {}
-- Points are { position, radius, selection }; see ResolveAnomalySelection for the selection format.
PLUGIN.anomalypoints = PLUGIN.anomalypoints or {}

ix.util.Include("sh_anomalydefs.lua")
ix.util.Include("sh_anomalyselection.lua")

if CLIENT then
	ix.option.Add("anomalyLights", ix.type.bool, true, {
		phrase = "Anomaly Lights",
		description = "Enable dynamic lighting from anomaly fields.",
		category = "Performance",
	})
end

ix.config.Add("artifactSpawnerThreshold", 5, "How many artifacts the anomalyspawner should keep the map populated with.", nil, {
	data = {min = 0, max = 50},
	category = "Spawning"
})

ix.spawnPolicy.Register("artifactSpawnerThreshold")

ix.config.Add("artifactSpawnerRate", 900, "The time it takes for artifacts to be attempted to spawn.", nil, {
	data = {min = 15, max = 3000},
	category = "Spawning"
})

ix.config.Add("artifactSpawnerChance", 3, "Chance for artifacts per anomalyfield to spawn when the time is up.", nil, {
	data = {min = 0, max = 100},
	category = "Spawning"
})

if SERVER then
	local spawntime = 1

	function PLUGIN:Think()
		if table.IsEmpty(self.anomalypoints) then return end
		if spawntime > CurTime() then return end

		spawntime = CurTime() + ix.config.Get("artifactSpawnerRate", 900)

		self:trySpawnArtifacts()
	end

	function PLUGIN:trySpawnArtifacts()
		for i, j in pairs(self.anomalypoints[game.GetMap()]) do
			local numartifacts = self:GetNumSpawnedArtifacts()
			if (numartifacts >= ix.spawnPolicy.Get("artifactSpawnerThreshold", 5)) then return end

			if (!j) then
				continue
			end

			if math.random(100) > ix.config.Get("artifactSpawnerChance",3) then
				continue
			end

			local data = {}
			data.start = j[1]
			data.endpos = data.start + Vector(0, 0, -64)
			data.filter = client
			data.mins = Vector(-32, -32, 0)
			data.maxs = Vector(32, 32, 32)
			local trace = util.TraceHull(data)

			if trace.Entity:IsValid() then
				if !(trace.Entity:GetClass() == "ix_storage") then
					continue
				end
			end
			
			self:spawnArtifacts(j)
		end
	end

	function PLUGIN:spawnArtifacts(point)
		local rand = math.random(101)
		local rarityselector = 0
		local anomalyselector = 0

		if rand <= 80 then
			rarityselector = 0
		elseif rand <= 98 then
			rarityselector = 1
		elseif rand <= 100 then
			rarityselector = 2
		else return end

		for k,v in pairs(ents.FindInSphere(point[1], 1024)) do
			if (string.sub(v:GetClass(), 1, 5) == "anom_") then
				for i=1,#self.anomalydefs do
					if self.anomalydefs[i].entityname == v:GetClass() then
						anomalyselector = i
						break
					end
				end
			end
		end

		if anomalyselector == 0 then return end

		local idat = 0

		if rarityselector == 0 then
			idat = table.Random(self.anomalydefs[anomalyselector].commonArtifacts)
		elseif rarityselector == 1 then
			idat = table.Random(self.anomalydefs[anomalyselector].rareArtifacts)
		else
			idat = table.Random(self.anomalydefs[anomalyselector].veryRareArtifacts)
		end

		ix.item.Spawn(idat, point[1] + Vector( math.Rand(-8,8), math.Rand(-8,8), 20 ), function(item, ent) item:SetData("bTemporary", true) ent.bTemporary = true ent.bArtifact = true end, AngleRand(), {})

	end

	-- Function that cleans up all anomalies (Entities with names starting with "anom_")
	function PLUGIN:cleanAnomalies()
		for k, v in ents.Iterator() do
			if (string.sub(v:GetClass(), 1, 5) == "anom_") then
				v:Remove()
			end
		end
	end

	function PLUGIN:GetNumSpawnedArtifacts()
		local n = 0
		for k,v in pairs(ents.FindByClass("ix_item")) do
			if( v.bTemporary and v.bArtifact ) then
				n = n + 1
			end
		end

		return n
	end

	-- Used for anomaly classes whose definition has no triggerRadius: the 60-unit trigger box's half-diagonal.
	local DEFAULT_TRIGGER_RADIUS = 85
	-- Anomalies further apart than this vertically are on different floors and may overlap horizontally.
	local PLACEMENT_VERTICAL_CLEARANCE = 128
	local PLACEMENT_ATTEMPTS = 8

	-- Collects the anomalies already in the world, skipping those removed this frame by cleanAnomalies.
	function PLUGIN:GetPlacedAnomalies()
		local radii = {}

		for _, definition in ipairs(self.anomalydefs) do
			radii[definition.entityname] = definition.triggerRadius
		end

		local placed = {}

		for _, entity in ents.Iterator() do
			local class = entity:GetClass()

			if string.sub(class, 1, 5) == "anom_" and not entity:IsMarkedForDeletion() then
				placed[#placed + 1] = {position = entity:GetPos(), radius = radii[class] or DEFAULT_TRIGGER_RADIUS}
			end
		end

		return placed
	end

	function PLUGIN:IsAnomalyPositionClear(position, radius, placed)
		for _, other in ipairs(placed) do
			local offset = other.position - position
			local reach = radius + other.radius

			if math.abs(offset.z) < PLACEMENT_VERTICAL_CLEARANCE and offset.x ^ 2 + offset.y ^ 2 < reach ^ 2 then
				return false
			end
		end

		local trace = util.TraceHull({
			start = position,
			endpos = position,
			mins = Vector(-16, -16, 0),
			maxs = Vector(16, 16, 71),
		})

		return not trace.Entity:IsValid()
	end

	-- Finds a spot inside the point whose trigger does not overlap any placed anomaly, or nil if none was found.
	function PLUGIN:FindAnomalyPosition(point, radius, placed)
		for _ = 1, PLACEMENT_ATTEMPTS do
			local position = self:GetSpawnLocation(point[1], point[2])

			if position and self:IsAnomalyPositionClear(position, radius, placed) then
				return position
			end
		end
	end

	-- Populates every spawn point with one of the anomalies its selection allows.
	function PLUGIN:spawnAnomalies()
		if CurTime() > 5 then
			spawntime = 1
		end

		local placed = self:GetPlacedAnomalies()

		for _, point in pairs(self.anomalypoints[game.GetMap()]) do
			local definitions, unknown = self:ResolveAnomalySelection(point[3])

			if #unknown > 0 then
				ErrorNoHalt(string.format("[anomalycontroller] Unknown anomaly selection '%s' at %s\n",
					table.concat(unknown, " "), tostring(point[1])))
			end

			if #definitions == 0 then continue end

			local definition = definitions[math.random(#definitions)]
			local radius = definition.triggerRadius or DEFAULT_TRIGGER_RADIUS

			for _ = 1, math.ceil(point[2] / definition.interval) do
				local position = self:FindAnomalyPosition(point, radius, placed)

				if not position then continue end

				local entity = ents.Create(definition.entityname)
				entity:SetPos(position)
				entity:Spawn()

				placed[#placed + 1] = {position = position, radius = radius}
			end
		end
	end

	function PLUGIN:LoadData()
		self.anomalypoints = self:GetData() or {}

		self.anomalypoints[game.GetMap()] = self.anomalypoints[game.GetMap()] or {}

		self:cleanAnomalies()
		self:spawnAnomalies()
	end

	function PLUGIN:SaveData()
		self:SetData(self.anomalypoints)
	end

	-- Height of an anomaly's origin above the ground, matching the bottom of most trigger boxes.
	local GROUND_OFFSET = 5
	-- How far above a spawn point the ground search starts, to cover terrain rising within its radius.
	local GROUND_SEARCH_UP = 128
	local GROUND_SEARCH_DOWN = 400

	local function hitsWorldOnly(entity)
		return entity:IsWorld()
	end

	-- Picks a random spot in the radius and returns it at ground level, or nil if there is no ground there.
	-- A thin vertical trace keeps trigger bounds, other anomalies and slopes from raising the result.
	function PLUGIN:GetSpawnLocation(origin, radius)
		local ceiling = util.TraceLine({
			start = origin,
			endpos = origin + Vector(0, 0, GROUND_SEARCH_UP),
			mask = MASK_SOLID,
			filter = hitsWorldOnly,
		})
		local offset = Vector(math.Rand(-radius, radius), math.Rand(-radius, radius), 0)
		local start = ceiling.HitPos - Vector(0, 0, 1) + offset

		local ground = util.TraceLine({
			start = start,
			endpos = Vector(start.x, start.y, origin.z - GROUND_SEARCH_DOWN),
			mask = MASK_SOLID,
			filter = hitsWorldOnly,
		})

		if ground.StartSolid or not ground.Hit or ground.HitSky then return end

		return ground.HitPos + Vector(0, 0, GROUND_OFFSET)
	end

else

	-- Simple hook to display points
	netstream.Hook("ix_DisplayAnomalyPoints", function(data)
	 	for k, v in pairs(data) do
	 		local emitter = ParticleEmitter( v[1] )
	 		local smoke = emitter:Add( "sprites/glow04_noz", v[1] )
	 		smoke:SetVelocity( Vector( 0, 0, 1 ) )
	 		smoke:SetDieTime(10)
			smoke:SetStartAlpha(255)
	 		smoke:SetEndAlpha(255)
	 		smoke:SetStartSize(64)
	 		smoke:SetEndSize(64)
	 		smoke:SetColor(255,186,50)
	 		smoke:SetAirResistance(300)
	 	end
	end)
end

local DEFAULT_POINT_RADIUS = 128

-- Adds a spawn point at the crosshair. An optional leading radius (default 128) is followed by any mix of
-- categories and anomaly names; each spawn picks one of the selected anomalies.
-- Example : /anomalyadd fire
-- Example : /anomalyadd 256 burner1 "burner 2" electro2
ix.command.Add("anomalyadd", {
	description = "Adds an anomaly spawn point: [radius] followed by categories and/or anomaly names.",
	superAdminOnly = true,
	arguments = {
		ix.type.text
	},
	OnRun = function(self, client, selection)
		local radius, selectors, unknown = PLUGIN:ParseAnomalySelection(selection)
		radius = radius or DEFAULT_POINT_RADIUS

		if radius <= 0 then
			return "@invalidArg", 1
		end

		if #unknown > 0 or #selectors == 0 then
			local categories, anomalies = PLUGIN:GetAnomalySelectorNames()
			local prefix = #unknown > 0 and ("Unknown anomaly selection: " .. table.concat(unknown, ", ") .. ". ")
				or "Choose at least one category or anomaly. "

			return prefix .. "Categories: " .. table.concat(categories, ", ") .. ". Anomalies: "
				.. table.concat(anomalies, ", ") .. "."
		end

		local trace = client:GetEyeTraceNoCursor()
		local hitpos = trace.HitPos + trace.HitNormal * 5
		local stored = table.concat(selectors, " ")

		table.insert(PLUGIN.anomalypoints[game.GetMap()], {hitpos, radius, stored})
		client:Notify("Anomaly point added with radius " .. radius .. ": " .. stored)
	end
})

-- Removes anomaly spawnpoints in a radius around the users crosshair
-- Example : /anomalyremove
-- Will remove anomaly spawnpoints in a 128 range around the users crosshair
-- Example : /anomalyremove 256
-- Will remove anomaly spawnpoints in a 256 range around the users crosshair
ix.command.Add("anomalyremove", {
	superAdminOnly = true,
	arguments = {
		ix.type.number
	},
	OnRun = function(self, client, range)
		local trace = client:GetEyeTraceNoCursor()
		local hitpos = trace.HitPos + trace.HitNormal*5
		local range = range or 128
		local mt = 0
		for k, v in pairs( PLUGIN.anomalypoints[game.GetMap()] ) do
			local distance = v[1]:Distance( hitpos )
			if distance <= tonumber(range) then
				PLUGIN.anomalypoints[game.GetMap()][k] = nil
				mt = mt + 1
			end
		end
		if mt > 0 then
			client:Notify( mt .. " anomaly locations has been removed.")
		else
			client:Notify( "No anomaly spawn points found at location.")
		end
	end
})

-- Will display glow sprites at all the anomaly spawn points on the map
ix.command.Add("anomalydisplay", {
	adminOnly = true,
	OnRun = function(self, client, arguments)
		if SERVER then
			netstream.Start(client, "ix_DisplayAnomalyPoints", PLUGIN.anomalypoints[game.GetMap()])
			client:Notify( "Displayed All Points for 10 secs." )
		end
	end
})

-- Debug command for removing anomaly entities in a radius
-- Example : /anomalyentremove 512
-- Will remove all entities that have names starting with "anom_" in a 512 radius around the users crosshair
ix.command.Add("anomalyentremove", {
	adminOnly = true,
	arguments = {
		ix.type.number
	},	
	OnRun = function(self, client, range)
		local trace = client:GetEyeTraceNoCursor()
		local hitpos = trace.HitPos + trace.HitNormal*5
		local range = range or 128
		local mt = 0
		for k, v in pairs( ents.FindInSphere(hitpos, range) ) do
			if (string.sub(v:GetClass(), 1, 5) == "anom_") then
				v:Remove()
				mt = mt + 1
			end
		end
		if mt > 0 then
			client:Notify( "Removed " .. mt .. " anomalies.")
		else
			client:Notify( "No anomalies found at location.")
		end
	end
})

ix.command.Add("cleananomalies", {
	adminOnly = true,
	OnRun = function(self, client, arguments)

		ix.plugin.list["anomalycontroller"]:cleanAnomalies()

		client:Notify("All anomalies have been cleaned up from the map.")
	end
})

ix.command.Add("spawnanomalies", {
	adminOnly = true,
	OnRun = function(self, client, arguments)

		ix.plugin.list["anomalycontroller"]:spawnAnomalies()

		client:Notify("Spawned anomalies on points (if any).")
	end
})