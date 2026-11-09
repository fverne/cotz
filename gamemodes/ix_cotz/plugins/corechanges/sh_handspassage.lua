local PASSAGE_KEY = "cotz/hands/player-passage"
local RESTORE_INTERVAL = 0.25
local playerMeta = FindMetaTable("Player")

function playerMeta:GetHandsPassage()
	return self:GetNWBool(PASSAGE_KEY, false)
end

function PLUGIN:ShouldCollide(ent1, ent2)
	if ent1.IsSTALKERNPC and ent2.IsSTALKERNPC then return false end
	if ent1:IsPlayer() and ent2:IsPlayer() and (ent1.cotzHandsPassage or ent2.cotzHandsPassage) then
		return false
	end
end

local function updateCollision(client, enabled)
	-- Proxies can run before GetNWBool exposes the new value. Cache the supplied value first.
	client.cotzHandsPassage = enabled == true
	client:SetCustomCollisionCheck(true)
	client:CollisionRulesChanged()
end

if CLIENT then
	local function initializePassage(client)
		client:SetNWVarProxy(PASSAGE_KEY, function(entity, _, _, enabled)
			updateCollision(entity, enabled)
		end)
		updateCollision(client, client:GetHandsPassage())
	end

	function PLUGIN:NetworkEntityCreated(entity)
		if entity:IsPlayer() then initializePassage(entity) end
	end

	for _, client in player.Iterator() do
		initializePassage(client)
	end
end

if SERVER then
	local function getHull(client)
		if client:Crouching() then return client:GetHullDuck() end

		return client:GetHull()
	end

	local function canRestoreCollision(client)
		local position = client:GetPos()
		local mins, maxs = getHull(client)
		local trace = util.TraceHull({
			start = position, endpos = position, mins = mins, maxs = maxs,
			filter = client, mask = MASK_PLAYERSOLID, collisiongroup = COLLISION_GROUP_PLAYER_MOVEMENT,
		})
		if trace.StartSolid or trace.AllSolid then return false end
		local worldMins, worldMaxs = position + mins, position + maxs
		-- A movement trace ignores other passable players, so check their hulls explicitly too.
		for _, other in player.Iterator() do
			if other ~= client and other:Alive() and other:IsSolid() then
				local otherMins, otherMaxs = getHull(other)
				otherMins, otherMaxs = other:GetPos() + otherMins, other:GetPos() + otherMaxs
				if worldMins.x < otherMaxs.x and worldMaxs.x > otherMins.x
					and worldMins.y < otherMaxs.y and worldMaxs.y > otherMins.y
					and worldMins.z < otherMaxs.z and worldMaxs.z > otherMins.z then return false end
			end
		end

		return true
	end

	local function applyPassage(client, enabled)
		-- Restore groups left by the previous implementation during a Lua reload.
		if client:GetCollisionGroup() == COLLISION_GROUP_PASSABLE_DOOR and client:GetHandsPassage() then
			client:SetCollisionGroup(client.cotzHandsCollisionGroup or COLLISION_GROUP_PLAYER)
			client.cotzHandsCollisionGroup = nil
		end
		updateCollision(client, enabled)
		client:SetNWBool(PASSAGE_KEY, enabled)
	end

	function playerMeta:SetHandsPassage(enabled)
		local character = self:GetCharacter()
		if not character then return false end
		enabled = enabled == true
		if not enabled and self:GetHandsPassage() and not canRestoreCollision(self) then return false end
		timer.Remove("cotz/hands/restore-collision/" .. self:EntIndex())
		applyPassage(self, enabled)
		character:SetData("cotzHandsPassage", enabled)
		character:Save()

		return true
	end

	function PLUGIN:PostPlayerLoadout(client)
		local character = client:GetCharacter()
		local key = "cotz/hands/restore-collision/" .. client:EntIndex()
		timer.Remove(key)
		if not character then return end
		local enabled = character:GetData("cotzHandsPassage", false) == true
		if enabled or not client:GetHandsPassage() or canRestoreCollision(client) then
			applyPassage(client, enabled)

			return
		end
		-- A character switch can request solid collisions while still overlapping another player.
		applyPassage(client, true)
		timer.Create(key, RESTORE_INTERVAL, 0, function()
			if not IsValid(client) or client:GetCharacter() ~= character then
				timer.Remove(key)
			elseif canRestoreCollision(client) then
				applyPassage(client, false)
				timer.Remove(key)
			end
		end)
	end
end
