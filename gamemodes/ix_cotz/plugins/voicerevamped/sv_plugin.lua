util.AddNetworkString("ixVoiceMenu")

function PLUGIN:InitializedPlugins()
    RunConsoleCommand("mp_show_voice_icons", "0")
end

function PLUGIN:PlayerLoadedCharacter(client, character)
    timer.Simple(0.25, function()
        client:SetLocalVar("voiceRange", 2)
    end)
end

/*
function PLUGIN:ShowSpare1(client)
    if (client:GetCharacter()) then
        netstream.Start(client, "ixVoiceMenu")
    end
end
*/