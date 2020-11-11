ITEM.name = "Geiger Counter"
ITEM.model = "models/lostsignalproject/items/devices/geiger.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.category = "Electronics"
ITEM.price = 150
ITEM.isGeiger = true
ITEM.busflag = {"hardware"}
ITEM.equipIcon = Material("materials/vgui/ui/stalker/misc/equip.png")
ITEM.repairCost = ITEM.price/100*1

function ITEM:GetDescription()
	return "This device detects the radiation levels nearby, alarming you if they increase."
end

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

function ITEM:PopulateTooltip(tooltip)
    if !self.entity then
        ix.util.PropertyDesc2(tooltip, "Geiger Counter", Color(64, 224, 208), Material("vgui/ui/stalker/weaponupgrades/handling.png"))
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
					if (itemTable.isGeiger == true and itemTable:GetData("equip")) then
						client:NotifyLocalized("You are already equipping a gieger counter detector.")

						return false
					end
				end
			end
		end


		item:SetData("equip", true)
		item.player:SetNetVar("ixhasgeiger", true)
		item.player:SetData("ixhasgeiger", true)

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
		item.player:SetNetVar("ixhasgeiger", false)
		item.player:SetData("ixhasgeiger", false)

		return false
	end,
	OnCanRun = function(item)
		local client = item.player

		return !IsValid(item.entity) and IsValid(client) and item:GetData("equip") == true and
			hook.Run("CanPlayerUnequipItem", client, item) != false and item.invID == client:GetCharacter():GetInventory():GetID()
	end
}