ITEM.name = "Anomaly Research Documents (simple)"
ITEM.description = "Describes different anomalies. Only covers the most common anomalies."
ITEM.model = "models/kek1ch/notes_paper_1.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.price = "2150"
ITEM.flag = "A"
ITEM.value = ITEM.price*0.5
ITEM.weight = 0.05

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
