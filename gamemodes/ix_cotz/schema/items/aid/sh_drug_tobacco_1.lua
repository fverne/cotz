ITEM.name = "Golden Virginia Tobacco"
ITEM.description = "A packet of Golden Virgina tobacco."
ITEM.longdesc = "A small soft packet of tobacco, with some cigarette paper packed into the fold.\nGolden Virginia is manufactured in Nottingham, England by Imperial Tobacco and sold throughout Europe. It is a blend of fine-cut Virginia, burley and oriental tobaccos.\nRolling your own cigarettes is fairly common in the zone, and as such a lot of this tobacco is imported."
ITEM.model = "models/lostsignalproject/items/consumable/hand_rolling_tobacco.mdl"

ITEM.sound = "stalkersound/inv_smoke.mp3"

ITEM.width = 2
ITEM.height = 1
ITEM.price = 1750

ITEM.quantity = 10
ITEM.hunger = 7
ITEM.psyheal = 7

ITEM.flatweight = 0.001
ITEM.weight = 0.002

ITEM.addictionNicotine = true

ITEM.exRender = true
ITEM.iconCam = {
	pos = Vector(0, 0, 200),
	ang = Angle(90, 0, 180),
	fov = 2.4,
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

		ix.util.PlayerPerformBlackScreenAction(item.player, "Rolling and Smoking", 10, function(player) 
			local hunger = player:GetCharacter():GetData("hunger", 100)
			player:SetHunger(hunger + item.hunger)
			player:AddBuff("buff_psyheal", 30, { amount = item.psyheal/60 })
		end)

		quantity = quantity - 1

		if (quantity >= 1) then
			item:SetData("quantity", quantity)
			return false
		end
		
		ix.chat.Send(item.player, "iteminternal", "lights his "..item.name.." and inhales deeply.", false)

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
