PLUGIN.name = "Ammo"
PLUGIN.author = "Lt. Taylor - modified by some faggot"
PLUGIN.desc = "Adds an ammo from inventory system - only takes ammo on reload"

if (CLIENT) then return end

local delay = 0

function PLUGIN:WeaponReloadFinished(entity)
    if entity:IsPlayer() then
		local wep = entity:GetActiveWeapon()
		local wepclass = wep:GetClass()
		local wepitem
		local ammo = {}
		
		for k,v in pairs(entity:GetChar():GetInv():GetItems()) do
			if v.isAmmo == true then
				if wep.Primary.Ammo == v.ammo then
					table.insert(ammo, v)
				end
			end

			if v.isWeapon && v.class == wepclass && v:GetData("equip",false) then
				wepitem = v
			end
		end

		local ammoInMag = wep:Clip1()
		local maxAmmoInMag = wep:GetMaxClip1()
		local neededAmmo = maxAmmoInMag - ammoInMag
		local foundAmmo = 0

		for k,v in pairs(ammo) do
			local ammocount = v:GetData("quantity",1)

			if ammocount > neededAmmo then
				v:SetData("quantity", ammocount-neededAmmo)
				wepitem:SetData("ammo", ammoInMag+foundAmmo)
				break
			else

				v:Remove()
			end

			foundAmmo = foundAmmo + ammocount
			neededAmmo = neededAmmo - ammocount
		end

		/*
		local newAmmo = ammoCount - neededAmmo

		if newAmmo <= 0 then
			timer.Simple( 0.1, function() ammo:Remove() end )
			wepitem:SetData("ammo", ammoCount+ammoInMag)
		else
			ammo:SetData("quantity",newAmmo)
			wepitem:SetData("ammo", maxAmmoInMag)
		end
		
		if delay < CurTime() then
			delay = CurTime() + 1
			ammo:SetData("quantity",newAmmo)
		else
			ammo:SetData("quantity",newAmmo,nil,true)
		end
		*/
    end
end


hook.Add("WeaponReloadFinished", "Weapon_ReloadFinished", WeaponReloadFinished)

function PLUGIN:AmmoCheck(client, weapon)
	local ammoCount = 0
	local ammoType = weapon.Primary.Ammo
	
	for k,v in pairs(client:GetChar():GetInv():GetItems()) do
		if v.isAmmo then
			if ammoType == v.ammo then
				ammoCount = ammoCount + v:GetData("quantity",1)
			end
		end
	end
	
	if ammoCount > 0 then
		client:SetAmmo(ammoCount,ammoType)
	else
		client:SetAmmo(0,ammoType)
	end
end

hook.Add("AmmoCheck", "Ammo_Check", AmmoCheck)