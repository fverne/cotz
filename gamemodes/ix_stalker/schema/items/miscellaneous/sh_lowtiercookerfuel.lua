ITEM.name = "Charcoal"
ITEM.description = "Low tier cooking fuel."
ITEM.longdesc = "No longer description available."
ITEM.model = "models/lostsignalproject/items/misc/charcoal.mdl"
ITEM.width = 2
ITEM.height = 2
ITEM.fueltier = 1
ITEM.quantity = 3
ITEM.splitSize = {1, 2}
ITEM.quantdesc = "This bag has enough charcoal for another %d refills."

if (CLIENT) then
	function ITEM:PaintOver(item, w, h)
		draw.SimpleText(
			item:GetData("quantity", item.quantity).."/"..item.quantity, "stalkerregularinvfont", 3, h - 1, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM, 1, color_black
		)
	end
end

ITEM.functions.combine = {
	OnCanRun = function(item, data)
		if !data or !data[1] then
			return false
		end

		local targetItem = ix.item.instances[data[1]]
		return (targetItem.uniqueID == item.uniqueID or targetItem.cookertier and targetItem.cookertier >= item.fueltier)

	end,
	OnRun = function(item, data)
		local targetItem = ix.item.instances[data[1]]
		if( targetItem.uniqueID == item.uniqueID ) then
			local targetAmmoDiff = targetItem.quantity - targetItem:GetData("quantity", targetItem.quantity)
			local localQuant = item:GetData("quantity", item.quantity)
			local targetQuant = targetItem:GetData("quantity", targetItem.quantity)
			item.player:EmitSound("stalkersound/inv_properties.mp3", 110)

			if targetAmmoDiff >= localQuant then
				targetItem:SetData("quantity", targetQuant + localQuant)
				return true
			else
				item:SetData("quantity", localQuant - targetAmmoDiff)
				targetItem:SetData("quantity", targetItem.quantity)
				return false
			end
		elseif ( targetItem.cookertier and targetItem.cookertier >= item.fueltier and !targetItem:GetData("cancook", false) ) then
			item:SetData("quantity", item:GetData("quantity", item.quantity) - 1)
			targetItem:SetData("cancook", true)

			return (item:GetData("quantity", item.quantity) == 0)
		end

		return false
	end,
}

ITEM.functions.split = {
    name = "Split",
    tip = "useTip",
    icon = "icon16/stalker/split.png",
    isMulti = true,
    multiOptions = function(item, client)
		local targets = {}
        local quantity = item:GetData("quantity", item.quantity)
		
        for i=1,#item.splitSize-1 do
			if quantity > item.splitSize[i] then
				table.insert(targets, {
					name = item.splitSize[i],
					data = {item.splitSize[i]},
				})
			end
		end
        return targets
	end,
	OnCanRun = function(item)
		if item:GetData("quantity", item.quantity) == 1 then
			return false
		end			
		
		return (!IsValid(item.entity))
	end,
    OnRun = function(item, data)
		if data[1] then
			local quantity = item:GetData("quantity", item.quantity)
			local client = item.player
			
			client:GetCharacter():GetInventory():Add(item.uniqueID, 1, {["quantity"] = data[1]})
			
			quantity = quantity - data[1]

			item.player:EmitSound("stalkersound/inv_properties.mp3", 110)
			
			item:SetData("quantity", quantity)
			
		end
		return false
	end,
}