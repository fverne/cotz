ITEM.name = "Asenapine Tablets"
ITEM.description = "A small blister packet."
ITEM.longdesc = "Asenapine is used by STALKERs to deaden the effects of the psychic mutants on their minds. It only works for a short while after ingesting."
ITEM.model = "models/lostsignalproject/items/medical/sleeping_pills.mdl"

ITEM.sound = "stalkersound/inv_eat_pills.mp3"

ITEM.width = 1
ITEM.height = 1
ITEM.price = 450

ITEM.quantity = 8

ITEM.weight = 0.005
ITEM.flatweight = 0.050

ITEM.exRender = true
ITEM.iconCam = {
	pos = Vector(-200, 0, 0),
	ang = Angle(0, -0, 45),
	fov = 1.5,
}

function ITEM:PopulateTooltipIndividual(tooltip)
    ix.util.PropertyDesc(tooltip, "Medical", Color(64, 224, 208))
    ix.util.PropertyDesc(tooltip, "Psy Suppressor", Color(64, 224, 208))
end

ITEM.functions.use = {
	name = "Heal",
	icon = "icon16/stalker/heal.png",
	OnRun = function(item)
		local quantity = item:GetData("quantity", item.quantity)

		item.player:AddBuff("buff_psysuppress", 180, { })
		ix.chat.Send(item.player, "iteminternal", "pops out a pill from the "..item.name.." package and swallows it.", false)

		quantity = quantity - 1

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