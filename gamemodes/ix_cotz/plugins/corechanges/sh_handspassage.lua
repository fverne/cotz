local PASSAGE_KEY = "cotz/hands/player-passage"
local PASSAGE_SECONDS = 60
local playerMeta = FindMetaTable("Player")

local function applyPassage(client, enabled)
	client.cotzHandsPassage = enabled == true
	client:SetCustomCollisionCheck(true)
	client:CollisionRulesChanged()
end

function PLUGIN:ShouldCollide(ent1, ent2)
	if ent1:IsPlayer() and ent2:IsPlayer() and (ent1.cotzHandsPassage or ent2.cotzHandsPassage) then
		return false
	end
	if ent1.IsSTALKERNPC and ent2.IsSTALKERNPC then return false end
end

if SERVER then
	function playerMeta:SetHandsPassage(enabled)
		timer.Remove("cotz/hands/player-passage/" .. self:EntIndex())
		applyPassage(self, enabled)
		self:SetNWBool(PASSAGE_KEY, enabled == true)
		if enabled then
			timer.Create("cotz/hands/player-passage/" .. self:EntIndex(), PASSAGE_SECONDS, 1, function()
				if IsValid(self) then self:SetHandsPassage(false) end
			end)
		end
	end

	function PLUGIN:PlayerDeath(client)
		client:SetHandsPassage(false)
	end
else
	local function watchPlayer(entity)
		if not entity:IsPlayer() then return end
		entity:SetNWVarProxy(PASSAGE_KEY, function(client, _, _, enabled)
			applyPassage(client, enabled)
		end)
		applyPassage(entity, entity:GetNWBool(PASSAGE_KEY, false))
	end

	function PLUGIN:NetworkEntityCreated(entity)
		watchPlayer(entity)
	end

	function PLUGIN:InitPostEntity()
		for _, client in player.Iterator() do watchPlayer(client) end
	end
end
