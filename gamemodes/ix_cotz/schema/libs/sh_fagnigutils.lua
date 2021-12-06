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
	player:ScreenFade( SCREENFADE.OUT, Color( 0, 0, 0 ), 1, 1 ) 
	player:SetNetVar("ix_noMenuAllowed", true)
	timer.Simple(1, function() 
		player:ScreenFade( SCREENFADE.IN, Color( 0, 0, 0 ), 1, actiondur-2 ) --fade in in the last second
	end)
	timer.Simple(actiondur, function()
		player:Freeze(false)
		player:SetNetVar("ix_noMenuAllowed", false)


		if( callbackfunc ) then --Call callback function last, so if it errors, we are not permanently frozen
			callbackfunc(player)
		end
		
	end)
end

if(CLIENT) then
	hook.Add("ShouldSuppressMenu", "ix_noMenuAllowed", function(client) 
		if(client:GetNetVar("ix_noMenuAllowed")) then
			return true
		end
	end)

	net.Receive("ix_KillMenu", function()
		ix.gui.menu:Remove()
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