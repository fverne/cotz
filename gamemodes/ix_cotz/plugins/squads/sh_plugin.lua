PLUGIN.name = "Squad"
PLUGIN.author = "STEAM_0:1:29606990 / modified by fverne"
PLUGIN.description = "Creation of your super-duper squad."

ix.squad = ix.squad or {}
ix.squad.list = ix.squad.list or {}
-- Explicit leader character IDs for legacy squads with multiple owner-account characters.
ix.squad.legacyLeaders = ix.squad.legacyLeaders or {}

if (CLIENT) then
	ix.option.Add("squadTeamColor", ix.type.color, Color(51, 153, 255), {
		category = "colors"
	})
end

ix.char.RegisterVar("squadID", {
	bNoDisplay = true,
	default = "NULL",
	field = "squad_id",
	fieldType = ix.type.string
})

-- Public display metadata; the full roster is synchronized only to squad members.
ix.char.RegisterVar("squadName", {
	bNoDisplay = true,
	default = ""
})

ix.char.RegisterVar("squadColor", {
	bNoDisplay = true,
	default = {},
})

ix.char.RegisterVar("squadOfficer", {
	bNoDisplay = true,
	bNoNetworking = true,
	default = 0,
	field = "squad_officer",
	fieldType = ix.type.bool
})

ix.util.Include("meta/sh_squad.lua", "shared")

function ix.squad.Register(owner, name, data)
	local squad = ix.squad.meta:New(owner, name)
	squad.members = squad.members or {}
	squad.memberInfo = squad.memberInfo or {}

	for k, v in pairs(data or {}) do
		squad[k] = v
	end

	ix.squad.list[owner] = squad
	return squad
end

function ix.squad.GetPlayer(characterID)
	for _, client in ipairs(player.GetHumans()) do
		local character = client:GetCharacter()

		if (character and character:GetID() == characterID) then
			return client
		end
	end
end

ix.util.Include("sv_plugin.lua")

if (CLIENT) then
	function PLUGIN:CreateMenuButtons(tabs)
		tabs["squads"] = function(container)
			local panel = container:Add("ixSquadMenu")
			panel:Dock(FILL)
		end
	end

	function ix.squad.GetScoreboardGroup(client)
		local character = client:GetCharacter()
		if (not character) then return end

		local id = character:GetSquadID()
		local name = character:GetSquadName()
		if (id == "NULL" or name == "") then return end

		return id, name, character:GetSquadColor()
	end


	do
		local function SquadColor(target)
			if (not LocalPlayer():GetCharacter() or not IsValid(target) or not target:IsPlayer()) then return end
			if (not target:GetCharacter()) then return end
			local sq = ix.squad.list[LocalPlayer():GetCharacter():GetSquadID()]
			if (sq and sq.members[target:GetCharacter():GetID()]) then
				return ix.option.Get("squadTeamColor", Color(51, 153, 255))
			end
		end

		hook.Add("GetPlayerColorSB", "SquadColor", SquadColor)
		hook.Add("GetKillfeedColor", "SquadColor", SquadColor)
	end

	do
		local players = {}
		local sq = nil

		function PLUGIN:PreDrawOutlines()
			if (!LocalPlayer():GetCharacter()) then return end
			players = {}

			for _, v in ipairs(player.GetAll()) do
				if (IsValid(v) and v != LocalPlayer() and v:GetCharacter() and v:Alive()) then
					sq = ix.squad.list[LocalPlayer():GetCharacter():GetSquadID()]

					if (sq and sq.members[v:GetCharacter():GetID()]) then
						players[#players + 1] = v
					end
				end
			end

			if (#players > 0) then
				outline.Add(players, ix.option.Get("squadTeamColor", Color(51, 153, 255)), OUTLINE_MODE_VISIBLE)
			end
		end
	end

	net.Receive("ixSquadSync", function()
		local data = net.ReadTable()
		if (table.IsEmpty(data)) then return end

		local squad = ix.squad.Register(data.owner, data.name, {
			color = data.color,
			description = data.description,
			leaderID = data.leaderID,
			memberInfo = data.memberInfo or {}
		})

		for characterID, rank in pairs(data.members or {}) do
			squad.members[tonumber(characterID)] = tonumber(rank)
		end

		local character = LocalPlayer():GetCharacter()
		if (IsValid(ix.gui.squad) and character and character:GetSquadID() == squad.owner
			and squad.members[character:GetID()] ~= nil) then
			ix.gui.squad.data = squad
			ix.gui.squad:SetMembers(squad, true)
		end
	end)

	net.Receive("ixSquadKick", function()
		local id = net.ReadString()
		local disbanded = net.ReadBool()
		local characterID = not disbanded and net.ReadUInt(32)
		local squad = ix.squad.list[id]
		if (not squad) then return end

		local character = LocalPlayer():GetCharacter()
		local wasMember = character and squad.members[character:GetID()] ~= nil

		if (disbanded) then
			ix.squad.list[id] = nil
		else
			squad.members[characterID] = nil
			squad.memberInfo[characterID] = nil
		end

		local panel = ix.gui.squad
		if (IsValid(panel) and panel.data.owner == id and (disbanded
			or (character and character:GetID() == characterID))) then
			panel:Remove()
		end

		if (character and (character:GetID() == characterID or (disbanded and wasMember))) then
			LocalPlayer():NotifyLocalized(disbanded and "squad_leader_disbanded" or "squad_kicked")
		end
	end)

	net.Receive("ixSquadLeave", function()
		local id = net.ReadString()
		local characterID = net.ReadUInt(32)
		local squad = ix.squad.list[id]

		if (squad) then
			squad.members[characterID] = nil
			squad.memberInfo[characterID] = nil
		end

		local character = LocalPlayer():GetCharacter()
		if (not character or character:GetID() ~= characterID) then return end
		if (IsValid(ix.gui.squad) and ix.gui.squad.data.owner == id) then ix.gui.squad:Remove() end
		LocalPlayer():NotifyLocalized("squad_successfully_left")
	end)
end

if (SERVER) then
	function ix.squad.AcceptInvite(client)
		local invite = client.squad_invite
		client.squad_invite = nil
		client:SetLocalVar("squadInvite", nil)
		local character = client:GetCharacter()
		if (not invite or invite.expires < CurTime() or not character) then return end
		if (character:GetID() ~= invite.targetID or character:GetSquadID() ~= "NULL") then return end

		local inviter = ix.squad.GetPlayer(invite.inviterID)
		if (not inviter or inviter:GetCharacter():GetSquadID() ~= invite.squadID) then return end

		ix.squad.AddMember(client, inviter)
	end
end
