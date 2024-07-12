-- this cant be empty
if not util.IsBinaryModuleInstalled("gdiscord") then return end
require("gdiscord")
local discord_id = "1221168292010659910"
local refresh_time = 60
local discord_start = discord_start or -1

function DiscordUpdate()
    local rpc_data = {}

    if game.SinglePlayer() then
        rpc_data["state"] = "Singleplayer"
    else
        local ip = game.GetIPAddress()

        if ip == "loopback" then
            if GetConVar("p2p_enabled"):GetBool() then
                rpc_data["state"] = "Peer 2 Peer"
            else
                rpc_data["state"] = "Local Server"
            end
        else
            rpc_data["state"] = string.Replace(ip, ":27015", "")
        end
    end

    rpc_data["partySize"] = player.GetCount()
    rpc_data["partyMax"] = game.MaxPlayers()

    if game.SinglePlayer() then
        rpc_data["partyMax"] = 0
    end

    local reputation = LocalPlayer():getCurrentRankName() or "N/A"
    rpc_data["details"] = "Reputation: " .. reputation
    local hostname = GetHostName()

    --[[
		official cotz servers are named:
		COTZ | Swamps - Start Here
		COTZ | Waystation
		COTZ | Pripyat

		so we have to do use patterns to split the string up to get the following:
		Swamps
		Waystation
		Pripyat
    ]]--

    local level = string.match(hostname, "|%s*([^|%-]+)%s*%-?%s*.-$") or string.match(hostname, "|%s*([^|%-]+)$") or "Unknown"
    local character = LocalPlayer():GetCharacter() and LocalPlayer():GetCharacter():GetName() or "Unknown"
    local avatar = LocalPlayer():GetCharacter() and string.match(LocalPlayer():GetCharacter():GetPdaavatar(), "/([^/]+)$") or "nodata"
    rpc_data["largeImageText"] = "Level: " .. level
    rpc_data["largeImageKey"] = level == "Unknown" and "unknown" or game.GetMap()
    rpc_data["smallImageText"] = character
    rpc_data["smallImageKey"] = avatar
    rpc_data["startTimestamp"] = discord_start
    DiscordUpdateRPC(rpc_data)
end

hook.Add("Initialize", "UpdateDiscordStatus", function()
    discord_start = os.time()
    DiscordRPCInitialize(discord_id)
    DiscordUpdate()
    timer.Create("DiscordRPCTimer", refresh_time, 0, DiscordUpdate)
end)