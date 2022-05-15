ITEM.name = "Anti-Radiation Drugs (New)"
ITEM.description = "A small blister packet that features anti-radiation signs on the package."
ITEM.longdesc = "Mexaminum radiation protection drugs are common in the Zone. When used, this drug induces contraction of peripheral blood vessels and oxygen deprivation, which serve to treat and prevent radiation exposure. The drug does not have severe side effects, although isolated cases of mild nausea, dizziness, cramps and stomach pain have been reported."
ITEM.model = "models/lostsignalproject/items/medical/chlorium.mdl"

ITEM.sound = "stalkersound/inv_eat_pills.mp3"

ITEM.width = 1
ITEM.height = 1
ITEM.price = 2350

ITEM.quantity = 2
ITEM.restore = 80

ITEM.weight = 0.010
ITEM.flatweight = 0.040

ITEM.exRender = true
ITEM.iconCam = {
	pos = Vector(-200, 0, 0),
	ang = Angle(0, -0, 45),
	fov = 1.5,
}

function ITEM:PopulateTooltipIndividual(tooltip)
    ix.util.PropertyDesc(tooltip, "Medical", Color(64, 224, 208))
end

ITEM.functions.use = {
	name = "Swallow",
	icon = "icon16/stalker/swallow.png",
	OnRun = function(item)
		local quantity = item:GetData("quantity", item.quantity)

		item.player:AddBuff("buff_radiationremoval", 30, { amount = item.restore/60 })

		quantity = quantity - 1

		if (quantity >= 1) then
			item:SetData("quantity", quantity)
			return false
		end
		
		ix.chat.Send(item.player, "iteminternal", "takes out a pill from the "..item.name.." and swallows it.", false)
		
		return true
	end,
	OnCanRun = function(item)
		return (!IsValid(item.entity)) and item.invID == item:GetOwner():GetCharacter():GetInventory():GetID()
	end
}