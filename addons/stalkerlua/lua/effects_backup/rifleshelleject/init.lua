local defmyname = "RifleShellEject"

local function PlayerCarryingTFAWeapon( ply )
	if !ply then
		if CLIENT then
			if IsValid(LocalPlayer()) then
				ply = LocalPlayer()
			else
				return false, nil, nil
			end
		else	
			return false, nil, nil
		end
	end
	
	local wep = ply:GetActiveWeapon()
	if IsValid(wep) then
		local n=wep:GetClass()
		local nfind=string.find(n,"tfa")
		if (wep.Base and string.find(wep.Base,"tfa_gun_base") ) then
			return true, ply, wep
		end
		return false, ply, wep
	end
	return false, ply, nil
end

function EFFECT:Init(ef)
	if CLIENT then
		local istrue,pl,wep = PlayerCarryingTFAWeapon()
		local vm = pl:GetViewModel()
		if  istrue and (ef:GetEntity() == vm or ef:GetEntity() == wep or ef:GetEntity() == nil ) then
			return
		else
			util.Effect(defmyname, ef, false )
		end
	end
	util.Effect(defmyname, ef, false )
end

function EFFECT:Think()
	return false
end

function EFFECT:Render()

end