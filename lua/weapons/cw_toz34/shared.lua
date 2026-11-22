AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "TOZ-34"
	SWEP.CSMuzzleFlashes = true
	
	SWEP.SelectIcon = surface.GetTextureID("weaponicons/mr96")
	killicon.Add("cw_mr96", "weaponicons/mr96", Color(255, 80, 0, 150))
	
	SWEP.MuzzleEffect = "muzzleflash_6"
	SWEP.PosBasedMuz = false
	SWEP.NoShells = true
		
	SWEP.IronsightPos = Vector(-1.986, -3.319, 2.009)
	SWEP.IronsightAng = Vector(0, 0.008, 0)

	SWEP.NXSPos = Vector(-2.004, -3.69, 1.616)
	SWEP.NXSAng = Vector(0, 0, 0)
	SWEP.NXSAlign = {right = 0, up = 0, forward = 0}

	-- Starting aim offsets transferred from the Saiga Sport relative to its NXS.
	SWEP.KobraPos = Vector(-1.974, -4.69, 2.0595)
	SWEP.KobraAng = Vector(0, 0, 0)
	SWEP.MicroT1Pos = Vector(-1.979, -3.69, 1.641)
	SWEP.MicroT1Ang = Vector(0, 0, 0)
	SWEP.EoTechPos = Vector(-1.979, -3.69, 1.541)
	SWEP.EoTechAng = Vector(0, 0, 0)
	SWEP.AimpointPos = Vector(-1.979, -3.69, 1.541)
	SWEP.AimpointAng = Vector(0, 0, 0)
	SWEP.CmorePos = Vector(-1.979, -3.69, 1.641)
	SWEP.CmoreAng = Vector(0, 0, 0)
	SWEP.ReflexPos = Vector(-1.979, -3.69, 1.776)
	SWEP.ReflexAng = Vector(0, 0, 0)
	SWEP.ShortDotPos = Vector(-1.979, -3.69, 1.666)
	SWEP.ShortDotAng = Vector(0, 0, 0)


	SWEP.ACOGPos = Vector(-1.9835, -4.69, 1.566)
	SWEP.ACOGAng = Vector(0, 0, 0)

	SWEP.SchmidtShortDotAxisAlign = {right = 0, up = 0, forward = 0}
	SWEP.ACOGAxisAlign = {right = 0, up = 0, forward = 0}

	-- The shared optics use AK-74 offsets relative to the TOZ-34 Micro T-1.
	SWEP.AttachmentModelsVM = {
		["md_nightforce_nxs"] = {
			model = "models/cw2/attachments/l96_scope.mdl",
			bone = "Tube02",
			pos = Vector(-0.066, -2.181, 0),
			angle = Angle(90, -90, 0),
			size = Vector(0.5, 0.5, 0.5),
		},
		["md_kobra"] = {
			model = "models/cw2/attachments/kobra.mdl",
			bone = "Tube02",
			pos = Vector(0.203, 0.563, 0.2545),
			angle = Angle(0, -180, 90),
			size = Vector(0.3, 0.3, 0.3),
		},
		["md_microt1"] = {
			model = "models/cw2/attachments/microt1.mdl",
			bone = "Tube02",
			pos = Vector(0.009, -1.731, 0.12),
			angle = Angle(0, -180, 90),
			size = Vector(0.2, 0.2, 0.2),
		},
		["md_eotech"] = {
			model = "models/wystan/attachments/2otech557sight.mdl",
			bone = "Tube02",
			pos = Vector(0.1465, 3.711, -5.1845),
			angle = Angle(90, -90, 0),
			size = Vector(0.5, 0.5, 0.5),
		},
		["md_aimpoint"] = {
			model = "models/wystan/attachments/aimpoint.mdl",
			bone = "Tube02",
			pos = Vector(-0.1145, 1.189, -2.68),
			angle = Angle(0, 0, -90),
			size = Vector(0.5, 0.5, 0.5),
		},
		["md_cmore"] = {
			model = "models/attachments/cmore.mdl",
			bone = "Tube02",
			pos = Vector(0.009, -1.631, 0.62),
			angle = Angle(0, 0, -90),
			size = Vector(0.3245, 0.3245, 0.3245),
		},
		["md_reflex"] = {
			model = "models/attachments/kascope.mdl",
			bone = "Tube02",
			pos = Vector(0.009, -1.706, 1.12),
			angle = Angle(0, 0, -90),
			size = Vector(0.275, 0.275, 0.275),
		},
		["md_schmidt_shortdot"] = {
			model = "models/cw2/attachments/schmidt.mdl",
			bone = "Tube02",
			pos = Vector(-0.142, 0.629, -1.659),
			angle = Angle(90, -90, 0),
			size = Vector(0.4, 0.4, 0.4),
		},

		["md_acog"] = {
			model = "models/wystan/attachments/2cog.mdl",
			bone = "Tube02",
			pos = Vector(-0.191, 1.244, -1.88),
			angle = Angle(0, 0, -90),
			size = Vector(0.375, 0.375, 0.375),
		},
	}
	
	SWEP.SprintPos = Vector(0.256, 0.01, 1.2)
	SWEP.SprintAng = Vector(-17.778, 0, 0)
	
	SWEP.AlternativePos = Vector(-0.281, 1.325, -0.52)
	SWEP.AlternativeAng = Vector(0, 0, 0)

	SWEP.ViewModelMovementScale = 0.8
	SWEP.HUD_MagText = "CYLINDER: "

	SWEP.LuaVMRecoilAxisMod = {vert = 1, hor = 1.5, roll = 3, forward = 1, pitch = 4}
	SWEP.CustomizationMenuScale = 0.01
	SWEP.DisableSprintViewSimulation = true
end

SWEP.BarrelBGs = {main = 1, regular = 1, long = 2, short = 0}
SWEP.LuaViewmodelRecoil = false
SWEP.CanRestOnObjects = false
SWEP.ADSFireAnim = false

SWEP.Attachments = {
	[1] = {
		header = "Sight",
		offset = {300, -300},
		atts = {
			"md_nightforce_nxs",
			"md_kobra",
			"md_microt1",
			"md_eotech",
			"md_aimpoint",
			"md_cmore",
			"md_reflex",
			"md_schmidt_shortdot",
			"md_acog",
		},
	},
	["+reload"] = {
		header = "Ammo",
		offset = {700, 325},
		atts = {"am_slugrounds", "am_trishot", "am_dartrounds", "am_magnumbuck"},
	},
}
	
SWEP.Animations = {fire = "fire01",
	reload = "reload",
	reload_empty = "reload_empty",
	idle = "idle",
	draw = "draw"}
	
SWEP.Sounds = {draw = {{time = 0, sound = "CW_FOLEY_LIGHT"}},

	reload = {[1] = {time = 0.5, sound = "CW_TOZ34_OPEN"},
	[2] = {time = 1.3, sound = "CW_TOZ34_SHELL1"},
	[3] = {time = 3.4, sound = "CW_TOZ34_SHELL2"},
	[4] = {time = 4.6, sound = "CW_TOZ34_OPEN"}},
	
	reload_empty = {[1] = {time = 0.5, sound = "CW_TOZ34_OPEN"},
	[2] = {time = 2.1, sound = "CW_TOZ_SHELL1"},
	[3] = {time = 2.5, sound = "CW_TOZ_SHELL2"},
	[4] = {time = 3.6, sound = "CW_TOZ34_OPEN"}}

	}

SWEP.SpeedDec = 10

SWEP.Slot = 3
SWEP.SlotPos = 0
SWEP.HoldType = "ar2"
SWEP.NormalHoldType = "ar2"
SWEP.RunHoldType = "passive"
SWEP.FireModes = {"break","2burst"}
SWEP.Base = "cw_base"
SWEP.Category = "STALKER Weapons"

SWEP.WearDamage = 0.33
SWEP.WearEffect = 0.005

SWEP.Author			= "gumlefar & verne"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModelFOV	= 80
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/weapons/view/shotguns/toz34.mdl"
SWEP.WorldModel		= "models/weapons/w_sv10.mdl"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 2
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "12 Gauge"

SWEP.FireDelay = 0.08
SWEP.FireSound = "CW_TOZ_FIRE"
SWEP.Recoil = 3

SWEP.Chamberable = false

SWEP.HipSpread = 0.06
SWEP.AimSpread = 0.006
SWEP.VelocitySensitivity = 4
SWEP.MaxSpreadInc = 0.4
SWEP.ClumpSpread = 0.008
SWEP.SpreadPerShot = 0.007
SWEP.SpreadCooldown = 0.2
SWEP.Shots = 9
SWEP.Shots_Base = 9
SWEP.Damage = 35
SWEP.DeployTime = 0.5

SWEP.ReloadSpeed = 1.2
SWEP.ReloadTime = 3.5
SWEP.ReloadTime_Empty = 2.7
SWEP.ReloadHalt = 5.75
SWEP.ReloadHalt_Empty = 4.85


function SWEP:IndividualInitialize()
	self:setBodygroup( 1 , 1 )
end


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
