local PLUGIN = PLUGIN

local REQUIRED_PLUGINS = {"eventcontroller", "jobsystem", "advdupeint", "vendor_adv", "dialogue"}

local function hasSceneEntities(entities)
	if not istable(entities) then return false end
	for _, entity in pairs(entities) do
		if IsValid(entity) then return true end
	end

	return false
end

function PLUGIN:IsDefenseDependency(uniqueID)
	for _, required in ipairs(REQUIRED_PLUGINS) do
		if uniqueID == required then return true end
	end

	return false
end

function PLUGIN:GetDefenseDependencyError()
	for _, uniqueID in ipairs(REQUIRED_PLUGINS) do
		if not ix.plugin.Get(uniqueID) or ix.plugin.unloaded[uniqueID] then
			return "Defense requires the " .. uniqueID .. " plugin."
		end
	end
	if not ix.eventController or not ix.vendorStock or not ix.jobs or not ix.jobs.field
		or ix.jobs.field.enabled == false or not ix.jobs.field.SelectDefenceSite
		or not ix.jobs.field.FindDefenceSpawn then
		return "Defense requires the encounter, research-defense and vendor services."
	end
end

function PLUGIN:ScheduleDefense()
	self.nextDefense = CurTime() + math.random(self.settings.intervalMinimum, self.settings.intervalMaximum)
end

function PLUGIN:DefenseStartFailed(message)
	self.nextDefense = CurTime() + self.settings.retry
	if self.lastStartError ~= message then
		print("[COTZ mutantdefense] " .. message)
		self.lastStartError = message
	end

	return message, false
end

function PLUGIN:AnnounceDefense(event)
	local receivers = {}
	for _, client in player.Iterator() do
		if client:GetCharacter() then receivers[#receivers + 1] = client end
	end
	if #receivers == 0 then return end
	local minutes = self.settings.warning / 60
	local message = string.format("The supply truck has crashed %s. Go secure the site if you want supplies back in town! Mutant waves begin in %g minutes.", event.location, minutes)
	ix.chat.Send(nil, "cotz/mutantdefense/announcement", message, true, receivers)
end

function PLUGIN:StartDefense()
	if self.enabled == false then return "Mutant defense is disabled.", false end
	if self.event then return "A mutant defense is already active.", false end
	local dependencyError = self:GetDefenseDependencyError()
	if dependencyError then return self:DefenseStartFailed(dependencyError) end
	local center
	local site, approaches, location = ix.jobs.field.SelectDefenceSite(
		ix.jobs.field.settings.defence,
		game.GetMap(),
		function(position, name)
			if not name or not name:find("%S") then return false end
			local grounded = ix.eventController:GetGroundedSpawnLocation(position)
			if not grounded or ix.eventController:HasPlayerNear(
				grounded + self.settings.dupeOffset, self.settings.playerSafeDistance
			) then return false end
			center = grounded

			return true
		end
	)
	if not site then return self:DefenseStartFailed("No named research-defense site has clear, safe ground.") end
	-- Keep serials on the reused plugin table so callbacks from older loads cannot target a new scene.
	self.defenseSerial = (self.defenseSerial or 0) + 1
	local event = {
		center = center, location = location, spawnPoints = table.Copy(approaches),
		playerSafeDistance = self.settings.playerSafeDistance,
		phase = "deploying", deployDeadline = CurTime() + self.settings.retry,
		wave = 0, slots = {}, candidates = {}, credited = {}, deaths = {},
		dupeID = "cotz/mutantdefense/" .. self.defenseSerial,
		dupePlugin = ix.plugin.Get("advdupeint"),
	}
	self.event = event
	local failure
	local function complete(success, result)
		if self.event ~= event or event.phase ~= "deploying" then
			if self.event ~= event then event.dupePlugin:DespawnDupe(event.dupeID) end
			return
		end
		if success and not hasSceneEntities(result) then
			success, result = false, "The dupe did not create a crash scene."
		end
		if not success then
			self.event = nil
			event.dupePlugin:DespawnDupe(event.dupeID)
			failure = "Supply-van deployment failed: " .. tostring(result)
			self:DefenseStartFailed(failure)
			return
		end
		event.phase, event.nextWave = "warning", CurTime() + self.settings.warning
		self.lastStartError = nil
		self:AnnounceDefense(event)
	end
	local ok, err = event.dupePlugin:SpawnDupe(
		self.settings.dupeName, event.dupeID, self.settings.dupeOffset, center, {noItems = true}, complete
	)
	if not ok and self.event == event then complete(false, err) end
	if failure then return failure, false end

	return "Supply-van defense placed at " .. location .. ". Waves begin after the warning countdown.", true
end

function PLUGIN:UpdateDefenseSchedule()
	if not self.settings.automationEnabled or self.event then return end
	if not self.nextDefense then self:ScheduleDefense() end
	if CurTime() < self.nextDefense then return end
	for _, client in player.Iterator() do
		if client:GetCharacter() and self:IsLivingDefender(client) then
			self:StartDefense()
			return
		end
	end
	self:DefenseStartFailed("No living eligible character is on the map.")
end
