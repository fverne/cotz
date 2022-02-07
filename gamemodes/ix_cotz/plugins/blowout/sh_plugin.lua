local PLUGIN = PLUGIN
PLUGIN.name = "Blowout"
PLUGIN.author = "gumlefar"
PLUGIN.desc = "Blowout addon converted to plugin, and cleaned up a bit"
ix.util.Include("cl_plugin.lua")

ix.config.Add("blowoutEnabled", true, "If true, blowouts will be able to be automatically triggered or manually by admins.", function()
    if (SERVER) then
        PLUGIN:ResetBlowoutVars()

        return
    end
end, {
    category = "Blowout"
})

ix.config.Add("blowoutRateCycle", 120, "How many minutes between the next blowout cycle. Default = 120 minutes (2 hours)", function()
    if (SERVER) then
        timer.Simple(0.01, function()
            PLUGIN.NextBlowout = CurTime() + (ix.config.Get("blowoutRateCycle", 120) * 60)
        end)
    end
end, {
    data = {
        min = 10,
        max = 720
    },
    category = "Blowout"
})

ix.config.Add("blowoutRemoveNPCs", false, "If true, blowouts will remove all the NPCs on the map.", nil, {
    category = "Blowout"
})

ix.config.Add("blowoutRemoveItems", false, "If true, blowouts will remove all the items on the map.", nil, {
    category = "Blowout"
})

-- Register HUD Bars.
if (SERVER) then
    util.AddNetworkString("BlowoutPlaySound")
    util.AddNetworkString("BlowoutChangePhase")
    PLUGIN.NextBlowout = CurTime() + (ix.config.Get("blowoutRateCycle", 120) * 60)
    PLUGIN.NextThink = 0
    PLUGIN.BlowoutVars = PLUGIN.BlowoutVars or {}
    PLUGIN.BlowoutVars.BlowoutStarted = false
    PLUGIN.BlowoutVars.PrehitTime = 0
    PLUGIN.BlowoutVars.BlastTime = 0
    PLUGIN.BlowoutVars.BuildupTime = 0
    PLUGIN.BlowoutVars.BlowoutHitTime = 0
    PLUGIN.BlowoutVars.FinalSoundTime = 0
    PLUGIN.BlowoutVars.NextAmbientSound = 0
    PLUGIN.BlowoutVars.NextHitSound = 0
    PLUGIN.BlowoutVars.BlowoutStep = 0
    PLUGIN.BlowoutVars.PostHitActionTime = 0
    PLUGIN.BlowoutVars.BlowoutFinishTime = 0

    function PLUGIN:Think()
        if not ix.config.Get("blowoutEnabled", true) then return end
        local CT = CurTime()
        if CT < self.NextThink then return end

        if self.NextBlowout == CurTime() + 60 then
            for k, v in pairs(player.GetAll()) do
                if v:IsAdmin() then
                    v:Notify("[ADMIN] A blowout is going to happen in 60 seconds. You can stop this if you wish by typing /blowoutresetcycle in chat.")
                end
            end
        end

        if self.NextBlowout < CurTime() and (not self.BlowoutVars.BlowoutStarted) then
            self.BlowoutVars.BlowoutStarted = true
            local dur = 30 --time until blowout hits - 60-90s probably
            self:ChangePhase(1, dur)
            self.BlowoutVars.PrehitTime = CT + dur - 6
            self.BlowoutVars.BlastTime = CT + dur
            self.BlowoutVars.BlowoutStep = 1
            self:PlaySoundOnClient("announce1")
        end

        if (self.BlowoutVars.BlowoutStarted) then
            self.NextThink = CT + 0.25

            if (self.BlowoutVars.PrehitTime < CT and self.BlowoutVars.BlowoutStep < 2) then
                self.BlowoutVars.BlowoutStep = 2
                self:PlaySoundOnClient("prehit")
                --print("Prehit - phase 2")
            end

            if (self.BlowoutVars.BlastTime < CT and self.BlowoutVars.BlowoutStep < 3) then
                self.BlowoutVars.BlowoutStep = 3
                self.BlowoutVars.BlowoutHitTime = CT + 18
                self.BlowoutVars.BuildupTime = CT + 2
                self.BlowoutVars.FinalSoundTime = CT + 17.25
                self:PlaySoundOnClient("start")
                self:ChangePhase(2, 0)
                --print("Start - phase 3")
                local e = ents.Create("env_shake") --Shake the world a little
                e:SetKeyValue("amplitude", "1")
                e:SetKeyValue("frequency", "100.0")
                e:SetKeyValue("duration", "10")
                e:SetKeyValue("spawnflags", "5")
                e:Fire("startshake")
            end

            if (self.BlowoutVars.BuildupTime < CT and self.BlowoutVars.BlowoutStep == 3) then
                self.BlowoutVars.BlowoutStep = 4
                self:PlaySoundOnClient("buildup")
                --print("buildup - phase 4")
            end

            if (self.BlowoutVars.FinalSoundTime < CT and self.BlowoutVars.BlowoutStep == 4) then
                self.BlowoutVars.BlowoutStep = 5
                self:PlaySoundOnClient("end")
                --print("end - phase 5")
            end

            if (self.BlowoutVars.BlowoutHitTime < CT and self.BlowoutVars.BlowoutStep == 5) then
                self.BlowoutVars.BlowoutStep = 6

                local movetypes = {
                    --[MOVETYPE_NONE] = true,
                    --[MOVETYPE_FLYGRAVITY] = true,
                    [MOVETYPE_NOCLIP] = true,
                    [MOVETYPE_OBSERVER] = true
                }

                for _, v in pairs(player.GetAll()) do
                    if (not self:IsPosSafe(v:GetShootPos(), v) and not movetypes[v:GetMoveType()]) then
                        v:Kill()
                    end
                end

                self:ChangePhase(3, 0)
                ix.plugin.list["anomalycontroller"]:cleanAnomalies()
                ix.plugin.list["anomalycontroller"]:spawnAnomalies()

                if ix.config.Get("blowoutRemoveNPCs", false) then
                    for k, v in pairs(ents.GetAll()) do
                        if IsValid(v) and (v:IsNPC() or baseclass.Get(v:GetClass()).Base == 'base_nextbot' or baseclass.Get(v:GetClass()).Base == 'nz_base' or baseclass.Get(v:GetClass()).Base == 'nz_risen') and not IsFriendEntityName(v:GetClass()) then
                            v:Remove()
                        end
                    end
                end

                if ix.config.Get("blowoutRemoveItems", false) then
                    for k, v in pairs(ents.FindByClass("ix_item")) do
                      if (v.bTemporary) then
                            v:Remove()
                        end
                    end
                end

                --print("killing - phase 6")
                self.BlowoutVars.PostHitActionTime = CT + 1
            end

            if (self.BlowoutVars.PostHitActionTime < CT and self.BlowoutVars.BlowoutStep > 5) then
                if (self.BlowoutVars.BlowoutStep < 7) then
                    self.BlowoutVars.BlowoutStep = 7
                    self.BlowoutVars.PostHitActionTime = CT + 6
                    --print("waiting - phase 7")
                elseif (self.BlowoutVars.BlowoutStep < 8) then
                    self.BlowoutVars.BlowoutStep = 8
                    self.BlowoutVars.PostHitActionTime = CT + 3.5
                    self:ChangePhase(4, 3.5)
                    --print("clearing up - phase 8")
                elseif (self.BlowoutVars.BlowoutStep < 9) then
                    self.BlowoutVars.BlowoutStep = 9
                    self.BlowoutVars.PostHitActionTime = CT + 8
                    self:ChangePhase(5, CurTime() + 20)
                    --print("finishing - phase 9")
                elseif (self.BlowoutVars.BlowoutStep < 10) then
                    self.BlowoutVars.BlowoutStep = 10
                    self:PlaySoundOnClient("posthit")
                    self.BlowoutVars.PostHitActionTime = CT + 12
                    --print("announce - phase 10")
                    self:ResetBlowoutVars()
                elseif (self.BlowoutVars.BlowoutStep < 11) then
                    self:ChangePhase(0, 0)
                    self:ResetBlowoutVars()
                    --print("done - phase 11")
                end
            end

            if self.BlowoutVars.NextHitSound < CT and self.BlowoutVars.BlowoutStep > 3 then
                self.BlowoutVars.NextHitSound = CT + math.Rand(0.75, 4)
                self:PlaySoundOnClient("hit") --Play the thunder sounds
                local e = ents.Create("env_shake") --Shake the world a little
                e:SetKeyValue("amplitude", "3")
                e:SetKeyValue("frequency", "100.0")
                e:SetKeyValue("duration", "10")
                e:SetKeyValue("spawnflags", "5")
                e:Fire("startshake")
            end

            if self.BlowoutVars.NextAmbientSound == 0 then
                self.BlowoutVars.NextAmbientSound = CT + 5
            elseif CT > self.BlowoutVars.NextAmbientSound then
                self.BlowoutVars.NextAmbientSound = CT + math.random(15, 20)
                self:PlaySoundOnClient("ambient")
            end
        end
    end

    function PLUGIN:PlaySoundOnClient(snd)
        local ID = 0

        if snd == "announce1" then
            ID = 1
        elseif snd == "announce2" then
            ID = 2
        elseif snd == "prehit" then
            ID = 3
        elseif snd == "ambient" then
            ID = math.random(4, 8)
        elseif snd == "start" then
            ID = 9
        elseif snd == "buildup" then
            ID = 10
        elseif snd == "hit" then
            ID = math.random(11, 13)
        elseif snd == "end" then
            ID = 14
        elseif snd == "posthit" then
            ID = 15
        end

        if ID > 0 then
            net.Start("BlowoutPlaySound")
            net.WriteUInt(ID, 8)
            net.Broadcast()
        end
    end

    function PLUGIN:ChangePhase(phase, duration)
        net.Start("BlowoutChangePhase")
        net.WriteUInt(phase, 8)
        net.WriteFloat(duration or 0)
        net.Broadcast()
    end

    function PLUGIN:IsPosSafe(pos, client)
        local tracedata_up = {}
        tracedata_up.start = pos
        tracedata_up.endpos = pos + Vector(0, 0, 999999)
        tracedata_up.mask = MASK_SOLID + MASK_WATER
        tracedata_up.filter = client
        local trace_up = util.TraceLine(tracedata_up) --Can the entity see the sky?

        if trace_up.HitSky then
            local Pos_up = trace_up.HitPos
            local tracedata_down = {}
            tracedata_down.start = Pos_up
            tracedata_down.endpos = pos
            tracedata_down.mask = MASK_SOLID + MASK_WATER
            tracedata_down.filter = client
            local trace_down = util.TraceLine(tracedata_down) --Can the sky see the entity? (excludes entities that are below displacements or inside brushes)
            if (not trace_down.Hit) then return false end

            return true
        end

        return true
    end

    function PLUGIN:ResetBlowoutVars()
        self.BlowoutVars.BlowoutStarted = false
        self.BlowoutVars.PrehitTime = 0
        self.BlowoutVars.BlastTime = 0
        self.BlowoutVars.BuildupTime = 0
        self.BlowoutVars.BlowoutHitTime = 0
        self.BlowoutVars.FinalSoundTime = 0
        self.BlowoutVars.NextAmbientSound = 0
        self.BlowoutVars.NextHitSound = 0
        self.BlowoutVars.BlowoutStep = 0
        self.BlowoutVars.PostHitActionTime = 0
        self.BlowoutVars.BlowoutFinishTime = 0
        self.NextBlowout = CurTime() + (ix.config.Get("blowoutRateCycle", 120) * 60)
    end
end

ix.command.Add("blowouttrigger", {
    adminOnly = true,
    description = "Triggers an instant blowout. Use /blowouttriggerdelay for a delayed blowout.",
    OnRun = function(self, client)
        if not ix.config.Get("blowoutEnabled") then
            if client:IsSuperAdmin() then
                client:Notify("Blowouts are currently disabled on the server! - You can enable it in the TAB menu config.")
            else
                if not client:IsSuperAdmin() then
                    client:Notify("Blowouts are currently disabled on the server!")
                end
            end

            return
        end

        if PLUGIN.BlowoutVars.BlowoutStarted then return client:Notify("A blowout is already active! You can not trigger another blowout until the active blowout has finished.") end

        PLUGIN.NextBlowout = CurTime()
        client:Notify("You have triggered a blowout to happen any moment now!")
    end
})

ix.command.Add("blowouttriggerdelay", {
    adminOnly = true,
    description = "Triggers a blowout with a delay until it starts. Delay is in seconds.",
    arguments = bit.bor(ix.type.number, ix.type.optional),
    OnRun = function(self, client, delay)
        if not ix.config.Get("blowoutEnabled") then
            if client:IsSuperAdmin() then
                client:Notify("Blowouts are currently disabled on the server! - You can enable it in the TAB menu config.")
            else
                if not client:IsSuperAdmin() then
                    client:Notify("Blowouts are currently disabled on the server!")
                end
            end

            return
        end

        if PLUGIN.BlowoutVars.BlowoutStarted then return client:Notify("A blowout is already active! You can not trigger another blowout until the active blowout has finished.") end

        if not delay then
            delay = 10
        end

        PLUGIN.NextBlowout = CurTime() + delay
        client:Notify("You have triggered a blowout to happen in " .. delay .. " seconds!")
    end
})

ix.command.Add("blowoutresetcycle", {
    adminOnly = true,
    description = "Resets the blowout rate cycle back to its original set time.",
    OnRun = function(self, client, delay)
        if not ix.config.Get("blowoutEnabled") then
            if client:IsSuperAdmin() then
                client:Notify("Blowouts are currently disabled on the server! - You can enable it in the TAB menu config.")
            else
                if not client:IsSuperAdmin() then
                    client:Notify("Blowouts are currently disabled on the server!")
                end
            end

            return
        end

        if PLUGIN.BlowoutVars.BlowoutStarted then return client:Notify("A blowout is already active! You can not reset its cycle until the blowout has finished.") end

        PLUGIN.NextBlowout = CurTime() + (ix.config.Get("blowoutRateCycle", 120) * 60)
        client:Notify("You have reset the blowout cycle! The next one will happen in " .. ix.config.Get("blowoutRateCycle", 120) .. " minutes!")
    end
})

ix.command.Add("blowoutgetnexttime", {
    adminOnly = true,
    description = "Notifies yourself the time until the next automated blowout.",
    OnRun = function(self, client, delay)
        if not ix.config.Get("blowoutEnabled") then
            if client:IsSuperAdmin() then
                client:Notify("Blowouts are currently disabled on the server! - You can enable it in the TAB menu config.")
            else
                if not client:IsSuperAdmin() then
                    client:Notify("Blowouts are currently disabled on the server!")
                end
            end

            return
        end

        if PLUGIN.BlowoutVars.BlowoutStarted then return client:Notify("A blowout is already active! You can not get the next time until a blowout until after the blowout has finished.") end

        client:Notify("Time until the next automated blowout: " .. math.Round(PLUGIN.NextBlowout - CurTime()) .. " seconds (" .. math.Round((PLUGIN.NextBlowout - CurTime()) / 60, 2) .. " minutes).")
    end
})
