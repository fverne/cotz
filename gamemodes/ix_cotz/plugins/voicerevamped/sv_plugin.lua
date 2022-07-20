util.AddNetworkString("ixVoiceMenu")

function PLUGIN:InitializedPlugins()
    RunConsoleCommand("mp_show_voice_icons", "0")
end

function PLUGIN:PlayerSpawn(client)
    client:SetNetVar("voiceRange", 2)
end

/*
function PLUGIN:ShowSpare1(client)
    if (client:GetCharacter()) then
        netstream.Start(client, "ixVoiceMenu")
    end
end
*/