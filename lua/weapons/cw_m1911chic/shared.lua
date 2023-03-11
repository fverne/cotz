if CustomizableWeaponry then

	AddCSLuaFile()
	AddCSLuaFile("sh_sounds.lua")
	include("sh_sounds.lua")
	
	util.PrecacheModel("models/cw2/pistols/silverballer.mdl")
	util.PrecacheModel("models/weapons/w_silverballer.mdl")

	if CLIENT then
		SWEP.DrawCrosshair = false -- False to hide default crosshair. Useful for centering ironsights but should be false for release.
		SWEP.PrintName = "Colt Chigaco" -- What's this called in weapons spawn menu?
		SWEP.CSMuzzleFlashes = true
		SWEP.ZoomAmount = 15 -- Zoom FOV by this much while aiming
		SWEP.AimSwayIntensity = 0.6
		
		SWEP.IconLetter = "f"

		SWEP.MuzzleEffect = "muzzleflash_pistol" -- Name of particle effect (Not a PCF) to use for muzzle flash
		SWEP.PosBasedMuz = true -- Zuh?
		
		SWEP.Shell = "smallshell" -- Type of ejected brass
		SWEP.ShellScale = 0.35 -- Size of ejected brass
		SWEP.ShellOffsetMul = 1
		SWEP.ShellPosOffset = {x = 0, y = 0, z = 0}

		SWEP.IronsightPos = Vector(-1.748, 0, 0.25)
		SWEP.IronsightAng = Vector(0.3, 0, 0)
		
		SWEP.SprintPos = Vector(1.634, -8.28, -7.311)
		SWEP.SprintAng = Vector(70, 0, 0)
		
		SWEP.MoveType = 1
		SWEP.ViewModelMovementScale = 0.8
		SWEP.FullAimViewmodelRecoil = true
		
		SWEP.LaserPosAdjust = Vector(0, 0, 0)
		SWEP.LaserAngAdjust = Angle(0.2, 180, 0)

		SWEP.AttachmentModelsVM = {
			["md_foregrip"] = {model = "models/weapons/cotz/chicgrip.mdl", bone = "M1911_Body", pos = Vector(1.7, -12, 2.599), angle = Angle(0, -90, 0), size = Vector(0.8, 0.8, 0.8)},
			["md_cobram2"] = {model = "models/cw2/attachments/cobra_m2.mdl", bone = "M1911_Body", pos = Vector(-0.04, 7.4, 1.2), angle = Angle(0, 90, 0), size = Vector(0.6, 0.6, 0.6), color = Color(255, 255, 255, 255)},
		}



		SWEP.ForegripOverride = true
		SWEP.ForegripParent = 1

		SWEP.ForeGripOffsetCycle_Draw = 0
		SWEP.ForeGripOffsetCycle_Reload = 0.80
		SWEP.ForeGripOffsetCycle_Reload_Empty = 0.8

		SWEP.ForegripOverridePos = {{
			["Bip01 L Finger23"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 30, 0) },
			["Bip01 L Finger13"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 34.444, 0) },
			["Bip01 L Finger41"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 52.222, 0) },
			["Bip01 L Finger32"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 25.555, 0) },
			["Bip01 L Finger31"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 47.777, 0) },
			["Bip01 L Finger22"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 34.444, 0) },
			["Bip01 L Clavicle"] = { scale = Vector(1, 1, 1), pos = Vector(0.555, 4.5, 0), angle = Angle(0, 0, 0) },
			["Bip01 L Hand"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(1.11, 14.444, 41.111) },
			["Bip01 L Finger12"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 45.555, 0) },
			["Bip01 L Finger21"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 30, 0) },
			["Bip01 L Finger11"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 18.888, 0) },
			["Bip01 L Finger0"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(18.888, 12.222, 34.444) }
		}}

	end

	-- default values are 9x19MM, because we don't know what the user wants
	SWEP.CaseLength = 22.8
	SWEP.BulletDiameter = 11.5
	
	--SWEP.LuaViewmodelRecoil = true -- True to enforce LUA-based movement of bolt/slide bone on shoot.
	SWEP.ADSFireAnim = true -- True to enable SMD-based movement of bolt/slide while aiming
	SWEP.CanRestOnObjects = false
	SWEP.CustomizationMenuScale = 0.01	
	
	SWEP.LuaVMRecoilAxisMod = {vert = 1, hor = 1.5, roll = 3, forward = 1, pitch = 4}	

	SWEP.Attachments = {[1] = {header = "Barrel", offset = {-350, -200}, atts = {"md_cobram2"}},
		[2] = {header = "grip", offset = {-400, -300}, atts = {"md_foregrip"}},
	["+reload"] = {header = "Ammo", offset = {800, 100}, atts = {"am_hollowpoint", "am_armorpiercing"}}}
	
	-- Sequence names go here: "idle", NOT animation events like "ACT_VM_IDLE"
	SWEP.Animations = {fire = {"shoot1", "shoot2"},
		fire_dry = "shoot_empty",
		reload = "reload",
		reload_empty = "reload_2",
		idle = "idle",
		draw = "draw"}

	SWEP.Sounds = {draw = {{time = 0, sound = "Silverballer.Deploy"}},

		reload = {[1] = {time = 0, sound = "Silverballer.Foley"},
		[2] = {time = 0.42, sound = "Silverballer.ClipOut"},
		[3] = {time = 1.1, sound = "Silverballer.ClipFoley"},
		[4] = {time = 1.38, sound = "Silverballer.ClipIn"},
		[5] = {time = 1.48, sound = "Silverballer.ClipLocked"}},
		
		reload_2 = {[1] = {time = 0, sound = "Silverballer.Foley"},
		[2] = {time = 0.42, sound = "Silverballer.ClipOut"},
		[3] = {time = 1.1, sound = "Silverballer.ClipFoley"},		
		[4] = {time = 1.375, sound = "Silverballer.ClipIn"},
		[5] = {time = 1.435, sound = "Silverballer.ClipLocked"},
		[6] = {time = 2.00, sound = "Silverballer.SlideForward"}}}


	SWEP.SpeedDec = 10

	SWEP.Slot = 2
	SWEP.SlotPos = 0
	SWEP.HoldType = "smg"
	SWEP.NormalHoldType = "pistol"
	SWEP.RunHoldType = "passive"
	SWEP.FireModes = {"auto"}
	SWEP.Base = "cw_base"
	SWEP.Category = "STALKER Weapons"			--Which spawn menu/weapons category this is in

	SWEP.Author			= "Doktor haus - edited by gumlefar" --Who made this shit?
	SWEP.Contact		= "" --Who should everyone spam with requests and complaints?
	SWEP.Purpose		= "" --Why?
	SWEP.Instructions	= "" --how do i shot web

	SWEP.ViewModelFOV	= 70	--first person Field Of Vision
	SWEP.ViewModelFlip	= false --Mirror ViewModel horizontally?
	SWEP.ViewModel		= "models/cw2/pistols/silverballer.mdl"
	SWEP.WorldModel		= "models/weapons/w_silverballer.mdl"
	SWEP.DrawTraditionalWorldModel = false	--Whether to use world model's embedded/compiled origin
	SWEP.WM = "models/weapons/w_silverballer.mdl"
	SWEP.WMPos = Vector(1.3,-5.2,2.8)		--world model origin X,Y,Z
	SWEP.WMAng = Vector(-10,180,180)			--world model angles X,Y,Z

	SWEP.Spawnable			= true
	SWEP.AdminSpawnable		= true


	SWEP.Primary.ClipSize		= 13
	SWEP.Primary.DefaultClip	= 13
	SWEP.Primary.Automatic		= true
	SWEP.Primary.Ammo			= ".45 ACP" --Ammo box entity to use

	SWEP.FireDelay = 0.07
	SWEP.FireSound = "CW_SILVERBALLER_FIRE"
	SWEP.FireSoundSuppressed = "CW_SILVERBALLER_FIRE_SD"
	SWEP.Recoil = 2.0

	SWEP.WearDamage = 0.1
	SWEP.WearEffect = 0.05

	SWEP.HipSpread = 0.025
	SWEP.AimSpread = 0.005
	SWEP.VelocitySensitivity = 1.2
	SWEP.MaxSpreadInc = 0.06
	SWEP.SpreadPerShot = 0.02
	SWEP.SpreadCooldown = 0.32
	SWEP.Shots = 1
	SWEP.Damage = 65
	SWEP.DeployTime = 1

	SWEP.ReloadSpeed = 1
	SWEP.ReloadTime = 1.9
	SWEP.ReloadHalt = 1.8

	SWEP.ReloadTime_Empty = 2.5
	SWEP.ReloadHalt_Empty = 2.4
	SWEP.SnapToIdlePostReload = false
end

function SWEP:IndividualInitialize()


	if(CLIENT)then
		self:setBodygroup( 1 , 1 )
		self.WMEnt:SetBodygroup( 0, 1 )
	end

	if SERVER then
		timer.Simple(0.1, function()
			self:attachSpecificAttachment("md_foregrip")
		end)
	end
end
