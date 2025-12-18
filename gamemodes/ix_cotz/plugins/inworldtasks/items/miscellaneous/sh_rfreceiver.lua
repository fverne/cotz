ITEM.name = "RF Receiver"
ITEM.description = "A device for detecting radio frequencies. Often used to find emitters of various nature. Has special use in the zone, as radioactive frequencies often take anomalous form."
ITEM.model = "models/lostsignalproject/items/devices/receiver2.mdl"
ITEM.price = 0
ITEM.flag = "A"

ITEM.width = 1
ITEM.height = 2

ITEM.noDrop = true
ITEM.flatweight = 0.100

ITEM.exRender = true
ITEM.iconCam = {
	pos = Vector(-14.04, 0.03, 162.5),
	ang = Angle(94.28, 179.87, 0),
	fov = 2
}

--disabled for testing
--ITEM.functions.drop.OnCanRun = function(item)
--	return !IsValid(item.entity) and item:GetData("finished",false)
--end

ITEM.functions.use = {
	name = "Take Measurement",
	icon = "icon16/stalker/repair.png",
	OnRun = function(item)
		ix.chat.Send(item.player, "iteminternal", "holds out their RF receiver, taking some measurements.", false)

		ix.util.PlayerPerformBlackScreenAction(item.player, "Taking Measurements", 5, function(player) 
			local ppos = player:GetPos()

			local pointtbl = item:GetData("points", {})
			local tmptbl = {}

			for k,v in pairs(pointtbl) do
				if ppos:DistToSqr(v) > 512*512 then
					table.insert(tmptbl, v)
				end
			end

			if(table.IsEmpty(tmptbl)) then
				hook.Run("ix_JobTrigger", player, item:GetData("finishedtrigger", "error"))
				item:SetData("finished", true)
			end

			item:SetData("points", tmptbl)
		end)
		
		return false
	end,
	OnCanRun = function(item)
		return (!IsValid(item.entity)) and (!item:GetData("finished")) and item.invID == item.player:GetCharacter():GetInventory():GetID() and item:GetData("map", "") == game.GetMap()
	end
}

ITEM.functions.zCheck = {
	name = "Check Assigned Points",
	icon = "icon16/stalker/repair.png",
	OnRun = function(item)
		if (item:GetData("map", "") == game.GetMap()) then
			ix.chat.Send(item.player, "iteminternal", "looks at their RF receiver.", false)
		
			local pointtbl = item:GetData("points", {})
			netstream.Start(item.player, "ix_ShowTaskPositions", item:GetData("points", {}), "vgui/icons/quest2.png")
		else
			item.player:Notify("This isn't the right area for this task. Location: " .. item:GetData("map", ""))
		end

		return false
	end,
	OnCanRun = function(item)
		return (!IsValid(item.entity)) and (!item:GetData("finished")) and item.invID == item.player:GetCharacter():GetInventory():GetID()
	end
}


-- ITEM.functions.zzDestroy = {
-- 	name = "Destroy Item",
-- 	icon = "icon16/stalker/drop.png",
-- 	OnRun = function(item)
-- 		return true
-- 	end,
-- 	OnCanRun = function(item)
-- 		return (!IsValid(item.entity)) and item.invID == item.player:GetCharacter():GetInventory():GetID()
-- 	end
-- }


function ITEM:GetDescription()
	if(self.entity) then return self.description end

	local desc = self.description.."\n\n"
	
	desc = desc.."Points needing measurement:\n"
	for k,v in pairs(self:GetData("points",{})) do
		local c = ix.util.GetLongLatFromVector(v)

		desc = desc.."  "..math.Round(c[1],4).." Latitude, "..math.Round(c[2],4).." Longtitude\n"
	end

	return Format(desc)
end

function ITEM:OnInstanced(invID, x, y)
	if (!self:GetData("points")) then
		local tmptbl = {}

		for i = 1, self:GetData("npoints", 3) do
			table.insert(tmptbl,ix.util.GetRandomRFPoint(self:GetData("map")))
		end

		self:SetData("points", tmptbl)
	end
end