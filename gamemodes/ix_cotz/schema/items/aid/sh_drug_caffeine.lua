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
	icon = "icon16/stalker_grey/heal.png",
	OnRun = function(item)
		local quantity = item:GetData("quantity", item.quantity)
		item.player:AddBuff("buff_staminarestore", 100, { amount = 2 })
		item.player:AddBuff("buff_sprintboost", 20, { multiplier = 1.1 })

		ix.chat.Send(item.player, "iteminternal", "swallows one of the "..item.name..".", false)

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

ITEM.functions.combine = {
	OnCanRun = function(item, data)
		return item:GetStackCombineTarget(data) ~= nil
	end,
	OnRun = function(item, data)
		return item:CombineStack(item:GetStackCombineTarget(data))
	end,
}

function ITEM:GetPropertyEffects()
	return {
		{buff = "buff_staminarestore", duration = 100, amount = 2},
		{buff = "buff_sprintboost", duration = 20, multiplier = 1.1},
	}
end
