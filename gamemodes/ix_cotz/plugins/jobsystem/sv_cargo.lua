local PLUGIN = PLUGIN

function PLUGIN:CanTransferItem(item, oldInventory, inventory)
	if not item.isFieldCargo then return end
	local owner = item:GetData("fieldOwner")
	local character = owner and ix.char.loaded[owner]
	if not character or not inventory or inventory:GetID() ~= character:GetInventory():GetID() then return false end
end

function PLUGIN:CanPlayerTakeItem(client, item)
	if item.isFieldCargo and (not client:GetCharacter()
		or item:GetData("fieldOwner") ~= client:GetCharacter():GetID()) then return false end
end

function PLUGIN:CanPlayerDropItem(client, item)
	if item.isFieldCargo then return false end
end

function PLUGIN:PhysgunPickup(client, entity)
	if entity:GetClass() == "ix_job_field_object" then return false end
end

function PLUGIN:CanPlayerHoldObject(client, entity)
	if entity:GetClass() == "ix_job_field_object" then return false end
end

function PLUGIN:CanTool(client, trace, tool)
	if IsValid(trace.Entity) and trace.Entity:GetClass() == "ix_job_field_object" then return false end
end

function PLUGIN:CanProperty(client, property, entity)
	if entity:GetClass() == "ix_job_field_object" then return false end
end
