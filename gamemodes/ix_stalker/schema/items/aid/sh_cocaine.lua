ITEM.name = "Cocaine"
ITEM.description = "Imported cocaine."
ITEM.longdesc = "Small aluminium case containing cocaine and the tools facilitating use. Cocaine is a powerful nervous system stimulant. Cocaine increases alertness, induces feelings of well-being, competence and sexuality. Anxiety, paranoia and restlessness are common side effects. With excessive dosage, tremors, convulsions and increased body temperature are observed. Bandits are known for sniffing this drug right before launching an assault or ambush."
ITEM.model = "models/kek1ch/drink_cocaine.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.category = "Aid"
ITEM.price = "750"
ITEM.busflag = {"medical1_1_1_1"}
ITEM.quantity = 3
ITEM.sound = "stalkersound/inv_sniff_2.mp3"
ITEM.weight = 0.05

function ITEM:GetDescription()
	if (!self.entity or !IsValid(self.entity)) then
		local quant = self:GetData("quantity", self.quantity)
		local str = self.longdesc.."\n \nThere's only "..quant.." uses left."

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
	name = "Snort",
	icon = "icon16/stalker/heal.png",
	OnRun = function(item)
		local quantity = item:GetData("quantity", item.quantity)
		item.player:AddBuff("buff_staminarestore", 150, { amount = 5 })

		quantity = quantity - 1

		if (quantity >= 1) then
			item:SetData("quantity", quantity)
			return false
		end
		
		ix.chat.Send(item.player, "iteminternal", "snorts some "..item.name..".", false)

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