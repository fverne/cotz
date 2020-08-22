ITEM.name = "Lucky Strike Cigarettes (10pk)"
ITEM.description = "A pack of 'Lucky Strike' brand cigarettes."
ITEM.longdesc = "Lucky Strike is rich in heritage and one of the world’s best-known brands. It was introduced in 1871 as a cut-plug chewing tobacco by the R. A. Patterson Tobacco Company of Richmond, Virginia, U.S.A.. Patterson Tobacco was acquired by the American Tobacco Company in 1905, which introduced Lucky Strike as a regular-sized (70 mm), non-filtered, American blend cigarette in 1916 in an attempt to compete with the success of R. J. Reynolds’ Camel brand. Lucky Strike Reds constitute a grade A American tobacco product that is well sought-after worldwide. The simplicity to its commercial package belies the rich taste when you light up. Known for its unique gourmet flavor, Lucky Strike Red commands a presence all on its own with a distinguished aroma.\nSeeing such a packet in the zone is pretty rare, as these are usually only imported trough overseas mercenaries, and even then it's in tiny numbers."
ITEM.model = "models/lostsignalproject/items/consumable/cigarettes_lucky.mdl"

ITEM.sound = "stalkersound/inv_smoke.mp3"

ITEM.width = 1
ITEM.height = 1
ITEM.price = 630

ITEM.quantity = 10
ITEM.hunger = 5
ITEM.psyheal = 5

ITEM.flatweight = 0.010
ITEM.weight = 0.001

if (CLIENT) then
	function ITEM:PopulateTooltip(tooltip)
		if (!self.entity) then
			ix.util.PropertyDesc(tooltip, "Everyday Item", Color(200, 200, 200))
			ix.util.PropertyDesc(tooltip, "Calms the Mind Very Slightly", Color(0, 255, 255))
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

		--item.player:AddBuff("buff_psyheal", 15, { amount = self.psyheal/30 })

		quantity = quantity - 1

		if (quantity >= 1) then
			item:SetData("quantity", quantity)
			return false
		end
		
		ix.chat.Send(item.player, "iteminternal", "pulls out a "..item.name.." and smokes it.", false)

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