ITEM.name = "Tool"
ITEM.width = 1
ITEM.height = 1
ITEM.description = "Technician stuff."
ITEM.longdesc = "Longer description here."
ITEM.price = 1

ITEM.functions.Sell = {
	name = "Sell",
	icon = "icon16/stalker/sell.png",
	sound = "physics/metal/chain_impact_soft2.wav",
	OnRun = function(item)
		local client = item.player
		client:Notify( "Sold for "..(item.price/2).." rubles." )
		client:GetCharacter():GiveMoney(item.price/2)
		
	end,
	OnCanRun = function(item)
		if item.price ~= 1 then
			return !IsValid(item.entity) and item:GetOwner():GetCharacter():HasFlags("1")
		else
			return false
		end
	end
}

ITEM.functions.Value = {
	name = "Value",
	icon = "icon16/help.png",
	sound = "physics/metal/chain_impact_soft2.wav",
	OnRun = function(item)
		local client = item.player
		client:Notify( "Item is sellable for "..(item.price/2).." rubles." )
		return false
	end,
	OnCanRun = function(item)
		if item.price ~= 1 then
			return !IsValid(item.entity) and item:GetOwner():GetCharacter():HasFlags("1")
		else
			return false
		end
	end
}