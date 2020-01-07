ITEM.name = "Pseudogiant Skin"
ITEM.model ="models/kek1ch/hide_burer.mdl"
ITEM.description = "The skin of a pseudogiant. Looks rigid."
ITEM.longdesc = "The skin of a pseudogiant in many ways resembles the skin of an elephant. It's thick and hard in touch, its texture is very irregular and full of folds which act as the creature's cooling mechanism. The average thickness of pseudogiant's skin is around 2 cm, which makes it very durable and capable of withstanding significant damage. This is, however, at the cost of increased weight."
ITEM.width = 1
ITEM.height = 1
ITEM.price = 10000
ITEM.flag = "A"
ITEM.value = ITEM.price*1*1
ITEM.weight = 0.25

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