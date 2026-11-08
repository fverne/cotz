local PLUGIN = PLUGIN
local previews = {}
local PREVIEW_DISTANCE_SQUARED = 192 ^ 2
local PREVIEW_COOLDOWN = 0.15

util.AddNetworkString("cotz/townnpcs/preview")
util.AddNetworkString("cotz/townnpcs/preview-sequence")

function PLUGIN:CanEditTownNPCPreview(client, npc)
	return IsValid(client) and client:IsPlayer() and client:IsAdmin() and IsValid(npc)
		and npc:GetClass() == "ix_townnpc_preview" and previews[client] == npc
		and client:GetPos():DistToSqr(npc:GetPos()) <= PREVIEW_DISTANCE_SQUARED
end

function PLUGIN:OpenTownNPCPreview(client, npc)
	if not self:CanEditTownNPCPreview(client, npc) then return end
	if (client.cotzPreviewNextOpen or 0) > CurTime() then return end
	client.cotzPreviewNextOpen = CurTime() + 0.5
	net.Start("cotz/townnpcs/preview")
	net.WriteEntity(npc)
	net.Send(client)
end

function PLUGIN:SetTownNPCPreviewSequence(client, npc, index)
	if not self:CanEditTownNPCPreview(client, npc) then return false end
	if (client.cotzPreviewNextChange or 0) > CurTime() then return false end
	client.cotzPreviewNextChange = CurTime() + PREVIEW_COOLDOWN
	if index < 0 or index >= npc:GetSequenceCount() or index ~= math.floor(index) then return false end
	local sequence = npc:GetSequenceName(index)
	if sequence == "" or npc:LookupSequence(sequence) < 0 then return false end
	npc:SetTownSpawnAnim(sequence)
	npc:SetAnim()

	return true
end

net.Receive("cotz/townnpcs/preview-sequence", function(_, client)
	local npc = net.ReadEntity()
	local index = net.ReadUInt(16)
	PLUGIN:SetTownNPCPreviewSequence(client, npc, index)
end)

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
	if sequence == nil then
		sequence = npc:GetIdleAnim()
		if sequence == "" or npc:LookupSequence(sequence) < 0 then sequence = npc:GetSequenceName(0) end
	end
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

	return "Preview ready. Press E on it to browse animations; use /TownNPCGetSpawnPoint to capture its pose."
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
