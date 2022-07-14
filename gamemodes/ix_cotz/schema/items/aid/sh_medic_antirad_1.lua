ITEM.name = "Anti-Radiation Drugs (Old)"
ITEM.description = "A small blister packet that features anti-radiation signs on the package."
ITEM.longdesc = "An older solution for removal of radiation from the body. These are not as effective, nor as fast acting as their modern counterparts, but they're still cheap and effective."
ITEM.model = "models/lostsignalproject/items/medical/antirad.mdl"

ITEM.sound = "stalkersound/inv_eat_pills.mp3"

ITEM.width = 1
ITEM.height = 1
ITEM.price = 850

ITEM.quantity = 2
ITEM.restore = 50

ITEM.weight = 0.010
ITEM.flatweight = 0.020

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

		item.player:AddBuff("buff_radiationremoval", 120, { amount = item.restore/240 })

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