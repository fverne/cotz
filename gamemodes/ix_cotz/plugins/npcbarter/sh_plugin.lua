PLUGIN.name = "NPC Barter"
PLUGIN.author = "gumlefar"
PLUGIN.desc = "Backend system for keeping track of NPC barters."

ix.npcbarter = ix.npcbarter or {}
ix.npcbarter.barterdict = ix.npcbarter.barterdict or {}
ix.npcbarter.activebarters = ix.npcbarter.activebarters or {}

function ix.npcbarter.Register(npcname, barterid, data)
	ix.npcbarter.barterdict[npcname] = ix.npcbarter.barterdict[npcname] or {}
	ix.npcbarter.barterdict[npcname][barterid] = ix.npcbarter.barterdict[npcname][barterid] or {}

	ix.npcbarter.barterdict[npcname][barterid] = data
end

ix.util.Include("sh_definitions.lua")

function PLUGIN:LoadData()
	ix.npcbarter.activebarters = self:GetData() or {}

	for progid, _ in pairs(ix.progression.definitions) do
		ix.progression.InvokeProgression(progid)
	end

	for npcname, _ in pairs(ix.npcbarter.barterdict) do
		for barterid, barterstruct in pairs(ix.npcbarter.barterdict[npcname]) do
			if barterstruct.defaultActive then
				ix.npcbarter.activebarters[barterid] = true
			end
		end
	end
end

function PLUGIN:SaveData()
	self:SetData(ix.npcbarter.activebarters)
end

function PLUGIN:PlayerSpawn(client, transition)
	net.Start("npcbarter_sync_receive")
		net.WriteTable(ix.npcbarter.activebarters)
	net.Send(client)
end