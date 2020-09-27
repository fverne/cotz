PLUGIN.name = "Progression"
PLUGIN.author = "gumlefar"
PLUGIN.desc = "System for tracking serverwide progression and performing actions based on progression levels."

ix.progression = ix.progression or {}
ix.progression.status = ix.progression.status or {}
ix.progression.definitions = ix.progression.definitions or {}

function ix.progression.Register(progid, data)
	ix.progression.definitions[progid] = data
end

ix.util.Include("sh_definitions.lua")

function PLUGIN:LoadData()
	ix.progression.status = self:GetData() or {}

	for progid, _ in pairs(ix.progression.definitions) do
		ix.progression.InvokeProgression(progid)
	end
end

function PLUGIN:SaveData()
	self:SetData(ix.progression.status)
end