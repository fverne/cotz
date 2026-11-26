local PLUGIN = PLUGIN

local LOOT_SOUND = "stalkersound/inv_medkit1.mp3"
local LOOT_TIME = 2
local activeLoots = {}

local function finishLoot(client, operation)
    if activeLoots[client] ~= operation then return end

    activeLoots[client] = nil
    if IsValid(operation.npc) then operation.npc:SetNetVar("beingLooted", false) end
    if IsValid(client) then client:SetNetVar("IsLooting", false) end
end

local function cancelLoot(client, operation)
    if IsValid(operation.npc) then operation.npc:StopSound(LOOT_SOUND) end
    ix.util.PlayerActionInterrupt(client)
    finishLoot(client, operation)
end

function PLUGIN:PlayerButtonDown(client, key)
    local operation = activeLoots[client]
    if key ~= KEY_F or not operation then return end

    cancelLoot(client, operation)
end

function PLUGIN:KeyPress(client, key)
    local operation = activeLoots[client]
    if operation then
        cancelLoot(client, operation)
        return
    end

    local Hit = client:GetEyeTraceNoCursor()
    local npc = Hit.Entity
    local items = client:GetCharacter():GetInventory():GetItems()
    if !(IsValid(npc)) then
        return
    end
    if !npc.cotzHumanCorpse then
        return
    end
    if client:GetCharacter() and client:Alive() then
        if (key == IN_USE) then
            if (npc:IsRagdoll() and npc:GetPos():Distance( client:GetPos() ) <= 55) then
                ix.plugin.list["looting"]:BeginLooting(client, npc)
            end
        end
    end
end
function PLUGIN:BeginLooting(client, npc)
    local weapon = client:GetActiveWeapon()
    if (weapon and weapon:IsValid()) then
        local class = weapon:GetClass()

        if class:find("cw_") then
            if weapon:isReloading() then 
                return client:Notify("You can not loot while you are reloading a weapon!") 
            end
        end
    end

    local char = client:GetCharacter()
    local inv = char:GetInventory()


    --Do animation and spawn loot
    local Hit = client:GetEyeTraceNoCursor()
    local npc = Hit.Entity
    if !(IsValid(npc)) then
        client:Notify("You are not looking at a corpse")
        return
    end
    if npc then
        if (npc:IsRagdoll() and npc:GetPos():Distance(client:GetPos()) <= 55) then
            if !npc.cotzHumanCorpse then
                return
            end

            local lootclass = npc:GetNetVar("loot")
            -- client:Notify(lootclass and lootclass or "nil")
            if lootclass == "" then
                 client:Notify("That corpse has already been looted!")
                 return
            end
            if npc:GetNetVar("beingLooted", false) then
                client:Notify("That corpse is being looted by someone else!")
                return
            end


            npc:SetNetVar("beingLooted", true)
            local operation = {npc = npc}
            activeLoots[client] = operation
            npc:EmitSound(LOOT_SOUND, 60, 120)
            client:SetNetVar("IsLooting", true)

            ix.util.PlayerPerformBlackScreenAction(client, "Looting", LOOT_TIME, function(player)
                if activeLoots[player] ~= operation then return end
                finishLoot(player, operation)
                if not IsValid(npc) then return end

                if lootclass then
                    local position = client:GetItemDropPos()
                    local idat = ix.util.GetRandomItemFromPool(lootclass)

                    client:Notify("You found "..ix.item.list[idat[1]]:GetName())

                    if (IsValid(client) and client:GetCharacter() and not client:GetCharacter():GetInventory():Add(idat[1], 1, idat[2])) then
                        ix.item.SpawnTemporary(idat[1], position, AngleRand(), idat[2])
                        position = position + Vector(0, 0, 5)
                        client:Notify("No space in your inventory! Items have been dropped.")
                    end
                else
                    client:Notify("You found nothing.")
                end
                npc:SetNetVar("loot", "")
            end)

            -- The shared action helper skips its callback when another system interrupts it.
            timer.Simple(LOOT_TIME + 0.1, function()
                finishLoot(client, operation)
            end)
        end
    end
end


