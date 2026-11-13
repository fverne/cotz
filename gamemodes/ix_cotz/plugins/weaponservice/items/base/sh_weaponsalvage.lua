ITEM.base = "base_valuable"
ITEM.category = "Weapon Salvage"
ITEM.isWeaponServiceItem = true

local function combineTarget(item, data)
	if type(data) ~= "table" or type(data[1]) ~= "number" then return end
	local target = ix.item.instances[data[1]]
	local client = item.player
	local character = IsValid(client) and client:GetCharacter()
	if not character or not target or target == item or target.uniqueID ~= item.uniqueID then return end
	local items = character:GetInventory():GetItems()
	if items[item.id] ~= item or items[target.id] ~= target
		or item.cotzWorkshopLocked or target.cotzWorkshopLocked then return end
	local sourceQuantity = item:GetData("quantity", item.quantity)
	local targetQuantity = target:GetData("quantity", target.quantity)
	if sourceQuantity < 1 or sourceQuantity > item.maxStack or sourceQuantity % 1 ~= 0
		or targetQuantity < 1 or targetQuantity >= target.maxStack or targetQuantity % 1 ~= 0 then return end

	return target, sourceQuantity, targetQuantity
end

ITEM.functions.combine = {
	OnCanRun = function(item, data)
		return combineTarget(item, data) ~= nil
	end,
	OnRun = function(item, data)
		local target, sourceQuantity, targetQuantity = combineTarget(item, data)
		if not target then return false end
		if hook.Run("CanPlayerInteractItem", item.player, "combine", target.id, {item.id}) == false then
			return false
		end
		local moved = math.min(sourceQuantity, target.maxStack - targetQuantity)
		if moved == sourceQuantity then
			if item:Remove() == false then return false end
		else
			item:SetData("quantity", sourceQuantity - moved)
		end
		target:SetData("quantity", targetQuantity + moved)
		item.player:GetCharacter():UpdateWeight()

		return false
	end,
}

function ITEM:GetPrice()
	return self.price * self:GetData("quantity", self.quantity)
end

if CLIENT then
	function ITEM:PaintOver(item, width, height)
		draw.SimpleText(item:GetData("quantity", item.quantity) .. "/" .. item.maxStack,
			"stalkerregularinvfont", 3, height - 1, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM)
	end
end
