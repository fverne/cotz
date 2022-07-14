ITEM.name = "Cardazepine Tablets"
ITEM.description = "A small blister packet."
ITEM.longdesc = "Cardazepine is the prime choice for recovering after a bad run-in with a psychic mutant. Unlike the alternative Modafine, the side effects of Cardazepine are nowhere near as bad, and it is also more effective.\nThe only problem is that they're in short supply, as only the ecologists seem to get regular shipments of them, but even so their stock is tiny. Some packs of this drug are also smuggled in by other means, but that's a rare occurence."
ITEM.model = "models/lostsignalproject/items/medical/antiemetic.mdl"

ITEM.sound = "stalkersound/inv_eat_pills.mp3"

ITEM.width = 1
ITEM.height = 1
ITEM.price = 1520

ITEM.quantity = 2
ITEM.psyheal = 75

ITEM.weight = 0.015
ITEM.flatweight = 0.010

ITEM.exRender = true
ITEM.iconCam = {
	pos = Vector(-200, 0, 0),
	ang = Angle(0, -0, 45),
	fov = 1.5,
}

function ITEM:PopulateTooltipIndividual(tooltip)
    ix.util.PropertyDesc(tooltip, "Medical", Color(64, 224, 208))
    ix.util.PropertyDesc(tooltip, "Calms the Mind", Color(64, 224, 208))
end

ITEM.functions.use = {
	name = "Heal",
	icon = "icon16/stalker/heal.png",
	OnRun = function(item)
		local quantity = item:GetData("quantity", item.quantity)

		item.player:AddBuff("buff_psyheal", 160, { amount = item.psyheal/320 })
		--item.player:AddBuff("debuff_psypillmovement", 15, {})
		ix.chat.Send(item.player, "iteminternal", "pops out a pill from the "..item.name.." package and swallows it.", false)

		quantity = quantity - 1

		if (quantity >= 1) then
			item:SetData("quantity", quantity)
			return false
		end
		
		return true
	end,
	OnCanRun = function(item)
		return (!IsValid(item.entity)) and item.invID == item:GetOwner():GetCharacter():GetInventory():GetID()
	end
}