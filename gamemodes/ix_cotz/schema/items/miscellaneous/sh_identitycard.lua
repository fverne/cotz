ITEM.name = "Unassigned Identification Card"
ITEM.description = "A flat piece of plastic for identification."
ITEM.model = "models/lostsignalproject/items/quest/keycard.mdl"

ITEM.price = "1000"

ITEM.data = { customName = ITEM.name, customDesc = ITEM.description, isUsed = 0}

ITEM.functions.Custom = {
	name = "Assign",
	tip = "Assign card to someone",
	icon = "icon16/stalker/customize.png",
	OnRun = function(item)
		local client = item.player
		client:RequestString("Change Name", "What organization does the card belong to?", function(text)
			item:SetData("customName", text.." Identification Card")
			client:RequestString("Change Description", "Write the name and rank of the cardholder.", function(text)
				item:SetData("customDesc", "Issued to: "..text)
				
			end, item:GetDescription()) --end of desc
		end, item:GetName()) --end of name

		item:SetData("isUsed", 1)

		return false
	end,
	
	OnCanRun = function(item)
		return (!IsValid(item.entity)) and (item:GetData("isUsed") == 0)
	end
}

ITEM.functions.Show = {
	icon = "icon16/stalker/read.png",
	OnRun = function(item)
		ix.chat.Send(item.player, "iteminternal", "shows their "..item:GetData("customName", "Unknown")..", "..item:GetData("customDesc", "Unknown")..".", false)
		
		return false
	end,
	OnCanRun = function(item)
		return (!IsValid(item.entity)) and (item:GetData("customName") != nil)
	end
}

function ITEM:GetDescription()
	local desc = self.description
	
	if(self:GetData("customDesc") != nil) then
		desc = self:GetData("customDesc")
	end
	
	return Format(desc)
end

function ITEM:GetName()
	local name = self.name
	
	if(self:GetData("customName") != nil) then
		name = self:GetData("customName")
	end
	
	return Format(name)
end

function ITEM:OnInstanced(invID, x, y)
	if !self:GetData("isUsed") then
		self:SetData("isUsed", 0)
	end
end