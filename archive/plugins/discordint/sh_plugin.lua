local PLUGIN = PLUGIN
PLUGIN.name = "Discord Integration"
PLUGIN.author = "chippy1337"
PLUGIN.description = "Adds Discord authentication and integration."

ix.util.Include("sv_plugin.lua")

if CLIENT then
    ix.command.Add("DiscordAuth", {
        description = "Authenticates with Discord.",
        adminOnly = false,
        arguments = {
            ix.type.string
        },
        OnRun = function(self, client, key) end
    })

    net.Receive("ixDiscordOOC", function()
        local name = net.ReadString()
        local text = net.ReadString()
        --CHAT_CLASS = class
        CHAT_CLASS = ix.chat.classes.discordooc
        chat.AddText(Color(207, 219, 229), "[DISCORD] ", name, color_white, ": " .. text)
        CHAT_CLASS = nil
    end)
end

ix.chat.Register("discordooc", {
    CanHear = function() return true end,
    CanSay = function() return true end,
	OnChatAdd = function(self, speaker, text)
		--chat.AddText(Color(255, 50, 50), "[DISCORD] ", speaker, color_white, ": "..text)
    end,
    font = "ixChatFontSmall"
})