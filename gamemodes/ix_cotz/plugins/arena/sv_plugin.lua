local PLUGIN = PLUGIN
PLUGIN.ArenaPlayers = PLUGIN.ArenaPlayers or {}
PLUGIN.ArenaSounds = {}
PLUGIN.Queues = PLUGIN.Queues or {}
PLUGIN.PendingRequests = PLUGIN.PendingRequests or {}
PLUGIN.RequestNPCName = "'Arena Master'"
PLUGIN.RequestNPCRadius = 512
PLUGIN.RequestCooldownSender = 30
PLUGIN.RequestCooldowns = PLUGIN.RequestCooldowns or {}
PLUGIN.Cutscenes.entities = PLUGIN.Cutscenes.entities or {}
util.AddNetworkString("ixArenaChallenge")
util.AddNetworkString("ixArenaRequest")
util.AddNetworkString("ixArenaRequestResponse")
util.AddNetworkString("ixArenaEnd")
util.AddNetworkString("ixArenaSceneShowed")
util.AddNetworkString("ixArenaCutscenePos")
util.AddNetworkString("ixArenaCutsceneEnded")
util.AddNetworkString("ixArenaCutsceneLaunch")
util.AddNetworkString("ixArenaAttachCameraTo")
util.AddNetworkString("ixArenaResetCamera")
util.AddNetworkString("ixArenaStopSpectate")
util.AddNetworkString("ixArenaChangeSpectateTarget")

net.Receive("ixArenaStopSpectate", function(len, ply)
	if not IsValid(ply) or not ply:IsPlayer() then return end
	if ply:GetLocalVar("arenaSpectate", false) then
		PLUGIN:ToggleSpectateArena(ply)
	end
end)

net.Receive("ixArenaChangeSpectateTarget", function(len, ply)
	if not IsValid(ply) or not ply:IsPlayer() then return end
	if not ply:GetLocalVar("arenaSpectate", false) then return end

	local idx = ply:GetLocalVar("arenaSpectateTargetIndex", 1)
	idx = (idx == 1) and 2 or 1
	ply:SetLocalVar("arenaSpectateTargetIndex", idx)

	local target = PLUGIN.Arenas["rp_marsh_cs"]["swampsarena"]["players"][idx].player
	if IsValid(target) then
		ply:SpectateEntity(target)
	end
end)

net.Receive("ixArenaRequest", function(len, ply)
	local targetSid = net.ReadString()
	local target = player.GetBySteamID(targetSid)

	if not IsValid(target) or not target:IsPlayer() then 
		ply:Notify("Target player not found!")
	end

	PLUGIN:RequestArenaMatch("swampsarena", ply, target)
end)

net.Receive("ixArenaRequestResponse", function(len, ply)
	local accepted = net.ReadBool()
	local senderSid = net.ReadString()
	local arenaName = net.ReadString()
	local sender = player.GetBySteamID(senderSid)
	local plySid = ply:SteamID()

	if not IsValid(sender) or not sender:IsPlayer() then
		ply:Notify("Request sender no longer available.")

		if PLUGIN.PendingRequests[plySid] then
			PLUGIN.PendingRequests[plySid][senderSid] = nil

			if next(PLUGIN.PendingRequests[plySid]) == nil then
				PLUGIN.PendingRequests[plySid] = nil
			end
		end

		return
	end

	if not PLUGIN.PendingRequests[plySid] or not PLUGIN.PendingRequests[plySid][senderSid] then
		ply:Notify("No such pending request.")
		return
	end

	local pending = PLUGIN.PendingRequests[plySid][senderSid]

	if pending.arena ~= arenaName then
		ply:Notify("Request no longer valid.")
		return
	end

	if CurTime() - PLUGIN.PendingRequests[plySid][senderSid].time > 10 then
		ply:Notify("The request has expired due to timeout.")
		PLUGIN.PendingRequests[plySid][senderSid] = nil

		return
	end

	if not accepted then
		sender:Notify(ply:Nick() .. " has declined your arena request.")
		ply:Notify("You declined the request from " .. sender:Nick())
		return
	end

	if not PLUGIN:CanStartArena(arenaName) then
		sender:Notify("Arena is currently busy.")
		ply:Notify("Arena is currently busy.")
		return
	end

	if sender:GetLocalVar("inArena", false) or ply:GetLocalVar("inArena", false) then
		sender:Notify("Either you or the player is now in an arena and cannot start.")
		ply:Notify("Either you or the player is now in an arena and cannot start.")
		return
	end

	local npcEnt = ix.progression.GetNPCFromName(PLUGIN.RequestNPCName)

	if IsValid(npcEnt) then
		local npcPos = npcEnt:GetPos()

		if sender:GetPos():DistToSqr(npcPos) > (PLUGIN.RequestNPCRadius * PLUGIN.RequestNPCRadius) then
			sender:Notify("The player accepted your request, however, you are too far away from the Arena Master!")
			return
		end

		if ply:GetPos():DistToSqr(npcPos) > (PLUGIN.RequestNPCRadius * PLUGIN.RequestNPCRadius) then
			ply:Notify("You are too far away from the Arena Master!")
			return
		end
	end

	PLUGIN.PendingRequests[plySid][senderSid] = nil

	PLUGIN:StartArenaFight(arenaName, sender, ply)
end)

net.Receive("ixArenaSceneShowed", function(len, ply)
	local scene = net.ReadUInt(32)
	ply:OnSceneShowed(scene)
end)

net.Receive("ixArenaCutscenePos", function(len, ply)
	ply:SetPos(net.ReadVector())
	ply:SetEyeAngles(net.ReadAngle())
end)

net.Receive("ixArenaCutsceneEnded", function(len, ply)
	local forceStop = net.ReadBool()
	ply:OnCutsceneEnded(forceStop, true)
end)


function PLUGIN:CanStartArena(arenaName)
	local arenas = self.Arenas[game.GetMap()]
	if not arenas then return false end
	local arenaData = arenas[arenaName]
	if not arenaData then return false end

	return not arenaData.active
end

function PLUGIN:GetSpectateTV()
	local ent
	for k,v in ipairs(ents.FindInSphere(ix.progression.GetNPCFromName("'Arena Master'"):GetPos(), 512)) do
		if v:GetClass() ~= "ix_arenaspectate" then continue end
		ent = v
		break
	end

	return IsValid(ent) and ent
end

function PLUGIN:RequestArenaMatch(arenaName, sender, target)
	if not IsValid(sender) or not sender:IsPlayer() then return end

	if not IsValid(target) or not target:IsPlayer() then
		sender:Notify("Target player not found.")

		return
	end

	if not sender:GetCharacter() or not target:GetCharacter() then
		sender:Notify("Either you or the target does not have a valid character.")

		return
	end

	-- cooldown checks (per-sender and per-target)
	local now = CurTime()
	local sSid = sender:SteamID()
	local tSid = target:SteamID()

	if PLUGIN.RequestCooldowns[sSid] and now - PLUGIN.RequestCooldowns[sSid] < PLUGIN.RequestCooldownSender then
		local wait = math.ceil(PLUGIN.RequestCooldownSender - (now - PLUGIN.RequestCooldowns[sSid]))
		sender:Notify("Please wait " .. wait .. "s before sending another request.")

		return
	end

	-- proximity check: require both sender and target to be near a configured NPC
	local npcEnt = ix.progression.GetNPCFromName(PLUGIN.RequestNPCName)

	if IsValid(npcEnt) then
		local npcPos = npcEnt:GetPos()

		if sender:GetPos():DistToSqr(npcPos) > (PLUGIN.RequestNPCRadius * PLUGIN.RequestNPCRadius) then
			sender:Notify("You are too far from the NPC to send arena requests.")

			return
		end

		if target:GetPos():DistToSqr(npcPos) > (PLUGIN.RequestNPCRadius * PLUGIN.RequestNPCRadius) then
			sender:Notify("Target is too far from the NPC to receive arena requests.")

			return
		end
	end

	local arenas = self.Arenas[game.GetMap()]

	if not arenas or not arenas[arenaName] then
		sender:Notify("Arena not found: " .. tostring(arenaName))

		return
	end

	if sender:GetLocalVar("inArena", false) or target:GetLocalVar("inArena", false) then
		sender:Notify("Either you or the target is already in an arena.")

		return
	end

	self.PendingRequests[tSid] = self.PendingRequests[tSid] or {}
	local key = sSid

	if self.PendingRequests[tSid][key] then
		sender:Notify("You already have a pending request to that player.")

		return
	end

	self.PendingRequests[tSid][key] = {
		arena = arenaName,
		time = now
	}

	PLUGIN.RequestCooldowns[sSid] = now

	local model = sender:GetModel()
	local rep = sender:getCurrentRankName()
	local loadout = {}
	local char = sender:GetCharacter()
	local inv = char:GetInventory()

	for _, item in pairs(inv:GetItems()) do
		if item.isWeapon or item.category == "Weapons" and item:GetData("equip", false) then
			table.insert(loadout, item:GetName() or "Unknown Item")
		end
	end

	net.Start("ixArenaRequest")
		net.WriteString(sender:Nick())
		net.WriteString(sSid)
		net.WriteString(arenaName)
		net.WriteString(model)
		net.WriteString(rep)
		net.WriteTable(loadout)
	net.Send(target)

	sender:Notify("Request sent to " .. target:Nick())
end

function PLUGIN:PlayerDisconnected(ply)
	local arenas = PLUGIN.Arenas[game.GetMap()]
	if not arenas then return end
	local sid = ply:SteamID()
	local disconnectedName = ply:Nick()

	-- Case A: disconnected player was a target — notify all senders and remove that table
	local pendingForTarget = PLUGIN.PendingRequests[sid]

	if pendingForTarget then
		for senderSid in pairs(pendingForTarget) do
			local sender = player.GetBySteamID(senderSid)

			if IsValid(sender) then
				sender:Notify(disconnectedName .. " disconnected; your pending arena request was cancelled.")
			end
		end

		PLUGIN.PendingRequests[sid] = nil
	end

	-- Case B: disconnected player was a sender — remove their entries from other targets and notify those targets
	for targetSid, tbl in pairs(PLUGIN.PendingRequests) do
		if tbl[sid] then
			local target = player.GetBySteamID(targetSid)

			if IsValid(target) then
				target:Notify(disconnectedName .. " disconnected; your pending arena request was cancelled.")
			end

			tbl[sid] = nil
		end

		if next(tbl) == nil then
			PLUGIN.PendingRequests[targetSid] = nil
		end
	end

	if ply:GetLocalVar("inArena", false) or ply:GetLocalVar("arenaSpectate", false) then
		ply:SetData("arenaPos", true)
	end

	for arenaName, arenaData in pairs(arenas) do
		local otherPlayer = nil

		if arenaData.players[1].player == ply then
			otherPlayer = arenaData.players[2].player
		elseif arenaData.players[2].player == ply then
			otherPlayer = arenaData.players[1].player
		end

		if otherPlayer then
			self:EndArena(arenaName, otherPlayer, ply)
			otherPlayer:OnCutsceneEnded(true, false)
		end
	end
end

function PLUGIN:PlayerDeath(victim, inflictor, attacker)
	if victim:IsPlayer() then
		local arenas = PLUGIN.Arenas[game.GetMap()]
		if not arenas then return end
		if not victim:GetLocalVar("inArena", false) then return end -- save looking up the arenas if we know they aren't in one

		for arenaName, arenaData in pairs(arenas) do
			if not IsValid(attacker) then
				if arenaData.players[1].player == victim then
					attacker = arenaData.players[2].player
				else
					attacker = arenaData.players[1].player
				end
			end

			self:EndArena(arenaName, attacker, victim)

			break
		end
	end
end

function PLUGIN:PlayerLoadedCharacter(client)
	timer.Simple(1, function()
		if not IsValid(client) then return end
		if client:GetData("arenaPos", false) then
			client:SetPos(Vector(-5633, -10038, 4989))
			client:SetData("arenaPos", false)
			client:Notify("You disconencted whilst in the Arena, your position has been fixed!")

			timer.Simple(0, function()
				if client:IsStuck() then
					client:SetPos(winner:GetPos() + Vector(0, 0, 16))

					local positions = ix.util.FindEmptySpace(client, {client})

					for _, v in ipairs(positions) do
						client:SetPos(v)
						if not client:IsStuck() then break end
					end
				end
			end)
		end
	end)
end

function PLUGIN:CanPlayerEquipItem(client, item)
	return not client:GetLocalVar("inArena", false)
end

function PLUGIN:CanPlayerUnequipItem(client, item)
	return not client:GetLocalVar("inArena", false)
end

function PLUGIN:CanPlayerInteractItem(client, action, item, data)
	return not client:GetLocalVar("arenaSpectate", false)
end

function PLUGIN:CanPlayerHoldObject(client, entity)
	return not client:GetLocalVar("arenaSpectate", false)
end

function PLUGIN:CanPlayerInteractEntity(client, entity, option, data)
	return not client:GetLocalVar("arenaSpectate", false)
end

function PLUGIN:EndArena(arenaName, winner, loser)
	local arenaData = PLUGIN.Arenas[game.GetMap()][arenaName]
	timer.Remove("ixArenaDurationTimer_" .. arenaName)

	if IsValid(winner) and winner:IsPlayer() then
		for k, ply in pairs( player.GetAll() ) do
			ix.chat.Send(ply, "eventpdainternal", Format("%s has defeated %s in the arena!", winner:GetName(), loser:GetName()), true, ply)
		end

		winner:Notify("You have won the arena! You will be teleported back in 5 seconds...")
		winner:SetLocalVar("arenaEndTime", nil)

		timer.Simple(5, function()
			if IsValid(winner) and winner:IsPlayer() and winner:Alive() then
				winner:SetPos(Vector(-5633, -10038, 4989))
				winner:SetLocalVar("inArena", false)

				timer.Simple(0, function()
					if not IsValid(winner) then return end
					if winner:IsStuck() then
						winner:SetPos(winner:GetPos() + Vector(0, 0, 16))

						local positions = ix.util.FindEmptySpace(winner, {winner})

						for _, v in ipairs(positions) do
							winner:SetPos(v)
							if not winner:IsStuck() then break end
						end
					end
				end)
			end
		end)
	end

	if IsValid(loser) and loser:IsPlayer() then
		local teleportPos = Vector(-5577, -10038, 4989)
		loser:Notify("You have lost the arena!")
		loser:SetLocalVar("inArena", false)
		loser:SetLocalVar("arenaEndTime", nil)
		loser:SetPos(teleportPos)
		timer.Simple(0, function()
			if not IsValid(loser) then return end
			loser:UnSpectate()
			loser:SetNetVar("resurrected", true)
			loser:Spawn()
			loser:SetPos(teleportPos)
			timer.Simple(0, function()
				if not IsValid(loser) then return end
				loser:SetHealth(10)
				if loser:IsStuck() then
					loser:SetPos(loser:GetPos() + Vector(0, 0, 16))

					local positions = ix.util.FindEmptySpace(loser, {loser})

					for _, v in ipairs(positions) do
						loser:SetPos(v)
						if not loser:IsStuck() then break end
					end
				end
			end)
		end)
	end

	arenaData.players[1].player = nil
	arenaData.players[2].player = nil

	local spectateTV = self:GetSpectateTV()

	if spectateTV then
		spectateTV:SetActive(false)
	end

	for _, spectator in pairs(arenaData.spectators) do
		if IsValid(spectator) and spectator:IsPlayer() then
			spectator:Notify("The arena has ended.")
			self:ToggleSpectateArena(spectator)
		end
	end

	arenaData.spectators = {}
	local participants = self.ArenaPlayers[arenaName]
	net.Start("ixArenaEnd")
	net.WriteString(loser:SteamID())
	net.Send(participants)
	self.ArenaPlayers[arenaName] = {}

	timer.Simple(6, function()
		self:RemoveArena(arenaName)
		arenaData.active = false
	end)
end

function PLUGIN:EndArenaDueToTimeout(arenaName)
	local arenaData = PLUGIN.Arenas[game.GetMap()][arenaName]

	local players = {arenaData.players[1].player, arenaData.players[2].player}

	for index, ply in ipairs(players) do
		if IsValid(ply) and ply:IsPlayer() then
			ply:Notify("The arena has ended due to timeout.")
			ply:SetLocalVar("inArena", false)
			ply:SetLocalVar("arenaEndTime", nil)
			ply:SetPos(index == 1 and Vector(-5633, -10038, 4989) or Vector(-5577, -10038, 4989))
		end
	end

	for _, spectator in pairs(arenaData.spectators) do
		if IsValid(spectator) and spectator:IsPlayer() then
			spectator:Notify("The arena has ended due to timeout.")
			self:ToggleSpectateArena(spectator)
		end
	end

	arenaData.players[1].player = nil
	arenaData.players[2].player = nil
	arenaData.spectators = {}
	self.ArenaPlayers[arenaName] = {}
	self:RemoveArena(arenaName)
	arenaData.active = false
end

function PLUGIN:StartArenaDurationTimer(arenaName, playerOne, playerTwo)
	local arenaData = PLUGIN.Arenas[game.GetMap()][arenaName]
	local duration = arenaData.duration
	local endTime = CurTime() + duration

	playerOne:SetLocalVar("arenaEndTime", endTime)
	playerTwo:SetLocalVar("arenaEndTime", endTime)

	timer.Create("ixArenaDurationTimer_" .. arenaName, duration, 1, function()
		if arenaData.active then
			PLUGIN:EndArenaDueToTimeout(arenaName)
		end
	end)
end

local invisCol = Color(255,255,255,0)

function PLUGIN:SetupArena(arenaName)
	local arenaData = self.Arenas[game.GetMap()][arenaName]
	if not arenaData.ents or #arenaData.ents == 0 then return end

	for entIndex, entData in ipairs(arenaData.ents) do
		local bSoundscape = entData.class == "soundscape"
		local ent = ents.Create(bSoundscape and "prop_dynamic" or entData.class)
		ent:SetModel(entData.model)
		ent:SetPos(entData.pos)
		ent:SetAngles(entData.ang)
		ent:Spawn()

		if entData.sequence then
			ent:SetSequence(entData.sequence)
		end

		if bSoundscape then
			ent:SetColor(invisCol)
			ent:SetRenderMode(RENDERMODE_NONE)
			ent:EmitSound(entData.soundscape, 75, 100, 1)
			local timerstr = "ixArenaSoundscape_" .. arenaName .. "_" .. entIndex

			timer.Create(timerstr, entData.duration, 0, function()
				if not IsValid(ent) then
					timer.Remove(timerstr)

					return
				end

				ent:EmitSound(entData.soundscape, 75, 100, 1)
			end)
		end

		arenaData.ents[entIndex].ent = ent
	end

	local dupePlugin = ix.plugin.Get("advdupeint")

	if dupePlugin then
		local dupeIndex = self.Arenas[game.GetMap()][arenaName]["dupes"]
		local selectDupe = dupeIndex[math.random(1, #dupeIndex)]
		self.Arenas[game.GetMap()][arenaName]["dupes"]["selected_dupe"] = selectDupe
		dupePlugin:SpawnDupe(selectDupe)
	end

	local function CrowdAmbience(entities)
		local selectedEnt = entities[math.random(3, #entities)].ent -- don't include soundscapes in the selection

		if selectedEnt and IsValid(selectedEnt) then
			selectedEnt:EmitSound("cotz/arena/new_arena_public_" .. math.random(1, 9) .. ".ogg", 75, 100, 1)
		end

		timer.Adjust("ixArenaCrowd_" .. arenaName, math.random(2, 5), nil, nil)
	end

	timer.Create("ixArenaCrowd_" .. arenaName, 2, 0, function()
		CrowdAmbience(arenaData.ents)
	end)
end

function PLUGIN:RemoveArena(arenaName)
	local arenaData = self.Arenas[game.GetMap()][arenaName]

	for entIndex, entData in ipairs(arenaData.ents) do
		if entData.ent and IsValid(entData.ent) then
			if entData.class == "soundscape" then
				local timerstr = "ixArenaSoundscape_" .. arenaName .. "_" .. entIndex

				if timer.Exists(timerstr) then
					timer.Remove(timerstr)
				end

				entData.ent:StopSound(entData.soundscape)
			end

			entData.ent:Remove()
			arenaData.ents[entIndex].ent = nil
		end
	end

	if timer.Exists("ixArenaCrowd_" .. arenaName) then
		timer.Remove("ixArenaCrowd_" .. arenaName)
	end

	local dupePlugin = ix.plugin.Get("advdupeint")

	if dupePlugin then
		dupePlugin:DespawnDupe(self.Arenas[game.GetMap()][arenaName]["dupes"]["selected_dupe"])
	end
end

function PLUGIN:StartArenaFight(arenaName, playerOne, playerTwo)
	local arenas = self.Arenas[game.GetMap()]
	if not arenas then return end
	local arenaData = arenas[arenaName]
	if not arenaData then return end

	if not IsValid(playerOne) or not IsValid(playerTwo) then
		return
	end

	self:SetupArena(arenaName)
	arenaData.active = true
	arenaData.players[1].player = playerOne
	arenaData.players[2].player = playerTwo
	playerOne:SetLocalVar("inArena", "playerOne")
	playerTwo:SetLocalVar("inArena", "playerTwo")
	playerOne:SetPos(arenaData.players[1].pos)
	playerOne:SetEyeAngles(arenaData.players[1].ang)
	--playerOne:SetHealth(playerOne:GetMaxHealth())
	playerTwo:SetPos(arenaData.players[2].pos)
	playerTwo:SetEyeAngles(arenaData.players[2].ang)
	--playerTwo:SetHealth(playerOne:GetMaxHealth())

	timer.Simple(0.1, function()
		playerOne:Freeze(true)
		playerTwo:Freeze(true)
	end)

	local spectateTV = self:GetSpectateTV()

	if spectateTV then
		spectateTV:SetActive(true)
	end

	self.ArenaPlayers[arenaName] = {}
	local recipients = self.ArenaPlayers[arenaName]
	table.insert(recipients, playerOne)
	table.insert(recipients, playerTwo)

	local numPlayersFinishedIntro = 0
	local totalPlayers = #recipients
	local allPlayersFinished = false
	local playerOnePos, playerTwoPos = Vector(-13378, -2437, 326), Vector(-13374, -1303, 326)

	for _, recipient in ipairs(recipients) do
		recipient:StartCutscene("arenaintro", function(ply)
			-- callback becomes nil if we don't do this
			timer.Simple(0, function()
				if ply == playerOne then
					ply:StartCutscene("arenaplayerone", function()
						numPlayersFinishedIntro = numPlayersFinishedIntro + 1

						if numPlayersFinishedIntro == totalPlayers and not allPlayersFinished then
							allPlayersFinished = true
							playerOne:Freeze(false)
							playerTwo:Freeze(false)
							playerOne:Notify("The fight has begun!")
							playerTwo:Notify("The fight has begun!")
							playerOne:SetPos(playerOnePos)
							playerTwo:SetPos(playerTwoPos)
							self:StartArenaDurationTimer(arenaName, playerOne, playerTwo)
						else
							ply:Notify("Waiting for the opponent to finish loading before beginning!")
						end
					end)
				elseif ply == playerTwo then
					ply:StartCutscene("arenaplayertwo", function(ply)
						numPlayersFinishedIntro = numPlayersFinishedIntro + 1

						if numPlayersFinishedIntro == totalPlayers and not allPlayersFinished then
							allPlayersFinished = true
							playerOne:Freeze(false)
							playerTwo:Freeze(false)
							playerOne:Notify("The fight has begun!")
							playerTwo:Notify("The fight has begun!")
							playerOne:SetPos(playerOnePos)
							playerTwo:SetPos(playerTwoPos)
							self:StartArenaDurationTimer(arenaName, playerOne, playerTwo)
						else
							ply:Notify("Waiting for the opponent to finish loading before beginning!")
						end
					end)
				else
					ply:StartCutscene("arenaspectator", function(ply) end)
				end
			end)
		end)
	end
end

local playerMeta = FindMetaTable("Player")

function playerMeta:StartCutscene(id, callback, attachData)
	net.Start("ixArenaCutsceneLaunch")
	net.WriteString(id)
	net.WriteBool(attachData and true or false)
	net.WriteTable(attachData and (attachData.ents_list or {}) or {})
	net.Send(self)

	if attachData then
		self:AttachCameraTo(attachData.ent, attachData.bone)

		timer.Simple(attachData.duration, function()
			self:OnCutsceneEnded()
		end)
	end

	self.Callback = function()
		callback(self)
	end

	timer.Simple(0, function()
		self:GodEnable()

		if self:FlashlightIsOn() then
			self:Flashlight(false)
		end

		self:AllowFlashlight(false)
	end)
end

function playerMeta:AddSceneCallback(scene, callback)
	if not self.SceneCallback then
		self.SceneCallback = {}
	end

	self.SceneCallback[scene] = callback
end

function playerMeta:OnSceneShowed(scene)
	if not self.SceneCallback then return end
	if not self.SceneCallback[scene] then return end
	self.SceneCallback[scene]()
end

function playerMeta:OnCutsceneEnded(forceStop, fromClient)
	if self.Callback and not forceStop then
		self.Callback()
	end

	self.Callback = nil
	self:ResetCamera()
	self.SceneCallback = nil
	self:GodDisable()
	self:AllowFlashlight(true)

	if not fromClient then
		net.Start("ixArenaCutsceneEnded")
		net.Send(self)
	end

	for k, ent in pairs(PLUGIN.Cutscenes.entities) do
		if not IsValid(ent) then continue end
		ent:Remove()
	end

	PLUGIN.Cutscenes.entities = {}
end

function playerMeta:AttachCameraTo(entity, bone)
	if not bone then
		bone = "ValveBiped.Bip01_Head1"
	end

	self.Attached = {
		ent = entity,
		bone = bone
	}

	net.Start("ixArenaAttachCameraTo")
	net.WriteUInt(entity:EntIndex(), 32)
	net.WriteString(bone)
	net.Send(self)
end

function playerMeta:ResetCamera()
	self.Attached = nil
	net.Start("ixArenaResetCamera")
	net.Send(self)
end

function PLUGIN:ToggleSpectateArena(ply)
	if not IsValid(ply) or not ply:IsPlayer() then return end

	if ply:GetLocalVar("arenaSpectate", false) then
		for i, v in ipairs(self.Arenas["rp_marsh_cs"]["swampsarena"]["spectators"]) do
			if v == ply then
				table.remove(self.Arenas["rp_marsh_cs"]["swampsarena"]["spectators"], i)
				break
			end
		end

		ply:SetLocalVar("arenaSpectate", false)
		ply:UnSpectate()
		ply:Spawn()
		ply:SetPos(Vector(-5711,-10054, 4970))
		ply:SetNetVar("canShoot", true)

		timer.Simple(0, function()
			if not IsValid(ply) then return end
			if ply:IsStuck() then
				ply:SetPos(ply:GetPos() + Vector(0, 0, 16))

				local positions = ix.util.FindEmptySpace(ply, {ply})

				for _, v in ipairs(positions) do
					ply:SetPos(v)
					if not ply:IsStuck() then break end
				end
			end
		end)
		return
	end

	table.insert(self.Arenas["rp_marsh_cs"]["swampsarena"]["spectators"], ply)
	ply:SetLocalVar("arenaSpectate", true)
	ply:SetLocalVar("arenaSpectateTargetIndex", 1)
	ply:Spectate(OBS_MODE_CHASE)
	ply:SpectateEntity(self.Arenas["rp_marsh_cs"]["swampsarena"]["players"][1].player)
	ply:SetNetVar("canShoot", false)
end