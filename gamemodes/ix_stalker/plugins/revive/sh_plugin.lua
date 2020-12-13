PLUGIN.name = "Revive"
PLUGIN.author = "some faggot"
PLUGIN.desc = "A downed/revive implementation"

ix.config.Add("reviveOn", true, "If true revive mode will be active.", nil, {
	category = "Revive"
})

ix.config.Add("reviveRessurrectionTime", 2, "How long it should take to revive someone.", nil, {
	data = {min = 1, max = 60},
	category = "Revive"
})

--[[
function PLUGIN:PlayerDisconnected(ply)
  if ix.temp.Corpses[ply] then
	for k, v in ipairs(ix.faction.indices) do
		if (k == client:Team()) then
			points = ix.plugin.list["spawns"].spawns[v.uniqueID] or {}

			break
		end
	end

	if (points) then 
		for k, v in ipairs(nut.class.list) do
			if (class == v.index) then
				className = v.uniqueID

				break
			end
		end

		points = points[className] or points[""]

		if (points and table.Count(points) > 0) then
			local position = table.Random(points)

			ply:SetPos(position)
		end
	end
end]]--

if (CLIENT) then

	surface.CreateFont( "ReviveText", {
	 font = "Trebuchet MS",
	 size = 25,
	 weight = 500,
	 blursize = 0,
	 scanlines = 0,
	 antialias = true
	} )

	hook.Add("HUDPaint", "DrawDeadPlayers", function()
		if (LocalPlayer():GetChar()) then
			for k, v in pairs(ents.FindByClass("prop_ragdoll")) do
				if IsValid(v) and v.isDeadBody then
					if LocalPlayer():GetPos():Distance(v:GetPos()) > 512 then return end
					if v.player == LocalPlayer() then return end
					local Pos = v:GetPos():ToScreen()
					draw.RoundedBox(0, Pos.x, Pos.y, 10, 40, Color(175, 100, 100))
					draw.RoundedBox(0, Pos.x - 15, Pos.y + 15, 40, 10, Color(175, 100, 100))

					draw.SimpleText("Time Left: "..math.Round(v:GetNWFloat("Time") - CurTime()), "ReviveText", Pos.x, Pos.y - 20, Color(249, 255, 239), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
				end
			end
		end
	end)

	netstream.Hook("ix_DeadBody", function( index )
		local ragdoll = Entity(index)

		if IsValid(ragdoll) then
			ragdoll.isDeadBody = true
		end
	end)
else
	function PLUGIN:PlayerSpawn( client )
		client:UnSpectate()
		if not client:GetChar() then 
			return 
		end

		if IsValid(ix.temp.Corpses[client]) then
			if (!client:GetNetVar("resurrected")) then
				hook.Run("DeathDrop",client,ix.temp.Corpses[client]:GetPos())
			end
			ix.temp.Corpses[client]:Remove()
			client:setNetVar("resurrected", false)
		end

	end

	--[[
		Purpose: Called when the player has died with a valid character.
	--]]

  ix.temp = ix.temp or {}
  ix.temp.Corpses = ix.temp.Corpses or {}

  function PLUGIN:DoPlayerDeath( client, attacker, dmg )
		if not client:GetChar() then 
			return 
		end

		ix.temp.Corpses[client] = ents.Create("prop_ragdoll")
		ix.temp.Corpses[client]:SetPos(client:GetPos())
		ix.temp.Corpses[client]:SetModel(client:GetModel())
		for k,v in pairs(client:GetBodyGroups()) do
			local curBG = client:GetBodygroup(v.id)
			ix.temp.Corpses[client]:SetBodygroup(v.id, curBG)
		end
		ix.temp.Corpses[client]:SetSkin(client:GetSkin())
		ix.temp.Corpses[client]:SetNetVar("player", client)
		ix.temp.Corpses[client]:SetAngles(client:GetAngles())
		ix.temp.Corpses[client]:Spawn()
		ix.temp.Corpses[client]:SetCollisionGroup(COLLISION_GROUP_WEAPON)
		local phys = ix.temp.Corpses[client]:GetPhysicsObject()
		if phys and phys:IsValid() then
			phys:ApplyForceCenter(client:GetVelocity() * 15);
		end
		ix.temp.Corpses[client].player = client
		ix.temp.Corpses[client]:SetNWFloat("Time", CurTime() + ix.config.get("spawnTime", 10))
		ix.temp.Corpses[client]:SetNWBool("Body", true)

		timer.Simple(0.5, function()
			netstream.Start(nil, "ix_DeadBody", ix.temp.Corpses[client]:EntIndex())
		end)

		--ix.chat.Send(client, "iteminternal", "falls to the ground due to their injuries.", false)

		client:Spectate(OBS_MODE_CHASE)
		client:SpectateEntity(SCHEMA.Corpses[client])
		client:notify("You will respawn in "..math.Round(ix.config.Get("spawnTime", 10)).." seconds.")
		timer.Simple(0.01, function()
			if(client:GetRagdollEntity() != nil and client:GetRagdollEntity():IsValid()) then
				client:GetRagdollEntity():Remove()
			end
		end)
	end
end

