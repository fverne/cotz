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
	player:SetNetVar("IsPoaching",true)
	timer.Simple(1, function()
	    if player:GetNetVar("IsPoaching") then
		    player:ScreenFade( SCREENFADE.IN, Color( 0, 0, 0 ), 0.5, 0.5 ) --fade in in the last second
	    end
	end)

	timer.Simple(actiondur, function()
		player:Freeze(false)
		player:SetNetVar("ix_noMenuAllowed", false)


		if( callbackfunc && player:GetNetVar("IsPoaching")) then --Call callback function last, so if it errors, we are not permanently frozen
			callbackfunc(player)
			player:SetNetVar("IsPoaching",false)
		end
		
	end)

end

function ix.util.PlayerActionInterrupt(player)
	-- just for poaching for now
	
	if (player:GetNetVar("IsPoaching)) then
		    player:SetAction("Action Cancelled", 1)
		    player:Freeze(false)
		    player:SetNetVar("ix_noMenuAllowed", false)
		    player:ScreenFade( SCREENFADE.IN, Color( 0, 0, 0 ), 0.2,0 )
		    player:SetNetVar("IsPoaching",false)
	end
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
