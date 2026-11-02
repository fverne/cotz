ix.jobs = ix.jobs or {}

local RARE_SPECIES = {
	bloodsuckerKilled = true, burerKilled = true, controllerKilled = true,
	chimeraKilled = true, electrochimeraKilled = true, pseudogiantKilled = true,
}

function ix.jobs.RecordLeaderboardKill(character, class)
	local stats = table.Copy(character:GetData("leaderboardStats", {}))
	local mutant = class:find("npc_mutant", 1, true)
	local human = class:find("npc_human", 1, true)
	if not mutant and not human then return end
	local key = mutant and "mutantsKilled" or "humansKilled"
	stats[key] = (stats[key] or 0) + 1
	local rare = false
	stats.species = stats.species or {}
	for _, rule in ipairs(ix.jobs.killCredit or {}) do
		local matched = false
		for _, name in ipairs(rule.classes or {}) do
			if name == class then matched = true break end
		end
		if matched then
			for _, trigger in ipairs(rule.triggers or {}) do
				if trigger:sub(1, 5) ~= "group" then
					stats.species[trigger] = true
					rare = rare or RARE_SPECIES[trigger] == true
				end
			end
		end
	end
	if rare then stats.rareMutantsKilled = (stats.rareMutantsKilled or 0) + 1 end
	character:SetData("leaderboardStats", stats)
end

function ix.jobs.RecordLeaderboardTask(character, definition)
	local stats = table.Copy(character:GetData("leaderboardStats", {}))
	stats.tasksCompleted = (stats.tasksCompleted or 0) + 1
	if (definition.tier or 1) >= 3 then stats.hardTasks = (stats.hardTasks or 0) + 1 end
	local kind = definition.fieldType
	if kind == "sensor" or kind == "defence" then
		stats.researchOperations = (stats.researchOperations or 0) + 1
	elseif kind == "recovery" then
		stats.recoveryOperations = (stats.recoveryOperations or 0) + 1
	end
	character:SetData("leaderboardStats", stats)
end

function ix.jobs.GetLeaderboardStats(data)
	local saved = data.leaderboardStats or {}
	local result = {}
	for _, key in ipairs({"mutantsKilled", "humansKilled", "tasksCompleted", "rareMutantsKilled",
		"hardTasks", "researchOperations", "recoveryOperations", "taskEarnings"}) do
		result[key] = saved[key] or 0
	end
	result.speciesKilled = 0
	for _ in pairs(saved.species or {}) do result.speciesKilled = result.speciesKilled + 1 end
	local favorites = {}
	local mostCompleted = 0
	local lines = (data.progression or {}).lines or {}
	local town = ix.townNPCs
	for slug, contact in pairs(town and town.contacts or {}) do
		local completed = 0
		for _, step in ipairs(contact.progression or {}) do
			local line = lines[town:StepID(slug, step.id)]
			if line and line.completed then completed = completed + 1 end
		end
		if completed > mostCompleted then
			mostCompleted = completed
			favorites = {contact.name or slug}
		elseif completed > 0 and completed == mostCompleted then
			favorites[#favorites + 1] = contact.name or slug
		end
	end
	table.sort(favorites)
	result.favoriteContact = #favorites > 0 and table.concat(favorites, ", ") or "None"

	return result
end
