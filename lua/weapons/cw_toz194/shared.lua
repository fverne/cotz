AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "TOZ-194"
	SWEP.CSMuzzleFlashes = true
	SWEP.ViewModelMovementScale = 1.5
	
	SWEP.IconLetter = "k"
	killicon.Add( "khr_toz194", "icons/select/khr_toz194", Color(255, 80, 0, 150))
	SWEP.SelectIcon = surface.GetTextureID("icons/select/khr_toz194")
	
	SWEP.MuzzleEffect = "muzzleflash_m3"
	SWEP.PosBasedMuz = false
	SWEP.SnapToGrip = true
	SWEP.ShellScale = 0.4
	SWEP.ShellOffsetMul = 1
	SWEP.Shell = "shotshell"
	SWEP.ShellDelay = 0.1
	
	SWEP.ShellPosOffset = {x = 0, y = 0, z = 0}
	SWEP.FireMoveMod = 1
	
	SWEP.SightWithRail = true
		
	SWEP.IronsightPos = Vector(-2.008, 0, 0.92)
	SWEP.IronsightAng = Vector(-0.065, 0.023, 0)
	
	SWEP.MicroT1Pos = Vector(0, 0, 0)
	SWEP.MicroT1Ang = Vector(0, 0, 0)
	
	SWEP.EoTech553Pos = Vector(0, 0, 0)
	SWEP.EoTech553Ang = Vector(0, 0, 0)	
	
	SWEP.CSGOACOGPos = Vector(0, 0, 0)
	SWEP.CSGOACOGAng = Vector(0, 0, 0)
	
	SWEP.KR_CMOREPos =  Vector(0, 0, 0)
	SWEP.KR_CMOREAng =  Vector(0, 0, 0)
	
	SWEP.ShortDotPos = Vector(0, 0, 0)
	SWEP.ShortDotAng = Vector(0, 0, 0)
	
	SWEP.FAS2AimpointPos = Vector(0, 0, 0)
	SWEP.FAS2AimpointAng = Vector(0, 0, 0)
	
	SWEP.SprintPos = Vector(1.6, 0, -1.601)
	SWEP.SprintAng = Vector(-12.664, 22.513, -9.146)
		
	SWEP.CustomizePos = Vector(4.36, 0, -3.36)
	SWEP.CustomizeAng = Vector(19.697, 22.513, 10.553)
	
	SWEP.AlternativePos = Vector(.5, 0, -.5)
	SWEP.AlternativeAng = Vector(0, 0, 0)
	
	SWEP.CustomizationMenuScale = 0.022
	--SWEP.ReticleInactivityPostFire = .8

	SWEP.AttachmentModelsVM = {
	}
	
end

SWEP.MuzzleVelocity = 335 -- in meter/s
SWEP.LuaViewmodelRecoil = true
SWEP.FullAimViewmodelRecoil = true
SWEP.LuaViewmodelRecoilOverride = true
SWEP.ADSFireAnim = true

SWEP.Attachments = {--[1] = {header = "Sight", offset = {600, -250},  atts = {}},
	["+reload"] = {header = "Ammo", offset = {-400, 250}, atts = {"am_slugrounds", "am_trishot", "am_dartrounds", "am_magnumbuck"}}}

SWEP.Animations = {fire = {"shoot1"},
	reload_start = "start_reload",
	insert = "insert",
	reload_end = "after_reload",
	idle = "idle",
	draw = "draw"}
	
SWEP.Sounds = {shoot1 = {[1] = {time = 0.0, sound = "TOZ194.PUMPB"},
	[2] = {time = .17, sound = "TOZ194.PUMPF"}},
	
	start_reload = {{time = 0.05, sound = "CW_FOLEY_LIGHT"}},
	insert = {{time = 0.1, sound = "CW_M3SUPER90_INSERT"}},
	
	after_reload = {{time = 0, sound = "CW_FOLEY_LIGHT"}},
	
	draw = {[1] = {time = 0, sound = "CW_FOLEY_MEDIUM"},
	[2] = {time = 0.7, sound = "TOZ194.PUMPB"},
	[3] = {time = 0.95, sound = "TOZ194.PUMPF"}}}
	

SWEP.SpeedDec = 10

SWEP.Slot = 3
SWEP.SlotPos = 0
SWEP.HoldType = "ar2"
SWEP.NormalHoldType = "ar2"
SWEP.RunHoldType = "passive"
SWEP.FireModes = {"pump"}
SWEP.Base = "cw_base"
SWEP.Category = "STALKER Weapons"

SWEP.Author			= ""
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModelFOV	= 70
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/khrcw2/v_khri_khrtoz194.mdl"
SWEP.WorldModel		= "models/khrcw2/w_khri_khrtoz194.mdl"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 3
SWEP.Primary.DefaultClip	= 3
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "12 Gauge"

SWEP.FireDelay = 60/120
SWEP.FireSound = "TOZ194_FIRE"
SWEP.Recoil = 4.2

SWEP.HipSpread = 0.06
SWEP.AimSpread = 0.005
SWEP.VelocitySensitivity = 4
SWEP.MaxSpreadInc = 0.4
SWEP.ClumpSpread = 0.018
SWEP.SpreadPerShot = 0.3
SWEP.SpreadCooldown = 0.75
SWEP.Shots = 9
SWEP.Damage = 21
SWEP.DeployTime = 1.5

SWEP.ReloadSpeed = .7
SWEP.ReloadStartTime = 0.3
SWEP.InsertShellTime = 0.5
SWEP.ReloadFinishWait = .4
SWEP.ShotgunReload = true

SWEP.Chamberable = true

SWEP.Offset = {
Pos = {
Up = 1,
Right = 1,
Forward = 0,
},
Ang = {
Up = 0,
Right = -6,
Forward = 180,
}
}

function SWEP:DrawWorldModel( )
        local hand, offset, rotate

        local pl = self:GetOwner()

        if IsValid( pl ) then
                        local boneIndex = pl:LookupBone( "ValveBiped.Bip01_R_Hand" )
                        if boneIndex then
                                local pos, ang = pl:GetBonePosition( boneIndex )
                                pos = pos + ang:Forward() * self.Offset.Pos.Forward + ang:Right() * self.Offset.Pos.Right + ang:Up() * self.Offset.Pos.Up

                                ang:RotateAroundAxis( ang:Up(), self.Offset.Ang.Up)
                                ang:RotateAroundAxis( ang:Right(), self.Offset.Ang.Right )
                                ang:RotateAroundAxis( ang:Forward(),  self.Offset.Ang.Forward )

                                self:SetRenderOrigin( pos )
                                self:SetRenderAngles( ang )
                                self:DrawModel()
                        end
        else
                self:SetRenderOrigin( nil )
                self:SetRenderAngles( nil )
                self:DrawModel()
        end
end


SWEP.WearDamage = 0.1
SWEP.WearEffect = 0.05
