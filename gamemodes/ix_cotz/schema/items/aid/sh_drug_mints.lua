ITEM.name = "Altoid Mints"
ITEM.description = "A small tin of strong mints."
ITEM.longdesc = "One of these is a nice followup to a big meal.\nPopular with STALKERs to freshen up a bit."
ITEM.model = "models/lostsignalproject/items/consumable/mint.mdl"

ITEM.sound = "stalkersound/inv_eat_pills.mp3"

ITEM.width = 1
ITEM.height = 1
ITEM.price = 410

ITEM.quantity = 50
ITEM.psyheal = 2

ITEM.weight = 0.0002
ITEM.flatweight = 0.025

ITEM.exRender = true
ITEM.iconCam = {
	pos = Vector(0, 0, 200),
	ang = Angle(90, 0, 180),
	fov = 1.4,
}

ITEM.functions.use = {
	name = "Eat",
	icon = "icon16/stalker/swallow.png",
	OnRun = function(item)
		local quantity = item:GetData("quantity", item.quantity)
		
		item.player:AddBuff("buff_psyheal", 20, { amount = item.psyheal/40 })

		quantity = quantity - 1

		if (quantity >= 1) then
			item:SetData("quantity", quantity)
			return false
		end
		
		ix.chat.Send(item.player, "iteminternal", "takes out a pill from the "..item.name.." and swallows it.", false)
		
		return true
	end,
	OnCanRun = function(item)
		return (!IsValid(item.entity)) and item.invID == item:GetOwner():GetCharacter():GetInventory():GetID()
	end
}