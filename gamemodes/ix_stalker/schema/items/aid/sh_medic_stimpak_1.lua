ITEM.name = "Experimental Medical Stimpak MkI"
ITEM.description = "A small injector, produced in the zone."
ITEM.longdesc = "An experimental syringe produced by the ecologists in the zone.\nThis is the first succesful attempt at creating a healing substance with distillations from artifacts, without major side effects. The only noteable side effect is a slight headache, and that it might leave the area where the solution is injected sore for a good while after injection."
ITEM.model = "models/lostsignalproject/items/medical/stim_pack1.mdl"

ITEM.sound = "stalkersound/inv_syringe.mp3"

ITEM.width = 1
ITEM.height = 1
ITEM.price = 800

ITEM.quantity = 1
ITEM.restore  = 40

ITEM.weight = 0.350
ITEM.flatweight = 0.125

ITEM.exRender = true
ITEM.iconCam = {
	pos = Vector(1, -0.20000000298023, 200),
	ang = Angle(90, 0, 180),
	fov = 2.2,
}

ITEM.functions.use = {
	name = "Heal",
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
		return (!IsValid(item.entity))
	end
}