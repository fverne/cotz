AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")
// SCK Name: svd
if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "TKPD"
	SWEP.CSMuzzleFlashes = true
	SWEP.ViewModelMovementScale = 1.15
	
	SWEP.IconLetter = "i"
	killicon.Add("cw_dragnov", "vgui/kills/cw_dragnov", Color(255, 80, 0, 150))
	SWEP.SelectIcon = surface.GetTextureID("vgui/kills/cw_dragnov")
	
	SWEP.MuzzleEffect = "muzzleflash_g3"
	SWEP.PosBasedMuz = true
	SWEP.SnapToGrip = true
	SWEP.ShellScale = 0.7
	SWEP.ShellOffsetMul = 1
	SWEP.ShellPosOffset = {x = 4, y = 0, z = -3}
	SWEP.ForeGripOffsetCycle_Draw = 0
	SWEP.ForeGripOffsetCycle_Reload = 0.0
	SWEP.ForeGripOffsetCycle_Reload_Empty = 0.0
	SWEP.FireMoveMod = 0.6

	SWEP.OverrideAimMouseSens = 0.2
	
	SWEP.IronsightPos = Vector(-11.5, -20.50, 0.73)
	SWEP.IronsightAng = Vector(0.5, 0, 0)
	
	SWEP.AlternativePos = Vector(0.319, 1.325, -1.04)
	SWEP.AlternativeAng = Vector(0, 0, 0)
	
	SWEP.SightWithRail = true
	
	--SWEP.BoltBone = "Bolt"
	--SWEP.BoltShootOffset = Vector(0, 5, 0)
	--SWEP.HoldBoltWhileEmpty = false
	--SWEP.DontHoldWhenReloading = true
	
	SWEP.BaseArm = "bip02"
	SWEP.BaseArmBoneOffset = Vector(-50, 0, 0)

	SWEP.AttachmentModelsVM = {
		["md_pbs1"] = {model = "models/cw2/attachments/pbs1.mdl", bone = "wpn_body", pos = Vector(1.899, 0.1, -33.766), angle = Angle(0, 90, -90), size = Vector(1.5, 1.5, 1.5)},
		["md_foregrip"] = { type = "Model", model = "models/wystan/attachments/foregrip1.mdl", bone = "wpn_body", pos = Vector(-1, 5, -30), angle = Angle(0, 0, -90), size = Vector(1.5, 1.5, 1.5)},
	}
	
	SWEP.ForeGripHoldPos = {
		["bip02_l_finger3"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(-12.223, 0, 0) },
		["bip02_l_finger41"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(-12.223, 0, 0) },
		["l_finger02_bi02"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(3.332, -34.445, -105.556) },
		["bip02_l_finger32"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(-23.334, 0, 0) },
		["bip02_l_finger31"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(-34.445, 0, 0) },
		["l_finger01_bi02"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(-7.778, -12.223, -45.556) },
		["bip02_l_finger11"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(-50, 0, 0) },
		["l_finger0_bi02"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(-50, 0, 0) },
		["bip02_l_finger1"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(-45.556, 0, 0) },
		["bip02_l_finger21"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(-27.778, 0, 0) },
		["l_hand_bi02"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(25.555, -56.667, 0) },
		["bip02_l_finger2"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(-34.445, 0, 0) },
		["bip02_l_finger4"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(-7.778, 0, 0) },
		["l_upperarm_bi02"] = { scale = Vector(1, 1, 1), pos = Vector(1, -3, -2), angle = Angle(0, 0, 0) }
	}



	SWEP.LuaVMRecoilAxisMod = {vert = 0.5, hor = 1, roll = 1, forward = 0.5, pitch = 0.5}
	SWEP.LaserPosAdjust = Vector(0, 0, 0)
	SWEP.LaserAngAdjust = Angle(2.25, 182.5, 0) 

	SWEP.RTAlign = {right = 0, up = 0, forward = 0}
	
	function SWEP:getTelescopeAngles()
		return self.Owner:EyeAngles()
	end
end

SWEP.LuaViewmodelRecoil = true

SWEP.TSGlass = Material("models/joe/tkpd/lense_rt")


	SWEP.Attachments = {[2] = {header = "Barrel", offset = {-250, -300},  atts = {"md_pbs1"}},
		[3] = {header = "Handguard", offset = {-250, 150}, atts = {"md_foregrip"}},
		--["+reload"] = {header = "Ammo", offset = {800, 100}, atts = {"am_hollowpoint", "am_armorpiercing"}}
	}
	
SWEP.Animations = {fire = "shoot",
	reload = "reload",
	idle = "idle1",
	draw = "draw"}
	
SWEP.Sounds = {
	draw = {
	[1] = {time = 0, sound = "CW_SVD_DRAW"}},
	
	reload = {
	[1] = {time = 0.0, sound = "CW_TKPD_RELOAD"}}
}

SWEP.SpeedDec = 50

SWEP.BipodFireAnim = true
SWEP.AimBreathingIntensity = 1
SWEP.AimBreathingEnabled = false

SWEP.Slot = 3
SWEP.SlotPos = 0
SWEP.HoldType = "ar2"
SWEP.NormalHoldType = "ar2"
SWEP.RunHoldType = "passive"
SWEP.FireModes = {"semi"}
SWEP.Base = "cw_base"
SWEP.Category = "STALKER Weapons"
SWEP.AimViewModelFOV = 50

SWEP.Author			= ""
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModelFOV	= 50
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/weapons/tfa_ins2/wpn_tkpd_hud_v.mdl"
SWEP.WorldModel		= "models/weapons/tfa_ins2/wpn_tkpd_w.mdl"
SWEP.DrawTraditionalWorldModel = false
SWEP.ADSFireAnim = false
SWEP.WM = "models/weapons/tfa_ins2/wpn_tkpd_w.mdl"
SWEP.WMPos = Vector(-1, 3, -1.2)
SWEP.WMAng = Vector(-10,1,180)

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 10
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo			= "9.3x64MM"

SWEP.WearDamage = 0.1
SWEP.WearEffect = 0.05

SWEP.FireDelay = 0.2
SWEP.FireSound = "CW_TKPD_FIRE"
SWEP.FireSoundSuppressed = "CW_VSSK_FIRE"
SWEP.Recoil = 2.2

SWEP.HipSpread = 0.15
SWEP.AimSpread = 0.005
SWEP.VelocitySensitivity = 3
SWEP.MaxSpreadInc = 0.4
SWEP.SpreadPerShot = 0.007
SWEP.SpreadCooldown = 0.4
SWEP.Shots = 1
SWEP.Damage = 425
SWEP.DeployTime = 1

SWEP.RecoilToSpread = 0.8

SWEP.ReloadSpeed = 1.10
SWEP.ReloadTime = 2.35
SWEP.ReloadTime_Empty = 3.8
SWEP.ReloadHalt = 0.1
SWEP.ReloadHalt_Empty = 0.1
SWEP.SnapToIdlePostReload = true

if CLIENT then
	local old, x, y, ang
	local reticle = surface.GetTextureID("models/joe/tkpd/tkpd_scope")

	local lens = surface.GetTextureID("cw2/gui/lense")
	local lensMat = Material("cw2/gui/lense")
	local cd, alpha = {}, 0.5
	local Ini = true

	-- render target var setup
	cd.x = 0
	cd.y = 0
	cd.w = 512
	cd.h = 512
	cd.fov = 3
	cd.drawviewmodel = false
	cd.drawhud = false
	cd.dopostprocess = false

	function SWEP:RenderTargetFunc()
		local complexTelescopics = self:canUseComplexTelescopics()
		
		-- if we don't have complex telescopics enabled, don't do anything complex, and just set the texture of the lens to a fallback 'lens' texture
		if not complexTelescopics then
			self.TSGlass:SetTexture("$basetexture", lensMat:GetTexture("$basetexture"))
			return
		end
		
		if self.dt.State == CW_AIMING then
			alpha = math.Approach(alpha, 0, FrameTime() * 5)
		else
			alpha = math.Approach(alpha, 1, FrameTime() * 5)
		end
		
		x, y = ScrW(), ScrH()
		old = render.GetRenderTarget()

		ang = self:getTelescopeAngles()
		
		if self.ViewModelFlip then
			ang.r = -self.BlendAng.z
		else
			ang.r = self.BlendAng.z
		end
		
		if not self.freeAimOn then
			ang:RotateAroundAxis(ang:Right(), self.RTAlign.right)
			ang:RotateAroundAxis(ang:Up(), self.RTAlign.up)
			ang:RotateAroundAxis(ang:Forward(), self.RTAlign.forward)
		end
		
		local size = self:getRenderTargetSize()

		cd.w = size
		cd.h = size
		cd.angles = ang
		cd.origin = self.Owner:GetShootPos()
		render.SetRenderTarget(self.ScopeRT)
		render.SetViewPort(0, 0, size, size)
			if alpha < 1 or Ini then
				render.RenderView(cd)
				Ini = false
			end
			
			ang = self.Owner:EyeAngles()
			ang.p = ang.p + self.BlendAng.x
			ang.y = ang.y + self.BlendAng.y
			ang.r = ang.r + self.BlendAng.z
			ang = -ang:Forward()
			
			local light = render.ComputeLighting(self.Owner:GetShootPos(), ang)
			
			cam.Start2D()
				surface.SetDrawColor(255, 255, 255, 255)
				surface.SetTexture(reticle)
				surface.DrawTexturedRect(0, 0, size, size)
				
				surface.SetDrawColor(150 * light[1], 150 * light[2], 150 * light[3], 255 * alpha)
				surface.SetTexture(lens)
				surface.DrawTexturedRectRotated(size * 0.5, size * 0.5, size, size, 90)
			cam.End2D()
		render.SetViewPort(0, 0, x, y)
		render.SetRenderTarget(old)
		
		if self.TSGlass then
			self.TSGlass:SetTexture("$basetexture", self.ScopeRT)
		end
	end
end