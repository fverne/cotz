-- Source: newer Russian Anomaly pack, Flaymi. English text: n.kny CZ. CW conversion: COTZ.

AddCSLuaFile()

SWEP.Base = "cw_anomaly_throwable_base"

SWEP.PrintName = "F-1 Grenade"

SWEP.Category = "S.T.A.L.K.E.R. Anomaly [CW 2.0]"

SWEP.Author = "Flaymi"

SWEP.Spawnable = true

SWEP.AdminOnly = false

SWEP.IconLetter = "b"

SWEP.ViewModel = "models/flaymi/anomaly/weapons/v_models/f1_hud.mdl"

SWEP.WorldModel = "models/flaymi/anomaly/weapons/w_models/wpn_f1_w.mdl"

SWEP.ViewModelFOV = 55

SWEP.ViewModelFlip = false

SWEP.UseHands = true

SWEP.Slot = 4

SWEP.SlotPos = 73

SWEP.NormalHoldType = "grenade"

SWEP.RunHoldType = "normal"

SWEP.FireModes = {
	[1] = "semi",
}

SWEP.Primary = {
	["ClipSize"] = 1,
	["DefaultClip"] = 1,
	["Automatic"] = false,
	["Ammo"] = "Frag Grenades",
}

SWEP.FireDelay = 2.0

SWEP.FireSound = false

SWEP.FireSoundSuppressed = false

SWEP.Damage = 0

SWEP.Shots = 1

SWEP.AmmoPerShot = 1

SWEP.HipSpread = 0

SWEP.AimSpread = 0

SWEP.Recoil = 0.0

SWEP.SpreadPerShot = 0

SWEP.MaxSpreadInc = 0

SWEP.SpreadCooldown = 0.25

SWEP.VelocitySensitivity = 0

SWEP.SpeedDec = 0

SWEP.ClumpSpread = 0

SWEP.DeployTime = 1.066667

SWEP.ReloadSpeed = 1

SWEP.ReloadTime = 6.366667

SWEP.ReloadTime_Empty = 1

SWEP.ReloadHalt = 6.366667

SWEP.ReloadHalt_Empty = 1

SWEP.ShotgunReload = false

SWEP.ReloadStartTime = 1

SWEP.InsertShellTime = 1

SWEP.ReloadFinishWait = 1

SWEP.AlwaysPlayReloadEnd = true

SWEP.Chamberable = false

SWEP.IronsightPos = Vector(0, 0, 0)

SWEP.IronsightAng = Vector(0, 0, 0)

SWEP.SprintPos = Vector(0, -10, -10)

SWEP.SprintAng = Vector(0, 0, 0)

SWEP.ZoomAmount = 20

SWEP.AimViewModelFOV = 55

SWEP.Animations = {
	["idle"] = "anm_idle",
	["draw"] = "anm_show",
	["holster"] = "anm_hide",
	["pullpin"] = "anm_throw_begin",
	["throw"] = "anm_throw",
	["throw_low"] = "anm_throw_low",
	["pullpin_low"] = "anm_throw_begin_low",
	["anm_hide"] = "anm_hide",
	["anm_idle"] = "anm_idle",
	["anm_down"] = "anm_down",
	["anm_idle_sprint"] = "anm_idle_sprint",
	["anm_throw_begin"] = "anm_throw_begin",
	["anm_throw_begin_low"] = "anm_throw_begin_low",
	["anm_throw"] = "anm_throw",
	["anm_throw_low"] = "anm_throw_low",
	["anm_show"] = "anm_show",
}

SWEP.Sounds = {
	["anm_throw_begin"] = {
		[1] = {
			["time"] = 0.133333,
			["sound"] = "TFA_ANOMALY.GRENBEGIN.Chechkout",
		},
	},
	["anm_throw_begin_low"] = {
		[1] = {
			["time"] = 0.133333,
			["sound"] = "TFA_ANOMALY.GRENBEGIN.Chechkout",
		},
	},
}

SWEP.AnomalySequences = {
	["anm_hide"] = 0.633333,
	["anm_idle"] = 6.366667,
	["anm_down"] = 6.366667,
	["anm_idle_sprint"] = 0.866667,
	["anm_throw_begin"] = 0.833333,
	["anm_throw_begin_low"] = 0.833333,
	["anm_throw"] = 0.666667,
	["anm_throw_low"] = 0.666667,
	["anm_show"] = 1.066667,
}

SWEP.AnomalyLauncherReloadTime = 1

SWEP.AnomalyInitialSilenced = false

SWEP.AnomalyAimFire = "anm_shots"

SWEP.AnomalyProjectileVelocity = 0

SWEP.BulletDiameter = 7.62

SWEP.CaseLength = 39

SWEP.WearDamage = 0

SWEP.DurabilityDamageChance = 0.01

SWEP.MuzzleAttachmentName = "muzzle"

SWEP.MuzzleEffect = "muzzleflash_ak74"

SWEP.Shell = false

SWEP.AttachmentModelsVM = {}

SWEP.Attachments = {}

SWEP.AnomalyAttachmentOrder = {}

SWEP.AnomalySource = {
	["Secondary"] = {},
	["Primary"] = {
		["DefaultClip"] = 1,
		["Automatic"] = false,
		["ClipSize"] = 1,
		["RPM"] = 30,
		["Ammo"] = "Frag Grenades",
		["Round"] = "anomaly_f1_thrgren",
	},
	["RunSightsAng"] = Vector(0, 0, 0),
	["RunSightsPos"] = Vector(0, -10, -10),
}

SWEP.WM = "models/flaymi/anomaly/weapons/w_models/wpn_f1_w.mdl"

SWEP.DrawTraditionalWorldModel = false

SWEP.WMPos = Vector(-1.7, 3.6548, -1.8255)

SWEP.WMAng = Vector(-5, 0, 180)

SWEP.AnomalyThrownEntity = "anomaly_f1_thrgren"

SWEP.AnomalyThrowVelocity = 1250

SWEP.AnomalyUnderhandVelocity = 625

SWEP.AnomalyThrowDelay = 0.23

SWEP.AnomalyCookTime = 3.2

SWEP.AnomalyCanCook = true

SWEP.AnomalyCookStart = 1

SWEP.AnomalyUnderhand = true

if CLIENT then
	SWEP.SelectIcon = surface.GetTextureID("vgui/entities/tfa_anomaly_f1")
	killicon.Add("cw_anomaly_f1", "vgui/killicons/tfa_anomaly_f1", Color(255, 255, 255))
end
