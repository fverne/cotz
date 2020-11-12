PLUGIN.name = "Discord Integration"
PLUGIN.author = "verne"
PLUGIN.description = "Discord integration for PDA chat."

--[[
Gmod to Discord Chat Relay:
Have your chat display in discord!

You need a Webhook URL to make this work.

Step 1: Go into discord, and hover your mouse over the desired channel you'd like messages to be sent to.
Step 2: Click on Edit Channel, and click on Webhooks.
Step 3: Click on "Create Webohook"
Step 4: Fill in a default username, and give it an avatar of your choosing. Then click save. Edit it again before going onto step 5
Step 5: Copy and paste the webhook URL down below.

You need a SteamWebAPIKey for avatars to be fetched.

Step 1: Goto http://steamcommunity.com/dev/apikey
Step 2: Fill in a domain name, I recommend the IP address of your server.
Step 3: Copy and paste the key down below.
]]

local WebhookURL = "https://discord.com/api/webhooks/776427981005520896/4_MB4Ns53oeTp21kHR1OK8kuTyYBm5UIpNOSF2q8q8tz1SiKbx-FwGo-58Ytcpj2tNc0"
local SteamWebAPIKey = "08758F8D6073703961DD78B0DBF92ED4"

function getAvatarFromJson( j_response ) -- Thanks https://facepunch.com/showthread.php?t=1484549&p=48631437&viewfull=1#post48631437
    local t_response = util.JSONToTable( j_response )

    if ( !istable( t_response ) or !t_response.response ) then return false end
    if ( !t_response.response.players or !t_response.response.players[1] ) then return false end
    
    return t_response.response.players[1].avatarfull
end
function getAvatarURL( code, body, headers )
    if !body then
        local t_struct = {
            failed = function( err ) MsgC( Color(255,0,0), "HTTP error: " .. err ) end,
            method = "get",
            url = "http://api.steampowered.com/ISteamUser/GetPlayerSummaries/v0002/",
            parameters = { key = SteamWebAPIKey, steamid = code },
            success = getAvatarURL
        }

        HTTP( t_struct )
    else
        return( getAvatarFromJson( body ) )
    end
end
function sendChat(p_sender, s_text, b_teamChat)
    if !p_sender then return end
    local t_post = {
        content = s_text,
        username = "(Gmod) " .. (p_sender:Nick() or "Unknown"),
        avatar_url = getAvatarURL( p_sender:SteamID64() )
    }
    local t_struct = {
        failed = function( err ) MsgC( Color(255,0,0), "HTTP error: " .. err ) end,
        method = "post",
        url = WebhookURL,
        parameters = t_post,
        type = "application/json; charset=utf-8" --JSON Request type, because I'm a good boy.
    }

    HTTP( t_struct )
end
hook.Add("PlayerSay","Discord_Webhook_Chat", sendChat)
