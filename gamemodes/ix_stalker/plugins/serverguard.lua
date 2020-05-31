PLUGIN.name = "ServerGuard Permissions"
PLUGIN.author = "alexgrist"
PLUGIN.desc = "Adds CAMI permission compatibility to ServerGuard."

local function OnPrivilegeRegistered(privilege)
    local permission = privilege.Name
    serverguard.permission:Add(permission)

    if (SERVER) then
        local defaultRank = privilege.MinAccess
        defaultRank = defaultRank:sub(1, 1):upper() .. defaultRank:sub(2)

        for rank, _ in pairs(serverguard.ranks:GetStored()) do
            -- we're setting defaults here, so only give permission if it hasn't been manually set already (i.e nil)
            if (serverguard.ranks:HasPermission(rank, permission) == nil and
                (defaultRank == "User" or serverguard.ranks:HasPermission(rank, defaultRank))) then
                serverguard.ranks:GivePermission(rank, permission)
            end
        end
    end
end

local function RegisterPrivileges()
    if (CAMI) then
        -- register privileges that may have been added before we've loaded
        for _, v in pairs(CAMI.GetPrivileges()) do
            OnPrivilegeRegistered(v)
        end
    end
end

hook.Add("CAMI.OnPrivilegeRegistered", "serverguard.CAMI.OnPrivilegeRegistered", OnPrivilegeRegistered)

hook.Add("CAMI.PlayerHasAccess", "serverguard.CAMI.PlayerHasAccess", function(client, privilege, callback)
    callback(not not serverguard.player:HasPermission(client, privilege), "serverguard")
    return true
end)

if (SERVER) then
    hook.Add("serverguard.RanksLoaded", "serverguard.RanksLoaded", RegisterPrivileges)
else
    RegisterPrivileges()
end