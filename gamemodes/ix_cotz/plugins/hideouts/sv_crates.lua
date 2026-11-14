local PLUGIN = PLUGIN
local previousLoaded = PLUGIN.PlayerLoadedCharacter
util.AddNetworkString("cotz/hideouts/crates")
util.AddNetworkString("cotz/hideouts/crate-quote")
util.AddNetworkString("cotz/hideouts/crate-buy")

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

function PLUGIN:CanCarryCraft(character, recipe, inputs)
	if not ix.weight or not ix.weight.CanCarry then return true end
	local carry = ix.weight.CalculateWeight(character)
	for _, input in ipairs(inputs) do
		carry = carry - (input.item:GetWeight() or 0)
		if input.remaining > 0 then
			local remainder = setmetatable({data = table.Copy(input.item.data)}, {__index = input.item})
			remainder.data.quantity = input.remaining
			carry = carry + (remainder:GetWeight() or 0)
		end
	end

	return ix.weight.CanCarry(ix.item.list[recipe.item]:GetWeight() or 0, carry, character)
end

function PLUGIN:GetCraftingSquadHideout(client)
	for _, record in pairs(self.state.hideouts) do
		if record.ownerType == "squad" and self:GetSquadRank(client, record) ~= nil
			and self:CanAccess(client, record) then
			return record
		end
	end
end

function PLUGIN:CanUseCrateVendor(client, target)
	local contact = self.personalContacts[game.GetMap()]
	local character = client:GetCharacter()

	return self.ready and self.operationsReady and character and contact and IsValid(target)
		and target:GetClass() == "ix_vendor_adv" and target:GetDisplayName() == contact.name
		and target:CanAccess(client) and client:GetPos():DistToSqr(target:GetPos()) <= 192 * 192
		and ix.progression.CanUseNPC(character, contact.name)
end

function PLUGIN:QuoteCrate(client, target, family, level, squad, callback)
	if not self:CanUseCrateVendor(client, target) then callback(nil, "Use the local hideout contact.") return end
	local character = client:GetCharacter()
	local recipe = self:GetCrateRecipe(family, level, squad)
	if not recipe or not self:GetCrateUnlock(character, level) then
		callback(nil, "Complete the preceding local hideout improvement first.")
		return
	end
	local record = squad and self:GetCraftingSquadHideout(client)
	if squad and not record then callback(nil, "Join the squad owning a hideout on this map to build its crates.") return end
	local function quoted(funding, reason)
		if not funding then callback(nil, reason) return end
		if not IsValid(client) or client:GetCharacter() ~= character or not self:CanUseCrateVendor(client, target) then
			callback(nil, "Your character or vendor access changed.")
			return
		end
		local quote = {
			character = character, target = target, recipe = recipe, record = record, funding = funding,
			expires = CurTime() + 120, revision = self.crateVersion,
			token = util.SHA256(tostring(character:GetID()) .. SysTime() .. math.random()),
		}
		client.cotzCrateQuote = quote
		callback(quote)
	end
	if record then self:QuoteHideoutFunding(client, record, recipe.price, quoted, 0)
	else quoted({player = recipe.price, treasury = 0}) end
end

function PLUGIN:CraftCrate(client, target, token, callback)
	local quote = client.cotzCrateQuote
	client.cotzCrateQuote = nil
	local character = client:GetCharacter()
	if not quote or quote.token ~= token or quote.character ~= character or quote.target ~= target
		or quote.expires < CurTime()
		or quote.revision ~= self.crateVersion or not self:CanUseCrateVendor(client, target) then
		callback(false, "Reopen the crate recipe for a current quote.")
		return
	end
	local recipe = quote.recipe
	local inventory = character:GetInventory()
	local inputs, reason = self:CollectCrateInputs(client, recipe)
	if not inputs then callback(false, reason) return end
	local definition = ix.item.list[recipe.item]
	if not definition then callback(false, "The configured crate item is unavailable.") return end
	if not self:CanCarryCraft(character, recipe, inputs) then
		callback(false, "You cannot carry the assembled crate. Free some carrying capacity first.")
		return
	end
	local x, y = inventory:FindEmptySlot(definition.width, definition.height, true)
	if not x then callback(false, "Make room for a crate in your main inventory first.") return end
	local record = quote.record or {id = "craft", owner = character:GetID(), ownerType = "character"}
	local function authorize()
		return IsValid(client) and client:GetCharacter() == character and self:CanUseCrateVendor(client, target)
			and self:GetCrateUnlock(character, recipe.level)
			and self:ValidateHideoutFunding(client, record, quote.funding)
			and self:CanCarryCraft(character, recipe, inputs)
	end
	if not authorize() then callback(false, "Crate eligibility or squad funding changed.") return end
	self:CommitOperation(client, record, {
		inputs = inputs, from = inventory, to = inventory, x = x, y = y,
		output = {item = recipe.item, data = recipe.data},
		moneyDelta = -quote.funding.player, treasuryDelta = -quote.funding.treasury,
		treasuryBalance = quote.funding.balance, rank = recipe.squad and 0 or nil,
		payload = {kind = "craft", family = recipe.family, level = recipe.level,
			treasury = -quote.funding.treasury, paid = quote.funding.player},
		resolve = function() return quote.record and self:GetHideout(record.id) or record end,
		authorize = authorize,
	}, function(ok, failure)
		if IsValid(client) and client:GetCharacter() == character then character:UpdateWeight() end
		callback(ok, ok and "Upgrade crate assembled. Install it in the matching hideout container." or failure)
	end)
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

function PLUGIN:OpenCrateBarter(client, target)
	if not self:CanUseCrateVendor(client, target) or (client.cotzCrateOpen or 0) > CurTime() then return end
	client.cotzCrateOpen = CurTime() + 0.5
	self:ReconcileInstalledLevels(client:GetCharacter())
	local maximum = 0
	for level = 1, 12 do
		if self:GetCrateUnlock(client:GetCharacter(), level) then maximum = level else break end
	end
	client.cotzCrateVendor = target
	net.Start("cotz/hideouts/crates")
	net.WriteUInt(maximum, 4)
	net.WriteBool(self:GetCraftingSquadHideout(client) ~= nil)
	net.Send(client)
end

net.Receive("cotz/hideouts/crate-quote", function(_, client)
	local family, level, squad = net.ReadString(), net.ReadUInt(4), net.ReadBool()
	if #family > 16 or not client:GetCharacter() or (client.cotzCrateNext or 0) > CurTime() then return end
	client.cotzCrateNext = CurTime() + 0.5
	PLUGIN:QuoteCrate(client, client.cotzCrateVendor, family, level, squad, function(quote, reason)
		if not IsValid(client) then return end
		if not quote then client:Notify(reason or "Crate unavailable.") return end
		net.Start("cotz/hideouts/crate-quote")
		net.WriteString(quote.token)
		net.WriteString(family)
		net.WriteUInt(level, 4)
		net.WriteBool(squad)
		net.WriteUInt(quote.funding.treasury, 32)
		net.WriteUInt(quote.funding.player, 32)
		net.Send(client)
	end)
end)

net.Receive("cotz/hideouts/crate-buy", function(_, client)
	local token = net.ReadString()
	if #token > 64 or not client:GetCharacter() or (client.cotzCrateBuyNext or 0) > CurTime() then return end
	client.cotzCrateBuyNext = CurTime() + 0.5
	PLUGIN:CraftCrate(client, client.cotzCrateVendor, token, function(_, reason)
		if IsValid(client) then client:Notify(reason) end
	end)
end)
