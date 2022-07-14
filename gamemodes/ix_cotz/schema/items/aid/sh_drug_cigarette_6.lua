ITEM.name = "Marlboro Cigarettes (20pk)"
ITEM.description = "A pack of 'Marlboro' brand cigarettes."
ITEM.longdesc = "Marlboro was founded in 1924 by Philip Morris. Marlboro was originally marketed as a cigarette for women. In 1950 it was relaunched and targeted men as well. Today, Marlboro cigarettes are found in many different variations.\nThis classic package is seldom seen in the zone, as there isn't a huge demand for them in the zone. They're mostly imported by western europeans and americans that enter the zone looking to make it big."
ITEM.model = "models/lostsignalproject/items/consumable/cigarettes_malboro.mdl"

ITEM.sound = "stalkersound/inv_smoke.mp3"

ITEM.width = 1
ITEM.height = 1
ITEM.price = 1140

ITEM.quantity = 20
ITEM.hunger = 4
ITEM.psyheal = 4

ITEM.flatweight = 0.010
ITEM.weight = 0.001

ITEM.addictionNicotine = true

ITEM.exRender = true
ITEM.iconCam = {
	pos = Vector(0, 0, 200),
	ang = Angle(90, 0, 180),
	fov = 1.2,
}

function ITEM:PopulateTooltipIndividual(tooltip)
    ix.util.PropertyDesc(tooltip, "Drug", Color(64, 224, 208))
	ix.util.PropertyDesc(tooltip, "Contains Nicotine", Color(64, 224, 208))
	ix.util.PropertyDesc(tooltip, "Calms the Mind", Color(64, 224, 208))
end

ITEM.functions.use = {
	name = "Smoke",
	icon = "icon16/stalker/smoke.png",
	OnRun = function(item)
		local quantity = item:GetData("quantity", item.quantity)

		ix.util.PlayerPerformBlackScreenAction(item.player, "Smoking", 6, function(player) 
			local hunger = player:GetCharacter():GetData("hunger", 100)
			player:AddBuff("buff_psyheal", 15, { amount = item.psyheal/30 })
			player:SetHunger(hunger + item.hunger)
		end)
		
		quantity = quantity - 1

		if (quantity >= 1) then
			item:SetData("quantity", quantity)
			return false
		end
		
		ix.chat.Send(item.player, "iteminternal", "pulls out a "..item.name.." and smokes it.", false)

		return true
	end,
	OnCanRun = function(item)
		return (!IsValid(item.entity)) and item.invID == item:GetOwner():GetCharacter():GetInventory():GetID()
	end
}

ITEM.functions.combine = {
	OnCanRun = function(item, data)
		if !data then
			return false
		end
		
		local targetItem = ix.item.instances[data[1]]

		if targetItem.uniqueID == item.uniqueID then
			return true
		else
			return false

		end
	end,
	OnRun = function(item, data)
		local targetItem = ix.item.instances[data[1]]
		local targetQuantDiff = targetItem.quantity - targetItem:GetData("quantity", targetItem.quantity)
		local localQuant = item:GetData("quantity", item.quantity)
		local targetQuant = targetItem:GetData("quantity", targetItem.quantity)
		item.player:EmitSound("stalkersound/inv_properties.mp3", 110)
		if targetQuantDiff >= localQuant then
			targetItem:SetData("quantity", targetQuant + localQuant)
			return true
		else
			item:SetData("quantity", localQuant - targetQuantDiff)
			targetItem:SetData("quantity", targetItem.quantity)
			return false
		end
	end,
}
