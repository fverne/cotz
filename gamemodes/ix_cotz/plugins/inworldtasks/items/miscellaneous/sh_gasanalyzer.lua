ITEM.name = "Gas Analyzer"
ITEM.description = "A small device for measuring fluctuations in pressure, as well as gaseous impurities. The internal memory can store a couple of GPS-positions, letting the research team know where to go."
ITEM.model = "models/illusion/eftcontainers/gasanalyser.mdl"
ITEM.price = 0
ITEM.flag = "A"

ITEM.width = 1
ITEM.height = 2

ITEM.noDrop = true
ITEM.weight = 0.100

ITEM.exRender = true
ITEM.iconCam = {
	pos = Vector(-2.5, 0, 7.5),
	ang = Angle(90, 180, 0),
	fov = 64,
}

--disabled for testing
--ITEM.functions.drop.OnCanRun = function(item)
--	return !IsValid(item.entity) and item:GetData("finished",false)
--end

ITEM.functions.use = {
	name = "Take Measurement",
	icon = "icon16/stalker/repair.png",
	OnRun = function(item)
		ix.chat.Send(item.player, "iteminternal", "holds out their gas analyzer, taking some measurements.", false)

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
		return (!IsValid(item.entity)) and (!item:GetData("finished")) and item.invID == item:GetOwner():GetCharacter():GetInventory():GetID()
	end
}

ITEM.functions.zCheck = {
	name = "Check Assigned Points",
	icon = "icon16/stalker/repair.png",
	OnRun = function(item)
		ix.chat.Send(item.player, "iteminternal", "looks at their gas analyzer.", false)
		
		local pointtbl = item:GetData("points", {})
		netstream.Start(item.player, "ix_ShowTaskPositions", item:GetData("points", {}))

		return false
	end,
	OnCanRun = function(item)
		return (!IsValid(item.entity)) and (!item:GetData("finished")) and item.invID == item:GetOwner():GetCharacter():GetInventory():GetID()
	end
}

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
			table.insert(tmptbl,ix.util.GetRandomTaskPoint())
		end

		self:SetData("points", tmptbl)
	end
end