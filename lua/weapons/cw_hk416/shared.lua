
AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")
util.PrecacheModel("models/weapons/v_cwkk_hk416.mdl")
util.PrecacheModel("models/weapons/w_cwkk_hk416.mdl")

local Vec0 = Vector(0,0,0)
local Vec1 = Vector(1,1,1)
local Ang0 = Angle(0,0,0)

if CLIENT then
	SWEP.PrintName = "HK416"
	SWEP.CSMuzzleFlashes = true
	SWEP.ViewModelMovementScale = 1.15
	
	SWEP.IconLetter = "w"
	killicon.Add( "cw_kk_hk416", "qq_icons/kills/cw_kk_hk416", Color(255, 80, 0, 150))
	SWEP.SelectIcon = surface.GetTextureID("qq_icons/select/cw_kk_hk416")
	
	SWEP.MuzzleEffect = "muzzleflash_6"
	
	SWEP.SnapToGrip = true
	SWEP.ShellScale = 0.35
	
	SWEP.ForeGripOffsetCycle_Reload = 0.775
	SWEP.ForeGripOffsetCycle_Reload_Empty = 0.825
	SWEP.ForeGripOffsetCycle_Draw = 0.6
	
	SWEP.M203OffsetCycle_Reload = 0.775
	SWEP.M203OffsetCycle_Reload_Empty = 0.73
	SWEP.M203OffsetCycle_Draw = 0.5
	SWEP.BaseArm = "Bip01 L Clavicle"
	SWEP.BaseArmBoneOffset = Vector(-50, 0, 0)
	
	SWEP.HoldBoltWhileEmpty = true
	SWEP.DontHoldWhenReloading = false
	
	SWEP.BoltBone = "g"
	SWEP.BoltShootOffset = Vector(0, 2.46, 0)
	SWEP.OffsetBoltOnBipodShoot = true
	
	SWEP.AttachmentModelsVM = {
		["md_saker"] = {model = "models/cw2/attachments/556suppressor.mdl", bone = "bod", rel = "", pos = Vector(-0.129, -0.615, 1.12), angle = Angle(0, 180, 0), size = Vector(0.75, 0.75, 0.75)},
		["md_foregrip"] = {model = "models/wystan/attachments/foregrip1.mdl", bone = "bod", rel = "", pos = Vector(-0.575, -22.234, 0.326), angle = Angle(0, 0, 0), size = Vector(0.8, 0.8, 0.699)},
		["md_microt1"] = { type = "Model", model = "models/cw2/attachments/microt1.mdl", bone = "bod", rel = "", pos = Vector(-0.15, -3, 4.72), adjustment = {min = -1, max = 2.4, axis = "y", inverse = true}, angle = Angle(0, 0, 0), size = Vector(0.4, 0.4, 0.4)},
		["md_eotech"] = { type = "Model", model = "models/wystan/attachments/2otech557sight.mdl", bone = "bod", rel = "", pos = Vector(-0.36, 8, -6.2), angle = Angle(0, 90, 0), size = Vector(1, 1, 1), adjustment = {min = 11, max = 13, axis = "y", inverse = true}},
		["md_aimpoint"] = { type = "Model", model = "models/wystan/attachments/aimpoint.mdl", bone = "bod", rel = "", pos = Vector(0.1, 2, -0.25), angle = Angle(0, -180, 0), size = Vector(0.85, 0.85, 0.85), adjustment = {min = 4.5, max = 7.5, axis = "y", inverse = true}},
		["md_reflex"] = { type = "Model", model = "models/attachments/kascope.mdl", bone = "bod", rel = "", pos = Vector(-0.12, -5, 4.7), angle = Angle(0, 180, 0), size = Vector(0.65, 0.65, 0.65), color = Color(255, 255, 255, 0)},
		["md_cmore"] = { type = "Model", model = "models/attachments/cmore.mdl", bone = "bod", rel = "", pos = Vector(-0.122, -3, 4.5), angle = Angle(0, 180, 0), size = Vector(0.649, 0.649, 0.649), color = Color(255, 255, 255, 0)},
		["md_schmidt_shortdot"] = { type = "Model", model = "models/cw2/attachments/schmidt.mdl", bone = "bod", rel = "", pos = Vector(0.2, 0, -0.55), angle = Angle(0, 90, 0), size = Vector(0.899, 0.899, 0.899)},
	}
	
	SWEP.ForeGripHoldPos = {
		["Bip01 L UpperArm"]	= {pos = Vector(0, 0, 0), angle = Angle(-0.5, -4.5, 5)},
		["Bip01 L Finger3"]		= {pos = Vector(0, 0, 0), angle = Angle(0, 28.024, 0)},
		["Bip01 L Finger41"]	= {pos = Vector(0, 0, 0), angle = Angle(0, -41.731, 0)},
		["Bip01 L Clavicle"]	= {pos = Vector(0, 0, 0), angle = Angle(-1.104, -6.309, -2.337)},
		["Bip01 L Finger22"]	= {pos = Vector(0, 0, 0), angle = Angle(0, -52.359, 0)},
		["Bip01 L Finger31"]	= {pos = Vector(0, 0, 0), angle = Angle(0, -19.549, 0)},
		["Bip01 L Finger02"]	= {pos = Vector(0, 0, 0), angle = Angle(14.552, -21.324, 0)},
		["Bip01 L Finger11"]	= {pos = Vector(0, 0, 0), angle = Angle(4.489, -47.452, 0)},
		["Bip01 L Finger4"]		= {pos = Vector(0, 0, 0), angle = Angle(0, 55, 0)},
		["Bip01 L Finger1"]		= {pos = Vector(0, 0, 0), angle = Angle(6.344, -24.75, -6.077)},
		["Bip01 L Finger0"]		= {pos = Vector(0, 0, 0), angle = Angle(-25.786, -21.994, 27.545)},
		["Bip01 L Finger32"]	= {pos = Vector(0, 0, 0), angle = Angle(0, -47.031, 0)},
		["Bip01 L Hand"]		= {pos = Vector(0, 0, 0), angle = Angle(-6.211, -3.247, 71.694)},
		["Bip01 L ForeTwist"]	= {pos = Vector(0, 0, 0), angle = Angle(-1, 0, 55.839)},
		["Bip01 L Finger21"]	= {pos = Vector(0, 0, 0), angle = Angle(0, -8.82, 0)},
		["Bip01 L Finger2"]		= {pos = Vector(0, 0, 0), angle = Angle(2.484, 4.798, 0)},
		["Bip01 L Finger01"]	= {pos = Vector(0, 0, 0), angle = Angle(18.684, 0.316, 0)},
		["Bip01 L Finger42"]	= {pos = Vector(0, 0, 0), angle = Angle(0, -65.405, 0)}
	}
	
	SWEP.IronsightPos = Vector(2.111, -2, 0.101)
	SWEP.IronsightAng = Vector(0.203, -0.015, 0)
	
	SWEP.MicroT1Pos = Vector(2.111, 7, 0.175)
	SWEP.MicroT1Ang = Vector(0.203, -0.015, 0)

	SWEP.EoTechPos = Vector(2.15, -2, 0)
	SWEP.EoTechAng = Vector(0.203, -0.015, 0)
	
	SWEP.AimpointPos = Vector(2.17, -2, 0.2)
	SWEP.AimpointAng = Vector(0.203, 0.215, 0)

	SWEP.ReflexPos = Vector(2.111, -2, 0.38)
	SWEP.ReflexAng = Vector(0.203, -0.015, 0)
	
	SWEP.CmorePos = Vector(2.111, -2, 0.28)
	SWEP.CmoreAng = Vector(0.203, -0.015, 0)

	SWEP.ShortDotPos = Vector(2.111, -2, 0.15)
	SWEP.ShortDotAng = Vector(0.203, -0.015, 0)
	SWEP.SchmidtShortDotAxisAlign = {right = 0, up = 0, forward = 0}
	
	SWEP.SightBackUpPos = Vector(3.9, 1, 0)
	SWEP.SightBackUpAng = Vector(2, 0, 35)

	SWEP.CustomizePos = Vector(-5.54, 2.516, -0.764)
	SWEP.CustomizeAng = Vector(21.302, -28.997, -18.444)
	
	SWEP.SprintPos = Vector(-2.161, -1.621, -1.081)
	SWEP.SprintAng = Vector(-17.775, -22.013, 26.052)

	SWEP.DrawCrosshair = false
	SWEP.AimSwayIntensity = 0.6
		
	SWEP.CustomizationMenuScale = 0.0135
		
	SWEP.WorldShellEjectionAttachmentID = 4
end

	function SWEP:fireAnimFunc()
		local cyc = 0
		local clip = self:Clip1()
		
		if self:isAiming() or self.dt.BipodDeployed or self.ActiveAttachments.md_foregrip or self.ActiveAttachments.md_m203 then
			cyc = 1
		end
		
		if clip > 1 then
			self:sendWeaponAnim("fire",1,cyc)
		else
			self:sendWeaponAnim("fire_dry",1,cyc)
		end
	end //*/
	
	SWEP.SightBGs		= {main = 2, carryhandle = 0, foldsight = 2, none = 1, foldfold = 3}
	SWEP.ForegripBGs	= {main = 3, regular = 0, covered = 1}
	SWEP.MagBGs			= {main = 4, regular = 0, round34 = 1, round100 = 2, round100_empty = 3, none = 4, regular_empty = 5, round34_empty = 6}
	SWEP.StockBGs		= {main = 5, regular = 0, heavy = 1, none = 3}
	SWEP.SilencerBGs	= {main = 6, off = 0, on = 1, long_off = 2, long_on = 3}

	SWEP.LuaViewmodelRecoil = true

	SWEP.Attachments = {
		-- {header = "Sight", offset = {550, -475}, atts = {"md_cod4_reflex","md_fas2_eotech","md_fas2_holo","md_cod4_acog_v2","md_fas2_leupold"}},
		{header = "Sight", offset = {550, -475}, atts = {"md_microt1", "md_eotech", "md_aimpoint", "md_reflex", "md_cmore","md_schmidt_shortdot", "md_acog"}},
		{header = "Barrel ext", offset = {-600, -475}, atts = {"md_saker"}},
		{header = "Bottom Rail", offset = {-600, 425}, atts = {"md_foregrip"}},
		["+reload"] = {header = "Ammo", offset = {1000, 510}, atts = {"am_hollowpoint", "am_armorpiercing"}},
	}

	SWEP.Animations = {
		fire = {"Sshoot1", "Sshoot2", "Sshoot3"},
		fire_dry = "Sshoot_last",
		reload = "Sreload1_tacticool",
		reload_empty = "Sreload1",
		idle = "Sidle",
		draw = "Sdraw"
	}
		
	SWEP.Sounds = {
		Sdraw = {
			[1] = {time = 0.17, sound = "CW_KK_HK416_BOLTBACK"},
			[2] = {time = 0.5, sound = "CW_KK_HK416_BOLTRELEASE"}
		},
		Sreload1 = {
			[1] = {time = 0.38, sound = "CW_KK_HK416_CLIPOUT"},
			[2] = {time = 0.83, sound = "CW_KK_HK416_MAGDROP"},
			[3] = {time = 1.04, sound = "CW_KK_HK416_CLIPIN"},
			[4] = {time = 2, sound = "CW_KK_HK416_BOLTCATCH"}
		},
		Sreload1_tacticool = {
			[1] = {time = 0.38, sound = "CW_KK_HK416_CLIPOUT"},
			[2] = {time = 0.83, sound = "CW_KK_HK416_MAGDROP"},
			[3] = {time = 1.04, sound = "CW_KK_HK416_CLIPIN"},
		},
	}

	SWEP.FireSound = "CW_KK_HK416_FIRE"
	SWEP.FireSoundSuppressed = "CW_KK_HK416_FIRE_SUPPRESSED"

	SWEP.SpeedDec = 20

	SWEP.Slot = 3
	SWEP.SlotPos = 0
	SWEP.HoldType = "ar2"
	SWEP.NormalHoldType = "ar2"
	SWEP.RunHoldType = "passive"
	SWEP.FireModes = {"auto", "3burst", "semi"}
	SWEP.Base = "cw_base"
	SWEP.Category = "STALKER Weapons"

	SWEP.Author			= ""
	SWEP.Contact		= ""
	SWEP.Purpose		= ""
	SWEP.Instructions	= ""

	SWEP.ViewModelFOV	= 70
	SWEP.ViewModelFlip	= true
	SWEP.ViewModel = "models/weapons/v_cwkk_hk416.mdl"
	SWEP.WorldModel = "models/weapons/w_cwkk_hk416.mdl"
	-- SWEP.ShowWorldModel = false
	
	SWEP.DrawTraditionalWorldModel = false
	SWEP.WM = "models/weapons/w_cwkk_hk416.mdl"
	SWEP.WMPos = Vector(0,0,0)
	SWEP.WMAng = Vector(-3,1,180)

	SWEP.Spawnable			= true
	SWEP.AdminSpawnable		= true

	SWEP.Primary.ClipSize		= 30
	SWEP.Primary.DefaultClip	= 0
	SWEP.Primary.Automatic		= true
	SWEP.Primary.Ammo			= "5.56x45MM"

	SWEP.FireDelay = 0.066666666666667
	SWEP.Recoil = 1.05

	SWEP.DurabilityDamageChance = 0.005
SWEP.WearDamage = 0.05
	SWEP.WearEffect = 0.007

	SWEP.HipSpread = 0.045
	SWEP.AimSpread = 0.004
	SWEP.VelocitySensitivity = 1.8
	SWEP.MaxSpreadInc = 0.08
	SWEP.SpreadPerShot = 0.007
	SWEP.SpreadCooldown = 0.2
	SWEP.Shots = 1
	SWEP.Damage = 86
	SWEP.DeployTime = 0.6

	SWEP.ReloadSpeed = 1
	SWEP.ReloadTime = 1.55
	SWEP.ReloadTime_Empty = 2
	SWEP.ReloadHalt = 2
	SWEP.ReloadHalt_Empty = 2.65
	-- SWEP.SnapToIdlePostReload = true