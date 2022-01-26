ix.util = ix.util or {}

-- Maps a value with a range to a new range
function ix.util.mapValueToRange(valToMap, origMinRange, origMaxRange, newMinRange, newMaxRange)
	return ((valToMap - origMinRange) * (newMaxRange - newMinRange) / (origMaxRange - origMinRange) + newMinRange);
end


function ix.util.PlayerPerformBlackScreenAction(player, actiontext, actiondur, callbackfunc)

	net.Start("ix_KillMenu")
	net.Send(player)

	player:SetAction(actiontext, actiondur)
	player:Freeze(true)
	player:ScreenFade( SCREENFADE.IN, Color( 0, 0, 0 ), 1, 1 )
	player:SetNetVar("ix_noMenuAllowed", true)

	timer.Create("ixBlackScreenAction" .. player:SteamID(), 1, 1, function()
		player:ScreenFade( SCREENFADE.IN, Color( 0, 0, 0 ), 1, actiondur-2 ) --fade in in the last second
	end)

	timer.Simple(actiondur, function()
		player:Freeze(false)
		player:SetNetVar("ix_noMenuAllowed", false)


		if( callbackfunc) then --Call callback function last, so if it errors, we are not permanently frozen
			callbackfunc(player)
		end

	end)

end

function ix.util.PlayerActionInterrupt(player)
    -- just for poaching for now
    if (player:GetNetVar("IsPoaching")) then
        player:SetAction("Action Cancelled", 1)
        player:Freeze(false)
        player:SetNetVar("ix_noMenuAllowed", false)

        if timer.Exists("ixBlackScreenAction" .. player:SteamID()) then
            timer.Remove("ixBlackScreenAction" .. player:SteamID())
            player:ScreenFade(SCREENFADE.PURGE, Color(0, 0, 0), 0.1, 0)
        end

        player:ScreenFade(SCREENFADE.PURGE, Color(0, 0, 0), 0.1, 0)
        player:ScreenFade(SCREENFADE.IN, Color(0, 0, 0), 0.2, 0)
        player:SetNetVar("IsPoaching", false)
    end
end


if(CLIENT) then
	hook.Add("ShouldSuppressMenu", "ix_noMenuAllowed", function(client)
		if(client:GetNetVar("ix_noMenuAllowed")) then
			return true
		end
	end)

	net.Receive("ix_KillMenu", function()
		if IsValid(ix.gui.menu) then
			ix.gui.menu:Remove()
		end
	end)

end

if (SERVER) then
	util.AddNetworkString("ix_KillMenu")
end

function ix.util.GetMutantMeatWeight(uniqueID, knifetier)
	if(!string.find(uniqueID, "meat")) then return end

	local item = ix.item.list[uniqueID]
	local weightvar = item.BaseWeight * 0.05

	return item.BaseWeight + math.Rand(-weightvar, weightvar) + (item.WeightPerLevel * knifetier)
end

function ix.util.SpawnAdvVendor(npctemplate, pos, ang)

	local npc = ents.Create("ix_vendor_adv")

	npc:SetPos(pos)
	npc:SetAngles(ang)

	npc:Spawn()

	npc:LoadTemplate(npctemplate)

end

ix.command.Add("spawnadvvendor", {
	adminOnly = true,
	arguments = {
		ix.type.string,
	},
	OnRun = function(self, client, npctemplate)
		local trace = client:GetEyeTraceNoCursor()
		local hitpos = trace.HitPos + trace.HitNormal

		print(hitpos)
		print(client:GetAngles())

		ix.util.SpawnAdvVendor(npctemplate, hitpos, client:GetAngles())
	end
})
