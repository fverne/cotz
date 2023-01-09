local PLUGIN = PLUGIN
PLUGIN.name = "Server Restarter"
PLUGIN.author = "verne"
PLUGIN.desc = "GMOD CurTime() becomes inaccurate and we have to restart to reset it."

PLUGIN.NextRestart = 0
PLUGIN.NextNotificationTime = 0
PLUGIN.IsRestarting = false

-- In Minutes
PLUGIN.TimeRemainingTable = {
    30,
    15,
    5,
    1,
    0
}

ix.config.Add("serverRestartHour", 6, "At what hours the server should restart, local to timezone.", function()
    if (SERVER) then
        timer.Simple(0.01, function()
            PLUGIN.NextRestart = PLUGIN:GetInitialRestartTime()
            PLUGIN.NextNotificationTime = PLUGIN:GetNextNotificationTimeBreakpoint()
        end)
    end
end, {
    data = {
        min = 0,
        max = 23
    },
    category = "Restart"
})

function PLUGIN:GetTimeToRestart()
    local time = os.time()
    time = self.NextRestart - time
    
    return time
end

function PLUGIN:NotifyServerRestart(client, timeRemaining)
    local timeRemainingMinutes = math.Round(timeRemaining / 60)

    client:Notify("Server is restarting in "..timeRemainingMinutes.." minutes!")
end

if (SERVER) then
    -- If we're close to restarting, let the client know
    function PLUGIN:CharacterLoaded(character)
        timer.Simple(0, function()
            local timeRemaining = self:GetTimeToRestart()
            local timeRemainingInMinutes = timeRemaining / 60
            
            if (timeRemainingInMinutes < self.TimeRemainingTable[1]) then
                self:NotifyServerRestart(character:GetPlayer(), self:GetTimeToRestart())
            end
        end)
    end

    function PLUGIN:GetInitialRestartTime()
        local temp = os.date("*t")
        local timeNowStruct

        if (temp.hour > ix.config.Get("serverRestartHour")) then
            timeNowStruct = os.date("*t", os.time() + (24 * 60 * 60)) -- we add a day this way, to account for date cancer
        else
            timeNowStruct = os.date("*t")
        end
        timeNowStruct.hour = ix.config.Get("serverRestartHour") -- restart on the hour given in config
        timeNowStruct.min = 0 -- restart on the same minute
        timeNowStruct.sec = 0 -- restart on the same second
        local timestamp = os.time(timeNowStruct)
        
        return timestamp
    end

    function PLUGIN:GetInitialNotificationTime()
        local nextBreakpoint = self:GetNextNotificationTimeBreakpoint()
        return self.NextRestart - nextBreakpoint
    end

    function PLUGIN:GetNextNotificationTimeBreakpoint()
        local timeMinutes = self:GetTimeToRestart() / 60
        
        for i = 1, #self.TimeRemainingTable do
            if (timeMinutes >= self.TimeRemainingTable[i]) then
                -- convert back to seconds
                return self.TimeRemainingTable[i] * 60
            end
        end
    end

    function PLUGIN:Think()
        if (self.IsRestarting == true) then
            return
        end

        if (self.NextRestart == 0) then
            self.NextRestart = self:GetInitialRestartTime()
            self.NextNotificationTime = self:GetInitialNotificationTime()
            return
        end

        local time = os.time()
        if (time > self.NextNotificationTime or time > self.NextRestart) then
            local nextBreakpoint = self:GetNextNotificationTimeBreakpoint()

            if (!nextBreakpoint) then
                self.IsRestarting = true
                RunConsoleCommand("changelevel", game.GetMap())
            else
                for _, v in pairs(player.GetAll()) do
                    self:NotifyServerRestart(v, self:GetTimeToRestart())
                end

                self.NextNotificationTime = self.NextRestart - nextBreakpoint
            end
        end
    end
end

ix.command.Add("AddServerRestartTime", {
	description = "Adds to the current server restart time by a specific amount of minutes.",
	adminOnly = true,
	arguments = bit.bor(ix.type.number, ix.type.optional),
	OnRun = function(self, client, delay)
		delay = delay or 60
		PLUGIN.NextRestart = PLUGIN.NextRestart + (delay * 60)
        PLUGIN.NextNotificationTime = PLUGIN.NextNotificationTime + (delay * 60)

        ix.util.Notify(string.format("Added %d minutes to server restart time!", delay))
	end
})