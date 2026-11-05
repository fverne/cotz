local PLUGIN = PLUGIN

local function matches(rule, class)
	for _, name in ipairs(rule.classes or {}) do
		if class == name then return true end
	end
	for _, pattern in ipairs(rule.patterns or {}) do
		if class:find(pattern, 1, true) then return true end
	end

	return false
end

local function recipients(entity, attacker)
	local result = {[attacker] = true}
	local distance = ix.jobs.settings.killCreditDistance
	for _, position in ipairs({attacker:GetPos(), entity:GetPos()}) do
		for _, client in ipairs(ents.FindInSphere(position, distance)) do
			if client:IsPlayer() and client:GetCharacter() then result[client] = true end
		end
	end

	return result
end

function PLUGIN:OnNPCKilled(entity, attacker, inflictor)
	ix.jobs.field.DefenceKilled(entity)
	if not IsValid(attacker) or not attacker:IsPlayer() then return end
	local class = entity:GetClass():lower()
	local character = attacker:GetCharacter()
	if character then ix.jobs.RecordLeaderboardKill(character, class) end
	local clients
	for _, rule in ipairs(ix.jobs.killCredit) do
		if matches(rule, class) then
			clients = clients or recipients(entity, attacker)
			for _, trigger in ipairs(rule.triggers) do
				for client in pairs(clients) do hook.Run("ix_JobTrigger", client, trigger) end
			end
		end
	end
end

function PLUGIN:PlayerSay(client, text, teamChat)
	if text:find("sneed", 1, true) then hook.Run("ix_JobTrigger", client, "chatSayTest") end
end
