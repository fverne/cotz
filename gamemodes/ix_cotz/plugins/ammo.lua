PLUGIN.name = "Ammo"
PLUGIN.author = "Lt. Taylor - modified by gumlefar"
PLUGIN.desc = "Adds an ammo from inventory system - only takes ammo on reload"

if (CLIENT) then return end

local delay = 0

function PLUGIN:WeaponReloadFinished(entity, isShotgunReload)
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

		--Cheeky
		if ( #ammo == 0 ) then
			timer.Simple(0.5, function() wep:SetClip1(0) end)
		end

		if not isShotgunReload then 
			local ammoInMag = wep:Clip1()
			local maxAmmoInMag = wep:GetMaxClip1()
			local neededAmmo = maxAmmoInMag - ammoInMag
			local foundAmmo = 0
	
			for k,v in pairs(ammo) do
				local ammocount = v:GetData("quantity",0)
	
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
		end
    end
end


hook.Add("WeaponReloadFinished", "Weapon_ReloadFinished", WeaponReloadFinished)

function PLUGIN:ProcessShotgunReload(entity)
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
	
		for k,v in pairs(ammo) do
			local ammocount = v:GetData("quantity",0)-1
	
			if ammocount > 0 then
				v:SetData("quantity", ammocount)
				wepitem:SetData("ammo", wepitem:GetData("ammo", 0))
				break
			else
				v:Remove()
				break
			end
		end
    end
end


hook.Add("ProcessShotgunReload", "Process_ShotgunReload", ProcessShotgunReload)

function PLUGIN:AmmoCheck(client, weapon)
	local ammoCount = 0
	local ammoType = weapon.Primary.Ammo
	
	for k,v in pairs(client:GetChar():GetInv():GetItems()) do
		if v.isAmmo then
			if ammoType == v.ammo then
				ammoCount = ammoCount + v:GetData("quantity",0)
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