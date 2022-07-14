ITEM.name = "'Petr 1.' Cigarettes (10pk)"
ITEM.description = "A pack of 'Petr 1.' brand cigarettes."
ITEM.longdesc = "'Petr 1.' (Пётр I) brand cigarettes are produced by Japan Tobacco International and sold regionally in Russia. The name refers to Peter the Great, the Tsar who made Russia a major European power in the eighteenth century. The dark packaging and use of the Russian imperial coat of arms, with the words 'The Great Russia', evokes a bygone era of a powerful empire. This suggests the design of the packet is intended to appeal to male smokers of all ages, especially those attracted to nationalist sentiments. The cigarettes are manufactured by JTI in St. Petersburg, Peter the Great's northern capital.\nIt is popular with STALKERs due to its good taste and decent nicotine content, not to mention the affordable price. "
ITEM.model = "models/lostsignalproject/items/consumable/cigarettes_russian.mdl"

ITEM.sound = "stalkersound/inv_smoke.mp3"

ITEM.width = 1
ITEM.height = 1
ITEM.price = 350

ITEM.quantity = 10
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
