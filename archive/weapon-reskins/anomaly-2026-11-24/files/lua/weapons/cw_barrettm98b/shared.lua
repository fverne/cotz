AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")
if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "Barret M98b"
	SWEP.CSMuzzleFlashes = true
	SWEP.ViewModelMovementScale = 1.15

	SWEP.IconLetter = "i"

	SWEP.FireMoveMod = 0.6

	//SWEP.DisableSprintViewSimulation = true

	SWEP.LuaVMRecoilAxisMod = {vert = 0.5, hor = 1, roll = 1, forward = 0.5, pitch = 0.5}

end

	SWEP.Attachments = {
		[2] = {header = "Barrel", offset = {-500, 150},  atts = {"md_saker"}},
		["+reload"] = {header = "Ammo", offset = {800, 150}, atts = {"am_hollowpoint", "am_armorpiercing"}}
	}

SWEP.SpeedDec = 35

SWEP.AimBreathingIntensity = 1
SWEP.AimBreathingEnabled = false

SWEP.Slot = 3
SWEP.HoldType = "ar2"
SWEP.NormalHoldType = "ar2"
SWEP.RunHoldType = "passive"
SWEP.FireModes = {"bolt"}
SWEP.Base = "cw_base"
SWEP.Category = "STALKER Weapons"

SWEP.Author			= "gumlefar & verne"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.WearDamage = 0.33
SWEP.WearEffect = 0.005

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 5
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= ".338 Lapua"

SWEP.FireDelay = 1.6
SWEP.Recoil = 7.2
SWEP.CustomizationMenuScale = 0.018
SWEP.ForceBackToHipAfterAimedShot = true
SWEP.GlobalDelayOnShoot = 1.5

SWEP.HipSpread = 0.08
SWEP.AimSpread = 0.003
SWEP.VelocitySensitivity = 18
SWEP.MaxSpreadInc = 0.9
SWEP.SpreadPerShot = 0.007
SWEP.SpreadCooldown = 0.2
SWEP.Shots = 1
SWEP.Damage = 450
SWEP.DeployTime = 1

SWEP.Chamberable = true

function SWEP:IndividualThink()
	if (SERVER) then
		if not self.ActiveAttachments.md_rearsight and not self:hasAttachmentInCategory(1) then
			self:attachSpecificAttachment("md_rearsight")
		end

		if( self.ActiveAttachments.md_rearsight and self:hasAttachmentInCategory(1)) then
			self:detach(3)
		end
	end
end

-- Anomaly CW2.0 model, animations and viewmodel recoil from cw_anomaly_m98b.

SWEP.ViewModel = "models/flaymi/anomaly/weapons/v_models/m98b.mdl"
SWEP.AnomalyScopeZoom = 4
SWEP.AnomalyReticle = "models/flaymi/stalker/anomaly/weapons/m98b/wpn_crosshair_modern1"
SWEP.WorldModel = "models/flaymi/anomaly/weapons/w_models/wpn_m98b_w.mdl"
SWEP.ViewModelFOV = 55
SWEP.AimViewModelFOV = 55
SWEP.ViewModelFlip = false
SWEP.UseHands = true
SWEP.IronsightPos = Vector(-3.7551, -5, 2.357)
SWEP.IronsightAng = Vector(0, 0, -0.1)
SWEP.SprintPos = Vector(7.5, -7, 0.3)
SWEP.SprintAng = Vector(-12, 51, -11)
SWEP.Animations = {
	["idle"] = "anm_idle",
	["draw"] = "anm_show",
	["holster"] = "anm_hide",
	["fire"] = "anm_shots",
	["reload"] = "anm_reload",
	["reload_empty"] = "anm_reload_empty",
	["anm_hide"] = "anm_hide",
	["anm_idle"] = "anm_idle",
	["anm_idle_aim"] = "anm_idle_aim",
	["anm_idle_sprint"] = "anm_idle_sprint",
	["anm_reload"] = "anm_reload",
	["anm_reload_empty"] = "anm_reload_empty",
	["anm_shots"] = "anm_shots",
	["anm_shots_aim"] = "anm_shots_aim",
	["anm_show"] = "anm_show",
	["anm_show_first"] = "anm_show_first",
}
SWEP.Sounds = {
	["anm_hide"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.M98B.Holster",
		},
	},
	["anm_reload"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.M98B.Reload",
		},
	},
	["anm_reload_empty"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.M98B.Reload",
		},
	},
	["anm_shots"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.M98B.Bolt",
		},
	},
	["anm_shots_aim"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.M98B.Bolt",
		},
	},
	["anm_show"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.M98B.Draw",
		},
	},
	["anm_show_first"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.M98B.Draw",
		},
	},
}
SWEP.ReloadSpeed = 1
SWEP.ReloadChamberCuts = {
	anm_reload = {from = 2.710526, to = 4.657895},
}
SWEP.ReloadTime = 5.131579
SWEP.ReloadTime_Empty = 5.131579
SWEP.ReloadHalt = 5.131579
SWEP.ReloadHalt_Empty = 5.131579
SWEP.ShotgunReload = false
SWEP.ReloadStartTime = 1
SWEP.InsertShellTime = 1
SWEP.ReloadFinishWait = 1
SWEP.AlwaysPlayReloadEnd = true
SWEP.MuzzleAttachmentName = "muzzle"
SWEP.MuzzleEffect = "muzzleflash_ak74"
SWEP.Shell = "mainshell"
SWEP.WM = "models/flaymi/anomaly/weapons/w_models/wpn_m98b_w.mdl"
SWEP.DrawTraditionalWorldModel = false
SWEP.WMPos = Vector(-1.2, 4.2824, -2.6834)
SWEP.WMAng = Vector(-10, 0, 180)
SWEP.FireSound = "TFA_ANOMALY.M98B.FIRE"
SWEP.FireSoundSuppressed = "TFA_ANOMALY.M98B.FIRE"
SWEP.LuaViewmodelRecoil = true
SWEP.LuaViewmodelRecoilOverride = true

if CLIENT then
	SWEP.SelectIcon = surface.GetTextureID("vgui/entities/tfa_anomaly_m98b")
end

if CLIENT then
	SWEP.AttachmentModelsVM = {
		["md_saker"] = {
			model = "models/cw2/attachments/556suppressor.mdl",
			bone = "wpn_body",
			pos = Vector(-0.013526, -1.285469, -25.412521),
			angle = Angle(0.035855, 179.570239, 89.850293),
			size = Vector(0.72, 0.72, 0.72),
		},
	}
end
