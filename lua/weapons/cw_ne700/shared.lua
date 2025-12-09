AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "Accurate Reloading .700 Nitro Express"
	SWEP.CSMuzzleFlashes = true
	SWEP.ViewModelMovementScale = 1.15
	
	SWEP.IconLetter = "w"
	killicon.Add("cw_ws_700", "vgui/kill_icon/cw_ws_700", Color(255, 80, 0, 150))
	SWEP.SelectIcon = surface.GetTextureID("vgui/kill_icon/cw_ws_700")
	
	SWEP.MuzzleEffect = "muzzleflash_g3"
	SWEP.PosBasedMuz = false
	SWEP.SnapToGrip = false
	SWEP.ShellScale = 0
	SWEP.ShellOffsetMul = 1
	SWEP.ShellPosOffset = {x = 4, y = 0, z = -3}
	SWEP.ForeGripOffsetCycle_Draw = 0
	SWEP.ForeGripOffsetCycle_Reload = 0
	SWEP.ForeGripOffsetCycle_Reload_Empty = 0
	SWEP.FireMoveMod = 0.6


	SWEP.IronsightPos = Vector(-2.592, 2, 2.68)
	SWEP.IronsightAng = Vector(-0.306, -0.76, -1.8)
	
	SWEP.EoTechPos = Vector(-2.461, 0, 0.759)
	SWEP.EoTechAng = Vector(0, 0, 0)

	//SWEP.AimpointPos = Vector(-2.5, 0, 1.399)
	//SWEP.AimpointAng = Vector(0, 0, 0)
	SWEP.AimpointPos = Vector(-2.5, 0, 1.649)
	SWEP.AimpointAng = Vector(-0.704, 0, 0)

	SWEP.MicroT1Pos = Vector(-2.466, 0, 1.32)
	SWEP.MicroT1Ang = Vector(0, 0, 0)
	
	SWEP.ACOGPos = Vector(-2.481, 0, 1.039)
	SWEP.ACOGAng = Vector(0, 0, 0)
	
	SWEP.SprintPos = Vector(1.786, 0, -1)
	SWEP.SprintAng = Vector(-10.778, 27.573, 0)
	
	SWEP.ShortDotPos = Vector(-2.441, 0, 1.36)
	SWEP.ShortDotAng = Vector(0, 0, 0)

	
	-- SWEP.BackupSights = {["md_acog"] = {[1] = Vector(-2.461, 0, -0.08), [2] = Vector(0, 0, 0)}}

	SWEP.SightWithRail = false
	SWEP.ACOGAxisAlign = {right = 0, up = 0, forward = 0}
	SWEP.SchmidtShortDotAxisAlign = {right = 0, up = 0, forward = 0}
	
	SWEP.BaseArm = "Bip01 L Clavicle"
	SWEP.BaseArmBoneOffset = Vector(-50, 0, 0)


	SWEP.AttachmentModelsVM = {
		["md_microt1"] = { type = "Model", model = "models/cw2/attachments/microt1.mdl", bone = "RW_Barrel", rel = "", pos = Vector(0.1, 0, 2.596), angle = Angle(0, -90, 0), size = Vector(0.5, 0.5, 0.5)},
		["md_eotech"] = { type = "Model", model = "models/wystan/attachments/2otech557sight.mdl", bone = "RW_Barrel", rel = "", pos = Vector(-16.105, -0.401, -13.7), angle = Angle(0, 0, 0), size = Vector(1.5, 1.5, 1.5)},
		["md_aimpoint"] = { type = "Model", model = "models/wystan/attachments/aimpoint.mdl", bone = "RW_Barrel", rel = "", pos = Vector(-6.1, 0.3, -3.3), angle = Angle(0, 90, 0), size = Vector(1, 1, 1)},
		["md_schmidt_shortdot"] = { type = "Model", model = "models/cw2/attachments/schmidt.mdl", bone = "RW_Barrel", rel = "", pos = Vector(-5.5, 0.349, -3.3), angle = Angle(0, 0, 0), size = Vector(1, 1, 1)},
		["md_acog"] = { type = "Model", model = "models/wystan/attachments/2cog.mdl", bone = "RW_Barrel", rel = "", pos = Vector(-5.715, 0.4, -3.3), angle = Angle(0, 90, 0), size = Vector(1, 1, 1)},
		["md_anpeq15"] = { type = "Model", model = "models/cw2/attachments/anpeq15.mdl", bone = "RW_Barrel", rel = "", pos = Vector(0, 0, 2.299), angle = Angle(0, 180, 0), size = Vector(0.5, 0.5, 0.5)}
	}

	SWEP.ForegripOverride = true
	SWEP.ForegripParent = "NewPos"
	SWEP.ForegripOverridePos = {
		["NewPos"] = {["TrueRoot"] = { scale = Vector(1, 1, 1), pos = Vector(2.64, -2.408, -2.721), angle = Angle(1, 0, 0) }}
	}

	SWEP.ReloadViewBobEnabled = true

	SWEP.LuaVMRecoilAxisMod = {vert = 2.5, hor = 2, roll = 3, forward = 1, pitch = 2,}
end

SWEP.RailBGs = {main = 3, on = 1, off = 0}
SWEP.BipodBGs = {main = 4, on = 1, off = 0}
SWEP.SightBGs = {main = 2, sg1 = 1, none = 0}

SWEP.LuaViewmodelRecoil = false
SWEP.ADSFireAnim  = true

SWEP.Attachments = {}

SWEP.Animations = {fire = {"shoot_single", "shoot_single2"},
	reload = "reload",
	reload_empty = "reload_empty",
	idle = "idle",
	draw = "draw"}
	
SWEP.Sounds = {draw = {{time = 0, sound = "CW_700nitro_deploy"}},

	reload = {[1] = {time = 0, sound = "CW_700nitro_open"},
	[2] = {time = 1.7, sound = "CW_700nitro_insert"},
	[3] = {time = 2.2, sound = "CW_700nitro_close"}},
	
	reload_empty = {[1] = {time = 0, sound = "CW_700nitro_open"},
	[2] = {time = 1.7, sound = "CW_700nitro_insert"},
	[3] = {time = 2.2, sound = "CW_700nitro_close"}},
}
SWEP.SpeedDec = 40

SWEP.Slot = 3
SWEP.SlotPos = 0
SWEP.HoldType = "ar2"
SWEP.NormalHoldType = "ar2"
SWEP.RunHoldType = "passive"
SWEP.FireModes = {"semi"}
SWEP.Base = "cw_base"
SWEP.Category = "STALKER Weapons"

SWEP.Author			= ""
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModelFOV	= 70
SWEP.ViewModelFlip	= false
SWEP.UseHands = true
SWEP.ViewModel		= "models/weapons/v_fc4_700nitro.mdl"
SWEP.WorldModel		= "models/weapons/w_fc4_700nitro_fixed.mdl"
SWEP.DrawTraditionalWorldModel = false
SWEP.WM = "models/weapons/w_fc4_700nitro_fixed.mdl"
SWEP.WMPos = Vector(0, 0.7, -0.5)
SWEP.WMAng = Vector(-5, -5, 180)
SWEP.Chamberable 	= false
SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 2
SWEP.Primary.DefaultClip	= 2
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= ".700 Nitro Express"

SWEP.FireDelay = 1.75
SWEP.FireSound = "CW_700nitro_FIRE"

SWEP.Recoil = 35.5
SWEP.SnapToIdlePostReload = true

SWEP.HipSpread = 0.027
SWEP.AimSpread = 0.001
SWEP.VelocitySensitivity = 8
SWEP.MaxSpreadInc = 0.06
SWEP.SpreadPerShot = 0.01
SWEP.SpreadCooldown = 0.2
SWEP.Shots = 1
SWEP.Damage = 2500
SWEP.DeployTime = 0.8

SWEP.WearDamage = 0.33
SWEP.WearEffect = 0.005

SWEP.ReloadSpeed = 0.6
SWEP.ReloadTime = 3
SWEP.ReloadTime_Empty = 3
SWEP.ReloadHalt = 3.05
SWEP.ReloadHalt_Empty = 3.05

function SWEP:postPrimaryAttack()
	if CLIENT then
		timer.Simple(1.5, function() 
			if(CurTime() < self.ReloadWait)then
				self:sendWeaponAnim("idle", 1, 0)
			end
		end)
	end
end