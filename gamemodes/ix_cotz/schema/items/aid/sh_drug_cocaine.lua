ITEM.name = "Cocaine"
ITEM.description = "Imported cocaine."
ITEM.longdesc = "Small aluminium case containing cocaine and the tools facilitating use. Cocaine is a powerful nervous system stimulant. Cocaine increases alertness, induces feelings of well-being, competence and sexuality. Anxiety, paranoia and restlessness are common side effects. With excessive dosage, tremors, convulsions and increased body temperature are observed. Bandits are known for sniffing this drug right before launching an assault or ambush."
ITEM.model = "models/lostsignalproject/items/medical/cocaine.mdl"

ITEM.sound = "stalkersound/inv_sniff_2.mp3"

ITEM.width = 1
ITEM.height = 1
ITEM.price = 3000

ITEM.quantity = 3

ITEM.flatweight = 0.050
ITEM.weight = 0.0005

ITEM.exRender = true
ITEM.iconCam = {
	pos = Vector(0, 0, 200),
	ang = Angle(90, 0, 45),
	fov = 1.4,
}

function ITEM:PopulateTooltipIndividual(tooltip)
    ix.util.PropertyDesc(tooltip, "Drug", Color(64, 224, 208))
end

ITEM.functions.use = {
	name = "Snort",
	icon = "icon16/stalker/heal.png",
	OnRun = function(item)
		local quantity = item:GetData("quantity", item.quantity)
		item.player:AddBuff("buff_staminarestore", 80, { amount = 4 })

		item.player:GetCharacter():SatisfyAddictions("StrongerDrugs")

		quantity = quantity - 1

		if (quantity >= 1) then
			item:SetData("quantity", quantity)
			return false
		end
		
		ix.chat.Send(item.player, "iteminternal", "snorts some "..item.name..".", false)

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