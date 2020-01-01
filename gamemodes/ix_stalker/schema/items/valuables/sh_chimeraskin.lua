ITEM.name = "Chimera Skin"
ITEM.model ="models/kek1ch/hide_chimera.mdl"
ITEM.description = "The skin of a chimera. Looks sturdy."
ITEM.longdesc = "All parts that can be taken from chimera's corpse can be sold for a large amount of money, but it is the skin that is one of the most valued scientific specimens as well as one of the best armor enhancements available in the Exclusion Zone. It offers very good protection properties and, even more importantly, is relatively light-weight thanks to which it does not limit mobility. However, its most unique feature is that organic fibers found in the skin act as very effective electrical conductors."
ITEM.width = 1
ITEM.height = 1
ITEM.price = 20000
ITEM.flag = "A"
ITEM.value = ITEM.price*1*1

ITEM.functions.Sell = {
	icon = "icon16/stalker/sell.png",
	sound = "physics/metal/chain_impact_soft2.wav",
	OnRun = function(item)
		local client = item.player
		client:Notify( "Sold for "..(item.value).." rubles." )
		client:GetCharacter():GiveMoney(item.value)
		
	end,
	OnCanRun = function(item)
		return !IsValid(item.entity) and item:GetOwner():GetCharacter():HasFlags("1")
	end
}

ITEM.functions.Value = {
	icon = "icon16/help.png",
	sound = "physics/metal/chain_impact_soft2.wav",
	OnRun = function(item)
		local client = item.player
		client:Notify( "Item is sellable for "..(item.value).." rubles." )
		return false
	end,
	OnCanRun = function(item)
		return !IsValid(item.entity) and item:GetOwner():GetCharacter():HasFlags("1")
	end
}