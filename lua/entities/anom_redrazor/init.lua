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
    self.Entity:SetModel("models/z-o-m-b-i-e/st/trees/st_bush_11.mdl") --Set its model.
    self.Entity:PhysicsInit(SOLID_VPHYSICS)
    self.Entity:SetMoveType(MOVETYPE_VPHYSICS) -- after all, gmod is a physics
    self.Entity:SetSolid(SOLID_VPHYSICS) -- Toolbox
    self.Entity:SetCollisionGroup(COLLISION_GROUP_WORLD)
    self.Entity:SetSkin(13)
    self.Entity:SetColor(Color(255, 0, 0, 255))
    local phys = self.Entity:GetPhysicsObject()

    if (phys:IsValid()) then
        phys:Sleep()
        phys:EnableMotion(false)
    end

    self.Entity:ResetSequenceInfo()
end

function ENT:Think()
    if delayTime < CurTime() then
        delayTime = CurTime() + 0.3
        local min, max = self.Entity:GetModelBounds()

        for k, v in ipairs(ents.FindInBox(self:GetPos() + Vector(min.x + 100, min.y + 100, -10), self:GetPos() + Vector(max.x - 100, max.y - 100, max.z - 100))) do
            if v:IsPlayer() and v:Alive() and v:IsValid() then
                local b = DamageInfo()
                b:SetDamage(5)
                b:SetDamageType(DMG_ACID)
                b:SetAttacker(self.Entity)
                b:SetInflictor(self.Entity)
                v:TakeDamageInfo(b)
                v:EmitSound("weapons/blades/slash.mp3")
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