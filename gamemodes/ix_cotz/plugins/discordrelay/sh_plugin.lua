PLUGIN.name = "CotZ Discord Relay"
PLUGIN.author = "verne"
PLUGIN.desc = "Simple relaying of special events from cotz to the discord of your choice via webhooks."

ix.util.Include("sh_config.lua")

ix.config.Add("webUrl", nil, "The web URL to send the request.", nil, {category = "discordrelay"})
