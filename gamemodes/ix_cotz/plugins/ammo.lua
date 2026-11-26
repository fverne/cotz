PLUGIN.name = "Ammo"
PLUGIN.author = "Lt. Taylor - modified by gumlefar"
PLUGIN.desc = "Adds an ammo from inventory system - only takes ammo on reload"

if SERVER then
	-- One-shot item data set by the Split action so the new stack is not merged straight back.
	local KEEP_SEPARATE_KEY = "cotzKeepSeparate"

	local function getAmmoItems(client, weapon)
		if not IsValid(weapon) or not weapon.CW20Weapon or not weapon.Primary then return end
		if not client:IsPlayer() or not client:Alive() then return end
		local character = client:GetCharacter()
		if not character then return end
		local ammoItems = {}
		local ammoCount = 0
		for _, item in pairs(character:GetInventory():GetItems()) do
			if item.isAmmo and item.ammo == weapon.Primary.Ammo then
				ammoItems[#ammoItems + 1] = item
				ammoCount = ammoCount + item:GetData("quantity", item.ammoAmount or 0)
			end
		end

		return ammoItems, ammoCount
	end

	local function consumeAmmo(client, weapon, amount)
		local ammoItems = getAmmoItems(client, weapon)
		if not ammoItems then return end
		local remaining = amount
		for _, item in ipairs(ammoItems) do
			if remaining <= 0 then break end
			local quantity = item:GetData("quantity", item.ammoAmount or 0)
			local consumed = math.min(quantity, remaining)
			remaining = remaining - consumed
			if quantity == consumed then
				item:Remove()
			else
				item:SetData("quantity", quantity - consumed)
			end
		end
		local item = weapon.ixItem
		if item then
			item:SetData("ammo", weapon:Clip1())
		end
	end

	local function canChangeStack(item, inventory)
		local hideouts = ix.plugin.Get("hideouts")

		return not IsValid(item.entity) and not (hideouts and hideouts:IsOperationLocked(item, inventory))
	end

	local function getTargetStacks(source, inventory)
		local targets = {}
		for _, item in pairs(inventory:GetItems(true)) do
			if item ~= source and item.isAmmo and source:CanStackWith(item) and canChangeStack(item, inventory)
				and item:GetStackQuantity() < item:GetStackCapacity() then
				targets[#targets + 1] = item
			end
		end
		-- Top up the fullest stacks first so partial stacks do not linger.
		table.sort(targets, function(first, second)
			local firstQuantity, secondQuantity = first:GetStackQuantity(), second:GetStackQuantity()
			if firstQuantity ~= secondQuantity then return firstQuantity > secondQuantity end

			return first.id < second.id
		end)

		return targets
	end

	local function mergeIncomingAmmo(item, character)
		local inventory = character:GetInventory()
		if inventory:GetItemByID(item.id, true) ~= item or not canChangeStack(item, inventory) then return end
		local remaining = item:GetStackQuantity()
		local changed = false
		for _, target in ipairs(getTargetStacks(item, inventory)) do
			if remaining <= 0 then break end
			local quantity = target:GetStackQuantity()
			local moved = math.min(remaining, target:GetStackCapacity() - quantity)
			remaining = remaining - moved
			target:SetData("quantity", quantity + moved)
			changed = true
		end
		if not changed then return end
		if remaining <= 0 then
			item:Remove()
		else
			item:SetData("quantity", remaining)
		end
		-- Merging drops the flat weight of any box that was emptied.
		ix.weight.Update(character)
	end

	function PLUGIN:InventoryItemAdded(_, inventory, item)
		if not item.isAmmo then return end
		if item:GetData(KEEP_SEPARATE_KEY) then
			item:SetData(KEEP_SEPARATE_KEY, nil)

			return
		end
		local character = ix.char.loaded[inventory.owner]
		if not character or character:GetInventory() ~= inventory then return end
		-- New items get their quantity, and transfers and reward claims finish, after this hook returns.
		timer.Simple(0, function()
			mergeIncomingAmmo(item, character)
		end)
	end

	function PLUGIN:WeaponReloadFinished(client, isShotgunReload, weapon, loadedRounds)
		if isShotgunReload or not loadedRounds then return end
		consumeAmmo(client, weapon, loadedRounds)
	end

	function PLUGIN:ProcessShotgunReload(client, weapon)
		consumeAmmo(client, weapon, 1)
	end

	function PLUGIN:AmmoCheck(client, weapon)
		local ammoItems, ammoCount = getAmmoItems(client, weapon)
		if not ammoItems then return end
		local ammoType = weapon.Primary.Ammo
		if client:GetAmmoCount(ammoType) ~= ammoCount then
			client:SetAmmo(ammoCount, ammoType)
		end
	end
end
