ITEM.name = "Paper"
ITEM.model = "models/kek1ch/notes_letter_1.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.description = "A paper which one you can write on."
ITEM.busflag = {"hardware1"}
ITEM.price = 50
ITEM.repairCost = ITEM.price/100*1

ITEM.functions.use = {
	name = "Interact",
	icon = "icon16/pencil.png",
	OnRun = function(item)
		local client = item.player
		local id = item:GetID()
		if (id) then
			netstream.Start(client, "receivePaper", id, item:GetData("PaperData") or "")
		end
		return false
	end
}

