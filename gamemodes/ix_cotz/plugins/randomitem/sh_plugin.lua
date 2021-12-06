local PLUGIN = PLUGIN

PLUGIN.name = "Random item"
PLUGIN.author = "gumlefar"
PLUGIN.desc = "Weight based random item selection. Can also persist a list of dropped items for spawning later."

function PLUGIN:LoadData()
	ix.randomitems.droppedplayeritems = self:GetData() or {}
end

function PLUGIN:SaveData()
	self:SetData(ix.randomitems.droppedplayeritems)
end