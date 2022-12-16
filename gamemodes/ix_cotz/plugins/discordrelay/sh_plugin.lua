PLUGIN.name = "CotZ Discord Relay"
PLUGIN.author = "verne"
PLUGIN.desc = "Simple relaying of special events from cotz to the web api of your choice via webhooks."

ix.config.Add("webUrl", "http://placeholder:1234", "The web URL to send the request.", nil, {category = "discordrelay"})
