local function bankingmenu()
    local function inQuad(fraction, beginning, change)
        return change * (fraction ^ 2) + beginning
    end

    local hudhide = ix.option.Get("disablehud", false)

    if not hudhide then
        ix.option.Set("disablehud", true)
    end

    inventoryframe = vgui.Create("DFrame")
    inventoryframe:SetTitle("")
    inventoryframe:SetSize(ScrW(), ScrH())
    inventoryframe:SetPos(0, 0)
    inventoryframe:ShowCloseButton(false)
    inventoryframe:SetDraggable(false)
    inventoryframe:MakePopup()

    function inventoryframe:OnRemove()
        if (IsValid(ownPanel)) then
            ownPanel:Remove()

            if not hudhide then
                ix.option.Set("disablehud", false)
            end
        end
    end

    inventoryframe.Paint = function(pnl, w, h)
        draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 210))
        surface.SetMaterial(Material("vgui/hsv-brightness", "noclamp smooth"))
        surface.SetDrawColor(255, 255, 255, 50)
        surface.DrawTexturedRectUV(0, 0, ScrW(), ScrH(), 0, 0, 1, 1)
    end

    local Panel = vgui.Create("DPanel", inventoryframe)
    Panel:SetPos(0, 1)
    Panel:SetSize(3000, 3000)
    Panel.Paint = function(s, w, d) end
    local icon = vgui.Create("DModelPanel", Panel)
    icon:SetSize(1800, 1120)
    icon:SetPos(40, 0)
    icon:SetModel("models/z-o-m-b-i-e/st/shkaf/st_seif_02.mdl") -- you can only change colors on playermodels

    -- disables default rotation
    function icon:LayoutEntity(Entity)
        return
    end

    icon:SetFOV(22)
    icon:SetCamPos(Vector(0, 280, 40))
    decidecolor = Color(255, 255, 255, 50)
    ItemBankDraw = vgui.Create("DPanel", inventoryframe)
    ItemBankDraw:SetSize(ScrW() / 8, ScrH() / 11)
    ItemBankDraw:SetPos(ScrW() / 2 - ScrW() / 16, ScrH() / 2 + 80)

    ItemBankDraw.Paint = function(s, w, h)
        local panel_cont_one_x, panel_cont_one_y = ItemBankDraw:GetSize()
        local gradientright = Material("vgui/gradient-r", "noclamp smooth")
        surface.SetDrawColor(0, 0, 0, 255)
        surface.DrawRect(0, 0, panel_cont_one_x, panel_cont_one_y)
        surface.SetMaterial(gradientright)
        surface.SetDrawColor(255, 255, 255, 90)
        surface.DrawTexturedRect(0, 0, panel_cont_one_x, panel_cont_one_y)
        surface.SetDrawColor(decidecolor)
        surface.DrawOutlinedRect(0, 0, panel_cont_one_x, panel_cont_one_y, 1)
        surface.SetFont("stalkerregulartitlefont")
        surface.SetTextColor(255, 255, 255)
        surface.SetTextPos(ScrW() / 13, ScrH() / 22)
        surface.DrawText("Item Bank")
    end

    ItemBankDrawIcon = vgui.Create("DModelPanel", ItemBankDraw)
    ItemBankDrawIcon:SetModel("models/lostsignalproject/items/misc/small_wood_box.mdl")
    ItemBankDrawIcon:SetSize(100, 100)
    ItemBankDrawIcon:SetPos(20, 0)
    ItemBankDrawIcon:SetFOV(20)
    ItemBankDrawIcon:SetLookAt(Vector(0, 0, 0))
    ItemBankDrawIcon:SetCamPos(Vector(0, 90, 20))
    ItemBankDrawIcon:SetDirectionalLight(BOX_TOP, Color(255, 255, 255))
    ItemBankDrawIcon:SetDirectionalLight(BOX_FRONT, Color(255, 255, 255))

    -- disables default rotation	
    function ItemBankDrawIcon:LayoutEntity(Entity)
        return
    end

    function RunKeyAnim()
        KeyFrame = vgui.Create("DFrame", inventoryframe)
        KeyFrame:SetSize(500, 500)
        KeyFrame:SetPos(0, 465)
        KeyFrame:SetTitle("")
        KeyFrame:ShowCloseButton(false)
        KeyFrame:SetDraggable(false)

        function KeyFrame.Paint(s, w, h)
        end

        KeyAnim = vgui.Create("DModelPanel", KeyFrame)
        KeyAnim:SetSize(350, 200)
        KeyAnim:SetPos(0, 0)
        KeyAnim:SetAlpha(0)
        KeyAnim:AlphaTo(255, 1, 0)
        KeyAnim:SetModel("models/lostsignalproject/items/quest/key.mdl")
        KeyAnim:SetLookAt(Vector(0, 0, 0))
        KeyAnim:SetCamPos(Vector(-0, -100, -200))
        KeyAnim:SetDirectionalLight(BOX_TOP, Color(0, 0, 0))
        KeyAnim:SetDirectionalLight(BOX_BACK, Color(0, 0, 0))
        KeyAnim:SetDirectionalLight(BOX_FRONT, Color(0, 0, 0))
        KeyAnim:SetDirectionalLight(BOX_BOTTOM, Color(180, 180, 180, 200))
        KeyAnim:SetFOV(2)
        KeyAnim:MoveToFront()

        -- disables default rotation
        function KeyAnim:LayoutEntity(Entity)
            return
        end

        local anim = Derma_Anim("EaseInQuad", KeyFrame, function(pnl, anim, delta, data)
            pnl:SetPos(inQuad(delta, 0, 400), 465) -- Change the X coordinate from 200 to 200+600
        end)

        anim:Start(2) -- Animate for two seconds

        KeyFrame.Think = function(self)
            if anim:Active() then
                anim:Run()
            end
        end
    end

    local DermaButton = vgui.Create("DButton", inventoryframe) -- Create the button and parent it to the frame
    DermaButton:SetText("") -- Set the text on the button
    DermaButton:SetPos(ScrW() / 2 - ScrW() / 16, ScrH() / 2 + 80) -- Set the position on the frame
    DermaButton:SetSize(ScrW() / 8, ScrH() / 11)
    DermaButton.Paint = function(s, w, h) end -- Set the size

    DermaButton.DoClick = function()
        if (not IsValid(ownPanel)) then
            RunKeyAnim()
            OpenItemBank()
        end
    end

    DermaButton.Think = function()
        if DermaButton:IsHovered() then
            decidecolor = Color(255, 255, 255, 150)
        else
            decidecolor = Color(255, 255, 255, 50)
        end
    end

    UpgradeBankDraw = vgui.Create("DPanel", inventoryframe)
    UpgradeBankDraw:SetSize(ScrW() / 8, ScrH() / 22)
    UpgradeBankDraw:SetPos(ScrW() / 2 - ScrW() / 16, ScrH() / 2 + 190)

    UpgradeBankDraw.Paint = function(s, w, h)
        local panel_cont_one_x, panel_cont_one_y = UpgradeBankDraw:GetSize()
        local gradientright = Material("vgui/gradient-r", "noclamp smooth")
        surface.SetDrawColor(0, 0, 0, 255)
        surface.DrawRect(0, 0, panel_cont_one_x, panel_cont_one_y)
        surface.SetMaterial(gradientright)
        surface.SetDrawColor(255, 255, 255, 90)
        surface.DrawTexturedRect(0, 0, panel_cont_one_x, panel_cont_one_y)
        surface.SetDrawColor(decidecolor2)
        surface.DrawOutlinedRect(0, 0, panel_cont_one_x, panel_cont_one_y, 1)
        surface.SetFont("stalkerregularsmallfont2")
        surface.SetTextColor(255, 255, 255)
        surface.SetTextPos(ScrW() / 23, 14)
        surface.DrawText("Upgrade Bank (RU500)")
    end

    UpgradeDrawIcon = vgui.Create("DModelPanel", UpgradeBankDraw)
    UpgradeDrawIcon:SetModel("models/kek1ch/money_ukraina.mdl")
    UpgradeDrawIcon:SetSize(50, 50)
    UpgradeDrawIcon:SetPos(20, 0)
    UpgradeDrawIcon:SetFOV(25)
    UpgradeDrawIcon:SetLookAt(Vector(0, 0, 0))
    UpgradeDrawIcon:SetCamPos(Vector(0, 0, 20))
    UpgradeDrawIcon:SetDirectionalLight(BOX_TOP, Color(255, 255, 255))
    UpgradeDrawIcon:SetDirectionalLight(BOX_FRONT, Color(255, 255, 255))

    function UpgradeDrawIcon:LayoutEntity(Entity)
        return
    end

    decidecolor2 = Color(255, 255, 255, 50)
    local UpgradeButton = vgui.Create("DButton", inventoryframe) -- Create the button and parent it to the frame
    UpgradeButton:SetText("") -- Set the text on the button -- Set the position on the frame
    UpgradeButton:SetSize(ScrW() / 8, ScrH() / 22)
    UpgradeButton:SetPos(ScrW() / 2 - ScrW() / 16, ScrH() / 2 + 190)
    UpgradeButton.Paint = function(s, w, h) end -- Set the size

    UpgradeButton.DoClick = function()
        if (not IsValid(ownPanel)) then
            netstream.Start("PlayerItemBankUpgrade")
        end
    end

    UpgradeButton.Think = function()
        if UpgradeButton:IsHovered() then
            decidecolor2 = Color(255, 255, 255, 150)
        else
            decidecolor2 = Color(255, 255, 255, 50)
        end
    end

    stashlvl = LocalPlayer():GetCharacter():GetData("itemBankUpgradeStage")
    HeaderPanel = vgui.Create("DPanel", inventoryframe)
    HeaderPanel:SetSize(ScrW() / 8, ScrH() / 22)
    HeaderPanel:SetPos(ScrW() / 2 - ScrW() / 16, ScrH() / 3.2)

    function HeaderPanel.Paint(s, w, h)
        local panel_cont_one_x, panel_cont_one_y = HeaderPanel:GetSize()
        local gradientright = Material("vgui/gradient-r", "noclamp smooth")
        surface.SetDrawColor(0, 0, 0, 200)
        surface.DrawRect(0, 0, panel_cont_one_x, panel_cont_one_y)
        surface.SetDrawColor(255, 255, 255, 50)
        surface.DrawOutlinedRect(0, 0, panel_cont_one_x, panel_cont_one_y, 1)
        surface.SetFont("stalkerregularsmallfont2")
        surface.SetTextColor(255, 255, 255)
        surface.SetTextPos(panel_cont_one_x / 2 - 70, panel_cont_one_y / 2 - 10)
        surface.DrawText("Bank Upgrade Stage (" .. stashlvl .. "/3)")
    end

    function HeaderPanel:Think()
        stashlvl = LocalPlayer():GetCharacter():GetData("itemBankUpgradeStage")
    end

    function OpenItemBank()
        DermaButton:Remove()
        UpgradeButton:Remove()  
        -- execute this code only onc
        inventoryframe:SetMouseInputEnabled(false)
        StartingFrame = vgui.Create("DFrame")
        StartingFrame:SetSize(ScrW(), ScrH())
        StartingFrame:Center()
        StartingFrame:SetTitle("")
        StartingFrame:MakePopup()
        StartingFrame:ShowCloseButton(false)
        StartingFrame:SetDraggable(false)
        StartingFrame:SetAlpha(0)
        StartingFrame:AlphaTo(255, 2, 0)

        StartingFrame.Paint = function(s, w, h)
            draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0))
        end

        function StartingFrame:Think()
            StartingFrame:MoveToFront()
        end

        loadingtext = vgui.Create("DLabel", StartingFrame)
        loadingtext:SetSize(200, ScrH() * 0.02)
        loadingtext:SetPos((ScrW() * 0.5) - ((ScrW() * 0.2) * 0.18), ScrH() * 0.25)
        loadingtext:SetText("Opening Item Bank...")
        loadingtext:SetFont("stalkerregularchatfont")
        loadingtext:SetAlpha(0)
        loadingtext:AlphaTo(255, 1.5, 0, function() end)

        function loadingtext:Paint(w, h)
        end

        loading = vgui.Create("DLabel", StartingFrame)
        loading:SetSize(100, ScrH() * 0.01)
        loading:SetPos((ScrW() * 0.5) - ((ScrW() * 0.2) * 0.5), ScrH() * 0.3)
        loading:SetText("")
        loading:SetFont("stalkerregularfont")
        loading:SetAlpha(0)
        loading:SizeTo(ScrW() * 0.2, ScrH() * 0.01, 3, 0, -3)
        loading:AlphaTo(255, 1.5, 0, function() end)

        function loading:Paint(w, h)
            surface.SetDrawColor(169, 169, 169)
            surface.DrawRect(0, 0, w, h)
        end

        timer.Simple(3, function()
            KeyFrame:Remove()

            local anim = Derma_Anim("EaseInQuad", StartingFrame, function(pnl, anim, delta, data)
                pnl:SetPos(0, (inQuad(delta, 0, ScrH()))) -- Change the X coordinate from 200 to 200+600
            end)

            anim:Start(2) -- Animate for two seconds

            StartingFrame.Think = function(self)
                if anim:Active() then
                    anim:Run()
                end
            end
        end)

        timer.Simple(2.3, function()
            sound.PlayFile("sound//physics/metal/metal_solid_strain3.wav", "noplay", function(station, errCode, errStr)
                if (IsValid(station)) then
                    station:Play()
                else
                    print("Error playing sound!", errCode, errStr)
                end
            end)
        end)

        timer.Simple(3, function()
            sound.PlayFile("sound//physics/metal/metal_solid_strain4.wav", "noplay", function(station, errCode, errStr)
                if (IsValid(station)) then
                    station:Play()
                else
                    print("Error playing sound!", errCode, errStr)
                end
            end)
        end)

        timer.Simple(2, function()
            netstream.Start("PlayerOpenItemBank")
            local Panel2 = vgui.Create("DFrame", inventoryframe)
            Panel2:SetPos(609, 248)
            Panel2:SetTitle("")
            Panel2:ShowCloseButton(false)
            Panel2:SetSize(652, 800)

            Panel2.Paint = function(pnl, w, h)
                draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 255))
            end
        end)

        timer.Simple(6, function()
            inventoryframe:SetMouseInputEnabled(true)
            inventoryframe:SetKeyboardInputEnabled(true)
            StartingFrame:Close()
            tabnotice = vgui.Create("DLabel", inventoryframe)
            tabnotice:SetSize(200, 100)
            tabnotice:SetPos(1700, 10)
            tabnotice:SetText("Press [TAB] to close")
            tabnotice:SetFont("stalkerregularchatfont")
            tabnotice:SetAlpha(0)

            tabnotice:AlphaTo(255, 1, 0, function()
                tabnotice.Paint = function(this)
                    this:SetAlpha(math.abs(math.cos(RealTime() * 0.8) * 255))
                end
            end)
        end)
    end
end

netstream.Hook("OpenBankingTeller", function(client)
    bankingmenu()
end)