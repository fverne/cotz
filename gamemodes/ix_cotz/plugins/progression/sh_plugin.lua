PLUGIN.name = "Progression"
PLUGIN.author = "gumlefar"
PLUGIN.desc = "System for tracking serverwide progression and performing actions based on progression levels."

ix.progression = ix.progression or {}
ix.progression.status = ix.progression.status or {}
ix.progression.definitions = ix.progression.definitions or {}
ix.progression.foreignstatus = ix.progression.foreignstatus or {}

PLUGIN.checktime = 0

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
ix.util.Include("sh_jittersprog.lua")
ix.util.Include("sh_eggheadprog.lua")

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

if(SERVER)then

function PLUGIN:Think()
	if self.checktime > CurTime() then return end
	self.checktime = CurTime() + 15

	self:GetForeignProgression()
	self:DumpOwnProgression()
end

function PLUGIN:GetForeignProgression()
	ix.progression.foreignstatus = {}

	ix.plugin.list["simplecrossserverdata"]:GetXServerData("%_progression", function(result)
		if (istable(result) and #result > 0) then
			for _, v in pairs(result) do
				if (istable(v)) then
					local key = v.key
					local data = util.JSONToTable(v.json_data or "[]")

					if not string.StartsWith(key,game.GetMap()) then
						table.insert(ix.progression.foreignstatus, data)
					end
				end
			end
		end
	end)
end

function PLUGIN:DumpOwnProgression()
	local key = game.GetMap().."_progression"

	ix.plugin.list["simplecrossserverdata"]:SetXServerData(key, ix.progression.status)

end

end