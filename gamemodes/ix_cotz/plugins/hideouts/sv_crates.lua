local PLUGIN = PLUGIN
local previousLoaded = PLUGIN.PlayerLoadedCharacter

function PLUGIN:ApplyCraftInputs(spec)
	for _, input in ipairs(spec.inputs) do
		if input.remaining == 0 then
			spec.from:Remove(input.item:GetID(), false, true)
			ix.item.instances[input.item:GetID()] = nil
		else
			input.item.data = input.data
			input.item:SetData("quantity", input.remaining, nil, true)
		end
	end
end

-- Crafting no longer creates outputs; CommitOperation retains this for its generic output support.
function PLUGIN:ApplyCraftOutput(spec, character)
	local item = ix.item.New(spec.output.item, spec.outputID)
	item.data = table.Copy(spec.output.data)
	item.invID, item.characterID, item.playerID = spec.to:GetID(), character:GetID(), spec.playerID
	local previous = spec.to.noSave
	spec.to.noSave = true
	local x = spec.to:Add(item:GetID(), 1, nil, spec.x, spec.y)
	spec.to.noSave = previous
	if not x then error("Committed hideout crate requires authoritative inventory restore") end
end

function PLUGIN:CollectCrateInputs(client, recipe)
	local inventory = client:GetCharacter():GetInventory()
	local candidates = {}
	for _, item in pairs(inventory:GetItems()) do
		if item.invID == inventory:GetID() and self:CanStockItem(client, item) then
			candidates[#candidates + 1] = item
		end
	end
	table.sort(candidates, function(first, second) return first:GetID() < second:GetID() end)
	local inputs, byID = {}, {}
	for _, group in ipairs(recipe.groups) do
		local remaining = group.quantity
		for _, itemID in ipairs(group.items) do
			local size = self.crateBatchSizes[itemID] or 1
			local available = 0
			for _, item in ipairs(candidates) do
				if item.uniqueID ~= itemID then continue end
				local input = byID[item:GetID()]
				if not input then
					local quantity = item:GetData("quantity", item.quantity or item.ammoAmount or 1)
					if not isnumber(quantity) or quantity ~= quantity or quantity < 1
						or quantity == math.huge or quantity % 1 ~= 0 then continue end
					input = {item = item, available = quantity, remaining = quantity}
					byID[item:GetID()] = input
				end
				available = available + input.remaining
			end
			local batches = math.min(remaining, math.floor(available / size))
			local units = batches * size
			for _, item in ipairs(candidates) do
				local input = byID[item:GetID()]
				if item.uniqueID == itemID and input and units > 0 then
					local consumed = math.min(input.remaining, units)
					input.remaining, units = input.remaining - consumed, units - consumed
				end
			end
			remaining = remaining - batches
			if remaining == 0 then break end
		end
		if remaining > 0 then return nil, "Not enough materials for " .. group.name .. "." end
	end
	for _, item in ipairs(candidates) do
		local input = byID[item:GetID()]
		if input and input.remaining < input.available then inputs[#inputs + 1] = input end
	end

	return inputs
end

function PLUGIN:CompleteInstalledLevel(character, level)
	local contact = self.personalContacts[game.GetMap()]
	if not contact or not ix.progression.SetCompleted then return end
	for step = 1, math.min(level, 12) do
		local id = "cotz/town/" .. contact.id .. "/v3/hideout/" .. string.format("%02d", step)
		if ix.progression.definitions[id] and not ix.progression.IsCompleted(character, id) then
			ix.progression.SetCompleted(character, id)
		end
	end
	character:Save()
end

function PLUGIN:ReconcileInstalledLevels(character)
	local highest = 0
	for _, record in pairs(self.state.hideouts) do
		if record.ownerType ~= "squad" and record.owner == character:GetID() then
			highest = math.max(highest, 1)
			if record.personalVersion then
				for _, slot in pairs(record.containers or {}) do highest = math.max(highest, slot.tier or 0) end
			end
		end
	end
	if highest > 0 then self:CompleteInstalledLevel(character, highest) end
end

function PLUGIN:PlayerLoadedCharacter(client, character)
	previousLoaded(self, client, character)
	if self.ready then self:ReconcileInstalledLevels(character) end
end
