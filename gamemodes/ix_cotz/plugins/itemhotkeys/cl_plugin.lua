// creates icons on the hud for the hotkeys
function PLUGIN:HUDPaint()
    local lp = LocalPlayer()
    local icon = Material("stalker/cursor.vmt")

    if (!lp:GetCharacter() or !lp:Alive() or ix.gui.characterMenu:IsVisible() or ix.option.Get("disablehud", false)) then return end

    if lp:GetCharacter():GetHotkeyItemName(1) != "nil" then
        surface.SetDrawColor(Color(83, 83, 83, 100))
        surface.DrawRect(ScrW()*0.05, ScrH()*0.835, ScrW()*0.03, ScrH()*0.05)
        draw.DrawText(string.upper(input.LookupBinding("gm_showhelp", true)), "stalkerregularsmallfont2", ScrW()*0.055, ScrH()*0.835, Color( 193, 136, 21, 255 ), TEXT_ALIGN_CENTER )
    end

    if lp:GetCharacter():GetHotkeyItemName(2) != "nil" then
        surface.SetDrawColor(Color(83, 83, 83, 100))
        surface.DrawRect(ScrW()*0.09, ScrH()*0.835, ScrW()*0.03, ScrH()*0.05)
        draw.DrawText(string.upper(input.LookupBinding("gm_showteam", true)), "stalkerregularsmallfont2", ScrW()*0.095, ScrH()*0.835, Color( 193, 136, 21, 255 ), TEXT_ALIGN_CENTER )
    end

    if lp:GetCharacter():GetHotkeyItemName(3) != "nil" then
        surface.SetDrawColor(Color(83, 83, 83, 100))
        surface.DrawRect(ScrW()*0.13, ScrH()*0.835, ScrW()*0.03, ScrH()*0.05)
        draw.DrawText(string.upper(input.LookupBinding("gm_showspare1", true)), "stalkerregularsmallfont2", ScrW()*0.135, ScrH()*0.835, Color( 193, 136, 21, 255 ), TEXT_ALIGN_CENTER )
    end

    if lp:GetCharacter():GetHotkeyItemName(4) != "nil" then
        surface.SetDrawColor(Color(83, 83, 83, 100))
        surface.DrawRect(ScrW()*0.17, ScrH()*0.835, ScrW()*0.03, ScrH()*0.05)
        draw.DrawText(string.upper(input.LookupBinding("gm_showspare2", true)), "stalkerregularsmallfont2", ScrW()*0.175, ScrH()*0.835, Color( 193, 136, 21, 255 ), TEXT_ALIGN_CENTER )
    end

    
end