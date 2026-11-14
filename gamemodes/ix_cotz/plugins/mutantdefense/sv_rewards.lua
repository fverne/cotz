local PLUGIN = PLUGIN

local REWARD_KEY = "mutantDefenseRewards"
local DELIVERY_KEY = "mutantDefenseDelivery"
local VOUCHER_ID = "mutant_defense_voucher"
local deliveries = {}

local function saveRewards(character, state)
	character:SetData(REWARD_KEY, state)
	character:Save()
end

local function notifyCharacter(character, message)
	local client = character:GetPlayer()
	if IsValid(client) and client:GetCharacter() == character then client:Notify(message) end
end

function PLUGIN:PendingVouchers(character)
	return character:GetData(REWARD_KEY, {}).pending or 0
end

function PLUGIN:AwardVoucher(character)
	local state = table.Copy(character:GetData(REWARD_KEY, {}))
	state.pending = (state.pending or 0) + 1
	saveRewards(character, state)
	-- notifyCharacter(character, "You earned a trader supply. Stored rewards can be collected through vendor dialogue if your inventory is full.")
	self:DeliverVoucher(character)
end

function PLUGIN:ConfirmVoucher(character, item)
	local state = table.Copy(character:GetData(REWARD_KEY, {}))
	if not state.token or item:GetData(DELIVERY_KEY) ~= state.token or (state.pending or 0) <= 0 then return end
	state.pending, state.token = state.pending - 1, nil
	deliveries[character:GetID()] = nil
	saveRewards(character, state)
	-- notifyCharacter(character, "Trader Supply added to your inventory.")
	if state.pending <= 0 then return end
	timer.Simple(0, function()
		local client = character:GetPlayer()
		if ix.mutantDefense == PLUGIN and IsValid(client) and client:GetCharacter() == character then
			PLUGIN:DeliverVoucher(character)
		end
	end)
end

function PLUGIN:DeliverVoucher(character)
	local client = character:GetPlayer()
	if not IsValid(client) or client:GetCharacter() ~= character then return false end
	local state = table.Copy(character:GetData(REWARD_KEY, {}))
	if (state.pending or 0) <= 0 then return false end
	local inventory = character:GetInventory()
	if state.token then
		for _, item in pairs(inventory:GetItems()) do
			if item.uniqueID == VOUCHER_ID and item:GetData(DELIVERY_KEY) == state.token then
				self:ConfirmVoucher(character, item)
				return true
			end
		end
	end
	if deliveries[character:GetID()] then return false end
	if not state.token then
		state.serial = (state.serial or 0) + 1
		state.token = character:GetID() .. "/" .. state.serial
		saveRewards(character, state)
	end
	-- Add reserves a slot synchronously; InventoryItemAdded confirms the database insert later.
	deliveries[character:GetID()] = character
	local result = inventory:Add(VOUCHER_ID, 1, {[DELIVERY_KEY] = state.token})
	if not result then
		deliveries[character:GetID()] = nil
		-- notifyCharacter(character, "Your trader supply is stored. Make inventory space and collect it through vendor dialogue.")
		return false
	end

	return true
end

function PLUGIN:InventoryItemAdded(_, inventory, item)
	if item.uniqueID ~= VOUCHER_ID or not item:GetData(DELIVERY_KEY) then return end
	-- Add may select a bag inventory without an owner; the inserted item retains its character ID.
	local owner = inventory.owner or item:GetCharacterID()
	local character = deliveries[owner] or (ix.char.loaded and ix.char.loaded[owner])
	if character then self:ConfirmVoucher(character, item) end
end

function PLUGIN:PlayerLoadedCharacter(client, character)
	timer.Simple(0, function()
		if ix.mutantDefense == PLUGIN and IsValid(client) and client:GetCharacter() == character then
			PLUGIN:DeliverVoucher(character)
		end
	end)
end

function PLUGIN:CanUseVoucherVendor(client, vendor)
	return IsValid(vendor) and vendor:GetClass() == "ix_vendor_adv" and not vendor:GetSherpa()
		and client:GetCharacter() ~= nil and vendor:CanAccess(client)
		and client:GetPos():DistToSqr(vendor:GetPos()) <= self.settings.useDistance ^ 2
		and hook.Run("CanPlayerUseVendor", client, vendor) ~= false
end

function PLUGIN:BeginVoucherAction(client, vendor)
	if not self:CanUseVoucherVendor(client, vendor) then return false end
	if CurTime() < (client.cotzDefenseNextAction or 0) then return false end
	client.cotzDefenseNextAction = CurTime() + self.settings.actionInterval

	return true
end

function PLUGIN:RedeemVoucher(client, vendor)
	if not self:BeginVoucherAction(client, vendor) then return false end
	local character = client:GetCharacter()
	local item = character:GetInventory():HasItem(VOUCHER_ID)
	if not item or item.cotzDefenseRedeeming then return false end
	item.cotzDefenseRedeeming = true
	if not ix.vendorStock.RestockFraction(character, vendor, 0.5) then
		item.cotzDefenseRedeeming = nil
		client:Notify("There is no eligible stock to replenish. Keep the voucher for later.")
		return false
	end
	item:Remove()
	character:GiveMoney(self.settings.voucherReward)
	print("[COTZ mutantdefense] Character", character:GetID(), string.format("trader supply accepted. You received %d rubles, and your eligible stock with this vendor has been replenished by half its maximum.", self.settings.voucherReward))

	return true
end

function PLUGIN:CollectVouchers(client, vendor)
	if not self:BeginVoucherAction(client, vendor) then return false end

	return self:DeliverVoucher(client:GetCharacter())
end

function PLUGIN:CanPlayerTradeWithVendor(_, _, uniqueID)
	if uniqueID == VOUCHER_ID then return false end
end
