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

ix.util.Include("sh_technutprog.lua")
ix.util.Include("sh_cleanerprog.lua")
ix.util.Include("sh_hagglerprog.lua")
ix.util.Include("sh_muteprog.lua")
ix.util.Include("sh_oldtimerprog.lua")
ix.util.Include("sh_quarterprog.lua")
ix.util.Include("sh_spicylemonprog.lua")

function PLUGIN:LoadData()
	ix.progression.status = self:GetData() or {}

	for progid, _ in pairs(ix.progression.definitions) do
		ix.progression.InvokeProgression(progid)
	end
end

function PLUGIN:SaveData()
	self:SetData(ix.progression.status)
end

function PLUGIN:PlayerSpawn(client, transition)
	net.Start("progression_sync_receive")
	net.WriteTable(ix.progression.status)
	net.Send(client)
end