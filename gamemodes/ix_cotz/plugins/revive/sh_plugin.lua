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
			if(ix.pac) then
				ragdoll.RenderOverride = function()
					ragdoll.objCache = ragdoll:GetNetVar("player")
					ragdoll:DrawModel()

					hook.Run("DrawPlayerRagdoll", ragdoll)
				end
			end
		end
	end)

	function PLUGIN:PlayerButtonDown(ply, but)
		if ( IsFirstTimePredicted() and but == 15 and !LocalPlayer():Alive()) then
			timer.Simple(2.5, function()
				if( input.IsButtonDown(15)) then
					net.Start("ix_PleaseKillMe")
					net.SendToServer()
				end
			end)
		end
	end
else
	function PLUGIN:PlayerSpawn( client )
		client:UnSpectate()
		if not client:GetCharacter() then
			return
		end

		if IsValid(ix.temp.Corpses[client]) then
			if (!client:GetNetVar("resurrected")) then
				hook.Run("DeathDrop",client,ix.temp.Corpses[client]:GetPos())
			end
			ix.temp.Corpses[client]:Remove()
			client:SetNetVar("resurrected", false)
		end

	end

	--[[
		Purpose: Called when the player has died with a valid character.
	--]]

  ix.temp = ix.temp or {}
  ix.temp.Corpses = ix.temp.Corpses or {}

  function PLUGIN:DoPlayerDeath( client, attacker, dmg )
		if not client:GetCharacter() then
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
		ix.temp.Corpses[client]:SetNWFloat("Time", CurTime() + ix.config.Get("spawnTime", 10))
		ix.temp.Corpses[client]:SetNWBool("Body", true)

		ix.temp.Corpses[client].isDeadBody = true

		--if(ix.pac) then
		--	ix.temp.Corpses[client].RenderOverride = function()
		--		ix.temp.Corpses[client].objCache = ix.temp.Corpses[client]:GetNetVar("player")
		--		ix.temp.Corpses[client]:DrawModel()

		--		hook.Run("DrawPlayerRagdoll", ix.temp.Corpses[client])
		--	end
		--end

		timer.Simple(0.5, function()
			netstream.Start(nil, "ix_DeadBody", ix.temp.Corpses[client]:EntIndex())
		end)

		--ix.chat.Send(client, "iteminternal", "falls to the ground due to their injuries.", false)

		client:Spectate(OBS_MODE_CHASE)
		client:SpectateEntity(ix.temp.Corpses[client])
		client:Notify("You will respawn in "..math.Round(ix.config.Get("spawnTime", 10)).." seconds.")
		timer.Simple(0.01, function()
			if(client:GetRagdollEntity() != nil and client:GetRagdollEntity():IsValid()) then
				client:GetRagdollEntity():Remove()
			end
		end)
	end

	util.AddNetworkString("ix_PleaseKillMe")
	net.Receive("ix_PleaseKillMe", function(length, client)
		if(!client:Alive()) then client:SetNetVar("deathTime", CurTime()) end
	end)
end

ix.command.Add("charrevive", {
    adminOnly = true,
    alias = {"revive", "resurrect"},
    description = "Revives the player who is in dead body state and set their HP. Default: 100 HP.",
    arguments = {ix.type.string, bit.bor(ix.type.number, ix.type.optional)},
    OnRun = function(self, client, target, health)
        local target = ix.util.FindPlayer(target)
        if not target then return client:Notify("Target can not be found!") end
        if not health then health = 100 end
        if health < 1 then return client:Notify("The health reset value must be greater than 1!") end

        if health then
            health = math.Round(health)
        end

        if not ix.temp.Corpses[target].isDeadBody then return client:Notify("The target is not dead, they can't be revived!") end
        target:UnSpectate()
        target:SetNetVar("resurrected", true)
        target:Spawn()
        target:SetHealth(health or 100)

        target:SetPos(ix.temp.Corpses[target]:GetPos())

        if target:IsStuck() then
            target:SetPos(ix.temp.Corpses[target]:GetPos() + Vector(0, 0, 16))

            local positions = ix.util.FindEmptySpace(target, {ix.temp.Corpses[target], target})

            for _, v in ipairs(positions) do
                target:SetPos(v)
                if not target:IsStuck() then return end
            end
        end

        if target ~= client then
            client:Notify("You revived " .. target:GetName())
            target:Notify("You were revived by " .. client:GetName())
        else
            if target == client then
                client:Notify("You revived yourself")
            end
        end
    end
})
