AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "TOZ-34 Special"
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

	SWEP.SprintPos = Vector(0.256, 0.01, 1.2)
	SWEP.SprintAng = Vector(-17.778, 0, 0)
	
	SWEP.AlternativePos = Vector(-0.281, 1.325, -0.52)
	SWEP.AlternativeAng = Vector(0, 0, 0)

	SWEP.SightBackUpPos = Vector(-3.7, -0.5, 1)
	SWEP.SightBackUpAng = Vector(2, 0, -40)

	SWEP.ViewModelMovementScale = 0.8
	SWEP.HUD_MagText = "CYLINDER: "
	SWEP.NXSAlign = {right = 0, up = 0, forward = 0}

	SWEP.LuaVMRecoilAxisMod = {vert = 1, hor = 1.5, roll = 3, forward = 1, pitch = 4}
	SWEP.CustomizationMenuScale = 0.01
	SWEP.DisableSprintViewSimulation = true
end

SWEP.BarrelBGs = {main = 1, regular = 1, long = 2, short = 0}
SWEP.LuaViewmodelRecoil = false
SWEP.CanRestOnObjects = false
SWEP.ADSFireAnim = false

SWEP.Attachments = {
[1] = {header = "Sight", offset = {300, -300},  atts = {"md_nightforce_nxs"}},
["+reload"] = {header = "Ammo", offset = {700, 325}, atts = {"am_slugrounds", "am_trishot", "am_dartrounds", "am_magnumbuck"}}
}

SWEP.AttachmentModelsVM = {
	["md_nightforce_nxs"] = { type = "Model", model = "models/cw2/attachments/l96_scope.mdl", bone = "Tube02", rel = "", pos = Vector(-0.066, -2.181, 0), angle = Angle(90, -90, 0), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}	
SWEP.WElements = {
	["md_nightforce_nxs"] = { type = "Model", model = "models/cw2/attachments/l96_scope.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(-0.519, 0, -10), angle = Angle(0, 0, 0), size = Vector(0.5, 0.5, 0.5), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}

SWEP.Animations = {fire = "fire01",
	reload = "reload_empty",
	reload_empty = "reload_empty",
	idle = "idle",
	draw = "reload"}
	
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

SWEP.SpeedDec = 15

SWEP.Slot = 3
SWEP.SlotPos = 0
SWEP.HoldType = "ar2"
SWEP.NormalHoldType = "ar2"
SWEP.RunHoldType = "passive"
SWEP.FireModes = {"break"}
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
SWEP.Recoil = 2.5

SWEP.DrawSpeed = 1000

SWEP.Chamberable = false

SWEP.HipSpread = 0.05
SWEP.AimSpread = 0.004
SWEP.VelocitySensitivity = 3
SWEP.MaxSpreadInc = 0.4
SWEP.ClumpSpread = 0.007
SWEP.SpreadPerShot = 0.007
SWEP.SpreadCooldown = 0.2
SWEP.Shots = 9
SWEP.Damage = 48
SWEP.DeployTime = 0.5

SWEP.ReloadSpeed = 1.5
SWEP.ReloadTime = 5
SWEP.ReloadTime_Empty = 4.5
SWEP.ReloadHalt = 5
SWEP.ReloadHalt_Empty = 4.5

function SWEP:IndividualInitialize()
	if(CLIENT)then
		self:setBodygroup( 1 , 1 )
	end

	if SERVER then
		timer.Simple(0.1, function()
			self:attachSpecificAttachment("md_nightforce_nxs")
		end)
	end
end
