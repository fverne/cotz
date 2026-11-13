local TUTORIAL_ACK_COOLDOWN = 0.5

util.AddNetworkString("cotz/tutorial/open")
util.AddNetworkString("cotz/tutorial/shown")

function PLUGIN:AdjustCreationPayload(client, payload, newPayload)
	-- Include eligibility in the original INSERT, before creation can be interrupted.
	newPayload.data = newPayload.data or {}
	newPayload.data.cotzTutorialPending = true
end

function PLUGIN:PlayerLoadedCharacter(client, character)
	client.cotzTutorialCharacter = nil
	client.cotzTutorialNextAck = nil

	if not ix.config.Get("tutorialPopupEnabled", true) then return end
	if character:GetData("cotzTutorialPending") ~= true then return end
	client.cotzTutorialCharacter = character:GetID()

	net.Start("cotz/tutorial/open")
		net.WriteUInt(character:GetID(), 32)
	net.Send(client)
end

net.Receive("cotz/tutorial/shown", function(length, client)
	if (client.cotzTutorialNextAck or 0) > CurTime() then return end
	client.cotzTutorialNextAck = CurTime() + TUTORIAL_ACK_COOLDOWN

	local characterID = net.ReadUInt(32)
	local character = client:GetCharacter()

	if not character or character:GetID() ~= characterID then return end
	if character:GetPlayer() ~= client or client.cotzTutorialCharacter ~= characterID then return end
	if character:GetData("cotzTutorialPending") ~= true then return end

	client.cotzTutorialCharacter = nil
	character:SetData("cotzTutorialPending", false)
	character:Save()
end)
