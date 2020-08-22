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

if (CLIENT) then
	function ITEM:PopulateTooltip(tooltip)
		if (!self.entity) then
			ix.util.PropertyDesc(tooltip, "Everyday Item", Color(200, 200, 200))
			ix.util.PropertyDesc(tooltip, "Calms the Mind", Color(0, 255, 255))
			ix.util.PropertyDesc(tooltip, "Unhealthy", Color(255, 0, 0))
		end
	end
end

ITEM.functions.use = {
	name = "Smoke",
	icon = "icon16/stalker/smoke.png",
	OnRun = function(item)
		local quantity = item:GetData("quantity", item.quantity)

		local hunger = item.player:GetCharacter():GetData("hunger", 100)
		item.player:SetHunger(hunger + item.hunger)

		--item.player:AddBuff("buff_psyheal", 30, { amount = self.psyheal/60 })

		quantity = quantity - 1

		if (quantity >= 1) then
			item:SetData("quantity", quantity)
			return false
		end
		
		ix.chat.Send(item.player, "iteminternal", "lights his "..item.name.." and inhales deeply.", false)

		return true
	end,
	OnCanRun = function(item)
		return (!IsValid(item.entity))
	end
}

ITEM.functions.combine = {
	OnCanRun = function(item, data)
		if !data then
			return false
		end
		
		local targetItem = ix.item.instances[data[1]]

		if targetItem.uniqueid == item.uniqueid then
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