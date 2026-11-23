AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "FN FAL"
	SWEP.CSMuzzleFlashes = true
	SWEP.ViewModelMovementScale = 1.15

	SWEP.IconLetter = "i"
	killicon.AddFont("cw_g3a3", "CW_KillIcons", SWEP.IconLetter, Color(255, 80, 0, 150))

	SWEP.FireMoveMod = 0.6

	SWEP.LuaVMRecoilAxisMod = {vert = 0.5, hor = 1, roll = 1, forward = 0.5, pitch = 0.5}

	function SWEP:getTelescopeAngles()
		return self.Owner:EyeAngles()
	end
end

if CLIENT then
	SWEP.AttachmentModelsVM = {
		["md_eotech"] = {
			model = "models/wystan/attachments/2otech557sight.mdl",
			bone = "wpn_body",
			pos = Vector(-0.35573, 8.822231, 9.75909),
			angle = Angle(-89.289965, -84.090573, -174.090997),
			size = Vector(1.21836, 1.21836, 1.21836),
		},
		["md_microt1"] = {
			model = "models/cw2/attachments/microt1.mdl",
			bone = "wpn_body",
			pos = Vector(-0.033258, -4.07825, -4.413465),
			angle = Angle(0.065479, -0.000104, -89.906247),
			size = Vector(0.487344, 0.487344, 0.487344),
		},
		["md_aimpoint"] = {
			model = "models/wystan/attachments/aimpoint.mdl",
			bone = "wpn_body",
			pos = Vector(0.251064, 1.84669, 1.994351),
			angle = Angle(-0.073095, -179.999126, 90.706262),
			size = Vector(1.035606, 1.035606, 1.035606),
		},
		["md_reflex"] = {
			model = "models/attachments/kascope.mdl",
			bone = "wpn_body",
			pos = Vector(0.032765, -4.12298, -7.460613),
			angle = Angle(-0.073095, -179.999126, 90.706262),
			size = Vector(0.791934, 0.791934, 0.791934),
		},
		["md_cmore"] = {
			model = "models/attachments/cmore.mdl",
			bone = "wpn_body",
			pos = Vector(0.004511, -3.863084, -4.410473),
			angle = Angle(-0.073095, -179.999126, 90.706262),
			size = Vector(0.790715, 0.790715, 0.790715),
		},
		["md_schmidt_shortdot"] = {
			model = "models/cw2/attachments/schmidt.mdl",
			bone = "wpn_body",
			pos = Vector(0.387055, 2.327768, 1.408786),
			angle = Angle(-89.997841, 90, 0),
			size = Vector(1.095305, 1.095305, 1.095305),
		},
		["md_acog"] = {
			model = "models/wystan/attachments/2cog.mdl",
			bone = "wpn_body",
			pos = Vector(0.387055, 2.330278, 1.408786),
			angle = Angle(-0.002159, 180, 89.999982),
			size = Vector(1.096524, 1.096524, 1.096524),
		},
		["md_nightforce_nxs"] = {
			model = "models/cw2/attachments/l96_scope.mdl",
			bone = "wpn_body",
			pos = Vector(0.099207, -4.790318, -3.20515),
			angle = Angle(-89.997841, 90, 0),
			size = Vector(0.91377, 0.91377, 0.91377),
		},
		["md_saker"] = {
			model = "models/cw2/attachments/556suppressor.mdl",
			bone = "wpn_body",
			pos = Vector(0.002229, -1.09316, -13.656654),
			angle = Angle(-0.002863, 180, 89.999982),
			size = Vector(0.5, 0.5, 0.5),
		},
	}
end

SWEP.Attachments = {[1] = {header = "Sight", offset = {600, -300},  atts = {
	"md_eotech",
	"md_microt1",
	"md_aimpoint",
	"md_reflex",
	"md_cmore",
	"md_schmidt_shortdot",
	"md_acog",
	"md_nightforce_nxs",
}},
	[2] = {header = "Barrel", offset = {-250, -300},  atts = {"md_saker"}},
	["+reload"] = {header = "Ammo", offset = {600, 100}, atts = {"am_hollowpoint", "am_armorpiercing"}}}

SWEP.SpeedDec = 30

SWEP.Slot = 3
SWEP.HoldType = "ar2"
SWEP.NormalHoldType = "ar2"
SWEP.RunHoldType = "passive"
SWEP.FireModes = {"auto", "semi"}
SWEP.Base = "cw_base"
SWEP.Category = "STALKER Weapons"

SWEP.Author			= "gumlefar & verne"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 20
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "7.62x51MM"

SWEP.DurabilityDamageChance = 0.005
SWEP.WearDamage = 0.05
SWEP.WearEffect = 0.007

SWEP.FireDelay = 0.0923076923
SWEP.Recoil = 1.5

SWEP.HipSpread = 0.13
SWEP.AimSpread = 0.004
SWEP.VelocitySensitivity = 4
SWEP.MaxSpreadInc = 0.1
SWEP.SpreadPerShot = 0.014
SWEP.SpreadCooldown = 0.2
SWEP.Shots = 1
SWEP.Damage = 130
SWEP.DeployTime = 0.8

SWEP.RecoilToSpread = 0.8 -- the M14 in particular will have 30% more recoil from continuous fire to give a feeling of "oh fuck I should stop firing 7.62x51MM in full auto at 750 RPM"

SWEP.SnapToIdlePostReload = true

-- Anomaly CW2.0 model, animations and viewmodel recoil from cw_anomaly_fal.

SWEP.ViewModel = "models/flaymi/anomaly/weapons/v_models/fal.mdl"
SWEP.WorldModel = "models/flaymi/anomaly/weapons/w_models/wpn_fal_w.mdl"
SWEP.ViewModelFOV = 55
SWEP.AimViewModelFOV = 55
SWEP.ViewModelFlip = false
SWEP.UseHands = true
SWEP.IronsightPos = Vector(-5.603, -2, 2.678)
SWEP.IronsightAng = Vector(-0.42, 0, 0)

SWEP.EoTechPos = Vector(-5.59258, -2, 1.150759)
SWEP.EoTechAng = Vector(-0.42, 0, 0)
SWEP.MicroT1Pos = Vector(-5.62364, -2, 1.696318)
SWEP.MicroT1Ang = Vector(-0.42, 0, 0)
SWEP.AimpointPos = Vector(-5.629764, -2, 1.616772)
SWEP.AimpointAng = Vector(-0.42, 0, 0)
SWEP.ReflexPos = Vector(-5.645735, -2, 1.786976)
SWEP.ReflexAng = Vector(-0.42, 0, 0)
SWEP.CmorePos = Vector(-5.622297, -2, 1.676126)
SWEP.CmoreAng = Vector(-0.42, 0, 0)
SWEP.ShortDotPos = Vector(-5.594682, -2, 1.552673)
SWEP.ShortDotAng = Vector(-0.42, 0, 0)
SWEP.SchmidtShortDotAxisAlign = {right = 0, up = 0, forward = 0}
SWEP.ACOGPos = Vector(-5.602145, -2, 1.221727)
SWEP.ACOGAng = Vector(-0.42, 0, 0)
SWEP.ACOGAxisAlign = {right = 0, up = 0, forward = 0}
SWEP.NXSPos = Vector(-5.631352, -2, 1.970551)
SWEP.NXSAng = Vector(-0.42, 0, 0)
SWEP.NXSAlign = {right = 0, up = 0, forward = 0}
SWEP.SprintPos = Vector(5, -8.7, 0.85)
SWEP.SprintAng = Vector(-13.2, 49.5, -10)
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
			["sound"] = "TFA_ANOMALY.FAL.Holster",
		},
	},
	["anm_reload"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.FAL.Reload",
		},
	},
	["anm_reload_empty"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.FAL.Reload_Empty",
		},
	},
	["anm_show"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.FAL.Draw",
		},
	},
	["anm_show_first"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.FAL.Draw",
		},
	},
}
SWEP.ReloadSpeed = 1
SWEP.ReloadTime = 3.1
SWEP.ReloadTime_Empty = 3.1
SWEP.ReloadHalt = 3.1
SWEP.ReloadHalt_Empty = 3.1
SWEP.ShotgunReload = false
SWEP.ReloadStartTime = 1
SWEP.InsertShellTime = 1
SWEP.ReloadFinishWait = 1
SWEP.AlwaysPlayReloadEnd = true
SWEP.MuzzleAttachmentName = "muzzle"
SWEP.MuzzleEffect = "muzzleflash_ak74"
SWEP.Shell = "mainshell"
SWEP.WM = "models/flaymi/anomaly/weapons/w_models/wpn_fal_w.mdl"
SWEP.DrawTraditionalWorldModel = false
SWEP.WMPos = Vector(-1.2, 4.5551, -3.0085)
SWEP.WMAng = Vector(-5, 0, 180)
SWEP.FireSound = "TFA_ANOMALY.FAL.FIRE"
SWEP.FireSoundSuppressed = "TFA_ANOMALY.FAL.FIRE_SILENCED"
SWEP.LuaViewmodelRecoil = true
SWEP.LuaViewmodelRecoilOverride = false

if CLIENT then
	SWEP.SelectIcon = surface.GetTextureID("vgui/entities/tfa_anomaly_fal")
	SWEP.BoltBone = "zatvor"
	SWEP.BoltShootOffset = Vector(0, 0, 1.887)
	SWEP.BoltBonePositionRecoverySpeed = 29
end

function SWEP:fireAnimFunc()
end
