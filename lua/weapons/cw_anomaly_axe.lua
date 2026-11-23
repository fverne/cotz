-- Source: newer Russian Anomaly pack, Flaymi. English text: n.kny CZ. CW conversion: COTZ.

AddCSLuaFile()

SWEP.Base = "cw_anomaly_melee_base"

SWEP.PrintName = "Fire axe"

SWEP.Category = "S.T.A.L.K.E.R. Anomaly [CW 2.0]"

SWEP.Author = "Flaymi"

SWEP.Spawnable = true

SWEP.AdminOnly = false

SWEP.IconLetter = "b"

SWEP.ViewModel = "models/flaymi/anomaly/weapons/v_models/wpn_axe.mdl"

SWEP.WorldModel = "models/flaymi/anomaly/weapons/w_models/wpn_axe.mdl"

SWEP.ViewModelFOV = 55

SWEP.ViewModelFlip = false

SWEP.UseHands = true

SWEP.Slot = 0

SWEP.SlotPos = 3

SWEP.NormalHoldType = "melee2"

SWEP.RunHoldType = "melee2"

SWEP.FireModes = {
	[1] = "semi",
}

SWEP.Primary = {
	["ClipSize"] = -1,
	["DefaultClip"] = -1,
	["Automatic"] = false,
	["Ammo"] = "",
}

SWEP.FireDelay = 1.2

SWEP.FireSound = false

SWEP.FireSoundSuppressed = false

SWEP.Damage = 32

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

SWEP.DeployTime = 0.7

SWEP.ReloadSpeed = 1

SWEP.ReloadTime = 6.333333

SWEP.ReloadTime_Empty = 1

SWEP.ReloadHalt = 6.333333

SWEP.ReloadHalt_Empty = 1

SWEP.ShotgunReload = false

SWEP.ReloadStartTime = 1

SWEP.InsertShellTime = 1

SWEP.ReloadFinishWait = 1

SWEP.AlwaysPlayReloadEnd = true

SWEP.Chamberable = false

SWEP.IronsightPos = Vector(0, 0, 0)

SWEP.IronsightAng = Vector(0, 0, 0)

SWEP.SprintPos = Vector(0, 0, 0)

SWEP.SprintAng = Vector(0, 0, 0)

SWEP.ZoomAmount = 20

SWEP.AimViewModelFOV = 55

SWEP.Animations = {
	["idle"] = "anm_idle",
	["draw"] = "anm_show",
	["holster"] = "anm_hide",
	["fire"] = "anm_attack",
	["stab"] = "anm_attack2",
	["anm_hide"] = "anm_hide",
	["anm_idle"] = "anm_idle",
	["anm_idle_sprint"] = "anm_idle_sprint",
	["anm_attack"] = "anm_attack",
	["anm_attack2"] = "anm_attack2",
	["anm_show"] = "anm_show",
}

SWEP.Sounds = {
	["anm_hide"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.AXE.Holster",
		},
	},
	["anm_show"] = {
		[1] = {
			["time"] = 0.0,
			["sound"] = "TFA_ANOMALY.AXE.Draw",
		},
	},
}

SWEP.AnomalySequences = {
	["anm_hide"] = 0.666667,
	["anm_idle"] = 6.333333,
	["anm_idle_sprint"] = 0.8,
	["anm_attack"] = 1.533333,
	["anm_attack2"] = 1.733333,
	["anm_show"] = 0.7,
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
	["Secondary"] = {
		["Delay"] = 0.8,
		["RPM"] = 50,
		["Length"] = 75,
		["Damage"] = 52,
	},
	["Primary"] = {
		["Damage"] = 32,
		["ClipSize"] = -1,
		["Length"] = 80,
		["Delay"] = 0.8,
		["RPM"] = 50,
		["Ammo"] = "",
		["Sound"] = "weapons/flaymi/stalker/anomaly/axe/knife_1.wav",
	},
}

SWEP.WM = "models/flaymi/anomaly/weapons/w_models/wpn_axe.mdl"

SWEP.DrawTraditionalWorldModel = false

SWEP.WMPos = Vector(1.2, 0, -3.5)

SWEP.WMAng = Vector(90, 0, 0)

SWEP.HoldType = "melee2"

SWEP.AnomalyMeleePrimary = {
	["Damage"] = 32,
	["ClipSize"] = -1,
	["Length"] = 80,
	["Delay"] = 0.8,
	["RPM"] = 50,
	["Ammo"] = "",
	["Sound"] = "weapons/flaymi/stalker/anomaly/axe/knife_1.wav",
}

SWEP.AnomalyMeleeSecondary = {
	["Delay"] = 0.8,
	["RPM"] = 50,
	["Length"] = 75,
	["Damage"] = 52,
}

SWEP.AnomalyHitSound = "weapons/flaymi/stalker/anomaly/axe/hurt4.wav"

SWEP.AnomalyWorldHitSound = "weapons/flaymi/stalker/anomaly/axe/impact_wpn_large_asphalt2.wav"

SWEP.AnomalyMissSound = "weapons/flaymi/stalker/anomaly/axe/knife_1.wav"

if CLIENT then
	SWEP.SelectIcon = surface.GetTextureID("vgui/entities/tfa_anomaly_axe")
	killicon.Add("cw_anomaly_axe", "vgui/killicons/tfa_anomaly_axe", Color(255, 255, 255))
end
