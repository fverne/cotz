ITEM.name = "Glucose Syringe"
ITEM.description = "A small plastic syringe."
ITEM.longdesc = "A single-use syringe with a glucose solution inside.\nInvented in 1922, injectable glucose is used in the treatment of diabetes mellitus. In the Zone, it has found new use.\nCarried by stalkers to give a quick energy boost and to stave off hunger.\nCan cause dizziness, headaches, and high thirst."
ITEM.model = "models/lostsignalproject/items/medical/glucose.mdl"

ITEM.sound = "stalkersound/inv_syringe.mp3"

ITEM.width = 1
ITEM.height = 1
ITEM.price = 2000

ITEM.quantity = 1

ITEM.weight = 0.035
ITEM.flatweight = 0.010

ITEM.exRender = true
ITEM.iconCam = {
	pos = Vector(-200, 0, 0),
	ang = Angle(0, -0, 45),
	fov = 2,
}

function ITEM:PopulateTooltipIndividual(tooltip)
    ix.util.PropertyDesc(tooltip, "Drug", Color(64, 224, 208))
	ix.util.PropertyDesc(tooltip, "Unhealthy", Color(255, 0, 0))
end

ITEM.functions.use = {
	name = "Inject",
	icon = "icon16/stalker/swallow.png",
	OnRun = function(item)
		local quantity = item:GetData("quantity", item.quantity)
		
            local hunger = item.player:GetCharacter():GetData("hunger", 100)
                player:SetHunger(hunger + 40)

		quantity = quantity - 1

		if (quantity >= 1) then
			item:SetData("quantity", quantity)
			return false
		end
		
		ix.chat.Send(item.player, "iteminternal", "injects himself with the "..item.name..".", false)
		
		return true
	end,
	OnCanRun = function(item)
		return (!IsValid(item.entity)) and item.invID == item.player:GetCharacter():GetInventory():GetID()
	end
}