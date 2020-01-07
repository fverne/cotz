if not CustomizableWeaponry then return end

AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
AddCSLuaFile("sh_soundscript.lua")
include("sh_sounds.lua")
include("sh_soundscript.lua")

SWEP.magType = "lmgBox"

CustomizableWeaponry:registerAmmo("7.62x54MMB", "7.62x54MMB Box Rounds", 7.62, 54)

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "PKP Pecheneg"
	SWEP.CSMuzzleFlashes = true
	SWEP.ViewModelMovementScale = 1.15
	SWEP.AimBreathingEnabled = true
	SWEP.NoShells = true
	SWEP.DrawAmmo = false

	SWEP.Shell = "KK_INS2_556x45"
	SWEP.ShellEjectVelocity = 50

	SWEP.Shell2 = "KK_INS2_556x45_link"
	SWEP.Shell2Scale = 0.7
	SWEP.Shell2EjectVelocity = 50
	SWEP.Shell2ViewAttachmentID = 4
	SWEP.Shell2ViewAngleAlign = {Forward = 0, Right = 0, Up = -90}
	SWEP.Shell2WorldAngleAlign = {Forward = 0, Right = 0, Up = -90}

	SWEP.AttachmentModelsVM = {
		["kk_ins2_suppressor_sec"] = {model = "models/weapons/upgrades/a_suppressor_sec.mdl", pos = Vector(), angle = Angle(), size = Vector(1, 1, 1), merge = true},

		["kk_ins2_lam"] = {model = "models/weapons/upgrades/a_laser_band.mdl", pos = Vector(0,0,-0.2), angle = Angle(), size = Vector(1, 1, 1), bone = "A_Underbarrel"},
		["kk_ins2_flashlight"] = {model = "models/weapons/upgrades/a_flashlight_band.mdl", pos = Vector(0,0,-0.2), angle = Angle(), size = Vector(1, 1, 1), bone = "A_Underbarrel"},
		["kk_ins2_anpeq15"] = {model = "models/weapons/attachments/v_cw_kk_ins2_cstm_anpeq_band.mdl", pos = Vector(0,0,-0.2), angle = Angle(), size = Vector(1, 1, 1), bone = "A_Underbarrel"},

		["kk_ins2_magnifier"] = {model = "models/weapons/upgrades/a_optic_aimp2x.mdl", rLight = true, pos = Vector(0,0.14,2.3), angle = Angle(90,0,90), size = Vector(1, 1, 1), bone = "A_Optic"},

		["kk_ins2_aimpoint"] = {model = "models/weapons/upgrades/a_optic_aimpoint.mdl", pos = Vector(0,0.1,1.3), angle = Angle(90,0,90), size = Vector(1, 1, 1), bone = "A_Optic"},
		["kk_ins2_elcan"] = {model = "models/weapons/upgrades/a_optic_elcan_m.mdl", rLight = true, pos = Vector(0,0.1,1.5), angle = Angle(90,0,90), size = Vector(1, 1, 1), bone = "A_Optic", retSizeMult = 0.85},
		["kk_ins2_eotech"] = {model = "models/weapons/upgrades/a_optic_eotech.mdl", pos = Vector(0,0.1,2), angle = Angle(90,0,90), size = Vector(1, 1, 1), bone = "A_Optic"},
		["kk_ins2_kobra"] = {model = "models/weapons/upgrades/a_optic_kobra.mdl", pos = Vector(0,0.1,1.2), angle = Angle(90,0,90), size = Vector(1, 1, 1), bone = "A_Optic"},
		["kk_ins2_po4"] = {model = "models/weapons/upgrades/a_optic_po4x24_m.mdl", rLight = true, pos = Vector(0.1,0.1,1.6), angle = Angle(90,0,90), size = Vector(1, 1, 1), bone = "A_Optic", retSizeMult = 0.85},

		["kk_ins2_cstm_cmore"] = {model = "models/weapons/attachments/v_cw_kk_ins2_cstm_cmore.mdl", pos = Vector(0,0.1,0.4), angle = Angle(180,0,90), size = Vector(1, 1, 1), bone = "A_Optic"},
		["kk_ins2_cstm_compm4s"] = {model = "models/weapons/attachments/v_cw_kk_ins2_cstm_compm4s.mdl", pos = Vector(0,0.15,1), angle = Angle(90,0,90), size = Vector(1, 1, 1), bone = "A_Optic"},
		["kk_ins2_cstm_microt1"] = {model = "models/weapons/attachments/v_cw_kk_ins2_cstm_microt1.mdl", pos = Vector(0,0.15,0.1), angle = Angle(90,0,90), size = Vector(1, 1, 1), bone = "A_Optic"},
		["kk_ins2_cstm_acog"] = {model = "models/weapons/attachments/v_cw_kk_ins2_cstm_acog_m.mdl", rLight = true, pos = Vector(0,0.1,1.6), angle = Angle(90,0,90), size = Vector(1, 1, 1), bone = "A_Optic", retSizeMult = 0.85},
		["kk_ins2_cstm_barska"] = {model = "models/weapons/attachments/v_cw_kk_ins2_cstm_barska.mdl", pos = Vector(0,0.1,1.5), angle = Angle(90,0,90), size = Vector(1, 1, 1), bone = "A_Optic"},
		["kk_ins2_cstm_eotechxps"] = {model = "models/weapons/attachments/v_cw_kk_ins2_cstm_eotechxps.mdl", pos = Vector(0,0.1,0), angle = Angle(90,0,90), size = Vector(1, 1, 1), bone = "A_Optic"},
	}

	SWEP.AttachmentModelsWM = {
		["kk_ins2_suppressor_sec"] = {model = "models/weapons/upgrades/w_sil_pistol.mdl", pos = Vector(-32.6,0.05,9.37), angle = Angle(), size = Vector(1, 1, 1), attachment = "silencer"},

		["kk_ins2_lam"] = {model = "models/weapons/upgrades/w_laser_sec.mdl", pos = Vector(), angle = Angle(), size = Vector(1, 1, 1), merge = true},
		["kk_ins2_flashlight"] = {model = "models/weapons/upgrades/w_laser_sec.mdl", pos = Vector(), angle = Angle(), size = Vector(1, 1, 1), merge = true},

		["kk_ins2_magnifier"] = {model = "models/weapons/upgrades/w_magaim.mdl", pos = Vector(-27.2,0,-5), angle = Angle(), size = Vector(1, 1, 1), bone = "A_Optic"},

		["kk_ins2_aimpoint"] = {model = "models/weapons/upgrades/w_aimpoint.mdl", pos = Vector(-37.2,0,-5), angle = Angle(), size = Vector(1, 1, 1), bone = "A_Optic"},
		["kk_ins2_elcan"] = {model = "models/weapons/upgrades/w_elcan.mdl", pos = Vector(-45.7,0,-4.8), angle = Angle(), size = Vector(1, 1, 1), bone = "A_Optic"},
		["kk_ins2_eotech"] = {model = "models/weapons/upgrades/w_eotech.mdl", pos = Vector(6.5,0,-9.5), angle = Angle(), size = Vector(1, 1, 1), bone = "A_Optic"},
		["kk_ins2_kobra"] = {model = "models/weapons/upgrades/w_kobra.mdl", pos = Vector(-27.2,0,-13.5), angle = Angle(), size = Vector(1, 1, 1), bone = "A_Optic"},
		["kk_ins2_po4"] = {model = "models/weapons/upgrades/w_po.mdl", pos = Vector(-54.8,0,-5), angle = Angle(), size = Vector(1, 1, 1), bone = "A_Optic"},

		["kk_ins2_cstm_cmore"] = {model = "models/weapons/attachments/w_cw_kk_ins2_cstm_cmore.mdl", pos = Vector(-27.8,0,-13), angle = Angle(), size = Vector(1, 1, 1), bone = "A_Optic"},
		["kk_ins2_cstm_compm4s"] = {model = "models/weapons/upgrades/w_aimpoint.mdl", pos = Vector(-37.2,0,-5), angle = Angle(), size = Vector(1, 1, 1), bone = "A_Optic"},
		["kk_ins2_cstm_microt1"] = {model = "models/weapons/upgrades/w_aimpoint.mdl", pos = Vector(-37.2,0,-5), angle = Angle(), size = Vector(1, 1, 1), bone = "A_Optic"},
		["kk_ins2_cstm_acog"] = {model = "models/weapons/attachments/w_cw_kk_ins2_cstm_acog.mdl", pos = Vector(-46.5,0.05,-4.8), angle = Angle(), size = Vector(1, 1, 1), bone = "A_Optic"},
		["kk_ins2_cstm_barska"] = {model = "models/weapons/upgrades/w_eotech.mdl", pos = Vector(6.5,0,-9.5), angle = Angle(), size = Vector(1, 1, 1), bone = "A_Optic"},
		["kk_ins2_cstm_eotechxps"] = {model = "models/weapons/attachments/w_cw_kk_ins2_cstm_eotechxps.mdl", pos = Vector(4.5,-34.4,6.1), angle = Angle(0,-90,0), size = Vector(1, 1, 1), bone = "A_Optic"},
	}

	SWEP.CustomizePos = Vector(4.488, -1.627, -0.821)
	SWEP.CustomizeAng = Vector(17.009, 29.971, 16.669)

	SWEP.IronsightPos = Vector(-2.0484, 0, 0.9581)
	SWEP.IronsightAng = Vector(0, 0.03, 0)

	SWEP.KKINS2KobraPos = Vector(-2.0139, -2, 0.0313)
	SWEP.KKINS2KobraAng = Vector()

	SWEP.KKINS2EoTechPos = Vector(-2.0008, -2, -0.1)
	SWEP.KKINS2EoTechAng = Vector()

	SWEP.KKINS2AimpointPos = Vector(-2.0127, -2, -0.102)
	SWEP.KKINS2AimpointAng = Vector()

	SWEP.KKINS2ElcanPos = Vector(-2.0071, -3, -0.1976)
	SWEP.KKINS2ElcanAng = Vector()

	SWEP.KKINS2PO4Pos = Vector(-2.0575, -4, 0.1637)
	SWEP.KKINS2PO4Ang = Vector()

	SWEP.KKINS2MagnifierPos = Vector(-2.0063, -3, -0.1537)
	SWEP.KKINS2MagnifierAng = Vector()

	SWEP.KKINS2CSTMCMorePos = Vector(-2.0127, -2, -0.102)
	SWEP.KKINS2CSTMCMoreAng = Vector()

	SWEP.KKINS2CSTMBarskaPos = Vector(-2.0008, -2, -0.1)
	SWEP.KKINS2CSTMBarskaAng = Vector()

	SWEP.KKINS2CSTMMicroT1Pos = Vector(-2.0127, -2, -0.122)
	SWEP.KKINS2CSTMMicroT1Ang = Vector()

	SWEP.KKINS2CSTMEoTechXPSPos = Vector(-2.0008, -2, -0.1)
	SWEP.KKINS2CSTMEoTechXPSAng = Vector()

	SWEP.KKINS2CSTMCompM4SPos = Vector(-2.0127, -2, -0.102)
	SWEP.KKINS2CSTMCompM4SAng = Vector()

	SWEP.KKINS2CSTMACOGPos = Vector(-2.0071, -3, -0.1976)
	SWEP.KKINS2CSTMACOGAng = Vector()

	SWEP.CustomizationMenuScale = 0.014
end

SWEP.MuzzleEffect = "muzzleflash_m249_1p_core"
SWEP.MuzzleEffectWorld = "muzzleflash_m249_3rd"

SWEP.Attachments = {
	{header = "Sight", offset = {400, -500}, atts = {"kk_ins2_kobra", "kk_ins2_eotech", "kk_ins2_aimpoint", "kk_ins2_elcan", "kk_ins2_po4", "kk_ins2_cstm_cmore", "kk_ins2_cstm_barska", "kk_ins2_cstm_microt1", "kk_ins2_cstm_eotechxps", "kk_ins2_cstm_compm4s", "kk_ins2_cstm_acog"}},
	{header = "Barrel", offset = {-200, -500}, atts = {"kk_ins2_suppressor_sec"}},
	{header = "Lasers", offset = {-400, 0}, atts = {"kk_ins2_lam", "kk_ins2_flashlight", "kk_ins2_anpeq15"}},
	{header = "More Sight", offset = {1000, 0}, atts = {"kk_ins2_magnifier"}, dependencies = CustomizableWeaponry_KK.ins2.magnifierDependencies},
	{header = "Magazine", offset = {200, 0}, atts = {"fn_mag25"}},
	{header = "Upgrade 1-1", offset = {200, 0}, atts = {"fn_hndl1"}},
	{header = "Upgrade 1-2", offset = {100, 0}, atts = {"fn_acc1", "fn_rec1"}},
	{header = "Upgrade 1-3", offset = {200, 0}, atts = {"fn_rof1", "fn_stab1"}},
	{header = "Upgrade 2-1", offset = {200, 0}, atts = {"fn_acc2"}},
	{header = "Upgrade 2-2", offset = {200, 0}, atts = {"fn_hndl2", "fn_stab2"}},
	{header = "Upgrade 2-3", offset = {200, 0}, atts = {"fn_rec2", "fn_rof2"}},
	["+use"] = {header = "Sight Contract", offset = {400, 0}, atts = {"kk_ins2_sights_cstm"}},
	["+reload"] = {header = "Ammo", offset = {200, 500}, atts = {"am_zoneloaded", "am_matchgrade"}}
}

SWEP.Animations = {
	base_pickup = "base_ready",
	base_draw = "base_draw",
	base_fire = {"base_fire_1","base_fire_2","base_fire_3"},
	base_fire_aim = {"iron_fire_1","iron_fire_2","iron_fire_3","iron_fire_4"},
	base_fire_empty = "base_dryfire",
	base_fire_empty_aim = "iron_dryfire",
	base_reload = "base_reload",
	base_reload_close = "base_reload_half",
	base_reload_empty = "base_reload_empty",
	base_idle = "base_idle",
	base_holster = "base_holster",
	base_sprint = "base_sprint",
	base_safe = "base_down",
	base_safe_aim = "iron_down",
	base_crawl = "base_crawl",

	bipod_in = "deployed_in",
	bipod_fire = {"deployed_fire_1","deployed_fire_2"},
	bipod_fire_aim = {"deployed_iron_fire_1","deployed_iron_fire_2"},
	bipod_fire_empty = "deployed_dryfire",
	bipod_fire_empty_aim = "deployed_iron_dryfire",
	bipod_reload = "deployed_reload",
	bipod_reload_close = "deployed_reload_half",
	bipod_reload_empty = "deployed_reload_empty",
	bipod_out = "deployed_out",
}

SWEP.SpeedDec = 30

SWEP.Slot = 3
SWEP.SlotPos = 0
SWEP.NormalHoldType = "ar2"
SWEP.RunHoldType = "passive"
SWEP.FireModes = {"auto"}
SWEP.Base = "cw_kk_ins2_base"
SWEP.Category = "Ethereal LMGs"

SWEP.Author			= "Lt. Taylor"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModelFOV	= 70
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/weapons/ethereal/v_pkp.mdl"
SWEP.WorldModel		= "models/weapons/ethereal/w_pkp.mdl"

SWEP.WMPos = Vector(5.184, 0.935, -1.03)
SWEP.WMAng = Vector(-10, -1, 180)

SWEP.Spawnable			= CustomizableWeaponry_KK.ins2.isContentMounted4(SWEP)
SWEP.AdminSpawnable		= CustomizableWeaponry_KK.ins2.isContentMounted4(SWEP)

SWEP.Primary.ClipSize		= 100
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "7.62x54MMB"

SWEP.FireDelay = 60/700
SWEP.FireSound = "CW_KK_INS2_PKP_FIRE"
SWEP.FireSoundSuppressed = "CW_KK_INS2_PKP_FIRE_SUPPRESSED"
SWEP.Recoil = 1.62

SWEP.HipSpread = 0.045
SWEP.AimSpread = 0.0027
SWEP.VelocitySensitivity = 1.8
SWEP.MaxSpreadInc = 0.04
SWEP.SpreadPerShot = 0.007
SWEP.SpreadCooldown = 0.13
SWEP.Shots = 1
SWEP.Damage = 30

SWEP.FirstDeployTime = 2.6
SWEP.DeployTime = 0.9
SWEP.HolsterTime = 0.6

SWEP.Chamberable = false
SWEP.BipodInstalled = true
SWEP.WeaponLength = 28

SWEP.MuzzleVelocity = 825

SWEP.ReloadTimes = {
	base_reload = {7.3, 9.5},
	base_reload_half = {8, 9.84},
	base_reload_empty = {9.35, 11},

	deployed_reload = {7.1, 8.77},
	deployed_reload_half = {7.9, 9.5},
	deployed_reload_empty = {8.85, 10.52},
}

SWEP.reloadProgressAnimsRaw = {
	base_reload_close = true,
	bipod_reload_close = true
}

SWEP.reticleInactivityCallbacksRaw = {
	["base_reload_close"] = 0.1,
	["bipod_reload_close"] = 0.1,
}

function SWEP:overrideReloadAnim(prefix, suffix)
	local clip = self:Clip1()

	if clip > 15 then
		return prefix .. "reload" .. suffix
	elseif clip > 0 then
		return prefix .. "reload_close" .. suffix
	end

	return prefix .. "reload_empty" .. suffix
end

if CLIENT then
	CustomizableWeaponry_KK.ins2.welementThink:add("cw_kk_ins2_m249", "bipod")
end