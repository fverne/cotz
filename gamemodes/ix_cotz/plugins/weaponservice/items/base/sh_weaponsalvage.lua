ITEM.base = "base_valuable"
ITEM.category = "Weapon Salvage"
ITEM.isWeaponServiceItem = true

-- Workshop deliveries stay out of stacks until their receipt is saved.
function ITEM:CanStackWith(target)
	return target.uniqueID == self.uniqueID and not self.cotzWorkshopLocked and not target.cotzWorkshopLocked
end

local function combineTarget(item, data)
	local target = item:GetStackCombineTarget(data)
	if not target then return end

	return target, item:GetStackQuantity(), target:GetStackQuantity()
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
