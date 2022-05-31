ITEM.name = "Caffeine Tablets"
ITEM.description = "A small box of caffeine tablets."
ITEM.longdesc = "Caffeine is a drug which acts as a stimulant upon the central nervous system. It’s found naturally in plants, such as coffee beans, tea leaves, and kola nuts. Caffeine pills are supplements made from caffeine. Some caffeine pills contain natural caffeine, extracted during the brewing process. These pills contain synthetic, also known as artificial, caffeine. Used by STALKERs to keep their wits about them over long stretches of time."
ITEM.model = "models/lostsignalproject/items/medical/caffeine.mdl"

ITEM.sound = "stalkersound/inv_eat_pills.mp3"

ITEM.width = 1
ITEM.height = 1
ITEM.price = 760

ITEM.quantity = 4

ITEM.flatweight = 0.030
ITEM.weight = 0.015

ITEM.exRender = true
ITEM.iconCam = {
	pos = Vector(0, 0, 200),
	ang = Angle(90, 0, 45),
	fov = 1.7,
}

ITEM.functions.use = {
	name = "Swallow",
	icon = "icon16/stalker/heal.png",
	OnRun = function(item)
		local quantity = item:GetData("quantity", item.quantity)
		item.player:AddBuff("buff_staminarestore", 100, { amount = 2 })

		ix.chat.Send(item.player, "iteminternal", "swallows one of the "..item.name..".", false)

		quantity = quantity - 1

		item.player:GetCharacter():SatisfyAddictions("PrescriptionDrugs")

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
