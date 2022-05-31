ITEM.name = "Bag"
ITEM.description = "A bag to increase your carry capacity."
ITEM.model = "models/props_c17/suitcase001a.mdl"
ITEM.category = "Storage"

ITEM.width = 2
ITEM.height = 2
ITEM.price = 0

ITEM.isNewBag = true
ITEM.outfitCategory = "backpack"
ITEM.pacData = {}
ITEM.equipIcon = ix.util.GetMaterial("materials/vgui/ui/stalker/misc/equip.png")

ITEM.weight = 1
ITEM.carryinc = 10

function ITEM:GetDescription()
	local quant = self:GetData("quantity", self.ammoAmount or self.quantity or 0)
	local quantdesc = ""
	local invdesc = ""
	if self.longdesc then
		invdesc = "\n\n"..(self.longdesc)
	end

	if self.quantdesc then
		quantdesc = "\n\n"..Format(self.quantdesc, quant)
	end

	if (self.entity) then
		return (self.description)
	else
        return (self.description..quantdesc..invdesc)
	end
end

if (CLIENT) then
	function ITEM:PaintOver(item, width, height)
		if (item:GetData("equip")) then
			surface.SetDrawColor(110, 255, 110, 255)
			--surface.DrawRect(w - 14, h - 14, 8, 8)
		else
			surface.SetDrawColor(255, 110, 110, 255)
		end

		surface.SetMaterial(item.equipIcon)
		surface.DrawTexturedRect(width-23,height-23,19,19)
	end
end

function ITEM:PopulateTooltip(tooltip)
    if (!self.entity) then
        ix.util.PropertyDesc2(tooltip, "Backpack", Color(64, 224, 208), Material("vgui/ui/stalker/weaponupgrades/handling.png"))
    end

    if (self.PopulateTooltipIndividual) then
      self:PopulateTooltipIndividual(tooltip)
    end
end

ITEM.functions.Equip = {
	name = "Put On",
	tip = "equipTip",
	icon = "icon16/stalker/equip.png",
	OnRun = function(item)
		local char = item.player:GetCharacter()
		local items = char:GetInventory():GetItems()

		for _, v in pairs(items) do
			if (v.id != item.id) then
				local itemTable = ix.item.instances[v.id]

				if (itemTable.pacData and v.outfitCategory == item.outfitCategory and itemTable:GetData("equip")) then
					item.player:Notify("You're already equipping this kind of outfit")

					return false
				end
			end
		end

		item:SetData("equip", true)
		item.player:AddPart(item.uniqueID, item)
		char:UpdateWeight()

		if (item.attribBoosts) then
			for k, v in pairs(item.attribBoosts) do
				char:AddBoost(item.uniqueID, k, v)
			end
		end

		item:OnEquipped()
		return false
	end,
	OnCanRun = function(item)
		local client = item.player

		return !IsValid(item.entity) and IsValid(client) and item:GetData("equip") != true and
			hook.Run("CanPlayerEquipItem", client, item) != false and item.invID == item:GetOwner():GetCharacter():GetInventory():GetID()
	end
}

ITEM.functions.EquipUn = { -- sorry, for name order.
	name = "Take Off",
	tip = "equipTip",
	icon = "icon16/stalker/unequip.png",
	OnRun = function(item)
		local char = item.player:GetCharacter()

		if (!char:CanRemoveCarry(item)) then
			item.player:Notify("Removing this item would make you heavily overweight.")
			return false
		end

		item:RemovePart(item.player)
		char:UpdateWeight()

		return false
	end,
	OnCanRun = function(item)
		local client = item.player

		return !IsValid(item.entity) and IsValid(client) and item:GetData("equip") == true and
			hook.Run("CanPlayerUnequipItem", client, item) != false
	end
}

ITEM:Hook("drop", function(item)
	if (item:GetData("equip") && item.player:GetCharacter():CanRemoveCarry(item)) then
		item:RemovePart(item.player)
	end
end)

function ITEM:RemovePart(client)
	local char = client:GetCharacter()

	self:SetData("equip", false)
	client:RemovePart(self.uniqueID)

	if (self.attribBoosts) then
		for k, _ in pairs(self.attribBoosts) do
			char:RemoveBoost(self.uniqueID, k)
		end
	end

	self:OnUnequipped()
end

-- Called before the item is permanently deleted.
function ITEM:OnRemoved()
	local owner = self.player

	if (self:GetData("equip")) then
		self:RemovePart(owner)
	end
end

function ITEM:OnEquipped()
	self.player:EmitSound("stalkersound/inv_slot.mp3")
end

function ITEM:OnUnequipped()
	self.player:EmitSound("stalkersound/inv_slot.mp3")
end

