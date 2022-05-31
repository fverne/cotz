ITEM.name = "Radio Base"
ITEM.model = "models/deadbodies/dead_male_civilian_radio.mdl"
ITEM.description = "A PDA used for communicating with other people."
ITEM.width = 1
ITEM.height = 1
ITEM.category = "Communication"
ITEM.price = 150
ITEM.isPDA = true

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

function ITEM:CanTransfer(oldInventory, newInventory)
	if (newInventory and self:GetData("equip")) then
		return false
	end

	return true
end

ITEM.functions.Equip = { -- sorry, for name order.
	name = "Attach to Belt",
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
					if (itemTable.isPDA and itemTable:GetData("equip")) then
						client:NotifyLocalized("You are already equipping a PDA.")

						return false
					end
				end
			end
		end

		for _, v in pairs(items) do
			if (v.id != item.id) then
				local itemTable = ix.item.instances[v.id]

				if (v.uniqueID == item.uniqueID and itemTable:GetData("equip")) then
					client:Notify("You already have another PDA equipped!")
					return false
				end
			end
		end

		item.player:GetCharacter():SetData("pdaavatar", item:GetData("avatar", "vgui/icons/face_31.png"))
		item.player:GetCharacter():SetData("pdanickname", item:GetData("nickname", item.player:GetName()))
		item:SetData("equip", true)
		item.player:GetCharacter():SetData("pdaequipped", true)
		item:OnEquipped()

		return false
	end,
	OnCanRun = function(item)
		local client = item.player

		return !IsValid(item.entity) and IsValid(client) and item:GetData("equip") != true and
			hook.Run("CanPlayerUnequipItem", client, item) != false and item.invID == item:GetOwner():GetCharacter():GetInventory():GetID()
	end
}

ITEM.functions.EquipUn = { -- sorry, for name order.
	name = "Detach from Belt",
	tip = "equipTip",
	icon = "icon16/stalker/unequip.png",
	OnRun = function(item)
		local client = item.player
		item:SetData("equip", false)
		item.player:GetCharacter():SetData("pdaequipped", false)
		item:OnUnEquipped()

		return false
	end,
	OnCanRun = function(item)
		local client = item.player

		return !IsValid(item.entity) and IsValid(client) and item:GetData("equip") == true and
			hook.Run("CanPlayerUnequipItem", client, item) != false and item.invID == item:GetOwner():GetCharacter():GetInventory():GetID()
	end
}

function ITEM:OnEquipped()

end

function ITEM:OnUnEquipped()

end