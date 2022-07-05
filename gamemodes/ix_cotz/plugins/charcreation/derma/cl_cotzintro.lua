local PLUGIN = PLUGIN
-- hard-coded + badly made intro sequence, sorry in advance to whoever views this.
surface.CreateFont("stalkerregularfont8", {
    font = "alsina",
    size = ScreenScale(12),
    extended = true,
    weight = 500,
    antialias = true
})

surface.CreateFont("stalkerregularfont7", {
    font = "alsina",
    size = ScreenScale(14),
    extended = true,
    weight = 500,
    antialias = true
})

surface.CreateFont("stalkerregularfont6", {
    font = "alsina",
    size = ScreenScale(16),
    extended = true,
    weight = 500,
    antialias = true
})

function PLUGIN.RequestContinue()
    requestBackgroundFrame = vgui.Create("DFrame")
    requestBackgroundFrame:SetTitle("")
    requestBackgroundFrame:SetSize(ScrW(), ScrH())
    requestBackgroundFrame:SetPos(0, 0)
    requestBackgroundFrame:MakePopup()
    requestBackgroundFrame:ShowCloseButton(false)
    requestBackgroundFrame:SetDraggable(false)

    requestBackgroundFrame.Paint = function(pnl, w, h)
        draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 255))
    end

    requestFrame = vgui.Create("DFrame", requestBackgroundFrame)
    requestFrame:SetTitle("")
    requestFrame:SetPos(ScrW() / 2 - 205, ScrH() / 2 - 100) 
    requestFrame:SetSize(413, 150) 
    requestFrame:ShowCloseButton(false)
    requestFrame:SetDraggable(false)
    requestFrame.Paint = function(pnl, w, h) end

    requestLabel = vgui.Create("DLabel", requestFrame)
    requestLabel:SetPos(12, 25)
    requestLabel:SetTextColor( Color( 255, 255, 255) )
    requestLabel:SetFont("stalkertitlefont")
    requestLabel:SetText("Do you wish to see the intro sequence?")
    requestLabel:SizeToContents()
    
    local requestSizeX, requestSizeY = requestFrame:GetSize()

    requestButtonY = vgui.Create("DButton", requestFrame)
    requestButtonY:SetText("Yes")
    requestButtonY:SetPos(requestSizeX/2 - 120, requestSizeY/2 + 10)
    requestButtonY:SetSize(100, 30)

    requestButtonY.DoClick = function()
        PLUGIN.PlayIntro()
        requestBackgroundFrame:Close()
    end
    
    requestButtonN = vgui.Create("DButton", requestFrame)
    requestButtonN:SetText("No")
    requestButtonN:SetPos(requestSizeX/2 + 20, requestSizeY/2 + 10)
    requestButtonN:SetSize(100, 30)

    requestButtonN.DoClick = function()
        requestBackgroundFrame:Close()
    end
end

function PLUGIN.PlayIntro()
    sound.PlayFile("sound/stalkersound/blowout_siren.wav", "mono", function(station, errCode, errStr)
        if IsValid(station) then
            station:Play()
            station:SetVolume(0.2)
        else
            print("Error playing sound!", errCode, errStr)
        end
    end)

    ixIntroSong = CreateSound(LocalPlayer(), "stalkersound/music/montee_ray_of_hope.ogg")
    ixIntroSong:Play()
    StartingFrame = vgui.Create("DFrame")
    StartingFrame:SetSize(ScrW(), ScrH())
    StartingFrame:Center()
    StartingFrame:SetTitle("")
    StartingFrame:MakePopup()
    StartingFrame:ShowCloseButton(false)
    StartingFrame:SetDraggable(false)

    StartingFrame.Paint = function(s, w, h)
        draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0))
    end

    timer.Simple(5, function()
        local frame2 = vgui.Create("DFrame", StartingFrame)
        frame2:SetSize(275, 80)
        frame2:SetPos(ScrW() / 2 - 100, ScrH() / 2 - 153)
        frame2:SetTitle("")
        frame2:ShowCloseButton(false)
        frame2:SetDraggable(false)
        frame2.Paint = function(s, w, h) end
        local richtext3 = vgui.Create("RichText", frame2)
        richtext3:Dock(FILL)
        richtext3:SetText("CALL OF THE ZONE")

        function richtext3:PerformLayout()
            richtext3:SetFontInternal("stalkerregularfont7")
            richtext3:InsertColorChange(255, 255, 255, 255)
            richtext3:SetVerticalScrollbarEnabled(false)
        end

        timer.Simple(10, function()
            frame2:Close()
        end)
    end)

    timer.Simple(15, function()
        local frame = vgui.Create("DFrame", StartingFrame)
        frame:SetSize(370, 200)
        frame:SetPos(ScrW() / 2 - 150, ScrH() / 2 - 120)
        frame:SetTitle("")
        frame:ShowCloseButton(false)
        frame:SetDraggable(false)
        frame.Paint = function(s, w, h) end
        local richtext = vgui.Create("RichText", frame)
        richtext:Dock(FILL)
        richtext:InsertColorChange(255, 255, 255, 255)
        richtext:SetVerticalScrollbarEnabled(false)

        local words = {"G", "R", "E", "A", "T", "", "S", "W", "A", "M", "P", "S"}

        local delay = 0

        for w, txt in pairs(words) do
            if w == 1 then
                delay = 0.2
            else
                delay = (w - 1) * 0.4
            end

            timer.Simple(delay, function()
                richtext:AppendText(txt .. " ")
                richtext:InsertFade(15, 1)
                richtext:SetBGColor(Color(0, 0, 0))
                richtext:SetFontInternal("stalkerregularfont6")
            end)
        end

        local NextFrame = vgui.Create("DFrame", StartingFrame)
        NextFrame:SetSize(275, 80)
        NextFrame:SetPos(ScrW() / 2 - 100, ScrH() / 2 - 153)
        NextFrame:SetTitle("")
        NextFrame:ShowCloseButton(false)
        NextFrame:SetDraggable(false)
        NextFrame.Paint = function(s, w, h) end
        local richtext3 = vgui.Create("RichText", NextFrame)
        richtext3:Dock(FILL)
        richtext3:SetText("CALL OF THE ZONE")

        function richtext3:PerformLayout()
            richtext3:InsertFade(10, 1)
            richtext3:SetFontInternal("stalkerregularfont7")
            richtext3:InsertColorChange(255, 255, 255, 255)
            richtext3:SetVerticalScrollbarEnabled(false)
        end

        timer.Simple(19.5, function()
            local SomeFrame = vgui.Create("DFrame", StartingFrame)
            SomeFrame:SetSize(375, 80)
            SomeFrame:SetPos(ScrW() / 2 - 170, ScrH() / 2 - 120)
            SomeFrame:SetTitle("")
            SomeFrame:ShowCloseButton(false)
            SomeFrame:SetDraggable(false)
            SomeFrame.Paint = function(s, w, h) end
            local richtext4 = vgui.Create("RichText", SomeFrame)
            richtext4:Dock(FILL)
            richtext4:InsertColorChange(200, 60, 32, 255)
            richtext4:SetVerticalScrollbarEnabled(false)

            local words = {"Chernobyl", "Exclusion"}

            local delay = 0

            for w, txt in pairs(words) do
                if w == 1 then
                    delay = 0.2
                else
                    delay = (w - 1) * 0.45
                end

                timer.Simple(delay, function()
                    richtext4:AppendText(txt .. " ")
                    richtext4:InsertFade(9.9, 1)
                    richtext4:SetBGColor(Color(0, 0, 0))
                    richtext4:SetFontInternal("stalkerregularfont7")
                end)
            end

            timer.Simple(4, function()
                local zoneframe = vgui.Create("DFrame", StartingFrame)
                zoneframe:SetSize(200, 80)
                zoneframe:SetPos(ScrW() / 2 + 60, ScrH() / 2 - 120)
                zoneframe:SetTitle("")
                zoneframe:ShowCloseButton(false)
                zoneframe:SetDraggable(false)
                zoneframe.Paint = function(s, w, h) end
                local zonetext = vgui.Create("RichText", zoneframe)
                zonetext:Dock(FILL)
                zonetext:SetFontInternal("stalkerregularfont7")
                zonetext:InsertColorChange(200, 60, 32, 255)
                zonetext:SetVerticalScrollbarEnabled(false)

                local words = {"Zone", "", "2010"}

                local delay = 0

                for w, txt in pairs(words) do
                    if w == 1 then
                        delay = 0.2
                    else
                        delay = (w - 1) * 0.45
                    end

                    timer.Simple(delay, function()
                        zonetext:AppendText(txt .. " ")
                        zonetext:InsertFade(6, 1)
                        zonetext:SetBGColor(Color(0, 0, 0))
                        zonetext:SetFontInternal("stalkerregularfont7")
                    end)
                end

                timer.Simple(12, function()
                    StartingFrame:Close()
                end)
            end)
        end)
    end)

    timer.Simple(48, function()
        local function inQuad(fraction, beginning, change)
            return change * (fraction ^ 2) + beginning
        end

        local closing = false
        local canclose = false

        local function inQuad(fraction, beginning, change)
            return change * (fraction ^ 2) + beginning
        end

        local main2 = vgui.Create("DFrame")
        main2:SetTitle("")
        main2:SetSize(ScrW(), ScrH())
        main2:SetPos(0)
        main2:MakePopup()
        main2:ShowCloseButton(false)

        main2.Paint = function(s, w, h)
            surface.SetDrawColor(0, 0, 0, 255)
            surface.DrawRect(0, 0, main2:GetWide(), main2:GetTall())
        end

        local maintitle = vgui.Create("DFrame", main2)
        maintitle:SetSize(380, 200)
        maintitle:SetPos(ScrW() / 2 - 180, ScrH() / 2 - 153)
        maintitle:SetTitle("")
        maintitle:ShowCloseButton(false)
        maintitle:SetDraggable(false)
        maintitle.Paint = function(s, w, h) end
        local titletext = maintitle:Add("DLabel")
        titletext:SetTall(ScrH() * 0.05)
        titletext:SetWide(ScrW() * 0.25)
        titletext:SetHeight(30)
        titletext:SetText("STALKER: CALL OF THE ZONE")
        titletext:SetAlpha(0)
        titletext:AlphaTo(50, 2, 0)
        titletext:SetTextColor(Color(255, 255, 255, 180))
        titletext:SetFont("stalkerregularfont6")
        local continuetext = maintitle:Add("DLabel")
        continuetext:SetTall(ScrH() * 0.05)
        continuetext:SetWide(ScrW() * 0.25)
        continuetext:SetHeight(120)
        continuetext:SetText("Press [ENTER] to trespass into the zone.")
        continuetext:SetTextColor(Color(255, 255, 255, 180))
        continuetext:SetFont("stalkerregularfont8")

        timer.Simple(3, function()
            canclose = true
        end)

        continuetext:SetAlpha(0)

        continuetext:AlphaTo(255, 1, 0, function()
            continuetext.Paint = function(this)
                this:SetAlpha(math.abs(math.cos(RealTime() * 0.8) * 255))
            end
        end)

        function main2:Think()
            if IsValid(maintitle) and input.IsKeyDown(KEY_ENTER) and not closing and canclose then
                closing = true

                main2:AlphaTo(0, 1, 0, function()
                    main2:Remove()
                    ixIntroSong:FadeOut(5)

                    if timer.Exists("ixIntroName") then
                        timer.Remove("ixIntroName")
                    end

                    if timer.Exists("ixIntroNameText") then
                        timer.Remove("ixIntroNameText")
                    end

                    if timer.Exists("ixIntroRep") then
                        timer.Remove("ixIntroRep")
                    end

                    if timer.Exists("ixIntroRepText") then
                        timer.Remove("ixIntroRepText")
                    end

                    if timer.Exists("ixIntroLocation") then
                        timer.Remove("ixIntroLocation")
                    end

                    if timer.Exists("ixIntroLocationText") then
                        timer.Remove("ixIntroLocationText")
                    end

                    if timer.Exists("ixIntroStalkernetText") then
                        timer.Remove("ixIntroLocationText")
                    end

                    if timer.Exists("ixIntroStalkernetStatus") then
                        timer.Remove("ixIntroStalkernetStatus")
                    end
                end)
            end
        end

        local mainnametext = vgui.Create("DPanel", main2)
        mainnametext:SetSize(250, 100)
        mainnametext:SetPos(500)
        mainnametext.Paint = function(s, w, h) end

        local anim = Derma_Anim("EaseInQuad", mainnametext, function(pnl, anim, delta, data)
            pnl:SetPos(inQuad(delta, ScrW() - 100, -ScrW() - 200), 600)
        end)

        anim:Start(30)

        mainnametext.Think = function(self)
            if anim:Active() then
                anim:Run()
            end
        end

        local nametext = mainnametext:Add("DLabel")
        nametext:Dock(TOP)
        nametext:SetContentAlignment(8)
        nametext:SetTall(ScrH() * 0.05)
        nametext:SetText("Name:")
        nametext:SetTextColor(Color(255, 255, 255, 180))
        nametext:DockMargin(5, 5, 5, 0)
        nametext:SetFont("stalkerregularfont6")

        timer.Create("ixIntroNameText", 31, 0, function()
            mainnametext:Remove()
            nametext:Remove()
            local mainnametext = vgui.Create("DPanel", main2)
            mainnametext:SetSize(250, 100)
            mainnametext:SetPos(500)
            mainnametext.Paint = function(s, w, h) end

            local anim = Derma_Anim("EaseInQuad", mainnametext, function(pnl, anim, delta, data)
                pnl:SetPos(inQuad(delta, ScrW() - 100, -ScrW() - 200), 600)
            end)

            anim:Start(31)

            mainnametext.Think = function(self)
                if anim:Active() then
                    anim:Run()
                end
            end

            local nametext = mainnametext:Add("DLabel")
            nametext:Dock(TOP)
            nametext:SetContentAlignment(8)
            nametext:SetTall(ScrH() * 0.05)
            nametext:SetText("Name:")
            nametext:SetTextColor(Color(255, 255, 255, 180))
            nametext:DockMargin(5, 5, 5, 0)
            nametext:SetFont("stalkerregularfont6")
        end)

        timer.Simple(2.8, function()
            local mainname = vgui.Create("DPanel", main2)
            mainname:SetSize(250, 100)
            mainname:SetPos(500)
            mainname.Paint = function(s, w, h) end

            local anim = Derma_Anim("EaseInQuad", mainname, function(pnl, anim, delta, data)
                pnl:SetPos(inQuad(delta, ScrW() - 100, -ScrW() - 210), 605)
            end)

            anim:Start(30)

            mainname.Think = function(self)
                if anim:Active() then
                    anim:Run()
                end
            end

            local name = mainname:Add("DLabel")
            name:Dock(TOP)
            name:SetContentAlignment(8)
            name:SetTall(ScrH() * 0.05)
            name:SetText(LocalPlayer():GetCharacter():GetName())
            name:SetAlpha(0)
            name:AlphaTo(100, 1, 9.5)
            name:SetTextColor(Color(255, 255, 255, 180))
            name:DockMargin(5, 5, 5, 0)
            name:SetFont("stalkerregularfont7")

            timer.Create("ixIntroName", 32, 0, function()
                mainname:Remove()
                name:Remove()
                local mainname = vgui.Create("DPanel", main2)
                mainname:SetSize(250, 100)
                mainname:SetPos(500)
                mainname.Paint = function(s, w, h) end

                local anim = Derma_Anim("EaseInQuad", mainname, function(pnl, anim, delta, data)
                    pnl:SetPos(inQuad(delta, ScrW() - 100, -ScrW() - 210), 605)
                end)

                anim:Start(32)

                mainname.Think = function(self)
                    if anim:Active() then
                        anim:Run()
                    end
                end

                local name = mainname:Add("DLabel")
                name:Dock(TOP)
                name:SetContentAlignment(8)
                name:SetTall(ScrH() * 0.05)
                name:SetAlpha(0)
                name:AlphaTo(100, 1, 9.5)
                name:SetText(LocalPlayer():GetCharacter():GetName())
                name:SetTextColor(Color(255, 255, 255, 180))
                name:DockMargin(5, 5, 5, 0)
                name:SetFont("stalkerregularfont7")
            end)
        end)

        local mainreptext = vgui.Create("DPanel", main2)
        mainreptext:SetSize(250, 100)
        mainreptext:SetPos(600)
        mainreptext.Paint = function(s, w, h) end

        local anim = Derma_Anim("EaseInQuad", mainreptext, function(pnl, anim, delta, data)
            pnl:SetPos(inQuad(delta, ScrW() - 100, -ScrW() - 200), 700)
        end)

        anim:Start(30)

        mainreptext.Think = function(self)
            if anim:Active() then
                anim:Run()
            end
        end

        local reptext = mainreptext:Add("DLabel")
        reptext:Dock(TOP)
        reptext:SetContentAlignment(8)
        reptext:SetTall(ScrH() * 0.1)
        reptext:SetText("Reputation:")
        reptext:SetTextColor(Color(255, 255, 255, 180))
        reptext:DockMargin(5, 5, 5, 0)
        reptext:SetFont("stalkerregularfont6")

        timer.Create("ixIntroRepText", 33, 0, function()
            mainreptext:Remove()
            reptext:Remove()
            local mainreptext = vgui.Create("DPanel", main2)
            mainreptext:SetSize(250, 100)
            mainreptext:SetPos(600)
            mainreptext.Paint = function(s, w, h) end

            local anim = Derma_Anim("EaseInQuad", mainreptext, function(pnl, anim, delta, data)
                pnl:SetPos(inQuad(delta, ScrW() - 100, -ScrW() - 200), 700)
            end)

            anim:Start(33)

            mainreptext.Think = function(self)
                if anim:Active() then
                    anim:Run()
                end
            end

            local reptext = mainreptext:Add("DLabel")
            reptext:Dock(TOP)
            reptext:SetContentAlignment(8)
            reptext:SetTall(ScrH() * 0.1)
            reptext:SetText("Reputation:")
            reptext:SetTextColor(Color(255, 255, 255, 180))
            reptext:DockMargin(5, 5, 5, 0)
            reptext:SetFont("stalkerregularfont6")
        end)

        timer.Simple(2.1, function()
            local mainrep = vgui.Create("DPanel", main2)
            mainrep:SetSize(250, 100)
            mainrep:SetPos(600)
            mainrep.Paint = function(s, w, h) end

            local anim = Derma_Anim("EaseInQuad", mainrep, function(pnl, anim, delta, data)
                pnl:SetPos(inQuad(delta, ScrW() - 100, -ScrW() - 210), 705)
            end)

            anim:Start(30)

            mainrep.Think = function(self)
                if anim:Active() then
                    anim:Run()
                end
            end

            local rep = mainrep:Add("DLabel")
            rep:Dock(TOP)
            rep:SetContentAlignment(8)
            rep:SetTall(ScrH() * 0.1)
            rep:SetText("Tourist")
            rep:SetTextColor(Color(138, 43, 226))
            rep:SetAlpha(0)
            rep:AlphaTo(255, 1, 9.7)
            rep:DockMargin(5, 5, 5, 0)
            rep:SetFont("stalkerregularfont7")

            timer.Create("ixIntroRep", 34, 0, function()
                mainrep:Remove()
                rep:Remove()
                local mainrep = vgui.Create("DPanel", main2)
                mainrep:SetSize(250, 100)
                mainrep:SetPos(600)
                mainrep.Paint = function(s, w, h) end

                local anim = Derma_Anim("EaseInQuad", mainrep, function(pnl, anim, delta, data)
                    pnl:SetPos(inQuad(delta, ScrW() - 100, -ScrW() - 210), 705)
                end)

                anim:Start(34)

                mainrep.Think = function(self)
                    if anim:Active() then
                        anim:Run()
                    end
                end

                local rep = mainrep:Add("DLabel")
                rep:Dock(TOP)
                rep:SetContentAlignment(8)
                rep:SetTall(ScrH() * 0.1)
                rep:SetText("Tourist")
                rep:SetTextColor(Color(138, 43, 226))
                rep:SetAlpha(0)
                rep:AlphaTo(255, 1, 9.5)
                rep:DockMargin(5, 5, 5, 0)
                rep:SetFont("stalkerregularfont7")
            end)
        end)

        local mainlocationtext = vgui.Create("DPanel", main2)
        mainlocationtext:SetSize(250, 100)
        mainlocationtext:SetPos(800)
        mainlocationtext.Paint = function(s, w, h) end

        local anim = Derma_Anim("EaseInQuad", mainlocationtext, function(pnl, anim, delta, data)
            pnl:SetPos(inQuad(delta, ScrW() - 100, -ScrW() - 200), 800)
        end)

        anim:Start(30)

        mainlocationtext.Think = function(self)
            if anim:Active() then
                anim:Run()
            end
        end

        local locationtext = mainlocationtext:Add("DLabel")
        locationtext:Dock(TOP)
        locationtext:SetContentAlignment(8)
        locationtext:SetTall(ScrH() * 0.1)
        locationtext:SetText("Location:")
        locationtext:SetTextColor(Color(255, 255, 255, 180))
        locationtext:DockMargin(5, 5, 5, 0)
        locationtext:SetFont("stalkerregularfont6")

        timer.Create("ixIntroLocationText", 32, 0, function()
            mainlocationtext:Remove()
            locationtext:Remove()
            local mainlocationtext = vgui.Create("DPanel", main2)
            mainlocationtext:SetSize(250, 100)
            mainlocationtext:SetPos(800)
            mainlocationtext.Paint = function(s, w, h) end

            local anim = Derma_Anim("EaseInQuad", mainlocationtext, function(pnl, anim, delta, data)
                pnl:SetPos(inQuad(delta, ScrW() - 100, -ScrW() - 200), 800)
            end)

            anim:Start(32)

            mainlocationtext.Think = function(self)
                if anim:Active() then
                    anim:Run()
                end
            end

            local locationtext = mainlocationtext:Add("DLabel")
            locationtext:Dock(TOP)
            locationtext:SetContentAlignment(8)
            locationtext:SetTall(ScrH() * 0.1)
            locationtext:SetText("Location:")
            locationtext:SetTextColor(Color(255, 255, 255, 180))
            locationtext:DockMargin(5, 5, 5, 0)
            locationtext:SetFont("stalkerregularfont6")
        end)

        timer.Simple(2.8, function()
            local mainlocation = vgui.Create("DPanel", main2)
            mainlocation:SetSize(250, 100)
            mainlocation:SetPos(800)
            mainlocation.Paint = function(s, w, h) end

            local anim = Derma_Anim("EaseInQuad", mainlocation, function(pnl, anim, delta, data)
                pnl:SetPos(inQuad(delta, ScrW() - 100, -ScrW() - 300), 805)
            end)

            anim:Start(30)

            mainlocation.Think = function(self)
                if anim:Active() then
                    anim:Run()
                end
            end

            local location = mainlocation:Add("DLabel")
            location:Dock(TOP)
            location:SetContentAlignment(8)
            location:SetTall(ScrH() * 0.1)
            location:SetText("Unknown")
            location:SetAlpha(0)
            location:AlphaTo(100, 1, 9)
            location:SetTextColor(Color(255, 255, 255, 180))
            location:DockMargin(5, 5, 5, 0)
            location:SetFont("stalkerregularfont7")

            timer.Create("ixIntroLocation", 33, 0, function()
                mainlocation:Remove()
                location:Remove()
                local mainlocation = vgui.Create("DPanel", main2)
                mainlocation:SetSize(250, 100)
                mainlocation:SetPos(800)
                mainlocation.Paint = function(s, w, h) end

                local anim = Derma_Anim("EaseInQuad", mainlocation, function(pnl, anim, delta, data)
                    pnl:SetPos(inQuad(delta, ScrW() - 100, -ScrW() - 210), 805)
                end)

                anim:Start(33)

                mainlocation.Think = function(self)
                    if anim:Active() then
                        anim:Run()
                    end
                end

                local location = mainlocation:Add("DLabel")
                location:Dock(TOP)
                location:SetContentAlignment(8)
                location:SetTall(ScrH() * 0.1)
                location:SetText("Unknown")
                location:SetAlpha(0)
                location:AlphaTo(100, 1, 9)
                location:SetTextColor(Color(255, 255, 255, 180))
                location:DockMargin(5, 5, 5, 0)
                location:SetFont("stalkerregularfont7")
            end)
        end)

        local mainnettext = vgui.Create("DPanel", main2)
        mainnettext:SetSize(250, 100)
        mainnettext:SetPos(800)
        mainnettext.Paint = function(s, w, h) end

        local anim = Derma_Anim("EaseInQuad", mainnettext, function(pnl, anim, delta, data)
            pnl:SetPos(inQuad(delta, ScrW() - 100, -ScrW() - 200), 200)
        end)

        anim:Start(30)

        mainnettext.Think = function(self)
            if anim:Active() then
                anim:Run()
            end
        end

        local stalkernettext = mainnettext:Add("DLabel")
        stalkernettext:Dock(TOP)
        stalkernettext:SetContentAlignment(8)
        stalkernettext:SetTall(ScrH() * 0.1)
        stalkernettext:SetText("Status:")
        stalkernettext:SetTextColor(Color(255, 255, 255, 180))
        stalkernettext:DockMargin(5, 5, 5, 0)
        stalkernettext:SetFont("stalkerregularfont6")

        timer.Create("ixIntroStalkernetText", 29, 0, function()
            mainnettext:Remove()
            stalkernettext:Remove()
            local mainnettext = vgui.Create("DPanel", main2)
            mainnettext:SetSize(250, 100)
            mainnettext:SetPos(800)
            mainnettext.Paint = function(s, w, h) end

            local anim = Derma_Anim("EaseInQuad", mainnettext, function(pnl, anim, delta, data)
                pnl:SetPos(inQuad(delta, ScrW() - 100, -ScrW() - 200), 200)
            end)

            anim:Start(29)

            mainnettext.Think = function(self)
                if anim:Active() then
                    anim:Run()
                end
            end

            local stalkernettext = mainnettext:Add("DLabel")
            stalkernettext:Dock(TOP)
            stalkernettext:SetContentAlignment(8)
            stalkernettext:SetTall(ScrH() * 0.1)
            stalkernettext:SetText("Status:")
            stalkernettext:SetTextColor(Color(255, 255, 255, 180))
            stalkernettext:DockMargin(5, 5, 5, 0)
            stalkernettext:SetFont("stalkerregularfont6")
        end)

        timer.Simple(1.2, function()
            local mainnetstatus = vgui.Create("DPanel", main2)
            mainnetstatus:SetSize(350, 100)
            mainnetstatus:SetPos(800)
            mainnetstatus.Paint = function(s, w, h) end

            local anim = Derma_Anim("EaseInQuad", mainnetstatus, function(pnl, anim, delta, data)
                pnl:SetPos(inQuad(delta, ScrW() - 100, -ScrW() - 210), 205)
            end)

            anim:Start(30)

            mainnetstatus.Think = function(self)
                if anim:Active() then
                    anim:Run()
                end
            end

            local stalkernetstatus = mainnetstatus:Add("DLabel")
            stalkernetstatus:Dock(TOP)
            stalkernetstatus:SetContentAlignment(8)
            stalkernetstatus:SetTall(ScrH() * 0.1)
            stalkernetstatus:SetText("ALIVE")
            stalkernetstatus:SetTextColor(Color(0, 255, 0))
            stalkernetstatus:DockMargin(5, 5, 5, 0)
            stalkernetstatus:SetAlpha(0)
            stalkernetstatus:AlphaTo(255, 1, 9)
            stalkernetstatus:SetFont("stalkerregularfont7")

            timer.Create("ixIntrostalkernetStatus", 30, 0, function()
                mainnetstatus:Remove()
                stalkernetstatus:Remove()
                local mainnetstatus = vgui.Create("DPanel", main2)
                mainnetstatus:SetSize(350, 100)
                mainnetstatus:SetPos(800)
                mainnetstatus.Paint = function(s, w, h) end

                local anim = Derma_Anim("EaseInQuad", mainnetstatus, function(pnl, anim, delta, data)
                    pnl:SetPos(inQuad(delta, ScrW() - 100, -ScrW() - 210), 205)
                end)

                anim:Start(30)

                mainnetstatus.Think = function(self)
                    if anim:Active() then
                        anim:Run()
                    end
                end

                local stalkernetstatus = mainnetstatus:Add("DLabel")
                stalkernetstatus:Dock(TOP)
                stalkernetstatus:SetContentAlignment(8)
                stalkernetstatus:SetTall(ScrH() * 0.1)
                stalkernetstatus:SetText("ALIVE")
                stalkernetstatus:SetAlpha(0)
                stalkernetstatus:AlphaTo(255, 1, 9)
                stalkernetstatus:SetTextColor(Color(0, 255, 0))
                stalkernetstatus:DockMargin(5, 5, 5, 0)
                stalkernetstatus:SetFont("stalkerregularfont7")
            end)
        end)
    end)
end