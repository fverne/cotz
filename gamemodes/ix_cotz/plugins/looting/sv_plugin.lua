local PLUGIN = PLUGIN

PLUGIN.HumanModels = {
    --bandit
    "models/bandit/bandit_regulare.mdl",
    "models/bandit/bandit_veteran.mdl",
    "models/bandit/bandit_novice.mdl",

    --zombifiedbandit
    "models/zombied/zombi_novice.mdl",
    "models/zombied/zombi_novice2.mdl",
    "models/zombied/zombiestalker2a.mdl",
    "models/zombied/zombiestalker2.mdl",

    --mercs
    "models/killer/killer.mdl",
    "models/killer/mask.mdl",

    --zombified mercs
    "models/zombied/zombifiedstalker3.mdl",

    --military
    "models/military/soldier.mdl",
    "models/military/elita.mdl",

    --zombified military
    "models/zombied/berillzombie.mdl",
    "models/zombied/zombi_spec.mdl",
    "models/zombied/zombi_skat.mdl",
}

function PLUGIN:PlayerButtonDown(client,key)
    local Hit = client:GetEyeTraceNoCursor()
    local npc = Hit.Entity
    if (client:GetNetVar("isLooting") == true && key == KEY_F ) then
       ix.util.PlayerActionInterrupt(client)
       npc:SetNetVar("beingLooted",false)
    end
end

function PLUGIN:KeyPress(client, key)
    if (client:GetNetVar("isLooting") == true ) then
       ix.util.PlayerActionInterrupt(client)
    end

    local Hit = client:GetEyeTraceNoCursor()
    local npc = Hit.Entity
    local items = client:GetCharacter():GetInventory():GetItems()
    if !(npc) or !(table.HasValue(self.HumanModels, npc:GetModel())) then
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
    if !(npc) then
        client:Notify("You are not looking at a corpse")
        return
    end
    if npc then
        if (npc:IsRagdoll() and npc:GetPos():Distance(client:GetPos()) <= 55) then
            if !(table.HasValue(self.HumanModels, npc:GetModel())) then
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
            npc:EmitSound("stalkersound/inv_medkit1.mp3",60,120)
            client:SetNetVar("isLooting", true)

            timer.Simple(2, function()
                if (IsValid(npc)) then
                    npc:SetNetVar("beingLooted", false)
                end
            end)

            ix.util.PlayerPerformBlackScreenAction(client, "Looting", 2, function(player)
                if not player:GetNetVar("isLooting") then
                    npc:StopSound("stalkersound/inv_medkit1.mp3")
                    return
                end
                if lootclass then
                    local position = client:GetItemDropPos()
                    local idat = ix.util.GetRandomItemFromPool(lootclass)

                    client:Notify("You found "..ix.item.list[idat[1]]:GetName())

                    if (IsValid(client) and client:GetCharacter() and not client:GetCharacter():GetInventory():Add(idat[1], 1, idat[2])) then
                        ix.item.Spawn(idat[1], position, nil, AngleRand(), idat[2])
                        position = position + Vector(0, 0, 5)
                        client:Notify("No space in your inventory! Items have been dropped.")
                    end
                else
                    client:Notify("You found nothing.")
                end
                npc:SetNetVar("loot", "")
            end)
        end
    end
end


