AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include('shared.lua')
ENT.AutomaticFrameAdvance = true
local delayTime = 0

function ENT:SpawnFunction(ply, tr)
    if (not tr.Hit) then return end
    local SpawnPos = tr.HitPos + Vector(0, 0, -5)
    local ent = ents.Create(self.ClassName)
    ent:SetPos(SpawnPos)
    ent:Spawn()
    ent:Activate()

    return ent
end

function ENT:Initialize()
    self.Entity:SetModel("models/z-o-m-b-i-e/st/trees/st_bush_02.mdl") --Set its model.
    --self.Entity:PhysicsInit( SOLID_NONE )      -- Make us work with physics,
    self.Entity:SetMoveType(MOVETYPE_NONE) -- after all, gmod is a physics
    self.Entity:SetSolid(SOLID_NONE) -- Toolbox
    self.Entity:SetSkin(13)
    self.Entity:SetColor(Color(255, 0, 0, 255))
    local phys = self.Entity:GetPhysicsObject()

    if (phys:IsValid()) then
        phys:Wake()
    end

    self.Entity:ResetSequenceInfo()
end

function ENT:Think()
    if delayTime < CurTime() then
        delayTime = CurTime() + 0.3
        local min, max = self:GetModelBounds()

        for k, v in pairs(ents.FindInBox(self:GetPos() + Vector(-80, -80, -10), self:GetPos() + Vector(80, 80, max.z - 50))) do
            if v:IsPlayer() and v:Alive() and v:IsValid() then
                local b = DamageInfo()
                b:SetDamage(5)
                b:SetDamageType(DMG_ACID)
                b:SetAttacker(self.Entity)
                b:SetInflictor(self.Entity)
                v:TakeDamageInfo(b)
                self:EmitSound("weapons/blades/slash.mp3")
            end
        end
    end

    self:NextThink(CurTime())

    return true
end

function ENT:Use(activator, caller, type, value)
end

function ENT:KeyValue(key, value)
end

function ENT:OnTakeDamage(dmginfo)
end

function ENT:StartTouch(entity)
end

function ENT:EndTouch(entity)
end

function ENT:Touch(entity)
end