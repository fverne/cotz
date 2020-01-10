ITEM.name = "Russian brand of cigarettes"
ITEM.description = "The pack is so worn it's hard to see the brand."
ITEM.longdesc = "The cheapest pack of cigarettes in the Zone. Russian budget brand. You can smoke these.\nThey have a soothing effect on the body, and counters radioactivity very slightly."
ITEM.model = "models/kek1ch/drink_cigar1.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.category = "Aid"
ITEM.price = "60"
ITEM.busflag = {"medical1"}
ITEM.radrem = 0.5
ITEM.quantity = 6
ITEM.sound = "stalkersound/inv_smoke.mp3"
ITEM.weight = 0.1

function ITEM:GetDescription()
	if (!self.entity or !IsValid(self.entity)) then
		local quant = self:GetData("quantity", self.quantity)
		local str = self.longdesc.."\n \nThere's only "..quant.." left."

		return str
	else
		return self.desc
	end
end

if (CLIENT) then
	function ITEM:PaintOver(item, w, h)

		draw.SimpleText(item:GetData("quantity", item.quantity).."/"..item.quantity, "DermaDefault", 3, h - 1, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM, 1, color_black)
	end
end

ITEM.functions.use = {
	name = "Smoke",
	icon = "icon16/stalker/smoke.png",
	OnRun = function(item)
		local quantity = item:GetData("quantity", item.quantity)
		item.player:AddBuff("buff_radiationremoval", 10, { amount = item.radrem })

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
		if !data[1] then
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
		local localQuant = item:GetData("quantity", item.quantity)
		local targetQuant = targetItem:GetData("quantity", targetItem.quantity)
		local combinedQuant = (localQuant + targetQuant)

		item.player:EmitSound("stalkersound/inv_properties.mp3", 110)

		if combinedQuant <= item.maxStack then
			targetItem:SetData("quantity", combinedQuant)
			return true
		elseif localQuant >= targetQuant then
			targetItem:SetData("quantity",item.maxStack)
			item:SetData("quantity",(localQuant - (item.maxStack - targetQuant)))
			return false
		else
			targetItem:SetData("quantity",(targetQuant - (item.maxStack - localQuant)))
			item:SetData("quantity",item.maxStack)
			return false
		end
	end,
}