ITEM.name = "Controller's hand"
ITEM.model ="models/lostsignalproject/items/parts/controler_hand.mdl"
ITEM.description = "The hand of a dead controller."
ITEM.longdesc = "The controller seems to use its hand when mentally attacking its prey. The scientists will gladly examine it in the hope of finding the source of mutation responsible for its psy-related powers. Smells like old socks and bad kimchee."
ITEM.width = 1
ITEM.height = 1
ITEM.price = 5000
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