local previews = {}

function PLUGIN:RunCommandTownNPCPreview(client, id, sequence)
	if not IsValid(client) then return "Run this command as a player in game." end
	if sequence == "" then return "Choose an animation sequence." end
	local contact = self.contacts[id]
	local template = contact and contact.template or id
	if not ix.npctemplates.templates[template] then return "Unknown town contact or vendor template." end
	local npc = ents.Create("ix_townnpc_preview")
	if not IsValid(npc) then return "Unable to create the posing preview." end
	local trace = client:GetEyeTraceNoCursor()
	npc:SetPos(trace.HitPos + trace.HitNormal)
	npc:SetAngles(Angle(0, client:EyeAngles().y, 0))
	npc:Spawn()
	npc:LoadTemplate(template)
	if npc:LookupSequence(sequence) < 0 then
		npc:Remove()

		return "That sequence does not exist on this model."
	end
	if IsValid(previews[client]) then previews[client]:Remove() end
	previews[client] = npc
	npc:SetNoBubble(true)
	npc:SetTownSpawnAnim(sequence)
	npc:SetAnim()
	undo.Create("Town NPC preview")
	undo.AddEntity(npc)
	undo.SetPlayer(client)
	undo.Finish()

	return "Preview ready. Aim at it and use /TownNPCGetSpawnPoint to capture its pose."
end

function PLUGIN:PlayerDisconnected(client)
	if IsValid(previews[client]) then previews[client]:Remove() end
	previews[client] = nil
end

function PLUGIN:OnUnload()
	for client, npc in pairs(previews) do
		if IsValid(npc) then npc:Remove() end
		previews[client] = nil
	end
end
