    local _SelectFiremode
    -- Prevents firemode cycling
    local function setCyclingAllowed(weapon, allowed)
        if (!IsValid(weapon)) then return end
 
        if (allowed) then
            if (_SelectFiremode) then
                weapon.SelectFiremode = _SelectFiremode
                _SelectFiremode = nil
            end
        else
            _SelectFiremode = _SelectFiremode or weapon.SelectFiremode
            weapon.SelectFiremode = function() end
        end
    end
 
    -- We can't get the owner in this hook, which is why we don't use setWepRaised here
    function PLUGIN:WeaponEquip(weapon)
        if (!IsValid(weapon)) then return end
 
        if (string.sub(weapon:GetClass(), 1, 3) == "cw_") then
            weapon:SelectFiremode("safe")
            --setCyclingAllowed(weapon, false)
        end
    end
 
    local playerMeta = FindMetaTable("Player")
 
    -- Sets whether or not the weapon is raised. (REDEFINITION: original at nutscript/gamemode/core/sh_util.lua)
    function playerMeta:SetWepRaised(state)
        -- Sets the networked variable for being raised.
        self:SetNetVar("raised", state)
 
        local weapon = self:GetActiveWeapon()
        if (!IsValid(weapon)) then return end
 
        -- Delays any weapon shooting.
        --weapon:SetNextPrimaryFire(CurTime() + 1)
        --weapon:SetNextSecondaryFire(CurTime() + 1)
 
        if (string.sub(weapon:GetClass(), 1, 3) == "cw_") then
            if (state) then
                --setCyclingAllowed(weapon, true)
                weapon:SelectFiremode(weapon.FireModes[1])
            else
                weapon:SelectFiremode("safe")
                --setCyclingAllowed(weapon, false)
            end
        end
    end
