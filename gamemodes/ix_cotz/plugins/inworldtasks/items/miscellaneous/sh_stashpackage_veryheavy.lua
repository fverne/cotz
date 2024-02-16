ITEM.name = "Very Heavy Package"
ITEM.description = "A small package."
ITEM.model = "models/lostsignalproject/items/repair/repair_helmet_repair.mdl"
ITEM.price = 0
ITEM.flag = "A"

ITEM.width = 3
ITEM.height = 3

ITEM.noDrop = true
ITEM.flatweight = 15.000

ITEM.exRender = true
ITEM.iconCam = {
	pos = Vector(611.17, 373.32, 161.74),
	ang = Angle(12.44, 211.4, 0),
	fov = 1.27
}


--disabled for testing
--ITEM.functions.drop.OnCanRun = function(item)
--	return !IsValid(item.entity) and item:GetData("finished",false)
--end

ITEM.functions.use = {
	name = "Stash",
	icon = "icon16/stalker/repair.png",
	OnRun = function(item)

		local stashdata = item:GetData("stashdata", {})

		local ppos = item.player:GetPos()
		if ppos:DistToSqr(stashdata[2]) > 128*128 then
			item.player:Notify("This is not the place to stash the package.")
			return false
		end

		ix.chat.Send(item.player, "iteminternal", "begins hiding something.", false)

		ix.util.PlayerPerformBlackScreenAction(item.player, "Stashing", 5, function(player) 
			hook.Run("ix_JobTrigger", player, item:GetData("finishedtrigger", "error"))

			item:SetData("points", tmptbl)
		end)
		
		return true
	end,
	OnCanRun = function(item)
		return (!IsValid(item.entity)) and (!item:GetData("finished")) and item.invID == item.player:GetCharacter():GetInventory():GetID() and item:GetData("map", "") == game.GetMap()
	end
}

ITEM.functions.zCheck = {
	name = "Check stash location",
	icon = "icon16/stalker/repair.png",
	OnRun = function(item)
		if (item:GetData("map", "") == game.GetMap()) then
			ix.chat.Send(item.player, "iteminternal", "checks his PDA notes.", false)
		
			local stashdata = item:GetData("stashdata", {})
			netstream.Start(item.player, "ix_ShowTaskPositions", {stashdata[2]}, "vgui/icons/stash.png")
		else
			item.player:Notify("This isn't the right area for this task")
		end

		return false
	end,
	OnCanRun = function(item)
		return (!IsValid(item.entity)) and (!item:GetData("finished")) and item.invID == item.player:GetCharacter():GetInventory():GetID()
	end
}


ITEM.functions.zzDestroy = {
	name = "Destroy Item",
	icon = "icon16/stalker/drop.png",
	OnRun = function(item)
		return true
	end,
	OnCanRun = function(item)
		return (!IsValid(item.entity)) and item.invID == item.player:GetCharacter():GetInventory():GetID()
	end
}


function ITEM:GetDescription()
	if(self.entity) then return self.description end

	local desc = self.description.."\n\n"
	desc = desc.."Area to stash in:\n"

	local stashdata = self:GetData("stashdata",{})
	local stashstring = stashdata[1]
	stashstring = string.SetChar(stashstring, 1, string.upper(stashstring[1]))

	desc = desc..stashstring.."\n"

	local c = ix.util.GetLongLatFromVector(stashdata[2])
	desc = desc.."  "..math.Round(c[1],4).." Latitude, "..math.Round(c[2],4).." Longtitude\n"

	return Format(desc)
end

function ITEM:OnInstanced(invID, x, y)
	if (!self:GetData("stashdata")) then
		local stashdata = ix.util.GetRandomStashTaskData()

		self:SetData("stashdata", stashdata)
	end
end