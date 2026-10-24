PLUGIN.name = "NPC Barter"
PLUGIN.author = "gumlefar"
PLUGIN.desc = "Backend system for keeping track of NPC barters."

ix.npcbarter = ix.npcbarter or {}
ix.npcbarter.barterdict = ix.npcbarter.barterdict or {}
ix.npcbarter.activebarters = ix.npcbarter.activebarters or {}

function ix.npcbarter.Register(npcName, barterid, data)
	ix.npcbarter.barterdict[npcName] = ix.npcbarter.barterdict[npcName] or {}
	ix.npcbarter.barterdict[npcName][barterid] = ix.npcbarter.barterdict[npcName][barterid] or {}

	ix.npcbarter.barterdict[npcName][barterid] = data
end

ix.util.Include("sh_definitions.lua")

function PLUGIN:LoadData()
	ix.npcbarter.activebarters = self:GetData() or {}

	for npcName, _ in pairs(ix.npcbarter.barterdict) do
		for barterid, barterstruct in pairs(ix.npcbarter.barterdict[npcName]) do
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
