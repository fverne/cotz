ITEM.name = "Anomaly Detector"
ITEM.model = "models/kek1ch/dev_decoder.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.category = "Electronics"
ITEM.price = 5000
ITEM.description = "A device that beeps when anomalies are close."
ITEM.isAnomalydetector = true
ITEM.busflag = {"hardware2"}
ITEM.equipIcon = Material("materials/vgui/ui/stalker/misc/equip.png")
ITEM.repairCost = ITEM.price/100*1

if (CLIENT) then
	function ITEM:PaintOver(item, w, h)
		if (item:GetData("equip")) then
			surface.SetDrawColor(110, 255, 110, 255)
		else
			surface.SetDrawColor(255, 110, 110, 255)
		end

		surface.SetMaterial(item.equipIcon)
		surface.DrawTexturedRect(w-23,h-23,19,19)
	end
end

ITEM.functions.Equip = { -- sorry, for name order.
	name = "Equip",
	tip = "useTip",
	icon = "icon16/stalker/equip.png",
	sound = "stalkersound/inv_dozimetr.ogg",
	OnRun = function(item)
		local client = item.player
		local char = client:GetCharacter()
		local items = char:GetInventory():GetItems()
		for _, v in pairs(items) do
			if (v.id != item.id) then
				local itemTable = ix.item.instances[v.id]

				if (!itemTable) then
					client:NotifyLocalized("tellAdmin", "wid!xt")

					return false
				else
					if (itemTable.isAnomalydetector and itemTable:GetData("equip")) then
						client:NotifyLocalized("You are already equipping an anomaly detector.")

						return false
					end
				end
			end
		end

		item:SetData("equip", true)
		item.player:SetData("ixhasanomdetector", true)
		item.player:SetNetVar("ixhasanomdetector", true)

		return false
	end,
	OnCanRun = function(item)
		local client = item.player

		return !IsValid(item.entity) and IsValid(client) and item:GetData("equip") != true and
			hook.Run("CanPlayerUnequipItem", client, item) != false and item.invID == client:GetCharacter():GetInventory():GetID()
	end
}

ITEM.functions.EquipUn = { -- sorry, for name order.
	name = "Unequip",
	tip = "equipTip",
	icon = "icon16/stalker/unequip.png",
	OnRun = function(item)
		local client = item.player
		item:SetData("equip", false)
		item.player:SetNetVar("ixhasanomdetector", false)
		item.player:SetData("ixhasanomdetector", false)


		return false
	end,
	OnCanRun = function(item)
		local client = item.player

		return !IsValid(item.entity) and IsValid(client) and item:GetData("equip") == true and
			hook.Run("CanPlayerUnequipItem", client, item) != false and item.invID == client:GetCharacter():GetInventory():GetID()
	end
}