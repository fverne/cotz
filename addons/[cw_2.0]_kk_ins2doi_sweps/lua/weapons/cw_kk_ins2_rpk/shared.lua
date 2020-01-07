if not CustomizableWeaponry then return end

AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
AddCSLuaFile("sh_soundscript.lua")
include("sh_sounds.lua")
include("sh_soundscript.lua")

SWEP.magType = "arMag"

util.PrecacheModel("models/weapons/v_cw_kk_ins2_rpk_tac.mdl")
util.PrecacheModel("models/weapons/w_cw_kk_ins2_rpk_tac.mdl")

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "RPK"
	SWEP.CSMuzzleFlashes = true
	SWEP.AimBreathingEnabled = true
	SWEP.ViewModelMovementScale = 1.15
	SWEP.DrawAmmo = false

	SWEP.Shell = "KK_INS2_762x39"
	SWEP.ShellDelay = 0.06

	SWEP.AttachmentModelsVM = {
		["kk_ins2_optic_rail"] = {model = "models/weapons/upgrades/a_modkit_06.mdl", pos = Vector(), angle = Angle(), size = Vector(1, 1, 1), merge = true},

		["kk_ins2_pbs1"] = {model = "models/weapons/upgrades/a_suppressor_ak.mdl", pos = Vector(), angle = Angle(), size = Vector(1, 1, 1), merge = true},

		["kk_ins2_lam"] = {model = "models/weapons/upgrades/a_laser_band.mdl", pos = Vector(), angle = Angle(), size = Vector(1, 1, 1), merge = true},
		["kk_ins2_flashlight"] = {model = "models/weapons/upgrades/a_flashlight_band.mdl", pos = Vector(), angle = Angle(), size = Vector(1, 1, 1), merge = true},
		["kk_ins2_anpeq15"] = {model = "models/weapons/attachments/v_cw_kk_ins2_cstm_anpeq_band.mdl", pos = Vector(), angle = Angle(), size = Vector(1, 1, 1), merge = true},

		["kk_ins2_magnifier"] = {model = "models/weapons/upgrades/a_optic_aimp2x.mdl", rLight = true, pos = Vector(), angle = Angle(), size = Vector(1, 1, 1), merge = true},

		["kk_ins2_aimpoint"] = {model = "models/weapons/upgrades/a_optic_aimpoint.mdl", pos = Vector(), angle = Angle(), size = Vector(1, 1, 1), merge = true},
		["kk_ins2_elcan"] = {model = "models/weapons/upgrades/a_optic_elcan_m.mdl", rLight = true, pos = Vector(), angle = Angle(), size = Vector(1, 1, 1), merge = true, retSizeMult = 0.85},
		["kk_ins2_eotech"] = {model = "models/weapons/upgrades/a_optic_eotech.mdl", pos = Vector(), angle = Angle(), size = Vector(1, 1, 1), merge = true},
		["kk_ins2_kobra"] = {model = "models/weapons/upgrades/a_optic_kobra_l.mdl", pos = Vector(), angle = Angle(), size = Vector(1, 1, 1), merge = true, retSizeMult = 1.2},
		["kk_ins2_po4"] = {model = "models/weapons/upgrades/a_optic_po4x24.mdl", rLight = true, pos = Vector(), angle = Angle(), size = Vector(1, 1, 1), merge = true},

		["kk_ins2_cstm_cmore"] = {model = "models/weapons/attachments/v_cw_kk_ins2_cstm_cmore.mdl", pos = Vector(), angle = Angle(), size = Vector(1, 1, 1), merge = true},
		["kk_ins2_cstm_compm4s"] = {model = "models/weapons/attachments/v_cw_kk_ins2_cstm_compm4s.mdl", pos = Vector(), angle = Angle(), size = Vector(1, 1, 1), merge = true},
		["kk_ins2_cstm_microt1"] = {model = "models/weapons/attachments/v_cw_kk_ins2_cstm_microt1.mdl", pos = Vector(), angle = Angle(), size = Vector(1, 1, 1), merge = true},
		["kk_ins2_cstm_acog"] = {model = "models/weapons/attachments/v_cw_kk_ins2_cstm_acog_m.mdl", rLight = true, pos = Vector(), angle = Angle(), size = Vector(1, 1, 1), merge = true, retSizeMult = 0.85},
		["kk_ins2_cstm_barska"] = {model = "models/weapons/attachments/v_cw_kk_ins2_cstm_barska.mdl", pos = Vector(), angle = Angle(), size = Vector(1, 1, 1), merge = true},
		["kk_ins2_cstm_eotechxps"] = {model = "models/weapons/attachments/v_cw_kk_ins2_cstm_eotechxps.mdl", pos = Vector(), angle = Angle(), size = Vector(1, 1, 1), merge = true},
	}

	SWEP.AttachmentModelsWM = {
		["kk_ins2_optic_rail"] = {model = "models/weapons/upgrades/w_modkit_6.mdl", pos = Vector(), angle = Angle(), size = Vector(1, 1, 1), merge = true},

		["kk_ins2_pbs1"] = {model = "models/weapons/upgrades/w_sil_ins1.mdl", pos = Vector(-32.7,12,0), angle = Angle(0,0,90), size = Vector(1, 1, 1), attachment = "silencer"},

		["kk_ins2_lam"] = {model = "models/weapons/upgrades/w_laser_ins.mdl", pos = Vector(0,0,8.25), angle = Angle(0,180,180), size = Vector(1, 1, 1), attachment = "laser"},
		["kk_ins2_flashlight"] = {model = "models/weapons/upgrades/w_laser_ins.mdl", pos = Vector(0,0,8.25), angle = Angle(0,180,180), size = Vector(1, 1, 1), attachment = "laser"},

		["kk_ins2_magnifier"] = {model = "models/weapons/upgrades/w_magaim.mdl", pos = Vector(), angle = Angle(), size = Vector(1, 1, 1), merge = true},

		["kk_ins2_aimpoint"] = {model = "models/weapons/upgrades/w_aimpoint.mdl", pos = Vector(), angle = Angle(), size = Vector(1, 1, 1), merge = true},
		["kk_ins2_elcan"] = {model = "models/weapons/upgrades/w_elcan.mdl", pos = Vector(), angle = Angle(), size = Vector(1, 1, 1), merge = true},
		["kk_ins2_eotech"] = {model = "models/weapons/upgrades/w_eotech.mdl", pos = Vector(), angle = Angle(), size = Vector(1, 1, 1), merge = true},
		["kk_ins2_kobra"] = {model = "models/weapons/upgrades/w_kobra.mdl", pos = Vector(), angle = Angle(), size = Vector(1, 1, 1), merge = true},
		["kk_ins2_po4"] = {model = "models/weapons/upgrades/w_po.mdl", pos = Vector(), angle = Angle(), size = Vector(1, 1, 1), merge = true},

		["kk_ins2_cstm_cmore"] = {model = "models/weapons/attachments/w_cw_kk_ins2_cstm_cmore.mdl", pos = Vector(), angle = Angle(), size = Vector(1, 1, 1), merge = true},
		["kk_ins2_cstm_compm4s"] = {model = "models/weapons/upgrades/w_aimpoint.mdl", pos = Vector(), angle = Angle(), size = Vector(1, 1, 1), merge = true},
		["kk_ins2_cstm_microt1"] = {model = "models/weapons/upgrades/w_aimpoint.mdl", pos = Vector(), angle = Angle(), size = Vector(1, 1, 1), merge = true},
		["kk_ins2_cstm_acog"] = {model = "models/weapons/attachments/w_cw_kk_ins2_cstm_acog.mdl", pos = Vector(), angle = Angle(), size = Vector(1, 1, 1), merge = true},
		["kk_ins2_cstm_barska"] = {model = "models/weapons/upgrades/w_eotech.mdl", pos = Vector(), angle = Angle(), size = Vector(1, 1, 1), merge = true},
		["kk_ins2_cstm_eotechxps"] = {model = "models/weapons/attachments/w_cw_kk_ins2_cstm_eotechxps.mdl", pos = Vector(), angle = Angle(), size = Vector(1, 1, 1), merge = true},
	}

	SWEP.IronsightPos = Vector(-2.3, -2, 0.13)
	SWEP.IronsightAng = Vector(0.95, 0.05, 0)

	SWEP.KKINS2KobraPos = Vector(-2.3107, -2, -0.5233)
	SWEP.KKINS2KobraAng = Vector()

	SWEP.KKINS2EoTechPos = Vector(-2.3099, -2, -0.4734)
	SWEP.KKINS2EoTechAng = Vector()

	SWEP.KKINS2AimpointPos = Vector(-2.3021, -2, -0.4478)
	SWEP.KKINS2AimpointAng = Vector()

	SWEP.KKINS2ElcanPos = Vector(-2.3062, -2, -0.5652)
	SWEP.KKINS2ElcanAng = Vector()

	SWEP.KKINS2PO4Pos = Vector(-2.2495, -1, -0.3634)
	SWEP.KKINS2PO4Ang = Vector()

	SWEP.KKINS2MagnifierPos = Vector(-2.307, -2, -0.4629)
	SWEP.KKINS2MagnifierAng = Vector()

	SWEP.KKINS2CSTMCMorePos = Vector(-2.3021, -2, -0.4478)
	SWEP.KKINS2CSTMCMoreAng = Vector()

	SWEP.KKINS2CSTMBarskaPos = Vector(-2.3099, -2, -0.4734)
	SWEP.KKINS2CSTMBarskaAng = Vector()

	SWEP.KKINS2CSTMMicroT1Pos = Vector(-2.3021, -2, -0.4478)
	SWEP.KKINS2CSTMMicroT1Ang = Vector()

	SWEP.KKINS2CSTMEoTechXPSPos = Vector(-2.3099, -2, -0.4734)
	SWEP.KKINS2CSTMEoTechXPSAng = Vector()

	SWEP.KKINS2CSTMCompM4SPos = Vector(-2.3021, -2, -0.4478)
	SWEP.KKINS2CSTMCompM4SAng = Vector()

	SWEP.KKINS2CSTMACOGPos = Vector(-2.3062, -2, -0.5652)
	SWEP.KKINS2CSTMACOGAng = Vector()

	// coz why nut
	SWEP.IronsightPos_sopmod = Vector(-2.3118, -2, 0.4771)
	SWEP.IronsightAng_sopmod = Vector(0.7678, 0.05, 0)

	SWEP.KKINS2KobraPos_sopmod = Vector(-2.3107, -8, -0.3917)
	SWEP.KKINS2KobraAng_sopmod = Vector()

	SWEP.KKINS2EoTechPos_sopmod = Vector(-2.3099, -8, -0.3084)
	SWEP.KKINS2EoTechAng_sopmod = Vector()

	SWEP.KKINS2AimpointPos_sopmod = Vector(-2.3021, -8, -0.296)
	SWEP.KKINS2AimpointAng_sopmod = Vector()

	SWEP.KKINS2ElcanPos_sopmod = Vector(-2.3068, -10, -0.401)
	SWEP.KKINS2ElcanAng_sopmod = Vector()

	SWEP.KKINS2PO4Pos_sopmod = Vector(-2.2503, -10, -0.2003)
	SWEP.KKINS2PO4Ang_sopmod = Vector()

	SWEP.KKINS2MagnifierPos_sopmod = Vector(-2.307, -10, -0.3014)
	SWEP.KKINS2MagnifierAng_sopmod = Vector()

	SWEP.KKINS2CSTMCMorePos_sopmod = Vector(-2.3021, -8, -0.296)
	SWEP.KKINS2CSTMCMoreAng_sopmod = Vector()

	SWEP.KKINS2CSTMBarskaPos_sopmod = Vector(-2.3099, -8, -0.3084)
	SWEP.KKINS2CSTMBarskaAng_sopmod = Vector()

	SWEP.KKINS2CSTMMicroT1Pos_sopmod = Vector(-2.3021, -8, -0.296)
	SWEP.KKINS2CSTMMicroT1Ang_sopmod = Vector()

	SWEP.KKINS2CSTMEoTechXPSPos_sopmod = Vector(-2.3099, -8, -0.3084)
	SWEP.KKINS2CSTMEoTechXPSAng_sopmod = Vector()

	SWEP.KKINS2CSTMCompM4SPos_sopmod = Vector(-2.3021, -8, -0.296)
	SWEP.KKINS2CSTMCompM4SAng_sopmod = Vector()

	SWEP.KKINS2CSTMACOGPos_sopmod = Vector(-2.3068, -10, -0.401)
	SWEP.KKINS2CSTMACOGAng_sopmod = Vector()

	SWEP.CustomizationMenuScale = 0.018
end

SWEP.MuzzleEffect = "muzzleflash_akm_1p_core"
SWEP.MuzzleEffectWorld = "muzzleflash_akm_3rd"

SWEP.Attachments = {
	{header = "Sight", offset = {400, -450}, atts = {"kk_ins2_kobra", "kk_ins2_eotech", "kk_ins2_aimpoint", "kk_ins2_elcan", "kk_ins2_po4", "kk_ins2_cstm_cmore", "kk_ins2_cstm_barska", "kk_ins2_cstm_microt1", "kk_ins2_cstm_eotechxps", "kk_ins2_cstm_compm4s", "kk_ins2_cstm_acog"}},
	{header = "Barrel", offset = {-100, -450}, atts = {"kk_ins2_pbs1"}},
	{header = "Lasers", offset = {200, 400}, atts = {"kk_ins2_lam", "kk_ins2_flashlight", "kk_ins2_anpeq15"}},
	{header = "More Sight", offset = {1000, 0}, atts = {"kk_ins2_magnifier"}, dependencies = CustomizableWeaponry_KK.ins2.magnifierDependencies},
	{header = "Caliber", offset = {-800, 350}, atts = {"am_cal_545x39", "am_cal_556x45"}},
	{header = "Upgrade 1-1", offset = {200, 0}, atts = {"fn_hndl1"}},
	{header = "Upgrade 1-2", offset = {100, 0}, atts = {"fn_acc1", "fn_rec1"}},
	{header = "Upgrade 1-3", offset = {200, 0}, atts = {"fn_rof1", "fn_stab1"}},
	{header = "Upgrade 2-1", offset = {200, 0}, atts = {"fn_acc2"}},
	{header = "Upgrade 2-2", offset = {200, 0}, atts = {"fn_hndl2", "fn_stab2"}},
	{header = "Upgrade 2-3", offset = {200, 0}, atts = {"fn_rec2", "fn_rof2"}},
	["+use"] = {header = "Sight Contract", offset = {400, -0}, atts = {"kk_ins2_sights_cstm"}},
	["+reload"] = {header = "Ammo", offset = {900, 500}, atts = {"am_zoneloaded", "am_matchgrade"}}
}

if CustomizableWeaponry_KK.ins2.ws then
	table.insert(SWEP.Attachments, 3, {header = "Package", offset = {-400, 0}, atts = {"kk_ins2_rpk_sopmod"}})
end

SWEP.Animations = {
	base_pickup = "base_ready",
	base_draw = "base_draw",
	base_fire = "base_fire",
	base_fire_aim = {"iron_fire_1","iron_fire_2","iron_fire_3","iron_fire_4"},
	base_fire_empty = "base_dryfire",
	base_fire_empty_aim = "iron_dryfire",
	base_reload = "base_reload",
	base_reload_empty = "base_reloadempty",
	base_idle = "base_idle",
	base_holster = "base_holster",
	base_firemode = "base_fireselect",
	base_firemode_aim = "iron_fireselect",
	base_sprint = "base_sprint",
	base_safe = "base_down",
	base_safe_aim = "iron_down",
	base_crawl = "base_crawl",

	bipod_in = "deployed_in",
	bipod_fire = "deployed_fire",
	bipod_fire_aim = {"deployed_iron_fire_1","deployed_iron_fire_2"},
	bipod_fire_empty = "deployed_dryfire",
	bipod_fire_empty_aim = "deployed_iron_dryfire",
	bipod_reload = "deployed_reload",
	bipod_reload_empty = "deployed_reloadempty",
	bipod_firemode = "deployed_fireselect",
	bipod_firemode_aim = "deployed_iron_fireselect",
	bipod_out = "deployed_out",
}

SWEP.SpeedDec = 30

SWEP.Slot = 3
SWEP.SlotPos = 1
SWEP.NormalHoldType = "ar2"
SWEP.RunHoldType = "passive"
SWEP.FireModes = {"auto", "semi"}
SWEP.Base = "cw_kk_ins2_base"
SWEP.Category = "Ethereal LMGs"

SWEP.Author			= "Lt. Taylor"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModelFOV	= 70
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/weapons/ethereal/v_rpk.mdl"
SWEP.WorldModel		= "models/weapons/ethereal/w_rpk.mdl"

SWEP.WMPos = Vector(4.427, 0.96, -1.397)
SWEP.WMAng = Angle(-10, 0, 180)

SWEP.CW_GREN_TWEAK = CustomizableWeaponry_KK.ins2.quickGrenade.models.f1
SWEP.CW_KK_KNIFE_TWEAK = CustomizableWeaponry_KK.ins2.quickKnife.models.gurkha

SWEP.Spawnable			= CustomizableWeaponry_KK.ins2.isContentMounted4(SWEP)
SWEP.AdminSpawnable		= CustomizableWeaponry_KK.ins2.isContentMounted4(SWEP)

SWEP.Primary.ClipSize		= 75
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "7.62x39MM"

SWEP.FireDelay = 60/600
SWEP.FireSound = "CW_KK_INS2_RPK_FIRE"
SWEP.FireSoundSuppressed = "CW_KK_INS2_RPK_FIRE_SUPPRESSED"
SWEP.Recoil = 1.5

SWEP.HipSpread = 0.043
SWEP.AimSpread = 0.004
SWEP.VelocitySensitivity = 1.6
SWEP.MaxSpreadInc = 0.05
SWEP.SpreadPerShot = 0.007
SWEP.SpreadCooldown = 0.13
SWEP.Shots = 1
SWEP.Damage = 24

SWEP.FirstDeployTime = 2.2
SWEP.DeployTime = 0.9
SWEP.HolsterTime = 0.7

SWEP.BipodDeployTime = 1.5
SWEP.BipodUndeployTime = 1.9

SWEP.BipodInstalled = true
SWEP.WeaponLength = 26
-- SWEP.WeaponLength = 22 // sopmod

SWEP.MuzzleVelocity = 745

SWEP.ReloadTimes = {
	base_reload = {3.4, 4.5},
	base_reloadempty = {3.4, 6},

	deployed_reload = {116/30, 4.8},
	deployed_reloadempty = {116/30, 6},
}

if CLIENT then
	local att = CustomizableWeaponry.registeredAttachmentsSKey["kk_ins2_rpk_sopmod"]

	CustomizableWeaponry_KK.ins2.welementThink:add("cw_kk_ins2_rpk", function(wep, welement)
		if wep.ActiveAttachments[att.name] then
			if welement:GetModel() != att.activeWM then
				welement:SetModel(att.activeWM)
			end
		else
			if welement:GetModel() != att.origWM then
				welement:SetModel(att.origWM)
			end
		end

		welement:SetSequence(wep.dt.BipodDeployed and 1 or 0)
	end)
end

if CLIENT then
	local pos, ang

	CustomizableWeaponry.callbacks:addNew("adjustViewmodelPosition", "KK_INS2_RPK", function(wep, TargetPos, TargetAng)
		if wep:GetClass() != "cw_kk_ins2_rpk" then return end
		if !wep.ActiveAttachments.kk_ins2_rpk_sopmod then return end
		if !wep:isAiming() then return end

		if wep._currentSecondarySight then
			pos = wep._currentSecondarySight.aimPos[1]
			ang = wep._currentSecondarySight.aimPos[2]
		elseif wep._currentPrimarySight then
			pos = wep._currentPrimarySight.aimPos[1]
			ang = wep._currentPrimarySight.aimPos[2]
		else
			pos = "IronsightPos"
			ang = "IronsightAng"
		end

		return wep[pos .. "_sopmod"], wep[ang .. "_sopmod"]
	end)
end

if CLIENT then
	local counterExists = file.Exists("models/weapons/stattrack.mdl", "GAME")

	function SWEP:updateOtherParts()
		if CustomizableWeaponry_KK.HOME then
			local cycle = self.CW_VM:GetCycle()
			local clip = self:Clip1()
			local ammo

			if self.getFullestMag then
				ammo = math.max(self:Clip1(), self:getFullestMag(), -1)
			else
				ammo = self.Owner:GetAmmoCount(self.Primary.Ammo) + clip
			end

			if self.Sequence:find("reload") and cycle > 0.3 and cycle < 1 then
				self.AttachmentModelsVM.kk_counter_mag.ent._KKCSGONUM = ammo
			else
				self.AttachmentModelsVM.kk_counter_mag.ent._KKCSGONUM = clip
			end

			self.AttachmentModelsVM.kk_counter_mag.active = counterExists
		end
	end
end