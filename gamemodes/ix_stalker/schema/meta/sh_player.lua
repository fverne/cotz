
local PLAYER = FindMetaTable("Player")

function PLAYER:IsPolice()
	return self:Team() == FACTION_POLICE
end
