ITEM.name = "Headlamp"
ITEM.description = "A headlamp with adjustable straps."
ITEM.model = "models/lostsignalproject/items/devices/tactical_torch.mdl"

ITEM.width = 1
ITEM.height = 1
ITEM.price = 1950
ITEM.weight = 0.310
ITEM.isHeadLamp = true

ITEM.img = ix.util.GetMaterial("cotz/ui/icons/misc_headlamp.png")
ITEM.equipIcon = ix.util.GetMaterial("materials/vgui/ui/stalker/misc/equip.png")


/* exrender for "models/lostsignalproject/items/devices/tactical_torch.mdl"
ITEM.exRender = true
ITEM.iconCam = {
	pos = Vector(-0.5, 11, 0),
	ang = Angle(0, 270, 0),
	fov = 45,
}
*/

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
	name = "Attach to Head",
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
					if (itemTable.isHeadLamp and itemTable:GetData("equip")) then
						client:NotifyLocalized("You are already equipping a headlamp.")

						return false
					end
				end
			end
		end

		item:SetData("equip", true)
		char:SetData("headlamp", true)
		item.player:EmitSound("stalkersound/inv_slot.mp3", 40)

		return false
	end,
	OnCanRun = function(item)
		local client = item.player

		return !IsValid(item.entity) and IsValid(client) and item:GetData("equip") != true and
			hook.Run("CanPlayerUnequipItem", client, item) != false and item.invID == item:GetOwner():GetCharacter():GetInventory():GetID()
	end
}

ITEM.functions.EquipUn = { -- sorry, for name order.
	name = "Detach from Head",
	tip = "equipTip",
	icon = "icon16/stalker/unequip.png",
	OnRun = function(item)
		local client = item.player
		item:SetData("equip", false)
		client:GetCharacter():SetData("headlamp", false)

		item.player:EmitSound("stalkersound/inv_slot.mp3", 40)

		return false
	end,
	OnCanRun = function(item)
		local client = item.player

		return !IsValid(item.entity) and IsValid(client) and item:GetData("equip") == true and
			hook.Run("CanPlayerUnequipItem", client, item) != false and item.invID == item:GetOwner():GetCharacter():GetInventory():GetID()
	end
}

ITEM:Hook("drop", function(item)
	item:SetData("equip", false)
	item.player:Flashlight(false)
	item.player:GetCharacter():SetData("headlamp", false)
end)
