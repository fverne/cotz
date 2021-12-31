util.AddNetworkString("ixVoiceMenu")

function PLUGIN:InitializedPlugins()
    RunConsoleCommand("mp_show_voice_icons", "0")
end

function PLUGIN:PlayerInitialSpawn(client)
    if (IsValid(client)) then
        timer.Simple(0.25, function()
            client.voiceRange = 2
        end)
    end
end

function PLUGIN:ShowSpare1(client)
    if (client:GetCharacter()) then
        net.Start("ixVoiceMenu")
        net.Send(client)
    end
end
