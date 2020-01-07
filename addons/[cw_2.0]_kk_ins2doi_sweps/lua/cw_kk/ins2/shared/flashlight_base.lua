
CustomizableWeaponry_KK.ins2.flashlight = CustomizableWeaponry_KK.ins2.flashlight or {}
function CustomizableWeaponry_KK.ins2.flashlight:IsValid() return true end
CustomizableWeaponry_KK.ins2.flashlight.__index = CustomizableWeaponry_KK.ins2.flashlight

// [IMPULSE 100] BIND PRESS

CustomizableWeaponry_KK.ins2.flashlight.atts = {
	["kk_ins2_anpeq15"] = 2,
	["kk_ins2_m6x"] = 2,
	["kk_ins2_fl_kombo"] = 3,
	["kk_ins2_flashlight"] = 1,
	["kk_ins2_lam"] = 1,
}

function CustomizableWeaponry_KK.ins2.flashlight:hasFL(wep)
	for k,_ in pairs(self.atts) do
		if wep.ActiveAttachments[k] then
			return k
		end
	end
end

local CW2_ATTS = CustomizableWeaponry.registeredAttachmentsSKey

function CustomizableWeaponry_KK.ins2.flashlight:getFL(wep)
	local k = self:hasFL(wep)
	return (k and CW2_ATTS[k] and CW2_ATTS[k].getLEMState) and CW2_ATTS[k]
end

if CLIENT then
	function CustomizableWeaponry_KK.ins2.flashlight:PlayerBindPress(ply, bind, pressed)
		if !pressed then return end
		if !bind:find("impulse 100") then return end

		local wep = ply:GetActiveWeapon()

		if !IsValid(wep) then return end
		if !wep.CW20Weapon then return end

		local hasFL = self:hasFL(wep)
		if !hasFL then return end
		local max = self.atts[hasFL]

		-- if wep.Owner:KeyDown(IN_USE) then
			-- wep._KK_INS2_LAM_MODE = wep._KK_INS2_LAM_MODE - 1
		-- else
			-- wep._KK_INS2_LAM_MODE = wep._KK_INS2_LAM_MODE + 1
		-- end

		-- if wep._KK_INS2_LAM_MODE > max then
			-- wep._KK_INS2_LAM_MODE = 0
		-- elseif wep._KK_INS2_LAM_MODE < 0 then
			-- wep._KK_INS2_LAM_MODE = max
		-- end

		-- wep:EmitSound("CW_KK_INS2_UMP45_FIRESELECT")

		if wep.Owner:KeyDown(IN_USE) then
			ply:ConCommand("_cw_kk_cyclelam r")
		else
			ply:ConCommand("_cw_kk_cyclelam")
		end

		return true
	end

	hook.Add("PlayerBindPress",
		CustomizableWeaponry_KK.ins2.flashlight,
		CustomizableWeaponry_KK.ins2.flashlight.PlayerBindPress
	)
end

if SERVER then
	local wep

	function CustomizableWeaponry_KK.ins2.flashlight:PlayerBindPress(ply, cmd, args, argStr)
		if !IsValid(ply) then return end

		wep = ply:GetActiveWeapon()
		if !IsValid(wep) then return end
		if !wep.CW20Weapon then return end

		local hasFL = self:hasFL(wep)
		if !hasFL then return end
		local max = self.atts[hasFL]

		-- if #args > 0 then
			-- wep.dt.INS2LAMMode = wep.dt.INS2LAMMode - 1
		-- else
			-- wep.dt.INS2LAMMode = wep.dt.INS2LAMMode + 1
		-- end

		-- if wep.dt.INS2LAMMode > max then
			-- wep.dt.INS2LAMMode = 0
		-- elseif wep.dt.INS2LAMMode < 0 then
			-- wep.dt.INS2LAMMode = max
		-- end

		if #args > 0 then
			wep:SetNWInt("INS2LAMMode", wep:GetNWInt("INS2LAMMode") - 1)
		else
			wep:SetNWInt("INS2LAMMode", wep:GetNWInt("INS2LAMMode") + 1)
		end

		if wep:GetNWInt("INS2LAMMode") > max then
			wep:SetNWInt("INS2LAMMode", 0)
		elseif wep:GetNWInt("INS2LAMMode") < 0 then
			wep:SetNWInt("INS2LAMMode", max)
		end

		wep:EmitSound("CW_KK_INS2_UMP45_FIRESELECT")
	end

	concommand.Add("_cw_kk_cyclelam", function(...)
		CustomizableWeaponry_KK.ins2.flashlight:PlayerBindPress(...)
	end)
end

if SERVER then
	local wep

	function CustomizableWeaponry_KK.ins2.flashlight:Think()
		for _,ply in pairs(player.GetAll()) do
			wep = ply:GetActiveWeapon()

			--if !IsValid(wep) then return end
			--if !wep.CW20Weapon then return end
			if IsValid(wep) and wep.CW20Weapon then 
				if self:hasFL(wep) then 
					ply:AllowFlashlight(true)
					return
				end
			end
		end
	end
	hook.Add("Think", CustomizableWeaponry_KK.ins2.flashlight, CustomizableWeaponry_KK.ins2.flashlight.Think)
end
