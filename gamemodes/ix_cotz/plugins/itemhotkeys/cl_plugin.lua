// creates icons on the hud for the hotkeys
function PLUGIN:HUDPaint()
    local lp = LocalPlayer()

    if (!lp:GetCharacter() or !lp:Alive() or ix.gui.characterMenu:IsVisible() or ix.option.Get("disablehud", false)) then return end

    local itemname, item, icon

    local boxheight = ScrH()*0.05
    local boxwidth = ScrW()*0.03

    local itemboxwidth
    local itemboxheight

    -- Hotkey 1
    surface.SetDrawColor(Color(142, 142, 142, 5))
    surface.DrawRect(ScrW()*0.05, ScrH()*0.835, boxwidth, boxheight)

    itemname = lp:GetCharacter():GetHotkeyItemName(1)
    if itemname != "nil" and itemname then
        item = ix.item.list[itemname]
        icon = ix.util.GetItemIcon(item)

        if !icon then
            return
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
    end
    draw.DrawText(string.upper(input.LookupBinding("gm_showhelp", true) or "N/A"), "stalkerregularsmallfont2", ScrW()*0.055, ScrH()*0.835, Color( 193, 136, 21, 255 ), TEXT_ALIGN_CENTER )

    -- Hotkey 2
    surface.SetDrawColor(Color(142, 142, 142, 5))
    surface.DrawRect(ScrW()*0.09, ScrH()*0.835, ScrW()*0.03, ScrH()*0.05)

    itemname = lp:GetCharacter():GetHotkeyItemName(2)
    if itemname != "nil" and itemname then
        item = ix.item.list[itemname]
        icon = ix.util.GetItemIcon(item)

        if !icon then
            return
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
    end
    draw.DrawText(string.upper(input.LookupBinding("gm_showteam", true) or "N/A"), "stalkerregularsmallfont2", ScrW()*0.095, ScrH()*0.835, Color( 193, 136, 21, 255 ), TEXT_ALIGN_CENTER )

    -- Hotkey 3
    surface.SetDrawColor(Color(142, 142, 142, 5))
    surface.DrawRect(ScrW()*0.13, ScrH()*0.835, ScrW()*0.03, ScrH()*0.05)

    itemname = lp:GetCharacter():GetHotkeyItemName(3)
    if itemname != "nil" and itemname then
        item = ix.item.list[itemname]
        icon = ix.util.GetItemIcon(item)

        if !icon then
            return
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
    end
    draw.DrawText(string.upper(input.LookupBinding("gm_showspare1", true) or "N/A"), "stalkerregularsmallfont2", ScrW()*0.135, ScrH()*0.835, Color( 193, 136, 21, 255 ), TEXT_ALIGN_CENTER )

    -- Hotkey 4
    surface.SetDrawColor(Color(142, 142, 142, 5))
    surface.DrawRect(ScrW()*0.17, ScrH()*0.835, ScrW()*0.03, ScrH()*0.05)

    itemname = lp:GetCharacter():GetHotkeyItemName(4)
    if itemname != "nil" and itemname then
        item = ix.item.list[itemname]
        icon = ix.util.GetItemIcon(item)

        if !icon then
            return
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
    end
    draw.DrawText(string.upper(input.LookupBinding("gm_showspare2", true) or "N/A"), "stalkerregularsmallfont2", ScrW()*0.175, ScrH()*0.835, Color( 193, 136, 21, 255 ), TEXT_ALIGN_CENTER )

end