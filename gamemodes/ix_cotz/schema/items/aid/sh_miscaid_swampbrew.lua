ITEM.name = "Swamp Doctor's Brew"
ITEM.description = "A cup of strange liquid."
ITEM.longdesc = "A hearty cup of some thick almost souplike liquid.\nThe taste is awful, but the positive effects of it cannot be understated. It'll clear your mind, heal your wounds, cleanse your body of the effects of radiation and energize your muscles."
ITEM.model = "models/lostsignalproject/items/medical/drink_crow.mdl"

ITEM.sound = "stalkersound/inv_drink_flask_effect.mp3"

ITEM.width = 1
ITEM.height = 1
ITEM.price = 1800

ITEM.quantity = 1
ITEM.restore  = 450
ITEM.psyheal = 300
ITEM.radrem   = 300

ITEM.weight = 0.125
ITEM.flatweight = 0.450

function ITEM:PopulateTooltipIndividual(tooltip)
    ix.util.PropertyDesc(tooltip, "Medical", Color(64, 224, 208))
    ix.util.PropertyDesc(tooltip, "Calms the Mind", Color(64, 224, 208))
end

ITEM.functions.use = {
	name = "Drink",
	icon = "icon16/stalker/heal.png",
	OnRun = function(item)
		local quantity = item:GetData("quantity", item.quantity)

		item.player:AddBuff("buff_staminarestore", 300, { amount = 1 })
		item.player:AddBuff("buff_psyheal", 300, { amount = item.psyheal/600 })
		item.player:AddBuff("buff_slowheal", 300, { amount = item.restore/300 })
		item.player:AddBuff("buff_radiationremoval", 300, { amount = item.radrem/600 })

		ix.chat.Send(item.player, "iteminternal", "downs the "..item.name..".", false)

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