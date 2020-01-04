PLUGIN.name = "Ammo"
PLUGIN.author = "Lt. Taylor"
PLUGIN.desc = "Adds an ammo from inventory system"

if (CLIENT) then return end

local delay = 0

function PLUGIN:WeaponFired(entity)
    if entity:IsPlayer() then
		local wep = entity:GetActiveWeapon()
		local wepclass = wep:GetClass()
		local ammo
		local newdura = 0
		
		for k,v in pairs(entity:GetChar():GetInv():GetItems()) do
			if v.isAmmo == true then
				if wep.Primary.Ammo == v.ammo then
					ammo = v
				end
			end
		end
		
		local ammoCount = ammo:GetData("quantity")
		if ammoCount == 1 then
			ammo:Remove()
		end
		
		local newAmmo = ammoCount - 1
		
		if delay < CurTime() then
			delay = CurTime() + 3
			ammo:SetData("quantity",newAmmo)
		else
			ammo:SetData("quantity",newAmmo,nil,true)
		end
    end
end

hook.Add("WeaponFired", "Weapon_Fired", WeaponFired)

function PLUGIN:AmmoCheck(client, weapon)
	local ammoCount = 0
	local ammoType = weapon.Primary.Ammo
	
	for k,v in pairs(client:GetChar():GetInv():GetItems()) do
		if v.isAmmo == true then
			if ammoType == v.ammo then
				ammoCount = ammoCount + v:GetData("quantity",1)
			end
		end
	end
	
	if ammoCount > 0 then
		client:SetAmmo(ammoCount - weapon:Clip1(),ammoType)
	else
		client:SetAmmo(0,ammoType)
		weapon:SetClip1(0)
	end
end

hook.Add("AmmoCheck", "Ammo_Check", AmmoCheck)