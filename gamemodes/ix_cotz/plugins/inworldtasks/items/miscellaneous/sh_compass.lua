ITEM.name = "Compass"
ITEM.description = "A small device that keeps track of its heading."
ITEM.model = "models/lostsignalproject/items/quest/gps.mdl"
ITEM.price = 700
ITEM.flag = "A"
ITEM.weight = 0.075

ITEM.isCompass = true

ITEM.width = 1
ITEM.height = 1
ITEM.exRender = true
ITEM.iconCam = {
	pos = Vector(0, 0, 6.8000001907349),
	ang = Angle(90, -90, 0),
	fov = 59,
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

function ITEM:GetDescription()
	if(self.entity) then return self.description end
	if(self:GetID() == 0) then return self.description end
	if(!self:GetOwner()) then return self.description end

	local desc = self.description.."\n\n"
	desc = desc.."\nCurrent Heading: "..ix.util.GetHeadingFromAngle(self:GetOwner():GetAngles()).."\n"

	return Format(desc)
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
				if (itemTable.isCompass == true and itemTable:GetData("equip")) then
					client:NotifyLocalized("You are already equipping a compass.")

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
	self.player:SetNetVar("ixhascompass", false)
	self.player:SetData("ixhascompass", false)
end

ITEM:Hook("drop", function(item)
	item:UnEquip(item.player)
end)

function ITEM:OnLoadout()
	if self:GetData("equip", false) then
		self.player:SetNetVar("ixhascompass", true)
		self.player:SetData("ixhascompass", true)
	end
end