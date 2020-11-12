
-- Config
DiscordRelay = DiscordRelay or {}

local webhook
if not file.Exists("cfg/relay_webhook.cfg", "GAME") or file.Read("cfg/relay_webhook.cfg", "GAME") == nil then
	print("Error! No webhook for Discord relay!")
	webhook = ""
else
	webhook = file.Read("cfg/relay_webhook.cfg", "GAME"):Trim()
end
-- Set this to your webhook URL.
DiscordRelay.WebhookURL = webhook

--[[
local authkey
if not file.Exists("cfg/apikey.cfg", "GAME") or file.Read("cfg/apikey.cfg", "GAME") == nil then
	print("Error! No auth key for Discord relay!")
	authkey = ""
else
	authkey = file.Read("cfg/apikey.cfg", "GAME"):Trim()
end
-- Set this to your Steam Web API Key
DiscordRelay.SteamWebAPIKey = authkey
]]

local token
if not file.Exists("cfg/relay_bot_token.cfg", "GAME") or file.Read("cfg/relay_bot_token.cfg", "GAME") == nil then
	print("Error! No bot token for Discord relay!")
	token = ""
else
	token = file.Read("cfg/relay_bot_token.cfg", "GAME"):Trim()
end
-- Set this to your Bot Token. Your bot must be added to your server.
DiscordRelay.BotToken = token

-- Set this to your Channel ID. You can get this number in Discord by typing \#channelnamehere into chat.
-- Remove the <# at the start and the > at the end, so you are left with only a long number.
DiscordRelay.DiscordGuildID = "172686511085584384"
DiscordRelay.DiscordChannelID = "290488910608465930"

/*----------------------------------------
Non Critical Config Options Below
------------------------------------------*/

-- Set this to the delay between fetching messages. Increase this if you are getting rate limited. Don't put this below 2.
DiscordRelay.MessageDelay = 2

-- Set this to the max amount of messages to retrieve
DiscordRelay.MaxMessages = 10

-- Should we avoid using a bot? You may need to add "sv_hibernate_think 1" to your server.cfg file.
-- If your server isn't announcing online status or you keep saeing "HTTP failed - ISteamHTTP isn't available" in your console, set this to false.
DiscordRelay.AvoidUsingBots = true

-- DEBUG MODE! Do not enable this unless you've been told to. It can get spammy in the console if you enable this.
-- As it stands, this only serves the purpose of identifying problems not identified by discord's json responses.
DiscordRelay.DEBUG_MODE = false

