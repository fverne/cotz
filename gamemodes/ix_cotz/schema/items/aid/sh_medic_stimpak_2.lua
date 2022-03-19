ITEM.name = "Experimental Medical Stimpak MkII"
ITEM.description = "A small injector, produced in the zone."
ITEM.longdesc = "The second iteration of the ecologists stimpak project.\nAfter refining the formula, ecologists have managed to make the healing effect much stronger, however it is slightly more troublesome to produce, leading to a higher price."
ITEM.model = "models/lostsignalproject/items/medical/stim_pack2.mdl"

ITEM.sound = "stalkersound/inv_syringe.mp3"

ITEM.width = 1
ITEM.height = 1
ITEM.price = 1200

ITEM.quantity = 1
ITEM.restore  = 70

ITEM.weight = 0.350
ITEM.flatweight = 0.125

ITEM.exRender = true
ITEM.iconCam = {
	pos = Vector(1, -0.20000000298023, 200),
	ang = Angle(90, 0, 180),
	fov = 2.2,
}

function ITEM:PopulateTooltipIndividual(tooltip)
    ix.util.PropertyDesc(tooltip, "Medical", Color(64, 224, 208))
end

ITEM.functions.use = {
	name = "Inject",
	icon = "icon16/stalker/heal.png",
	OnRun = function(item)
		local quantity = item:GetData("quantity", item.quantity)

		item.player:AddBuff("buff_rapidheal", 2, { amount = item.restore/4 })
		item.player:SetLocalVar("stm", math.min(item.player:GetLocalVar("stm", 100) + item.restore, 100))
		ix.chat.Send(item.player, "iteminternal", "jabs the "..item.name.." in his leg and injects the payload.", false)

		quantity = quantity - 1

		if (quantity >= 1) then
			item:SetData("quantity", quantity)
			return false
		end
		
		return true
	end,
	OnCanRun = function(item)
		return (!IsValid(item.entity)) and item.invID == item.player:GetCharacter():GetInventory():GetID()
	end
}