PLUGIN.name = "Voice Chat Revamped"
PLUGIN.author = "Black Tea + armdupe"
PLUGIN.desc = "A plugin that revamps voice chat that adds a lot of things such as overlay, voice distance and 3d sound and more."
ix.util.Include("sv_plugin.lua")

-- Start of Voice Overlay
if (CLIENT) then
    local PANEL = {}
    local ixVoicePanels = {}

    function PANEL:Init()
        local hi = vgui.Create("DLabel", self)
        hi:SetFont("ixIconsMedium")
        hi:Dock(LEFT)
        hi:DockMargin(8, 0, 8, 0)
        hi:SetTextColor(color_white)
        hi:SetText("i")
        hi:SetWide(30)
        self.LabelName = vgui.Create("DLabel", self)
        self.LabelName:SetFont("ixMediumFont")
        self.LabelName:Dock(FILL)
        self.LabelName:DockMargin(0, 0, 0, 0)
        self.LabelName:SetTextColor(color_white)
        self.Color = color_transparent
        self:SetSize(280, 32 + 8)
        self:DockPadding(4, 4, 4, 4)
        self:DockMargin(2, 2, 2, 2)
        self:Dock(BOTTOM)
    end

    function PANEL:Setup(client)
        self.client = client
        self.name = hook.Run("ShouldAllowScoreboardOverride", client, "name") and hook.Run("GetDisplayedName", client) or client:Nick()
        self.LabelName:SetText(self.name)
        self:InvalidateLayout()
    end

    function PANEL:Paint(w, h)
        if (not IsValid(self.client)) then return end
        ix.util.DrawBlur(self, 1, 2)
        surface.SetDrawColor(0, 0, 0, 50 + self.client:VoiceVolume() * 50)
        surface.DrawRect(0, 0, w, h)
        surface.SetDrawColor(255, 255, 255, 50 + self.client:VoiceVolume() * 120)
        surface.DrawOutlinedRect(0, 0, w, h)
    end

    function PANEL:Think()
        if (IsValid(self.client)) then
            self.LabelName:SetText(self.name)
        end

        if (self.fadeAnim) then
            self.fadeAnim:Run()
        end
    end

    function PANEL:FadeOut(anim, delta, data)
        if (anim.Finished) then
            if (IsValid(ixVoicePanels[self.client])) then
                ixVoicePanels[self.client]:Remove()
                ixVoicePanels[self.client] = nil

                return
            end

            return
        end

        self:SetAlpha(255 - (255 * (delta * 2)))
    end

    vgui.Register("VoicePanel", PANEL, "DPanel")

    function PLUGIN:PlayerStartVoice(client)
        if (not IsValid(g_VoicePanelList) or not ix.config.Get("allowVoice", false)) then return end
        hook.Run("PlayerEndVoice", client)

        if (IsValid(ixVoicePanels[client])) then
            if (ixVoicePanels[client].fadeAnim) then
                ixVoicePanels[client].fadeAnim:Stop()
                ixVoicePanels[client].fadeAnim = nil
            end

            ixVoicePanels[client]:SetAlpha(255)

            return
        end

        if (not IsValid(client)) then return end
        local pnl = g_VoicePanelList:Add("VoicePanel")
        pnl:Setup(client)
        ixVoicePanels[client] = pnl
    end

    local function VoiceClean()
        for k, v in pairs(ixVoicePanels) do
            if (not IsValid(k)) then
                hook.Run("PlayerEndVoice", k)
            end
        end
    end

    timer.Create("VoiceClean", 10, 0, VoiceClean)

    function PLUGIN:PlayerEndVoice(client)
        if (IsValid(ixVoicePanels[client])) then
            if (ixVoicePanels[client].fadeAnim) then return end
            ixVoicePanels[client].fadeAnim = Derma_Anim("FadeOut", ixVoicePanels[client], ixVoicePanels[client].FadeOut)
            ixVoicePanels[client].fadeAnim:Start(2)
        end
    end

    local function CreateVoiceVGUI()
        gmod.GetGamemode().PlayerStartVoice = function() end
        gmod.GetGamemode().PlayerEndVoice = function() end

        if (IsValid(g_VoicePanelList)) then
            g_VoicePanelList:Remove()
        end

        g_VoicePanelList = vgui.Create("DPanel")
        g_VoicePanelList:ParentToHUD()
        g_VoicePanelList:SetSize(270, ScrH() - 200)
        g_VoicePanelList:SetPos(ScrW() - 320, 100)
        g_VoicePanelList:SetPaintBackground(false)
    end

    hook.Add("InitPostEntity", "CreateVoiceVGUI", CreateVoiceVGUI)
end

--[[
WARNING: This has not been tested with other players and may not work and or break your voice chat.
This has only been semi-tested with a bot and the magic of if statements + printing to console.
I highly suggest anyone who is seeing this message to not commit this part of the plugin (below this warning message)
to their gamemode until the plugin has this message removed or has been commited to the Master branch.
You have been warned.
]]--

-- Start of Voice Modes

ixVoice = ixVoice or {}

ixVoice.Ranges = {
    {
        name = "Whispering", -- for a future update/addition to the plugin, you will see soon
        range = 120
    },
    {
        name = "Talking",
        range = 300
    },
    {
        name = "Yelling",
        range = 600
    }
}

local voiceDistance = 360000

if (SERVER) then
    function PLUGIN:PlayerCanHearPlayersVoice(listener, speaker)
        local allowVoice = ix.config.Get("allowVoice")
        if (IsValid(listener.ixRagdoll)) then return false, false end
        if (listener == speaker) then return true, true end
        if (not allowVoice) then return false, false end
        local oldrange = voiceDistance

        if (speaker.voiceRange) then
            oldrange = ixVoice.Ranges[speaker.voiceRange].range
            oldrange = oldrange * oldrange
            --  print(oldrange)
        end

     -- print(listener)
     -- print(speaker)

        if (listener:GetPos():DistToSqr(speaker:GetPos()) > oldrange) then return false, false end
        if (listener:GetPos():DistToSqr(speaker:GetPos()) <= oldrange) then return false, false end

        return true, true
    end
end

local function ChangeMode(mode)
    local client = LocalPlayer()
    client.voiceRange = mode

    if (client.voiceRange > #ixVoice.Ranges) then
        client.voiceRange = 1
    end
end


net.Receive("ixVoiceMenu", function(length) -- copied from recognition plugin
    local menu = DermaMenu()
    print(LocalPlayer().voiceRange)

    menu:AddOption("Change voice mode to Whispering range.", function()
        ChangeMode(1)
    end)

    menu:AddOption("Change voice mode to Talking range.", function()
        ChangeMode(2)
    end)

    menu:AddOption("Change voice mode to Yelling range.", function()
        ChangeMode(3)
    end)

    menu:Open()
    menu:MakePopup()
    menu:Center()
end)


--[[
if (CLIENT) then
  concommand.Add("printvoicemode", function()
    print(LocalPlayer().voiceRange)
  end)
end
]]--
