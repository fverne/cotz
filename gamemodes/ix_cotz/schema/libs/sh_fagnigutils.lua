ix.util = ix.util or {}

-- Maps a value with a range to a new range
function ix.util.mapValueToRange(valToMap, origMinRange, origMaxRange, newMinRange, newMaxRange)
	return ((valToMap - origMinRange) * (newMaxRange - newMinRange) / (origMaxRange - origMinRange) + newMinRange);
end


function ix.util.PlayerPerformBlackScreenAction(player, actiontext, actiondur, callbackfunc)

	net.Start("ix_KillMenu")
	net.Send(player)

	player:SetNetVar("ix_hasBlackScreen", true)
	player:SetAction(actiontext.." (Press F to cancel)", actiondur)
	player:Freeze(true)
	player:ScreenFade( SCREENFADE.IN, Color( 0, 0, 0 ), 1, 1 )
	player:SetNetVar("ix_noMenuAllowed", true)

	timer.Create("ixBlackScreenAction" .. player:SteamID(), 1, 1, function()
		player:ScreenFade( SCREENFADE.IN, Color( 0, 0, 0 ), 1, actiondur-2 ) --fade in in the last second
	end)

	timer.Create("ixBlackScreenActionFunction" .. player:SteamID(), actiondur, 1, function()
		player:Freeze(false)
		player:SetNetVar("ix_noMenuAllowed", false)

		-- in case we cancel, dont do the callback function
		if !player:GetNetVar("ix_hasBlackScreen") then
			return
		end

		player:SetNetVar("ix_hasBlackScreen", nil)

		if(callbackfunc) then --Call callback function last, so if it errors, we are not permanently frozen
			callbackfunc(player)
		end
	end)
end

function ix.util.PlayerActionInterrupt(player)
    if (player:GetNetVar("ix_hasBlackScreen")) then
        player:SetAction("Action Cancelled", 0.2)
        player:Freeze(false)
        player:SetNetVar("ix_noMenuAllowed", false)
		player:SetNetVar("ix_hasBlackScreen", nil)

        if timer.Exists("ixBlackScreenAction" .. player:SteamID()) then
            timer.Remove("ixBlackScreenAction" .. player:SteamID())
            player:ScreenFade(SCREENFADE.PURGE, Color(0, 0, 0), 0.1, 0)
        end
        if timer.Exists("ixBlackScreenActionFunction" .. player:SteamID()) then
        	timer.Remove("ixBlackScreenActionFunction" .. player:SteamID())
        end
        player:ScreenFade(SCREENFADE.PURGE, Color(0, 0, 0), 0.1, 0)
        player:ScreenFade(SCREENFADE.IN, Color(0, 0, 0), 0.2, 0)
        player:SetNetVar("IsPoaching", false) -- in case we poach
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

		if (IsValid(ix.gui.openedStorage)) then
			net.Start("ixStorageClose")
			net.SendToServer()
			ix.gui.openedStorage:Remove()
		end

	end)

end

hook.Add("ShouldSuppressMenu", "ix_reloadNoMenuAllowed", function(client)
	local weapon = client:GetActiveWeapon()

	if(weapon.ReloadDelay or ((weapon.dt and weapon.dt.State and weapon.dt.State == CW_ACTION))) then
		return true
	end
end)

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

ix.command.Add("GetEntitiesInSphere", {
	description = "Dump all entities in sphere",
	adminOnly = true,
	arguments = {
		ix.type.number
	},
	OnRun = function(self, client, radius)

		local aimPos = client:GetEyeTraceNoCursor().HitPos
		
		for k,v in ipairs(ents.FindInSphere(aimPos, radius)) do
			print("Entity: (", v:GetClass(), v:GetName(), v:MapCreationID(), ")")
		end
	end
})