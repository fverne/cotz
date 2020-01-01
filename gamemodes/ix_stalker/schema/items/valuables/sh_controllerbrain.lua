ITEM.name = "Controller's Brain"
ITEM.model ="models/kek1ch/item_controller_brain.mdl"
ITEM.description = "The brain of a controller."
ITEM.longdesc = "Controllers have potent mental powers and it's safe to say that these powers have their origin in their brain. What's interesting, every mutant possessing abilities related to psy waves has a brain of similar structure."
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