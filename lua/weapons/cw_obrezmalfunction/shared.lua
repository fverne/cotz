AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "Mercenary Malfunction"
	SWEP.CSMuzzleFlashes = true
	SWEP.ViewModelMovementScale = 1.15
	
	SWEP.IconLetter = "w"
	killicon.Add( "khr_mosin", "icons/killicons/khr_mosin", Color(255, 80, 0, 150))
	SWEP.SelectIcon = surface.GetTextureID("icons/killicons/khr_mosin")
	
	SWEP.DrawTraditionalWorldModel = false
	SWEP.WM = "models/weapons3/mosina.mdl"
	SWEP.WMPos = Vector(-2,5,13)
	SWEP.WMAng = Vector(0,10, 270)
	
	SWEP.MuzzleEffect = "muzzleflash_SUPPRESSED"
	SWEP.PosBasedMuz = true
	SWEP.SightWithRail = true
	SWEP.NoDistance = true
	SWEP.SnapToIdlePostReload = false
	SWEP.CrosshairEnabled = true
	SWEP.FOVPerShot = 0.25
	SWEP.ShellScale = 0.28
	SWEP.ShellDelay = .75
	SWEP.NoShells = false
	SWEP.ShellOffsetMul = 0
	SWEP.ShellPosOffset = {x = 6, y = -.25, z = .5}
	SWEP.FireMoveMod = 0.6
	SWEP.CustomizationMenuScale = 0.03

	SWEP.IronsightPos = Vector(-2.8155, -1.6667, 1.455)
	SWEP.IronsightAng = Vector(0, 0.03, 0)

	SWEP.PUPos = Vector(-2.819, 0, 0.723)
	SWEP.PUAng = Vector(0, 0, 0)
	
	SWEP.SprintPos = Vector(1.786, -1, -1)
	SWEP.SprintAng = Vector(-10.778, 27.573, 0)
	
	SWEP.AlternativePos = Vector(-0.5, 0, -0.25)
	SWEP.AlternativeAng = Vector(0, 0, 0)

	-- SWEP.AlternativePos = Vector(25.5, -25, -0.25)
	-- SWEP.AlternativeAng = Vector(0, 90, 0)
	
	SWEP.ACOGPos = Vector(-2.821, -9, -0.2144)
	SWEP.ACOGAng = Vector(-1, 0, 0)

	SWEP.NXSPos = Vector(-3.793, -3, 1.467)
	SWEP.NXSAng = Vector(0, 0, -45)

	SWEP.PSOPos = Vector(-2.916, -9, 0.12)
	SWEP.PSOAng = Vector(0, -1.15, 0)

	SWEP.ShortDotPos = Vector(-3.626, -5, 1.28)
	SWEP.ShortDotAng = Vector(0, 0, 0)

	-- SWEP.SightBackUpPos = Vector(-2.8155, -1.6667, 1.455)
	-- SWEP.SightBackUpAng = Vector(0, 0.03, 0)

	SWEP.SightBackUpPos = Vector(0.3155, -1.6667, 2.255)
	SWEP.SightBackUpAng = Vector(0, 0.03, 0)
	
	SWEP.NXSAlign = {right = 0, up = 0, forward = 45}
	SWEP.ACOGAxisAlign = {right = 1.1, up = 0, forward = 0}
	SWEP.PUAxisAlign = {right = 0, up = 0, forward = 0}
	SWEP.SchmidtShortDotAxisAlign = {right = 180, up = 180, forward = 180}
	SWEP.LuaVMRecoilAxisMod = {vert = 1, hor = 1, roll = 1, forward = 0, pitch = 1}
	SWEP.PSO1AxisAlign = {right = -1.15, up = 0, forward = 0}

	SWEP.AttachmentModelsVM = {
		["md_pbs1"] = {model = "models/cw2/attachments/pbs1.mdl", bone = "Weapon", pos = Vector(0, 17.5, -.3), angle = Angle(0, 180, 0), size = Vector(0.9, 2.5, 0.9)},
		["md_nightforce_nxs"] = {model = "models/cw2/attachments/l96_scope.mdl", bone = "Weapon", pos = Vector(-1.1, 1, 1.8), angle = Angle(0, 270, 45), size = Vector(1.2, 1, 1)},
		["md_saker"] = {model = "models/weapons/w_csgo_bayonet.mdl", bone = "Weapon", pos = Vector(-3, 10, 1), angle = Angle(0, -30, 90), size = Vector(1.3, 1.3, 1.3)}, -- i'm so sorry
	}

end

SWEP.MuzzleVelocity = 865 -- in meter/s

SWEP.BoltBGs = {main = 1, bent = 1, straight = 0}
SWEP.SightBGs = {main = 2, scope = 1, none = 0}
SWEP.StockBGs = {main = 0, full = 0, custom = 1, carbine = 2, obrez = 3}


SWEP.Attachments = {
[1] = {header = "Sight", offset = {300, -300},  atts = {"md_pso1","md_nightforce_nxs"}},
[2] = {header = "Muzzle", offset = {300, -300},  atts = {"md_pbs1"}},
[3] = {header = "Finish", offset = {50, -350},  atts = {"md_mnolddark"}},
[4] = {header = "Bayonet", offset = {300, -300},  atts = {"md_saker"}},
["+reload"] = {header = "Ammo", offset = {-150, 425}, atts = {"am_hollowpoint", "am_armorpiercing"}}}

SWEP.Animations = {fire = "base_fire_start",
	reload_start = "reload_start",
	insert = "reload_insert",
	reload_end = "reload_end",
	idle = "reload_end",
	draw = "base_draw"}
	
SWEP.Sounds = {	bent_reload_start = {
		{time = 4/30, sound = "KHRMOSIN_BOLTRELEASE"},
		{time = 10/30, sound = "KHRMOSIN_BOLTBACK"},
	},
	
	reload_start = {
		{time = 4/30, sound = "KHRMOSIN_BOLTRELEASE"},
		{time = 10/30, sound = "KHRMOSIN_BOLTBACK"},
	},

		reload_insert = {
		{time = 8/30, sound = "KHRMOSIN_BULLETIN"},
	},
	
		reload_end = {
		{time = 7/30, sound = "KHRMOSIN_BOLTFORWARD"},
		{time = 11/30, sound = "KHRMOSIN_BOLTLATCH"},
	},
	
		bent_reload_end = {
		{time = 7/30, sound = "KHRMOSIN_BOLTFORWARD"},
		{time = 11/30, sound = "KHRMOSIN_BOLTLATCH"},
	},
	
		bent_fire_start = {
		{time = 15/30, sound = "KHRMOSIN_BOLTRELEASE"},
		{time = 19/30, sound = "KHRMOSIN_BOLTBACK"},
		{time = 28/30, sound = "KHRMOSIN_BOLTFORWARD"},
		{time = 35/30, sound = "KHRMOSIN_BOLTLATCH"},
		
	},
		
		base_fire_start = {
		{time = 15/30, sound = "KHRMOSIN_BOLTRELEASE"},
		{time = 19/30, sound = "KHRMOSIN_BOLTBACK"},
		{time = 28/30, sound = "KHRMOSIN_BOLTFORWARD"},
		{time = 35/30, sound = "KHRMOSIN_BOLTLATCH"}
	}}

SWEP.SpeedDec = 5

SWEP.Slot = 3
SWEP.SlotPos = 0
SWEP.HoldType = "ar2"
SWEP.NormalHoldType = "ar2"
SWEP.RunHoldType = "passive"
SWEP.FireModes = {"bolt"}
SWEP.Base = "cw_base"
SWEP.Category = "STALKER Weapons"

SWEP.Author			= ""
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModelFOV	= 70
SWEP.AimViewModelFOV = 60
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/khrcw2/v_khri_mosinm91.mdl"
SWEP.WorldModel		= "models/weapons3/mosina.mdl"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true
SWEP.ADSFireAnim = true
SWEP.Chamberable = false

SWEP.LuaViewmodelRecoil = false
SWEP.ForcedHipWaitTime = 1.2

SWEP.OverallMouseSens = .8
SWEP.Primary.ClipSize		= 5
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "7.62x54MMR"
SWEP.ForceBackToHipAfterAimedShot = true

SWEP.FireDelay = 60/50
SWEP.FireSound = "CW_BER_SVT40_FIRE"
SWEP.FireSoundSuppressed = "CW_BER_SVT40_FIRE"
SWEP.Recoil = 3.8

SWEP.SuppressedOnEquip = true

SWEP.HipSpread = 0.045
SWEP.AimSpread = 0.010
SWEP.VelocitySensitivity = 4
SWEP.MaxSpreadInc = 0.5
SWEP.SpreadPerShot = 0.025
SWEP.SpreadCooldown = 0.2
SWEP.GlobalDelayOnShoot = 1.1

SWEP.WearDamage = 0.33
SWEP.WearEffect = 0.005

SWEP.Shots = 1
SWEP.Damage = 210
SWEP.DeployTime = .6

SWEP.FireAnimSpeed = 1.3
SWEP.ReloadSpeed = 1.2
SWEP.ReloadStartTime = 0.9
SWEP.InsertShellTime = .75
SWEP.ReloadFinishWait = 1
SWEP.ShotgunReload = true
SWEP.AlwaysPlayReloadEnd = true


function SWEP:IndividualInitialize()
	self:setBodygroup(self.StockBGs.main, self.StockBGs.obrez)
	self:setBodygroup(self.BoltBGs.main, self.BoltBGs.bent)
	if self.CW_VM then
		self.CW_VM:SetSkin(3)
	end
	if SERVER then
		timer.Simple(0.1, function()
			self:attachSpecificAttachment("md_nightforce_nxs")
			self:attachSpecificAttachment("md_pbs1")
			self:attachSpecificAttachment("md_saker")
		end)
	end
end