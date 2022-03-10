if SERVER then
    AddCSLuaFile()
end

SWEP.PrintName = "Hands"
SWEP.Author = ""
SWEP.Purpose = ""
SWEP.ViewModel = Model("models/weapons/c_arms_cstrike.mdl")
SWEP.WorldModel = ""
SWEP.AnimPrefix = "rpg"
SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "none"
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "none"
SWEP.Secondary.Delay = 0.75
SWEP.FireWhenLowered = true
SWEP.UseHands = false
SWEP.HoldType = "fist"
SWEP.NormalHoldType = "passive"
SWEP.RunHoldType = "passive"
SWEP.LowerAngles = Angle(0, 5, -14)
SWEP.LowerAngles2 = Angle(0, 5, -22)
SWEP.ViewModelFOV = 45
SWEP.ViewModelFlip = false
SWEP.Drop = false
SWEP.Secondary.Damage = 5

function SWEP:Holster()
    if (not IsValid(self.Owner)) then return end
    self:SetHoldType(self.HoldType)
end

function SWEP:Precache()
end

if SERVER then
    local ent_diff = vector_origin
    local ent_diff_time = CurTime()
    local stand_time = 0
end

function SWEP:Initialize()
    self:SetHoldType(self.HoldType)
    self.Time = 0
    self.Range = 75
    self.HoldRange = 100
    self.LastHand = 0
end

function SWEP:Think()
    if self.Drag and (not self.Owner:KeyDown(IN_ATTACK) or not IsValid(self.Drag.Entity)) then
        self.Drag = nil
    end

    if self.Drag and self.Drag.Entity:GetPos():Distance(self:GetOwner():GetShootPos()) > self.HoldRange then
        self.Drag = nil
    end

    local curTime = CurTime()

    if (CLIENT) then
        if (self.Owner) then
            local viewModel = self.Owner:GetViewModel()

            if (IsValid(viewModel)) then
                viewModel:SetPlaybackRate(1)
            end
        end
    end
end

function SWEP:PrimaryAttack()
    if SERVER then
        self.Owner:SetWepRaised(false)
    end

    --self:SetHoldType("passive")
    --self.Owner:DrawViewModel(false)
    local Pos = self.Owner:GetShootPos()
    local Aim = self.Owner:GetAimVector()

    local Tr = util.TraceLine{
        start = Pos,
        endpos = Pos + Aim * self.Range,
        filter = player.GetAll(),
    }

    local HitEnt = Tr.Entity

    if self.Drag then
        HitEnt = self.Drag.Entity
    else
        if not IsValid(HitEnt) or HitEnt:GetMoveType() ~= MOVETYPE_VPHYSICS or HitEnt:IsVehicle() or HitEnt:GetNWBool("NoDrag", false) or HitEnt.BlockDrag or IsValid(HitEnt:GetParent()) then return end

        if not self.Drag then
            self.Drag = {
                OffPos = HitEnt:WorldToLocal(Tr.HitPos),
                Entity = HitEnt,
                Fraction = Tr.Fraction,
            }
        end
    end

    if CLIENT or not IsValid(HitEnt) then return end
    local Phys = HitEnt:GetPhysicsObject()

    if IsValid(Phys) then
        local Pos2 = Pos + Aim * self.Range * self.Drag.Fraction
        local OffPos = HitEnt:LocalToWorld(self.Drag.OffPos)
        local Dif = Pos2 - OffPos
        local Nom = (Dif:GetNormal() * math.min(1, Dif:Length() / 100) * 250 - Phys:GetVelocity()) * (Phys:GetMass())
        local Nom2 = (Dif:GetNormal() * math.min(1, Dif:Length() / 100) * 10 - Phys:GetVelocity()) * (Phys:GetMass())
        local Nom3 = (Dif:GetNormal() * math.min(1, Dif:Length() / 100) * 130 - Phys:GetVelocity()) * (Phys:GetMass())
        local Nom4 = (Dif:GetNormal() * math.min(1, Dif:Length() / 100) * 200 - Phys:GetVelocity()) * (Phys:GetMass())
        local PhysRagdollMass = (Dif:GetNormal() * math.min(1, Dif:Length() / 100) * 800 - Phys:GetVelocity()) * (Phys:GetMass())

        if Phys:GetMass() >= 200 and Phys:GetMass() < 1000 and not HitEnt:IsRagdoll() then
            Phys:ApplyForceOffset(Nom2, OffPos)
            Phys:AddAngleVelocity(-Phys:GetAngleVelocity() / 4)
        else
            if Phys:GetMass() >= 50 and Phys:GetMass() < 100 and not HitEnt:IsRagdoll() then
                Phys:ApplyForceOffset(Nom3, OffPos)
                Phys:AddAngleVelocity(-Phys:GetAngleVelocity() / 4)
            else
                if Phys:GetMass() >= 20 and Phys:GetMass() < 50 and not HitEnt:IsRagdoll() then
                    Phys:ApplyForceOffset(Nom4, OffPos)
                    Phys:AddAngleVelocity(-Phys:GetAngleVelocity() / 4)
                else
                    if Phys:GetMass() < 20 and not HitEnt:IsRagdoll() then
                        Phys:ApplyForceOffset(Nom, OffPos)
                        Phys:AddAngleVelocity(-Phys:GetAngleVelocity() / 4)
                    else
                        if HitEnt:IsRagdoll() then
                            Phys:ApplyForceOffset(PhysRagdollMass, OffPos)
                            Phys:SetAngleVelocity(Vector(1, 1, 1))
                        end
                    end
                end
            end
        end
    end
end

function SWEP:SecondaryAttack()
    if SERVER then
        self.Owner:SetWepRaised(true)
    end

    --self:SetHoldType("fist")
    self.Owner:DrawViewModel(true)
    if CLIENT then return end
    if IsValid(self.Owner:GetVehicle()) then return end
    local Pos = self.Owner:GetShootPos()
    local Aim = self.Owner:GetAimVector()

    local ent = util.TraceLine{
        start = Pos,
        endpos = Pos + Aim * self.Range,
        filter = {self, self.Owner},
    }.Entity

    if (not IsFirstTimePredicted()) then return end
    self:SetNextSecondaryFire(CurTime() + self.Secondary.Delay)
    if (hook.Run("CanPlayerThrowPunch", self.Owner) == false) then return end
    local staminaUse = ix.config.Get("punchStamina", 10)

    if (staminaUse > 0) then
        local value = self.Owner:GetLocalVar("stm", 0) - staminaUse

        if (value < 0) then
            return
        elseif (SERVER) then
            self.Owner:SetLocalVar("stm", value)
        end
    end

    if (SERVER) then
        self.Owner:EmitSound("npc/vort/claw_swing" .. math.random(1, 2) .. ".wav")
    end

    local damage = self.Secondary.Damage
    self:doPunchAnimation()
    self.Owner:SetAnimation(PLAYER_ATTACK1)
    self.Owner:ViewPunch(Angle(self.LastHand + 2, self.LastHand + 5, 0.125))
    self:SetNW2Float("startTime", CurTime())
    self:SetNW2Bool("startPunch", true)
end

if CLIENT then
    local x, y = ScrW() / 2, ScrH() / 2
    local MainCol = Color(255, 255, 255)
    local Col = Color(255, 255, 255, 255)

    function SWEP:DrawHUD()
        if IsValid(self.Owner:GetVehicle()) then return end
        local Pos = self.Owner:GetShootPos()
        local Aim = self.Owner:GetAimVector()

        local Tr = util.TraceLine{
            start = Pos,
            endpos = Pos + Aim * self.Range,
            filter = player.GetAll(),
        }

        local HitEnt = Tr.Entity

        if IsValid(HitEnt) and HitEnt:GetMoveType() == MOVETYPE_VPHYSICS and not self.Drag and not HitEnt:IsVehicle() and not IsValid(HitEnt:GetParent()) and not HitEnt:GetNWBool("NoDrag", false) and not (HitEnt.CanPlayerDrag and not HitEnt:CanPlayerDrag(self.Owner)) and not HitEnt.HideDragOverlay then
            self.Time = math.min(1, self.Time + 2 * FrameTime())
        else
            self.Time = math.max(0, self.Time - 2 * FrameTime())
        end

        if self.Time > 0 then
            Col.a = MainCol.a * self.Time
            --[[
		 	draw.SimpleText(
		 		"Drag",
		 		"stalkerregularfont",
		 		x,
		 		y + 10,
		 		Col,
		 		TEXT_ALIGN_CENTER
		 	)
		 	]]
        end

        if self.Drag and IsValid(self.Drag.Entity) then
            local Pos2 = Pos + Aim * 100 * self.Drag.Fraction
            local OffPos = self.Drag.Entity:LocalToWorld(self.Drag.OffPos)
            local Dif = Pos2 - OffPos
            local A = OffPos:ToScreen()
            local B = Pos2:ToScreen()
            surface.SetDrawColor(255, 255, 255, 255)
            surface.DrawRect(A.x - 2, A.y - 2, 4, 4)
            surface.SetDrawColor(255, 255, 255, 255)
            surface.DrawRect(B.x - 2, B.y - 2, 4, 4)
            surface.SetDrawColor(255, 255, 255, 255)
            surface.DrawLine(A.x, A.y, B.x, B.y)
        end
    end
end

if (CLIENT) then
    function SWEP:PreDrawViewModel(viewModel, weapon, client)
        local hands = player_manager.TranslatePlayerHands(player_manager.TranslateToPlayerModelName(client:GetModel()))

        if (hands and hands.model) then
            viewModel:SetModel(hands.model)
            viewModel:SetSkin(hands.skin)
            viewModel:SetBodyGroups(hands.body)
        end
    end
end

function SWEP:Deploy()
    if (not IsValid(self.Owner)) then return end
    --self:reset()
    local viewModel = self.Owner:GetViewModel()

    if (IsValid(viewModel)) then
        viewModel:SetPlaybackRate(1)
        viewModel:ResetSequence(ACT_VM_FISTS_DRAW)
    end

    return true
end

function SWEP:Holster()
    if (not IsValid(self.Owner)) then return end
    --self:reset()
    local viewModel = self.Owner:GetViewModel()

    if (IsValid(viewModel)) then
        viewModel:SetPlaybackRate(1)
        viewModel:ResetSequence(ACT_VM_FISTS_HOLSTER)
    end

    return true
end

function SWEP:doPunchAnimation()
    self.LastHand = math.abs(1 - self.LastHand)
    local sequence = 4 + self.LastHand
    local viewModel = self.Owner:GetViewModel()

    if (IsValid(viewModel)) then
        viewModel:SetPlaybackRate(0.5)
        viewModel:SetSequence(sequence)
    end

    if (self:GetNW2Bool("startPunch", false)) then
        if (CurTime() > self:GetNW2Float("startTime", CurTime()) + 0.055) then
            self:doPunch()
            self:SetNW2Bool("startPunch", false)
            self:SetNW2Float("startTime", 0)
        end
    end
end

function SWEP:doPunch()
    if (IsValid(self) and IsValid(self.Owner)) then
        local damage = self.Secondary.Damage

        local context = {
            damage = damage
        }

        local result = hook.Run("PlayerGetFistDamage", self.Owner, damage, context)

        if (result ~= nil) then
            damage = result
        else
            damage = context.damage
        end

        self.Owner:LagCompensation(true)
        local data = {}
        data.start = self.Owner:GetShootPos()
        data.endpos = data.start + self.Owner:GetAimVector() * 96
        data.filter = self.Owner
        local trace = util.TraceLine(data)

        if (SERVER and trace.Hit) then
            local entity = trace.Entity

            if (IsValid(entity)) then
                local damageInfo = DamageInfo()
                damageInfo:SetAttacker(self.Owner)
                damageInfo:SetInflictor(self)
                damageInfo:SetDamage(damage)
                damageInfo:SetDamageType(DMG_SLASH)
                damageInfo:SetDamagePosition(trace.HitPos)
                damageInfo:SetDamageForce(self.Owner:GetAimVector() * 500)
                entity:DispatchTraceAttack(damageInfo, data.start, data.endpos)
                self.Owner:EmitSound("physics/body/body_medium_impact_hard" .. math.random(1, 6) .. ".wav", 80)
            end
        end

        hook.Run("PlayerThrowPunch", self.Owner, trace)
        self.Owner:LagCompensation(false)
    end
end