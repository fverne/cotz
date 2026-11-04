local PLUGIN = PLUGIN
local MAX_POINTS = 16
local SAME_POSITION_SQUARED = 16 ^ 2

local function getPoints(id)
	local maps = PLUGIN.spawnPoints or {}
	maps[game.GetMap()] = maps[game.GetMap()] or {}
	PLUGIN.spawnPoints = maps

	return maps[game.GetMap()][id], maps[game.GetMap()]
end

ix.command.Add("TownNPCAddSpawnPoint", {
	adminOnly = true,
	arguments = {ix.type.string},
	OnRun = function(_, client, id)
		local contact = PLUGIN.contacts[id]
		if not contact or contact.map ~= game.GetMap() then return "Choose a contact on this map." end
		local npc = ix.progression.GetNPCFromName(contact.name)
		if not IsValid(npc) then return "Place the contact first." end
		local points, contacts = getPoints(id)
		points = points or {{position = npc:GetPos(), angles = npc:GetAngles()}}
		if #points >= MAX_POINTS then return "This contact already has 16 spawn points." end
		local position = client:GetPos()
		for _, point in ipairs(points) do
			if point.position:DistToSqr(position) < SAME_POSITION_SQUARED then
				return "A spawn point already exists nearby."
			end
		end
		points[#points + 1] = {position = position, angles = Angle(0, client:GetAngles().y, 0)}
		contacts[id] = points
		PLUGIN:SaveData()

		return "Saved spawn point " .. #points .. " for " .. contact.name .. "; applies next map restart."
	end,
})

ix.command.Add("TownNPCClearSpawnPoints", {
	adminOnly = true,
	arguments = {ix.type.string},
	OnRun = function(_, client, id)
		local contact = PLUGIN.contacts[id]
		if not contact or contact.map ~= game.GetMap() then return "Choose a contact on this map." end
		local _, contacts = getPoints(id)
		contacts[id] = nil
		local previous = (PLUGIN.lastSpawnPositions or {})[game.GetMap()]
		if previous then previous[id] = nil end
		PLUGIN:SaveData()

		return "Cleared alternate spawn points for " .. contact.name .. "."
	end,
})

function PLUGIN:ApplyTownSpawnPoints()
	-- PostLoadData may also be called manually; never move contacts again during this session.
	if self.spawnPositionsApplied then return end
	self.spawnPositionsApplied = true
	local map = game.GetMap()
	local contacts = (self.spawnPoints or {})[map]
	if not contacts or not next(contacts) then return end
	self.lastSpawnPositions = self.lastSpawnPositions or {}
	local previous = self.lastSpawnPositions[map] or {}
	self.lastSpawnPositions[map] = previous
	local changed = false
	for _, npc in ipairs(ents.FindByClass("ix_vendor_adv")) do
		local contact = self.byName[npc:GetDisplayName()]
		local points = contact and contact.map == map and contacts[contact.id]
		if points and #points > 0 then
			local lastPosition = previous[contact.id] or npc:GetPos()
			local candidates = {}
			for _, point in ipairs(points) do
				if point.position:DistToSqr(lastPosition) >= SAME_POSITION_SQUARED then
					candidates[#candidates + 1] = point
				end
			end
			local pool = #candidates > 0 and candidates or points
			local point = pool[math.random(#pool)]
			npc:SetPos(point.position)
			npc:SetAngles(point.angles)
			previous[contact.id] = point.position
			changed = true
		end
	end
	if changed then self:SaveData() end
end
