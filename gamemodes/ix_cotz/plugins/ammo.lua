PLUGIN.name = "Ammo"
PLUGIN.author = "Lt. Taylor - modified by gumlefar"
PLUGIN.desc = "Adds an ammo from inventory system - only takes ammo on reload"

if SERVER then
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
