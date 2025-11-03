AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "Sako RK 95"
	SWEP.CSMuzzleFlashes = true
	
	SWEP.IronsightPos = Vector(-2.990, -1.423, 0.43)
	SWEP.IronsightAng = Vector(0, 0, 0)
	
	SWEP.AimpointPos = Vector(-2.990, -1.423, -0.49)
	SWEP.AimpointAng = Vector(0, 0, 0)
	
	SWEP.EoTechPos = Vector(-2.990, -1.423, -0.49)
	SWEP.EoTechAng = Vector(0, 0, 0)
	
	SWEP.CmorePos = Vector(-2.990, -1.423, -0.19)
	SWEP.CmoreAng = Vector(0, 0, 0)
	
	SWEP.MicroT1Pos = Vector(-2.990, -1.423, -0.29)
	SWEP.MicroT1Ang = Vector(0, 0, 0)
	
	SWEP.ReflexPos = Vector(-2.990, -1.423, -0.05)
	SWEP.ReflexAng = Vector(0, 0, 0)

	SWEP.ACOGPos = Vector(-2.995, -3.423, -0.44)
	SWEP.ACOGAng = Vector(0, 0, 0)
	SWEP.ACOGAxisAlign = {right = 0, up = 0, forward = 0}

	SWEP.ViewModelMovementScale = 1.15
	
	SWEP.IconLetter = "b"
	killicon.AddFont("cw_ak74", "CW_KillIcons", SWEP.IconLetter, Color(255, 80, 0, 150))
	
	SWEP.MuzzleEffect = "muzzleflash_ak74"
	SWEP.MuzzleAttachmentName = "muzzle"
	SWEP.PosBasedMuz = false
	SWEP.ShellScale = 0.7
	SWEP.ShellOffsetMul = 1
	SWEP.ShellPosOffset = {x = -2, y = 0, z = -3}
	SWEP.SightWithRail = true
	SWEP.ForeGripOffsetCycle_Draw = 0
	SWEP.ForeGripOffsetCycle_Reload = 0.65
	SWEP.ForeGripOffsetCycle_Reload_Empty = 0.9
	SWEP.BoltBone = "bolt"
	SWEP.BoltShootOffset = Vector(-2, 0, 0)
	SWEP.OffsetBoltOnBipodShoot = true
	SWEP.BoltBonePositionRecoverySpeed = 25

	SWEP.AttachmentModelsVM = {["md_rail"] = {model = "models/wystan/attachments/rail.mdl", bone = "stock", pos = Vector(-6.448, -0.038, 0.671), angle = Angle(0, 0, -90), size = Vector(0.925, 0.925, 0.925)},
		["md_microt1"] = {model = "models/cw2/attachments/microt1.mdl", bone = "stock", pos = Vector(-5, -1.9, 0.47), angle = Angle(-90, 90, 0), adjustment = {min = -1.3, max = 0.5, inverseOffsetCalc = true, axis = "y"}, size = Vector(0.4, 0.4, 0.4)},
		["md_eotech"] = {model = "models/wystan/attachments/2otech557sight.mdl", bone = "stock", pos = Vector(6, 9, 0.74), adjustment = {min = 9, max = 11.609, axis = "x", inverse = true, inverseDisplay = true}, angle = Angle(0, 180, 90), size = Vector(1, 1, 1)},
		["md_aimpoint"] = {model = "models/wystan/attachments/aimpoint.mdl", bone = "stock", pos = Vector(1, 3.9, 0.2), adjustment = {min = 4, max = 6.6, axis = "x", inverse = true}, angle = Angle(90, -90, 0), size = Vector(1, 1, 1)},
		["md_foregrip"] = {model = "models/wystan/attachments/foregrip1.mdl", bone = "stock", pos = Vector(0, 2.5, 0.05), angle = Angle(90, 0, -90), size = Vector(0.75, 0.75, 0.75)},
		["md_pbs1"] = {model = "models/cw2/attachments/pbs1.mdl", bone = "stock", pos = Vector(-19.57, -0.32, -0.15), angle = Angle(0, 90, 0), size = Vector(0.5, 0.5, 0.5)},
		["md_schmidt_shortdot"] = {model = "models/cw2/attachments/schmidt.mdl", bone = "stock", pos = Vector(0, 2.75, 0.16), angle = Angle(0, 180, 90), size = Vector(0.8, 0.8, 0.8)},
		["md_reflex"] = { type = "Model", model = "models/attachments/kascope.mdl", bone = "stock", rel = "", pos = Vector(-6, -1.9, 0.46), angle = Angle(90, 270, 0), size = Vector(0.55, 0.55, 0.55), color = Color(255, 255, 255, 0)},
		["md_cmore"] = { type = "Model", model = "models/attachments/cmore.mdl", bone = "stock", rel = "", pos = Vector(-5, -1.6, 0.46), angle = Angle(90, 270, 0), size = Vector(0.649, 0.649, 0.649), color = Color(255, 255, 255, 0)},
		["md_acog"] = {model = "models/wystan/attachments/2cog.mdl", bone = "stock", pos = Vector(0, 2.5, 0.18), angle = Angle(90, 90, 180), size = Vector(0.75, 0.75, 0.75)},
	}

	SWEP.ShortDotPos = Vector(-2.990, -3.423, -0.3)
	SWEP.ShortDotAng = Vector(0, 0, 0)

	SWEP.ForegripOverride = {
	["Left Impudicus Phalanges1"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(-23.334, 12.222, 25.555) },
	["Left Demonstratus Phalanges3"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, -32.223, -3.333) },
	["Left Auricularis Phalanges1"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(-27.778, 61.111, 23.333) },
	["Left Demonstratus Phalanges1"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(-14.445, -30, 45.555) },
	["Left Lower Arm 2"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(5.556, 0, -23.334) },
	["Left Annularis Phalanges3"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, -58.889, 0) },
	["Left Auricularis Phalanges3"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, -50, 0) },
	["Left Annularis Phalanges1"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(-21.112, 14.444, 32.222) },
	["Left Auricularis Phalanges2"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, -30, 0) },
	["Left Impudicus Phalanges2"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, -36.667, 1.11) },
	["Left Hand"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0.925, 0), angle = Angle(-32.223, 10, 63.333) },
	["Left Polex Phalange1"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(-45.556, -18.889, 0) }
	}
		
	SWEP.SchmidtShortDotAxisAlign = {right = 0, up = 0, forward = 0}
end

function SWEP:drawViewModel()
	if not self.CW_VM then
		return
	end

	local FT = FrameTime()
	
	self.LuaVMRecoilIntensity = math.Approach(self.LuaVMRecoilIntensity, 0, FT * 10 * self.LuaVMRecoilLowerSpeed)
	self.LuaVMRecoilLowerSpeed = math.Approach(self.LuaVMRecoilLowerSpeed, 1, FT * 2)
	
	self:drawGrenade()
	self:applyOffsetToVM()
	self:_drawViewModel()
	
	if self.BoneMod then
		for key,value in pairs(self.BoneMod) do
			self.CW_VM:ManipulateBoneScale(self.CW_VM:LookupBone(key), value.scale)
			self.CW_VM:ManipulateBonePosition(self.CW_VM:LookupBone(key), value.pos)
			self.CW_VM:ManipulateBoneAngles(self.CW_VM:LookupBone(key), value.angle)
		end
	end

end

SWEP.LuaViewmodelRecoil = true

SWEP.Attachments = {[1] = {header = "Sight", offset = {800, -500},  atts = {"md_microt1", "md_eotech", "md_aimpoint", "md_cmore", "md_reflex", "md_schmidt_shortdot", "md_acog"}},
	[2] = {header = "Barrel", offset = {300, -500}, atts = {"md_pbs1"}},
	["+reload"] = {header = "Ammo", offset = {800, 0}, atts = {"am_hollowpoint", "am_armorpiercing"}}}

SWEP.Animations = {draw = "deploy",
	idle = "idle_scoped",
	fire = "fire",
	fire_iron = "fire_scoped",
	reload = "reload",
	reload_empty = "reload_empty"
}
	

SWEP.Sounds = {
	
	deploy = {[1] = {time = 0.1, sound = "CW_FOLEY_MEDIUM"}},
	
	reload = {[1] = {time = 0.7, sound = "CYN_CW_FAS2_RK95_MAGOUT"},
		[2] = {time = 1.3, sound = "CW_FOLEY_LIGHT"},
		[3] = {time = 1.6, sound = "CYN_CW_FAS2_MAGPOUCH_AR"},
		[4] = {time = 1.96, sound = "CYN_CW_FAS2_RK95_MAGIN"}
	},
	
	reload_empty = {[1] = {time = 0.7, sound = "CYN_CW_FAS2_RK95_MAGOUT_EMPTY"},
		[2] = {time = 1.3, sound = "CW_FOLEY_LIGHT"},
		[3] = {time = 1.45, sound = "CYN_CW_FAS2_MAGPOUCH_AR"},
		[4] = {time = 1.97, sound = "CYN_CW_FAS2_RK95_MAGIN"},
		[5] = {time = 3.2, sound = "CYN_CW_FAS2_RK95_BOLTPULL"},
		[6] = {time = 3.45, sound = "CYN_CW_FAS2_RK95_BOLTRELEASE"}
	}
}


SWEP.SpeedDec = 25

SWEP.Slot = 3
SWEP.SlotPos = 0
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

SWEP.ViewModelFOV	= 70
SWEP.ViewModelFlip	= false
SWEP.ViewModel = "models/weapons/view/rifles/rk95.mdl"
SWEP.WorldModel = "models/weapons/world/rifles/rk95.mdl"
SWEP.DrawTraditionalWorldModel = false
SWEP.WM = "models/weapons/world/rifles/rk95.mdl"
SWEP.WMPos = Vector(-0.4, 7, 2.4)
SWEP.WMAng = Vector(-6, 0, 180)

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 30
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "7.62x39MM"

SWEP.FireDelay = 0.08
SWEP.FireSound = "CW_RK95_FIRE"
SWEP.FireSoundSuppressed = "CW_RK95_FIRE_SUPPRESSED"
SWEP.Recoil = 1.4

SWEP.DurabilityDamageChance = 0.005
SWEP.WearDamage = 0.05
SWEP.WearEffect = 0.007

SWEP.HipSpread = 0.1
SWEP.AimSpread = 0.005
SWEP.VelocitySensitivity = 3
SWEP.MaxSpreadInc = 0.09
SWEP.SpreadPerShot = 0.007
SWEP.SpreadCooldown = 0.2
SWEP.Shots = 1
SWEP.Damage = 87
SWEP.DeployTime = 0.6

SWEP.ReloadSpeed = 1
SWEP.ReloadTime = 2.1
SWEP.ReloadTime_Empty = 2.2
SWEP.ReloadHalt = 2.9
SWEP.ReloadHalt_Empty = 3.9
SWEP.SnapToIdlePostReload = true

function SWEP:IndividualInitialize()
	self:setBodygroup( 1 , 1 )
end