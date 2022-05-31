ITEM.name = "Codeine Tablets"
ITEM.description = "A small blister packet that features some medical red cross signs on the package."
ITEM.longdesc = "Codeine is an opioid analgesic, and a drug used to decrease pain by increasing the threshold for pain without impairing consciousness or altering other sensory functions. In addition to decreasing pain, codeine also causes sedation, drowsiness, and respiratory depression. Often used by STALKERs to kill pain and to mellow out after a stressful raid."
ITEM.model = "models/lostsignalproject/items/medical/barvinok.mdl"

ITEM.sound = "stalkersound/inv_eat_pills.mp3"

ITEM.width = 1
ITEM.height = 1
ITEM.price = 560

ITEM.quantity = 8
ITEM.restore = 5
ITEM.psyheal = 12

ITEM.weight = 0.050
ITEM.flatweight = 0.002

ITEM.exRender = true
ITEM.iconCam = {
	pos = Vector(-200, 0, 0),
	ang = Angle(0, -0, 45),
	fov = 1.5,
}

function ITEM:PopulateTooltipIndividual(tooltip)
    ix.util.PropertyDesc(tooltip, "Drug", Color(64, 224, 208))
end

ITEM.functions.use = {
	name = "Swallow",
	icon = "icon16/stalker/swallow.png",
	OnRun = function(item)
		local quantity = item:GetData("quantity", item.quantity)

		item.player:AddBuff("buff_slowheal", 5, { amount = item.restore/5 })
		item.player:AddBuff("buff_psyheal", 60, { amount = item.psyheal/120 })

		ix.chat.Send(item.player, "iteminternal", "takes out a pill from the "..item.name.." and swallows it.", false)

		item.player:GetCharacter():SatisfyAddictions("PrescriptionDrugs")

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
