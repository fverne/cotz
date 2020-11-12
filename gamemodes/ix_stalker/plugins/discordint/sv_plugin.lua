

require("gwsockets")

local wsEndpoint = "ws://127.0.0.1:27015/" --should be an IP, usually is the server that websockets is running on, anyways
local wsApiKey = "changeme" --requires an API key

COMM_SOCKET = COMM_SOCKET or GWSockets.createWebSocket(wsEndpoint, false)

local socket = COMM_SOCKET

socket.receivers = {}

function socket:onMessage(txt)
    local data = util.JSONToTable(txt)
    if !data then return end
    if !isstring(data.apiKey) then return end
    if (data.apiKey != wsApiKey) then return end
    data.apiKey = nil
    if !isstring(data.type) then return end
    
    if isfunction(self.receivers[data.type]) then
        self.receivers[data.type](data)
    end
end

function socket:onError(txt)

end

function socket:sendData(type, data)
    if !self:isConnected() then return end
    if !isstring(type) then return end
    if !istable(data) then return end
    
    data.type = type
    data.apiKey = wsApiKey
    
    local jsonData = util.TableToJSON(data)
    if (type == "reportResponse") then
        print(type, #jsonData)
    end

    local add = ""
    for i = 1, #jsonData do
        add = add .. " "
    end

    self:write(jsonData .. add)
end

function socket:onConnected()
    if timer.Exists("ixWSReconnect") then timer.Remove("ixWSReconnect") end

    self.wasConnected = true

    print("WS connected!")

    timer.Create("ixServerStatus", 5, 0, function()
        local factions = {}
        local staffCount = 0
        for _, v in ipairs(player.GetAll()) do
            if v:IsAdmin() then
                staffCount = staffCount + 1
            end

            local character = v.GetCharacter and v:GetCharacter()
            if character then
                local factionID = character:GetFaction()
                if factionID == FACTION_STAFF then continue end
                local factionName = ix.faction.indices[factionID].name
                factions[factionName] = factions[factionName] and factions[factionName] + 1 or 1
            end
        end

        socket:sendData("serverStatus", {
            players = #player.GetAll(),
            maxplayers = game.MaxPlayers(),
            factions = factions,
            staffCount = staffCount,
            oocEnabled = ix.config.Get("allowGlobalOOC"),
            oocDelay = ix.config.Get("oocDelay")
        })
    end)
end
socket:onConnected()

function socket:onDisconnected()
    timer.Remove("ixServerStatus")

    timer.Create("ixWSReconnect", 1, 0, function()
        xpcall(function()
            socket:open()
        end, function()
            timer.Remove("ixWSReconnect")
        end)
    end)
end

pcall(socket.open, socket)

-- receivers

util.AddNetworkString("ixDiscordOOC")

function socket.receivers.oocChat(data)
    net.Start("ixDiscordOOC")
    net.WriteString(data.user)
    net.WriteString(data.text)
    net.Broadcast()
end

-- senders

function PLUGIN:PlayerMessageSend(speaker, chatType, text, anonymous, receivers, rawText)
    if chatType == "ooc" then
        timer.Simple(0, function()
            COMM_SOCKET:sendData("oocChat", {
                name = speaker:Name(),
                text = text,
                steamid = speaker:SteamID64(),
                color = ix.faction.indices[speaker:Team()].color
            })
        end)
    end
end