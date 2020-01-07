PLUGIN.name = "CW2.0 Raise/Lower"
PLUGIN.author = "Verne & Lt. Taylor"
PLUGIN.desc = "Allows the use of CW2.0 weapons."

    -- We can't get the owner in this hook, which is why we don't use setWepRaised here
function PLUGIN:WeaponEquip(weapon)
    if (!IsValid(weapon)) then return end
 
    if (string.sub(weapon:GetClass(), 1, 3) == "cw_") then
		weapon:SetSafe(true)
    end
end
 
local playerMeta = FindMetaTable("Player")
 
-- Sets whether or not the weapon is raised. (REDEFINITION: original at nutscript/gamemode/core/sh_util.lua)
function playerMeta:SetWepRaised(state)
    -- Sets the networked variable for being raised.
    self:SetNetVar("raised", state)
    local weapon = self:GetActiveWeapon()
    if (!IsValid(weapon)) then return end
    if (string.sub(weapon:GetClass(), 1, 3) == "cw_") then
        if (state) then
            weapon:SetSafe(false)
        else
			weapon:SetSafe(true)
        end
    end
end
