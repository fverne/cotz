local jobs = ix.jobs

local function inventoryFor(client)
	local character = client:GetCharacter()

	return character and character:GetInventory()
end

local function removeTool(client, definition, completed)
	local inventory = inventoryFor(client)
	if not inventory then return end
	for _, item in pairs(inventory:GetItems()) do
		local matches = item.uniqueID == definition.toolItem
		if completed then
			matches = matches and item:GetData("finished", false)
			for _, key in ipairs(definition.toolCompletionKeys) do
				matches = matches and item:GetData(key) == definition.toolData[key]
			end
		end
		if matches then
			item:Remove()
			if completed then ix.dialogue.notifyItemLost(client, ix.item.list[definition.toolItem].name) end
			return
		end
	end
end

function jobs.RegisterToolJob(definition, identifier)
	definition.CanAcceptTask = function(client)
		local inventory = inventoryFor(client)
		if not inventory then return false end
		-- The installed Inventory:Add returns reserved coordinates for string IDs.
		-- These legacy tools retain that acceptance contract; field cargo uses Instance/Transfer instead.
		if inventory:Add(definition.toolItem, 1, table.Copy(definition.toolData)) then
			ix.dialogue.notifyItemGet(client, ix.item.list[definition.toolItem].name)
			return true
		end
		client:Notify("Not enough space in inventory! Retake the task.")

		return false
	end
	if definition.removeToolOnComplete then
		definition.OnTaskComplete = function(client) removeTool(client, definition, true) end
	end
	definition.OnTaskAbandon = function(client) removeTool(client, definition, false) end
	jobs.register(definition, identifier)
end
