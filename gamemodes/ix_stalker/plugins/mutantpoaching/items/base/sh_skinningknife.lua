ITEM.name = "Skinning Knife"
ITEM.description = "A knife for mutant poaching."
ITEM.model = "models/weapons/w_knife_ct.mdl"

ITEM.width = 2
ITEM.height = 1
ITEM.price = 500

ITEM.meattickets = 0
ITEM.parttickets = 0
ITEM.knifetier = 0
ITEM.isPoachKnife = true

ITEM.img = Material("vgui/hud/knife1.png", "noclamp smooth")
ITEM.equipIcon = Material("materials/vgui/ui/stalker/misc/equip.png")


if (CLIENT) then
	function ITEM:PaintOver(item, w, h)
		//Equipsquare
		if (item:GetData("equip")) then
			surface.SetDrawColor(110, 255, 110, 255)
			--surface.DrawRect(w - 14, h - 14, 8, 8)
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
					if (itemTable.isPoachKnife and itemTable:GetData("equip")) then
						client:NotifyLocalized("You are already equipping a knife.")

						return false
					end
				end
			end
		end

		item:SetData("equip", true)
		item.player:EmitSound("stalkersound/inv_slot.mp3", 40)

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

		item.player:EmitSound("stalkersound/inv_slot.mp3", 40)

		return false
	end,
	OnCanRun = function(item)
		local client = item.player

		return !IsValid(item.entity) and IsValid(client) and item:GetData("equip") == true and
			hook.Run("CanPlayerUnequipItem", client, item) != false and item.invID == client:GetCharacter():GetInventory():GetID()
	end
}