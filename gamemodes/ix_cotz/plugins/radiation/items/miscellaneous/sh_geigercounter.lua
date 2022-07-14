ITEM.name = "Geiger Counter"
ITEM.description = "A personal geiger counter that measures local radiation levels."
ITEM.model = "models/lostsignalproject/items/devices/geiger.mdl"
ITEM.category = "Electronics"

ITEM.width = 1
ITEM.height = 1
ITEM.price = 650
ITEM.weight = 0.460

ITEM.isGeiger = true

ITEM.exRender = true
ITEM.iconCam = {
	pos = Vector(0, 0, 200),
	ang = Angle(90, 0, -180),
	fov = 2.1,
}

ITEM.equipIcon = ix.util.GetMaterial("materials/vgui/ui/stalker/misc/equip.png")

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
	name = "Attach to Belt",
	tip = "useTip",
	icon = "icon16/stalker/equip.png",
	sound = "stalkersound/inv_dozimetr.ogg",
	OnRun = function(item)
		item:Equip(item.player)

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
		item:UnEquip(item.player)

		return false
	end,
	OnCanRun = function(item)
		local client = item.player

		return !IsValid(item.entity) and IsValid(client) and item:GetData("equip") == true and
			hook.Run("CanPlayerUnequipItem", client, item) != false and item.invID == item:GetOwner():GetCharacter():GetInventory():GetID()
	end
}

function ITEM:Equip(client)
	local char = client:GetCharacter()
	local items = char:GetInventory():GetItems()
	for _, v in pairs(items) do
		if (v.id != self.id) then
			local itemTable = ix.item.instances[v.id]

			if (!itemTable) then
				client:NotifyLocalized("tellAdmin", "wid!xt")

				return false
			else
				if (itemTable.isGeiger == true and itemTable:GetData("equip")) then
					client:NotifyLocalized("You are already equipping a geiger counter detector.")

					return false
				end
			end
		end
	end

	self:SetData("equip", true)
	self:OnLoadout()
end

function ITEM:UnEquip(client)
	self:SetData("equip", false)
	self.player:SetNetVar("ixhasgeiger", false)
	self.player:SetData("ixhasgeiger", false)
end

ITEM:Hook("drop", function(item)
	item:UnEquip(item.player)
end)

function ITEM:OnLoadout()
	if self:GetData("equip", false) then
		self.player:SetNetVar("ixhasgeiger", true)
		self.player:SetData("ixhasgeiger", true)
	end
end