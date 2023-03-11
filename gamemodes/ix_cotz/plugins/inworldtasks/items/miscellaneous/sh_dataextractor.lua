ITEM.name = "Data Extracting Flash Drive"
ITEM.description = "A small flash drive made with the explicit purpose of extracting certain info from a PC. Just insert ."
ITEM.model = "models/lostsignalproject/items/quest/usb1.mdl"
ITEM.price = 0
ITEM.flag = "A"

ITEM.width = 1
ITEM.height = 1

ITEM.noDrop = true
ITEM.weight = 0.100

ITEM.exRender = true
ITEM.iconCam = {
	pos = Vector(0.40000000596046, 0, 50),
	ang = Angle(90, 45, 0),
	fov = 5,
}

--disabled for testing
--ITEM.functions.drop.OnCanRun = function(item)
--	return !IsValid(item.entity) and item:GetData("finished",false)
--end

ITEM.functions.use = {
	name = "Insert Flash Drive",
	icon = "icon16/stalker/repair.png",
	OnRun = function(item)
		local trace = item.player:GetEyeTraceNoCursor()
		local ent = trace.Entity

		if (ent and ent:IsValid() and ent:GetClass() == "ix_dataextractpc" and ent:GetPos():DistToSqr(item.player:GetPos()) < 512*512) then
			ix.chat.Send(item.player, "iteminternal", "inserts the flash drive into the computer.", false)

			ix.util.PlayerPerformBlackScreenAction(item.player, "Inserting flash drive", 15, function(player) 

				local typestbl = item:GetData("types", {})
				local tmptbl = {}

				for k,v in pairs(typestbl) do
					if ent:GetPCColor() != v then
						table.insert(tmptbl, v)
					end
				end

				if(table.IsEmpty(tmptbl)) then
					hook.Run("ix_JobTrigger", player, item:GetData("finishedtrigger", "error"))
					item:SetData("finished", true)
				end

				item:SetData("types", tmptbl)
			end)
		end
		
		return false
	end,
	OnCanRun = function(item)
		return (!IsValid(item.entity)) and (!item:GetData("finished")) and item.invID == item.player:GetCharacter():GetInventory():GetID()
	end
}

function ITEM:GetDescription()
	if(self.entity) then return self.description end

	local desc = self.description.."\n\n"
	
	desc = desc.."PC types remaining to scan:\n"
	for k,v in pairs(self:GetData("types",{})) do
		desc = desc.."  "..v.." colored PC\n"
	end

	return Format(desc)
end

function ITEM:OnInstanced(invID, x, y)
	if (!self:GetData("types")) then
		self:SetData("types", ix.util.GetDataSearchColors(self:GetData("ntypes",3)))
	end
end