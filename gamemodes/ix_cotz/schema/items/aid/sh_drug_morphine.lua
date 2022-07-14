ITEM.name = "Morphine Syringe"
ITEM.description = "A small plastic syringe."
ITEM.longdesc = "A single-use syringe with a morphine solution inside.\nMorphine was first obtained from poppy seeds in 1805, and is routinely used in medical situations for powerful pain relief.\nUsed by STALKERs to reduce the strain on their minds and their bodies by the zones extreme conditions."
ITEM.model = "models/lostsignalproject/items/medical/glucose.mdl"

ITEM.sound = "stalkersound/inv_syringe.mp3"

ITEM.width = 1
ITEM.height = 1
ITEM.price = 1450

ITEM.quantity = 1
ITEM.restore = 15
ITEM.psyheal = 40

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
end

ITEM.functions.use = {
	name = "Inject",
	icon = "icon16/stalker/swallow.png",
	OnRun = function(item)
		local quantity = item:GetData("quantity", item.quantity)
		
		item.player:AddBuff("buff_slowheal", 5, { amount = item.restore/5 })
		item.player:AddBuff("buff_psyheal", 60, { amount = item.psyheal/120 })

		item.player:GetCharacter():SatisfyAddictions("StrongerDrugs")

		quantity = quantity - 1

		if (quantity >= 1) then
			item:SetData("quantity", quantity)
			return false
		end
		
		ix.chat.Send(item.player, "iteminternal", "injects himself with the "..item.name..".", false)
		
		return true
	end,
	OnCanRun = function(item)
		return (!IsValid(item.entity)) and item.invID == item:GetOwner():GetCharacter():GetInventory():GetID()
	end
}