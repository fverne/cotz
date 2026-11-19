// creates icons on the hud for the hotkeys
function PLUGIN:HUDPaint()
    local lp = LocalPlayer()
    local char = lp:GetCharacter()
    if (!char or !lp:Alive() or ix.gui.characterMenu:IsVisible() or ix.option.Get("disablehud", false)) then return end
    local inv = char:GetInventory() --LAGGY??
    local hotkeys = ix.plugin.Get("itemhotkeys")
    local itemname, item, icon

    local boxheight = ScrH()*0.05
    local boxwidth = ScrW()*0.03

    local itemboxwidth
    local itemboxheight
    local items, count

    -- Hotkey 1
    surface.SetDrawColor(Color(142, 142, 142, 5))
    surface.DrawRect(ScrW()*0.05, ScrH()*0.835, boxwidth, boxheight)

    itemname = char:GetHotkeyItemName(1)
    if itemname != "nil" and itemname then
        count = 0
        items = inv:GetItemsByUniqueID(itemname)
        if #items ~= 0 then
            for k, v in pairs(hotkeys.hotkeyitems) do
                if items[1].uniqueID == k then
                    for _, j in pairs(items) do
                        if j:GetData("cooldown",0) < os.time() then
                            count = count + j:GetData("quantity", j.quantity or 1)
                        end
                    end
                end
            end
        end
        item = ix.item.list[itemname]
        icon = ix.util.GetItemIcon(item)

        if !icon then
            icon = Material("vgui/icons/art.png")
        end

        if item then
            itemboxwidth = boxwidth / item.height
            itemboxheight = boxheight / item.width
        else
            itemboxwidth = boxwidth
            itemboxheight = boxheight
        end

        surface.SetDrawColor(Color(255, 255, 255, 255))
        surface.SetMaterial(icon)
        surface.DrawTexturedRect(ScrW()*0.05 + ((boxwidth * 0.5) - (itemboxwidth * 0.5)), ScrH()*0.835 + ((boxheight * 0.5) - (itemboxheight * 0.5)), itemboxwidth, itemboxheight)
        draw.DrawText(count, "stalkerregularsmallfont2", ScrW()*0.052, ScrH()*0.865, Color( 193, 136, 21, 255 ), TEXT_ALIGN_LEFT )
    end
    draw.DrawText(string.upper(input.LookupBinding("gm_showhelp", true) or "N/A"), "stalkerregularsmallfont2", ScrW()*0.052, ScrH()*0.835, Color( 193, 136, 21, 255 ), TEXT_ALIGN_LEFT )
    -- Hotkey 2
    surface.SetDrawColor(Color(142, 142, 142, 5))
    surface.DrawRect(ScrW()*0.09, ScrH()*0.835, ScrW()*0.03, ScrH()*0.05)

    itemname = char:GetHotkeyItemName(2)
    if itemname != "nil" and itemname then
        count = 0
        items = inv:GetItemsByUniqueID(itemname)
        if #items ~= 0 then
            for k, v in pairs(hotkeys.hotkeyitems) do
                if items[1].uniqueID == k then
                    for _, j in pairs(items) do
                        if j:GetData("cooldown",0) < os.time() then
                            count = count + j:GetData("quantity", j.quantity or 1)
                        end
                    end
                end
            end
        end
        item = ix.item.list[itemname]
        icon = ix.util.GetItemIcon(item)

        if !icon then
            icon = Material("vgui/icons/art.png")
        end

        if item then
            itemboxwidth = boxwidth / item.height
            itemboxheight = boxheight / item.width
        else
            itemboxwidth = boxwidth
            itemboxheight = boxheight
        end

        surface.SetDrawColor(Color(255, 255, 255, 255))
        surface.SetMaterial(icon)
        surface.DrawTexturedRect(ScrW()*0.09 + ((boxwidth * 0.5) - (itemboxwidth * 0.5)), ScrH()*0.835 + ((boxheight * 0.5) - (itemboxheight * 0.5)), itemboxwidth, itemboxheight)
        draw.DrawText(count, "stalkerregularsmallfont2", ScrW()*0.092, ScrH()*0.865, Color( 193, 136, 21, 255 ), TEXT_ALIGN_LEFT )
    end
    draw.DrawText(string.upper(input.LookupBinding("gm_showteam", true) or "N/A"), "stalkerregularsmallfont2", ScrW()*0.092, ScrH()*0.835, Color( 193, 136, 21, 255 ), TEXT_ALIGN_LEFT )

    -- Hotkey 3
    surface.SetDrawColor(Color(142, 142, 142, 5))
    surface.DrawRect(ScrW()*0.13, ScrH()*0.835, ScrW()*0.03, ScrH()*0.05)

    itemname = char:GetHotkeyItemName(3)
    if itemname != "nil" and itemname then
        count = 0
        items = inv:GetItemsByUniqueID(itemname)
        if #items ~= 0 then
            for k, v in pairs(hotkeys.hotkeyitems) do
                if items[1].uniqueID == k then
                    for _, j in pairs(items) do
                        if j:GetData("cooldown",0) < os.time() then
                            count = count + j:GetData("quantity", j.quantity or 1)
                        end
                    end
                end
            end
        end
        item = ix.item.list[itemname]
        icon = ix.util.GetItemIcon(item)

        if !icon then
            icon = Material("vgui/icons/art.png")
        end

        if item then
            itemboxwidth = boxwidth / item.height
            itemboxheight = boxheight / item.width
        else
            itemboxwidth = boxwidth
            itemboxheight = boxheight
        end

        surface.SetDrawColor(Color(255, 255, 255, 255))
        surface.SetMaterial(icon)
        surface.DrawTexturedRect(ScrW()*0.13 + ((boxwidth * 0.5) - (itemboxwidth * 0.5)), ScrH()*0.835 + ((boxheight * 0.5) - (itemboxheight * 0.5)), itemboxwidth, itemboxheight)
        draw.DrawText(count, "stalkerregularsmallfont2", ScrW()*0.132, ScrH()*0.865, Color( 193, 136, 21, 255 ), TEXT_ALIGN_LEFT )
    end
    draw.DrawText(string.upper(input.LookupBinding("gm_showspare1", true) or "N/A"), "stalkerregularsmallfont2", ScrW()*0.132, ScrH()*0.835, Color( 193, 136, 21, 255 ), TEXT_ALIGN_LEFT )

    -- Hotkey 4
    surface.SetDrawColor(Color(142, 142, 142, 5))
    surface.DrawRect(ScrW()*0.17, ScrH()*0.835, ScrW()*0.03, ScrH()*0.05)

    itemname = char:GetHotkeyItemName(4)
    if itemname != "nil" and itemname then
        count = 0
        items = inv:GetItemsByUniqueID(itemname)
        if #items ~= 0 then
            for k, v in pairs(hotkeys.hotkeyitems) do
                if items[1].uniqueID == k then
                    for _, j in pairs(items) do
                        if j:GetData("cooldown",0) < os.time() then
                            count = count + j:GetData("quantity", j.quantity or 1)
                        end
                    end
                end
            end
        end
        item = ix.item.list[itemname]
        icon = ix.util.GetItemIcon(item)

        if !icon then
            icon = Material("vgui/icons/art.png")
        end

        if item then
            itemboxwidth = boxwidth / item.height
            itemboxheight = boxheight / item.width
        else
            itemboxwidth = boxwidth
            itemboxheight = boxheight
        end

        surface.SetDrawColor(Color(255, 255, 255, 255))
        surface.SetMaterial(icon)
        surface.DrawTexturedRect(ScrW()*0.17 + ((boxwidth * 0.5) - (itemboxwidth * 0.5)), ScrH()*0.835 + ((boxheight * 0.5) - (itemboxheight * 0.5)), itemboxwidth, itemboxheight)
        draw.DrawText(count, "stalkerregularsmallfont2", ScrW()*0.172, ScrH()*0.865, Color( 193, 136, 21, 255 ), TEXT_ALIGN_LEFT )
    end
    draw.DrawText(string.upper(input.LookupBinding("gm_showspare2", true) or "N/A"), "stalkerregularsmallfont2", ScrW()*0.172, ScrH()*0.835, Color( 193, 136, 21, 255 ), TEXT_ALIGN_LEFT )

end