PLUGIN.name = "NPC Looting"
PLUGIN.desc = "Looting dead npcs - uses randomitemlib"
PLUGIN.author = "fverne"

PLUGIN.HumanModels = {
    "models/bandit/bandit_regulare.mdl",
    "models/bandit/bandit_veteran.mdl",
    "models/bandit/bandit_novice.mdl",
}


if CLIENT then
    function PLUGIN:KeyPress(client, key)
        local hit = client:GetEyeTraceNoCursor()
        local ragdoll = hit.Entity

        if client:GetCharacter() and client:Alive() and key == IN_USE then
            if IsFirstTimePredicted() and ragdoll:IsRagdoll() and ragdoll:GetPos():Distance( client:GetPos() ) <= 55 then

                if !table.HasValue(self.HumanModels, ragdoll:GetModel()) then
                    return
                end

                local lootclass
                if ragdoll:GetNetVar("loot") then
                    lootclass = ragdoll:GetNetVar("loot")
                else
                    client:Notify("That corpse does not have any loot.")
                    return
                end
                self:OpenLootMenu(client, lootclass)
            end
        end
    end

    function PLUGIN:OpenLootMenu(client, lootclass)
        --netstream.Start("ix_npcLootOpen", client, lootclass)
        local frame = vgui.Create("ixStalkerFrame")
        frame:SetTitle( "" )
        frame:SetVisible( true )
        frame:SetDraggable( true )
        frame:Center()
        frame:MakePopup()
        frame:SetSize(ScrW()*0.2, ScrH()*0.3)
        frame:SetPos((ScrW()/2)-ScrW()*0.15,(ScrH()/2)-ScrH()*0.2)
            
        local btn = frame:Add("ixStalkerButton")
        btn:SetText("Search Pockets")
        btn:SetFont("stalkerregularfont")
        btn:SetTall(ScrH()*0.05)
        btn:SetWide(ScrW()*0.15)


        function btn.DoClick()
            if (CLIENT) and (IsValid(ix.gui.menu)) then
                ix.gui.menu:Remove()
            end
            netstream.Start("doLoot", lootclass)
            frame:Close()
        end

        frame:PostLayoutUpdate()
        btn:Center()

    end
end

if SERVER then
    netstream.Hook("doLoot", function(client, lootclass)

        local hit = client:GetEyeTraceNoCursor()
        local ragdoll = hit.Entity

        if !(ragdoll and ragdoll:GetNetVar("loot") == lootclass) then
            client:Notify("You are not looking at a corpse")
            return
        end

        client:EmitSound("stalkersound/inv_open.mp3")

        local position = client:GetItemDropPos()
        local idat = ix.util.GetRandomItemFromPool(lootclass)

        client:Notify("You found "..ix.item.list[idat[1]]:GetName())

        if (IsValid(client) and client:GetCharacter() and not client:GetCharacter():GetInventory():Add(idat[1], 1, idat[2])) then
            ix.item.Spawn(idat[1], position, nil, AngleRand(), idat[2])
            position = position + Vector(0, 0, 5)
            client:Notify("No space in your inventory! Items have been dropped.")
        end

        ragdoll:SetNetVar("loot", nil)
    end)
end