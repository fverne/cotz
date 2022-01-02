local reg = debug.getregistry()
local GetActiveWeapon = reg.Player.GetActiveWeapon
local GetRunSpeed = reg.Player.GetRunSpeed
local GetWalkSpeed = reg.Player.GetWalkSpeed
local GetCrouchedWalkSpeed = reg.Player.GetCrouchedWalkSpeed
local Crouching = reg.Player.Crouching

local function CW_Move(ply, m)
    if Crouching(ply) then
        local wep = GetActiveWeapon(ply)

        if IsValid(wep) and wep.CW20Weapon then
            if wep.dt and wep.dt.State == CW_AIMING then
                m:SetMaxSpeed((GetWalkSpeed(ply) * GetCrouchedWalkSpeed(ply) - wep.SpeedDec * 0.5))
            end
        end
    else
        local wep = GetActiveWeapon(ply)

        if IsValid(wep) and wep.CW20Weapon then
            if wep.dt and wep.dt.State == CW_AIMING then
                m:SetMaxSpeed((GetWalkSpeed(ply) - wep.SpeedDec) * 0.75)
            else
                if (not ply:GetNetVar("brth") == true) then
                    m:SetMaxSpeed(GetRunSpeed(ply) - wep.SpeedDec)
                else
                    if (ply:GetNetVar("brth") == true) then
                        m:SetMaxSpeed(GetWalkSpeed(ply))
                    else
                        m:SetMaxSpeed(GetRunSpeed(ply))
                    end
                end
            end
        end
    end
end

hook.Add("Move", "CW_Move", CW_Move)

local function CW_StartCommand(ply, ucmd)
	local wep = GetActiveWeapon(ply)

	if IsValid(wep) and wep.CW20Weapon then
		if wep == wep.SwitchWep then
			wep.SwitchWep = nil
		end

		local switchTo = wep.SwitchWep

		if IsValid(switchTo) then
			ucmd:SelectWeapon(switchTo)
		else
			wep.SwitchWep = nil
		end
	end
end

hook.Add("StartCommand", "CW_StartCommand", CW_StartCommand)
