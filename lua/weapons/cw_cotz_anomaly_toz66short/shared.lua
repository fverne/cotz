AddCSLuaFile()
AddCSLuaFile("weapons/cw_toz66short/sh_sounds.lua")
include("weapons/cw_toz66short/sh_sounds.lua")

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "TOZ BM-16 Sawnoff"
	SWEP.CSMuzzleFlashes = true

	killicon.Add("cw_cotz_anomaly_toz66short", "weaponicons/mr96", Color(255, 80, 0, 150))

	SWEP.NoShells = true

	SWEP.ViewModelMovementScale = 0.8
	SWEP.HUD_MagText = "CYLINDER: "

	SWEP.LuaVMRecoilAxisMod = {vert = 0.5, hor = 0.75, roll = 1, forward = 0.5, pitch = 1}
	SWEP.CustomizationMenuScale = 0.01
	SWEP.DisableSprintViewSimulation = true
end

SWEP.CanRestOnObjects = false

SWEP.Attachments = {
["+reload"] = {header = "Ammo", offset = {700, 325}, atts = {"am_slugrounds", "am_trishot", "am_dartrounds", "am_magnumbuck"}}
}

SWEP.SpeedDec = 0

SWEP.Slot = 3
SWEP.HoldType = "ar2"
SWEP.NormalHoldType = "ar2"
SWEP.RunHoldType = "passive"
SWEP.FireModes = {"break","2burst"}
SWEP.Base = "cw_base"
SWEP.Category = "Anomaly Reskins"
SWEP.AdminOnly = true

SWEP.Author			= "gumlefar & verne"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 2
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "12 Gauge"

SWEP.FireDelay = 0.01
SWEP.Recoil = 4.7

SWEP.WearDamage = 0.33
SWEP.WearEffect = 0.005

SWEP.HipSpread = 0.06
SWEP.AimSpread = 0.006
SWEP.VelocitySensitivity = 6
SWEP.MaxSpreadInc = 0.4
SWEP.ClumpSpread = 0.0425
SWEP.SpreadPerShot = 0.3
SWEP.SpreadCooldown = 0.2
SWEP.Shots = 9
SWEP.Damage = 35
SWEP.DeployTime = 1
SWEP.Chamberable = false

SWEP.Shots_Base = 9
function SWEP:IndividualThink()
	if self.FireMode == "2burst" and self:Clip1() > 1 then
		self.AmmoPerShot = 2
		self.Shots = self.Shots_Base * 2
		self.Recoil = self.Recoil_Orig * 1.75
	else
		self.AmmoPerShot = 1
		self.Shots = self.Shots_Base
		self.Recoil = self.Recoil_Orig
	end
end

-- Anomaly CW2.0 model, animations and viewmodel recoil from cw_anomaly_bm16.

SWEP.ViewModel = "models/flaymi/anomaly/weapons/v_models/bm16.mdl"
SWEP.WorldModel = "models/flaymi/anomaly/weapons/w_models/wpn_bm16_w.mdl"
SWEP.ViewModelFOV = 55
SWEP.AimViewModelFOV = 55
SWEP.ViewModelFlip = false
SWEP.UseHands = true
SWEP.IronsightPos = Vector(-2.97, -2, 2.495)
SWEP.IronsightAng = Vector(2, 0, 0)
SWEP.SprintPos = Vector(6.5, -7.5, 0.55)
SWEP.SprintAng = Vector(-13, 49, -10)
SWEP.Animations = {
	["idle"] = "anm_idle",
	["draw"] = "anm_show",
	["holster"] = "anm_hide",
	["fire"] = "anm_shots",
	["reload"] = "anm_reload",
	["reload_empty"] = "anm_reload_empty",
	["fire_dry"] = "anm_shots_last",
	["anm_hide"] = "anm_hide",
	["anm_hide_last"] = "anm_hide_last",
	["anm_hide_empty"] = "anm_hide_empty",
	["anm_idle"] = "anm_idle",
	["anm_idle_last"] = "anm_idle_last",
	["anm_idle_empty"] = "anm_idle_empty",
	["anm_idle_aim"] = "anm_idle_aim",
	["anm_idle_aim_last"] = "anm_idle_aim_last",
	["anm_idle_aim_empty"] = "anm_idle_aim_empty",
	["anm_idle_sprint"] = "anm_idle_sprint",
	["anm_idle_sprint_last"] = "anm_idle_sprint_last",
	["anm_idle_sprint_empty"] = "anm_idle_sprint_empty",
	["anm_reload"] = "anm_reload",
	["anm_reload_empty"] = "anm_reload_empty",
	["anm_shots"] = "anm_shots",
	["anm_shots_last"] = "anm_shots_last",
	["anm_show"] = "anm_show",
	["anm_show_last"] = "anm_show_last",
	["anm_show_empty"] = "anm_show_empty",
	["anm_show_first"] = "anm_show_first",
}
SWEP.Sounds = {
	["anm_hide"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.BM16.Holster",
		},
	},
	["anm_hide_last"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.BM16.Holster",
		},
	},
	["anm_hide_empty"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.BM16.Holster",
		},
	},
	["anm_reload"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.BM16.Reload",
		},
	},
	["anm_reload_empty"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.BM16.Reload_Empty",
		},
	},
	["anm_show"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.BM16.Draw",
		},
	},
	["anm_show_last"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.BM16.Draw",
		},
	},
	["anm_show_empty"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.BM16.Draw",
		},
	},
	["anm_show_first"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.BM16.Draw",
		},
	},
}
SWEP.ReloadSpeed = 1
SWEP.ReloadTime = 4.5
SWEP.ReloadTime_Empty = 4.5
SWEP.ReloadHalt = 4.5
SWEP.ReloadHalt_Empty = 4.5
SWEP.ShotgunReload = false
SWEP.ReloadStartTime = 1
SWEP.InsertShellTime = 1
SWEP.ReloadFinishWait = 1
SWEP.AlwaysPlayReloadEnd = true
SWEP.MuzzleAttachmentName = "muzzle"
SWEP.MuzzleEffect = "muzzleflash_ak74"
SWEP.Shell = false
SWEP.WM = "models/flaymi/anomaly/weapons/w_models/wpn_bm16_w.mdl"
SWEP.DrawTraditionalWorldModel = false
SWEP.WMPos = Vector(-1, 4.265, -2.8827)
SWEP.WMAng = Vector(-10, 0, 180)
SWEP.FireSound = "TFA_ANOMALY.BM16.FIRE"
SWEP.FireSoundSuppressed = "TFA_ANOMALY.BM16.FIRE"
SWEP.LuaViewmodelRecoil = true
SWEP.LuaViewmodelRecoilOverride = false

if CLIENT then
	SWEP.SelectIcon = surface.GetTextureID("vgui/entities/tfa_anomaly_bm16")
end

function SWEP:fireAnimFunc()
end
