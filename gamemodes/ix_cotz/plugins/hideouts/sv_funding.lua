local PLUGIN = PLUGIN

function PLUGIN:QuoteHideoutFunding(client, record, price, callback, minimumRank)
	local character = client:GetCharacter()
	minimumRank = minimumRank or 1
	if record.ownerType ~= "squad" or record.fundUpgrades ~= true then
		callback({player = price, treasury = 0, enabled = false, rank = minimumRank})
		return
	end
	self:CheckSquadRole(client, record, minimumRank, function(allowed)
		if not allowed then callback(nil, "Squad funding access is unavailable.") return end
		self:GetTreasury(record, function(balance, reason)
			if balance == nil then callback(nil, reason) return end
			if not IsValid(client) or client:GetCharacter() ~= character
				or not self:CanAccess(client, record) then
				callback(nil, "Squad access changed.")
				return
			end
			local contribution = math.min(price, balance)
			callback({player = price - contribution, treasury = contribution, balance = balance, enabled = true, rank = minimumRank})
		end)
	end)
end

function PLUGIN:ValidateHideoutFunding(client, record, funding)
	if record.ownerType ~= "squad" then return funding.treasury == 0 end

	local rank = self:GetSquadRank(client, record)

	return rank ~= nil and rank >= (funding.rank or 1) and self:CanAccess(client, record)
		and (record.fundUpgrades == true) == (funding.enabled == true)
end

function PLUGIN:SetUpgradeFunding(client, record, enabled)
	if not record or record.ownerType ~= "squad" or self:GetSquadRank(client, record) ~= 2 then
		return false, "Only the squad leader can change upgrade funding."
	end
	local character = client:GetCharacter()
	self:CheckSquadRole(client, record, 2, function(allowed)
		if not allowed or not IsValid(client) or client:GetCharacter() ~= character
			or not self:CanUseManagementMenu(client, record.id)
			or self:GetSquadRank(client, record) ~= 2 then return end
		local instance = self.instances[record.id]
		if (instance and (instance.operations or 0) > 0) or self:IsTreasuryOperationPending(record) then
			client:Notify("Wait for the squad transaction to finish.")
			return
		end
		local previous = record.fundUpgrades
		record.fundUpgrades = enabled == true
		if not self:Persist() then
			record.fundUpgrades = previous
			client:Notify("Could not save upgrade funding.")
			return
		end
		self:RefreshManagementMenu(client)
	end)

	return true
end
