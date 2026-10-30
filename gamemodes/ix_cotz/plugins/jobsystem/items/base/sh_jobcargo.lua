ITEM.name = "Field cargo"
ITEM.description = "Equipment bound to an active field assignment."
ITEM.isFieldCargo = true
ITEM.noDrop = true
ITEM.flag = "A"

-- The installed item transfer path also checks this after plugin hooks. Keep the
-- binding here because existing COTZ hooks may return true and stop hook dispatch.
function ITEM:CanTransfer(oldInventory, inventory)
	local character = SERVER and ix.char.loaded[self:GetData("fieldOwner")]
		or CLIENT and LocalPlayer():GetCharacter()
	if not character or character:GetID() ~= self:GetData("fieldOwner")
		or not inventory or inventory:GetID() ~= character:GetInventory():GetID() then return false end
end

function ITEM:GetWeight()
	return self.flatweight
end

function ITEM:GetDescription()
	return self.description .. "\nReturn this to the contact who issued your assignment."
end
