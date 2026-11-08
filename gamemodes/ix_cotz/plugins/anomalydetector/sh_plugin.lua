local PLUGIN = PLUGIN
PLUGIN.name = "Anomaly Detector"
PLUGIN.author = "gumlefar, verne"
PLUGIN.desc = "Beeps when anomalies are nearby when you have an anomaly detector."

local playerMeta = FindMetaTable("Player")

function playerMeta:hasAnomdetector()
	return self:GetNetVar("ixhasanomdetector") and true or false
end

if SERVER then
	local SCAN_INTERVAL = 0.2
	local SCAN_RANGE = 512
	local BEEP_RANGE = 400
	local MIN_BEEP_INTERVAL = 0.1
	local detectorStates = setmetatable({}, {__mode = "k"})

	local function findNearestAnomaly(position)
		local nearest
		local nearestDistance = SCAN_RANGE * SCAN_RANGE
		for _, entity in ipairs(ents.FindInSphere(position, SCAN_RANGE)) do
			if string.sub(entity:GetClass(), 1, 4) == "anom" then
				local distance = position:DistToSqr(entity:GetPos())
				if distance <= nearestDistance then
					nearest = entity
					nearestDistance = distance
				end
			end
		end

		return nearest
	end

	local function updateDetector(client, now)
		if not client:hasAnomdetector() then
			detectorStates[client] = nil
			return
		end

		local state = detectorStates[client]
		if not state then
			state = {nextScan = 0}
			detectorStates[client] = state
		end

		local position = client:GetPos()
		if now >= state.nextScan then
			state.nextScan = now + SCAN_INTERVAL
			state.nearest = findNearestAnomaly(position)
		end

		if not IsValid(state.nearest) then return end
		local distance = position:DistToSqr(state.nearest:GetPos())
		if distance >= BEEP_RANGE * BEEP_RANGE then return end

		local interval = math.max(math.sqrt(distance) / BEEP_RANGE, MIN_BEEP_INTERVAL)
		if now < (client.LastBeep or 0) + interval then return end

		client.LastBeep = now
		client:EmitSound("stalkerdetectors/anom_prox.wav")
	end

	function PLUGIN:Think()
		local now = CurTime()
		for _, client in player.Iterator() do
			updateDetector(client, now)
		end
	end
end
