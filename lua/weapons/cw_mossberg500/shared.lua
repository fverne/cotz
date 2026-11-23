AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "Mossberg 500"
	SWEP.CSMuzzleFlashes = true
	SWEP.ViewModelMovementScale = 1

	SWEP.IconLetter = "k"
	killicon.AddFont("cw_ump45", "CW_KillIcons", SWEP.IconLetter, Color(255, 80, 0, 150))

	SWEP.FireMoveMod = 1

	SWEP.CustomizationMenuScale = 0.016
	SWEP.ReticleInactivityPostFire = 0.6

	SWEP.LuaVMRecoilAxisMod = {vert = 1.5, hor = 2, roll = 1, forward = 1, pitch = 1}

end

SWEP.Attachments = {
["+reload"] = {header = "Ammo", offset = {700, 325}, atts = {"am_slugrounds", "am_trishot", "am_dartrounds", "am_magnumbuck"}}
}

SWEP.SpeedDec = 15

SWEP.Slot = 3
SWEP.HoldType = "ar2"
SWEP.NormalHoldType = "ar2"
SWEP.RunHoldType = "passive"
SWEP.FireModes = {"pump"}
SWEP.Base = "cw_base"
SWEP.Category = "STALKER Weapons"

SWEP.Author			= "gumlefar & verne"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 5
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "12 Gauge"

SWEP.WearDamage = 0.33
SWEP.WearEffect = 0.005

SWEP.FireDelay = 1.0
SWEP.Recoil = 4.5

SWEP.HipSpread = 0.06
SWEP.AimSpread = 0.015
SWEP.VelocitySensitivity = 4
SWEP.MaxSpreadInc = 0.35
SWEP.ClumpSpread = 0.030
SWEP.SpreadPerShot = 0.19
SWEP.SpreadCooldown = 0.2
SWEP.Shots = 9
SWEP.Damage = 38
SWEP.DeployTime = 1

SWEP.Chamberable = true

-- Anomaly CW2.0 model, animations and viewmodel recoil from cw_anomaly_mossberg590.

SWEP.ViewModel = "models/flaymi/anomaly/weapons/v_models/mossberg590.mdl"
SWEP.WorldModel = "models/flaymi/anomaly/weapons/w_models/wpn_mossberg590_w.mdl"
SWEP.ViewModelFOV = 55
SWEP.AimViewModelFOV = 55
SWEP.ViewModelFlip = false
SWEP.UseHands = true
SWEP.IronsightPos = Vector(-3.01, 0, 3.1)
SWEP.IronsightAng = Vector(-0.061, 0.01, 0)
SWEP.SprintPos = Vector(5.8, -7.6, 1.2)
SWEP.SprintAng = Vector(-14, 49, -10)
SWEP.Animations = {
	["idle"] = "anm_idle",
	["draw"] = "anm_show",
	["holster"] = "anm_hide",
	["fire"] = "anm_shots",
	["reload"] = "anm_open",
	["reload_start"] = "anm_open",
	["insert"] = "anm_add_cartridge",
	["reload_end"] = "anm_close",
	["anm_hide"] = "anm_hide",
	["anm_idle"] = "anm_idle",
	["anm_idle_aim"] = "anm_idle_aim",
	["anm_idle_sprint"] = "anm_idle_sprint",
	["anm_open"] = "anm_open",
	["anm_add_cartridge"] = "anm_add_cartridge",
	["anm_close"] = "anm_close",
	["anm_shots"] = "anm_shots",
	["anm_show"] = "anm_show",
	["anm_show_first"] = "anm_show_first",
}
SWEP.Sounds = {
	["anm_hide"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.MOSSBERG590.Holster",
		},
	},
	["anm_add_cartridge"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.MOSSBERG590.ReloadInsert",
		},
	},
	["anm_close"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.MOSSBERG590.ReloadEnd",
		},
	},
	["anm_shots"] = {
		[1] = {
			["time"] = 0.066667,
			["sound"] = "TFA_ANOMALY.MOSSBERG590.Pump",
		},
	},
	["anm_show"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.MOSSBERG590.Draw",
		},
	},
	["anm_show_first"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.MOSSBERG590.Draw",
		},
	},
}
SWEP.ReloadSpeed = 1
SWEP.ReloadTime = 0.766667
SWEP.ReloadTime_Empty = 1
SWEP.ReloadHalt = 0.766667
SWEP.ReloadHalt_Empty = 1
SWEP.ShotgunReload = true
SWEP.ReloadStartTime = 0.766667
SWEP.InsertShellTime = 0.8
SWEP.ReloadFinishWait = 1.466667
SWEP.AlwaysPlayReloadEnd = true
SWEP.MuzzleAttachmentName = "muzzle"
SWEP.MuzzleEffect = "muzzleflash_ak74"
SWEP.Shell = false
SWEP.WM = "models/flaymi/anomaly/weapons/w_models/wpn_mossberg590_w.mdl"
SWEP.DrawTraditionalWorldModel = false
SWEP.WMPos = Vector(-1, 4.0222, -3.3634)
SWEP.WMAng = Vector(-10, 0, 180)
SWEP.FireSound = "TFA_ANOMALY.MOSSBERG590.FIRE"
SWEP.FireSoundSuppressed = "TFA_ANOMALY.MOSSBERG590.FIRE"
SWEP.LuaViewmodelRecoil = true
SWEP.LuaViewmodelRecoilOverride = true

if CLIENT then
	SWEP.SelectIcon = surface.GetTextureID("vgui/entities/tfa_anomaly_mossberg590")
end
