local PLUGIN = PLUGIN
local playerMeta = FindMetaTable("Player")

function playerMeta:ResetDrunkLevel()
    self:SetLocalVar("drunklevel", 0)
end

function playerMeta:IncreaseDrunkLevel(amount)
    if not amount or not isnumber(amount) then return end
    self:SetLocalVar("drunklevel", math.Clamp(self:GetLocalVar("drunklevel", 0) + amount, 0, 100))
end

function PLUGIN:Think()
    if not self.next_think then
        self.next_think = CurTime()
    end

    if self.next_think <= CurTime() then
        for k, v in next, player.GetAll() do
            local level = v:GetDrunkLevel()

            if level > 0 then
                v:SetLocalVar("drunklevel", math.Clamp(level - ix.config.Get("intoxicationRecoverRate", 5), 0, 100))
            end
        end

        self.next_think = CurTime() + ix.config.Get("intoxicationUpdateTime", 30)
    end
end

local moves = {
    [IN_FORWARD] = true,
    [IN_BACK] = true,
    [IN_MOVELEFT] = true,
    [IN_MOVERIGHT] = true,
    [IN_SPEED] = true,
}

function PLUGIN:StartCommand(ply, ucmd)
    if ((ply.nextDrunkCheck or 0) < CurTime()) then
        ply.nextDrunkCheck = CurTime() + 0.05

        if (ply:GetDrunkLevel() > 30) then
            ucmd:ClearButtons()

            if ((ply.nextDrunkSide or 0) < CurTime()) then
                ply.nextDrunkSide = CurTime() + math.Rand(0.1, 0.3) + (ply:GetDrunkLevel() * 0.01)
                ply.sideRoll = math.random(-1, 1)
                ply.frontRoll = math.random(-1, 1)
            end

            if (ply.frontRoll == 1) then
                ucmd:SetForwardMove(100000)
            elseif (ply.frontRoll == -1) then
                ucmd:SetForwardMove(-100000)
            end

            if (ply.sideRoll == 1) then
                ucmd:SetSideMove(100000)
            elseif (ply.sideRoll == -1) then
                ucmd:SetSideMove(-100000)
            end
        end
    end
end

function PLUGIN:PlayerLoadedCharacter(client, character)
    timer.Simple(0.25, function()
        client:ResetDrunkLevel()
    end)
end

function PLUGIN:PlayerSpawn(player)
    player:ResetDrunkLevel()
end