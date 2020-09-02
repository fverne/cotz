SWEP.Base = "weapon_base"

if ( SERVER ) then
  AddCSLuaFile( "shared.lua" )
  SWEP.HoldType     = "ar2"
end

-- Visual/sound settings
SWEP.PrintName    = "AKS74u"
SWEP.Category   = "NPC SWEPS"
SWEP.Slot     = 2
SWEP.SlotPos    = 4
SWEP.DrawAmmo   = true
SWEP.DrawCrosshair  = true
SWEP.ViewModelFlip  = true
SWEP.ViewModelFOV = 64
SWEP.ViewModel    = "models/weapons/v_rif_ak47.mdl"
SWEP.WorldModel   = "models/weapons/w_smg_aks.mdl"
SWEP.ReloadSound  = "weapons/pistol/pistol_reload1.wav"
SWEP.HoldType   = "ar2"

-- Other settings
SWEP.Weight     = 5
SWEP.AutoSwitchTo = false
SWEP.AutoSwitchFrom = false
SWEP.Spawnable    = false
SWEP.AdminSpawnable = false

-- SWEP info
SWEP.Author     = ""
SWEP.Contact    = ""
SWEP.Purpose    = ""
SWEP.Instructions = ""

SWEP.firepitch = 100

-- Primary fire settings
SWEP.Primary.Sound        = "CW_AK74_FIRE"
SWEP.Primary.Damage       = 19
SWEP.Primary.NumShots     = 1
SWEP.Primary.Recoil       = 0
SWEP.Primary.Cone       = 8
SWEP.Primary.Delay        = 0.000005
SWEP.Primary.ClipSize     = 30
SWEP.Primary.DefaultClip    = 256
SWEP.Primary.Tracer       = 1
SWEP.Primary.Force        = 10
SWEP.Primary.TakeAmmoPerBullet  = false
SWEP.Primary.Automatic      = true
SWEP.Primary.Ammo       = "SMG1"

-- Secondary fire settings
SWEP.Secondary.Sound        = ""
SWEP.Secondary.Damage       = 10
SWEP.Secondary.NumShots       = 1
SWEP.Secondary.Recoil       = 1
SWEP.Secondary.Cone         = 3
SWEP.Secondary.Delay        = 0.01
SWEP.Secondary.ClipSize       = -1
SWEP.Secondary.DefaultClip      = 0
SWEP.Secondary.Tracer       = 1
SWEP.Secondary.Force        = 5
SWEP.Secondary.TakeAmmoPerBullet  = false
SWEP.Secondary.Automatic      = false
SWEP.Secondary.Ammo         = ""

SWEP.BurstNum = 6
SWEP.BurstCnt = 0

-- Hooks
function SWEP:Initialize()
  if ( SERVER ) then
    self:SetWeaponHoldType( self.HoldType )
  end
end

function SWEP:PrimaryAttack()
  if not IsFirstTimePredicted() then return end
  if ( !self:CanPrimaryAttack() or self:GetNextPrimaryFire() > CurTime() ) then return end

  if(self.BurstCnt == 0) then self.BurstCnt = self.BurstNum end

  local bullet = {} -- Set up the shot
  bullet.Num = self.Primary.NumShots
  bullet.Src = self.Owner:GetShootPos()
  bullet.Dir = self.Owner:GetAimVector()
  bullet.Spread = Vector( self.Primary.Cone / 90, self.Primary.Cone / 90, 0 )
  bullet.Tracer = self.Primary.Tracer
  bullet.Force = self.Primary.Force
  bullet.Damage = self.Primary.Damage
  bullet.AmmoType = self.Primary.Ammo

  self.Owner:FireBullets( bullet )
  self.Owner:MuzzleFlash()
  self.Weapon:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
  --self.Owner:SetAnimation( PLAYER_ATTACK1 )
  self.Weapon:EmitSound(Sound(self.Primary.Sound),340,self.firepitch)
  if (!self.Owner:IsNPC()) then
    if (self.Primary.TakeAmmoPerBullet) then
      self:TakePrimaryAmmo(self.Primary.NumShots)
    else
      self:TakePrimaryAmmo(1)
    end
  end

  self.BurstCnt = self.BurstCnt - 1
  if( self.BurstCnt == 0 ) then
    self:SetNextPrimaryFire( CurTime() + 3 )
    self.Owner:SetSchedule(SCHED_TAKE_COVER_FROM_ENEMY)
    self.Owner.NextAttack = CurTime() + 8
  else
    self:SetNextPrimaryFire( CurTime() + self.Primary.Delay )
  end

end

function SWEP:Think()
end

function SWEP:Reload()
  self.Weapon:DefaultReload(ACT_VM_RELOAD)
  self.firepitch = math.random(94,106)
  return true
end

function SWEP:Deploy()
  self.firepitch = math.random(94,106)
  return true
end

function SWEP:Holster()
  return true
end

function SWEP:OnRemove()
end

function SWEP:OnRestore()
self.firepitch = math.random(94,106)
end

function SWEP:Precache()
end

function SWEP:OwnerChanged()
end

function SWEP:GetNPCBurstSettings()
  local burstcntmin = 4
  local busrtcntmax = 5
  local burstdelay = 0.05

  return burstcntmin, burstcntmax, burstdelay
end

function SWEP:GetNPCRestTimes()
  local minwait = 0.05
  local maxwait = 0.1

  return minwait, maxwait
end