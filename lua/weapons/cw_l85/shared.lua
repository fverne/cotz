AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "L85"
	SWEP.CSMuzzleFlashes = true
	SWEP.ViewModelMovementScale = 1.15
	
	--SWEP.IconLetter = "w"
	SWEP.SelectIcon = surface.GetTextureID("weaponicons/l85a1")
	--killicon.AddFont("cw_l85", "CW_KillIcons", SWEP.IconLetter, Color(255, 80, 0, 0))
	killicon.Add("cw_l85fix", "weaponicons/l85a1", Color(255, 80, 0, 150))

	SWEP.SimpleTelescopicsFOV = 69  -- nice
	
	SWEP.MuzzleEffect = "muzzleflash_6"
	SWEP.PosBasedMuz = true
	SWEP.SnapToGrip = true
	SWEP.ShellScale = 0.7
	SWEP.ShellOffsetMul = 1
	SWEP.ShellPosOffset = {x = 2, y = 0, z = -2}
	SWEP.ForeGripOffsetCycle_Draw = 0.9
	SWEP.ForeGripOffsetCycle_Reload = 1
	SWEP.ForeGripOffsetCycle_Reload_Empty = 1
	
	SWEP.M203OffsetCycle_Reload = 0.65
	SWEP.M203OffsetCycle_Reload_Empty = 0.73
	SWEP.M203OffsetCycle_Draw = 0
	
	---SWEP.IronsightPos = Vector(22.614, -1.103, -0.274)
	--SWEP.IronsightPos = Vector(2.614, -1.103, -0.34)
	--SWEP.IronsightAng = Vector(1.251, -0.053, 0)
	
	SWEP.IronsightPos = Vector(2.618, -4.148, 0.477) --Vector(2.618, -2.448, 0.307)
	SWEP.IronsightAng = Vector(-1.25,0,0) --Vector(1.251, -0.053, -0.149)
	--SWEP.AimAng = Vector(-1.25,0,0)
	
	SWEP.AlternativePos = Vector(-0.32, 0, -0.64)
	SWEP.AlternativeAng = Vector(0, 0, 0)

	SWEP.SprintPos = Vector(-1.005, -0.403, 0)
	SWEP.SprintAng = Vector(-8.443, -32.362, 0)


	SWEP.CustomizePos = Vector(-3.891, -0.542, -1.321)
	SWEP.CustomizeAng = Vector(13.875, -27.591, -8.108)
	
	SWEP.SightBackUpPos = Vector(2.614, -1.103, -0.34)
	SWEP.SightBackUpAng = Vector(1.251, -0.053, 0)
	
	SWEP.BaseArm = "Bip01-L-UpperArm"
	SWEP.BaseArmBoneOffset = Vector(0, 0, 0)
	
	SWEP.AttachmentModelsVM = {
		["md_saker"] = {model = "models/cw2/attachments/556suppressor.mdl", bone = "Body", pos = Vector(0.008, -6.374, -2.095), angle = Angle(0, 180, 0), size = Vector(0.6, 0.6, 0.6)},
		["md_foregrip"] = {model = "models/wystan/attachments/foregrip1.mdl", bone = "Body", rel = "", pos = Vector(-0.378, -22.701, -3.418), angle = Angle(0, 0, 2.997), size = Vector(0.75, 0.75, 0.75)}
	}
	
	SWEP.ForeGripHoldPos = {
		["Bone10(mirrored)"] = {pos = Vector(0, 0, 0), angle = Angle(-26.601, 1.996, 0) },
		["Bone22(mirrored)"] = {pos = Vector(0, 0, 0), angle = Angle(-36.717, -17.036, 22.711) },
		["Bone01(mirrored)"] = {pos = Vector(6.135, 3.982, -6.394), angle = Angle(-34.147, 69.346, 42.576) },
		["Bone23(mirrored)"] = {pos = Vector(0, 0, 0), angle = Angle(0.05, -13.188, -1.055) },
		["Bone06(mirrored)"] = {pos = Vector(0, 0, 0), angle = Angle(-42.478, 0, 0) },
		["Bone15(mirrored)"] = {pos = Vector(0, 0, 0), angle = Angle(15.409, 0, 0) },
		["Bone08(mirrored)"] = {pos = Vector(0, 0, 0), angle = Angle(7.741, 0, 0) },
		["Bone07(mirrored)"] = {pos = Vector(0, 0, 0), angle = Angle(0.876, 0, 0) },
		["Bone19(mirrored)"] = {pos = Vector(0, 0, 0), angle = Angle(0.391, 0, 0) },
		["Bone24(mirrored)"] = {pos = Vector(0, 0, 0), angle = Angle(-18.942, -68.932, 12.362) },
		["Bone11(mirrored)"] = {pos = Vector(0, 0, 0), angle = Angle(-3.478, 7.822, 0) },
		["Bone14(mirrored)"] = {pos = Vector(0, 0, 0), angle = Angle(-29.633, 7.408, -18.871) },
		["Bone16(mirrored)"] = {pos = Vector(0, 0, 0), angle = Angle(-70.115, 0, 0) },
		["Bone18(mirrored)"] = {pos = Vector(0, 0, 0), angle = Angle(-18.96, 7.178, -15.605) },
		["Bone20(mirrored)"] = {pos = Vector(0, 0, 0), angle = Angle(-33.633, 0, 0) },
		["Bone12(mirrored)"] = {pos = Vector(0, 0, 0), angle = Angle(-22.014, 0, 0) }
	}

	
	SWEP.WElements = {
	["weapon"] = { type = "Model", model = "models/weapons/v_rif_l852.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(0, 1, -0.5), angle = Angle(-5.844, 0, 180), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
	}
	SWEP.LuaVMRecoilAxisMod = {vert = 1, hor = 1, roll = 1.5, forward = 0, pitch = 0.5}
	SWEP.OverrideAimMouseSens = 0.8
	
	-- what the fuck is the use for this
	SWEP.ZoomTextures = {{tex = surface.GetTextureID("models/weapons/v_models/l85a2/susat_scopecross"), offset = {0.5, 4}, size={1200, 1200}}}
	SWEP.RTAlign = {right = -0.1, up = 0, forward = 0}
	
end

SWEP.BlurOnAim = false


SWEP.LuaViewmodelRecoil = true
SWEP.LuaViewmodelRecoilOverride = false

SWEP.Attachments = {
	[1] = {header = "Barrel", offset = {200, -300}, atts = {"md_saker"}}, --offset = {200, -500}
	[2] = {header = "Handguard", offset = {-400, 0}, atts = {"md_foregrip"}},
	["+reload"] = {header = "Ammo", offset = {200, 400}, atts = {"am_hollowpoint", "am_armorpiercing"}}}

SWEP.Animations = {fire = {"shoot1", "shoot2", "shoot3"},
	reload = "reload",
	idle = "idle",
	draw = "draw"}
	
SWEP.Sounds = {reload = {[1] = {time = 0.35, sound = "CW_l85_MAGOUT"},
	[2] = {time = 1.2, sound = "CW_l85_MAGIN"},
	[3] = {time = 1.9, sound = "CW_l85_BOLT"}}}

SWEP.SpeedDec = 20

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
SWEP.ViewModelFlip	= true
SWEP.ViewModel 		= "models/weapons/v_rif_l852_mod2.mdl" -- recompiled model to not have snappy reload animation
SWEP.WorldModel 	= "models/weapons/w_rif_l852.mdl"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 30
SWEP.Primary.DefaultClip	= 0
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "5.56x45MM"

SWEP.FireDelay = 0.12
SWEP.FireSound = "CW_l85_FIRE"
SWEP.FireSoundSuppressed = "CW_G3A3_FIRE_SUPPRESSED"
SWEP.Recoil = 1.15

SWEP.DurabilityDamageChance = 0.005
SWEP.WearDamage = 0.05
SWEP.WearEffect = 0.007

SWEP.HipSpread = 0.10
SWEP.AimSpread = 0.005
SWEP.VelocitySensitivity = 3
SWEP.MaxSpreadInc = 0.12
SWEP.SpreadPerShot = 0.01
SWEP.SpreadCooldown = 0.2
SWEP.Shots = 1
SWEP.Damage = 80
SWEP.DeployTime = 0.7
SWEP.DrawSpeed = 0.98

SWEP.ReloadSpeed = 0.95
SWEP.ReloadTime = 1.82
SWEP.ReloadTime_Empty = 2.6
SWEP.ReloadHalt = 2.0
SWEP.ReloadHalt_Empty = 3.1
SWEP.SnapToIdlePostReload = true

-- such a pain in the ass to fucking do this
SWEP.DrawTraditionalWorldModel = false
SWEP.WM 	= "models/weapons/w_rif_l852.mdl"
SWEP.WMPos 	= Vector(0, -6, -1) --Vector(0, 0, -2)
SWEP.WMAng 	= Vector(0, 0, 180) --Vector(0, 6.565, 180)
-- I fucking give up. If it looks retarded in-game, that's because the world model is retarded to setup

if CLIENT then
	local old, x, y, ang
	local reticle = surface.GetTextureID("models/weapons/v_models/l85a2/susat_scopecross")

	local lens = surface.GetTextureID("cw2/gui/lense")
	local lensMat = Material("cw2/gui/lense")
	local cd, alpha = {}, 0.5
	local Ini = true
	
	local l85scopemat = Material( "models/weapons/v_models/l85a2/susatrt" )
	
	-- render target var setup
	cd.x = 0
	cd.y = 0
	cd.w = 512
	cd.h = 512
	cd.fov = 15
	cd.drawviewmodel = false
	cd.drawhud = false
	cd.dopostprocess = false

	function SWEP:RenderTargetFunc()
		local complexTelescopics = true --self:canUseComplexTelescopics()
		
		-- if we don't have complex telescopics enabled, don't do anything complex, and just set the texture of the lens to a fallback 'lens' texture
		if not complexTelescopics then
			self.TSGlass:SetTexture("$basetexture", lensMat:GetTexture("$basetexture"))
			return
		end
		
		if self:canSeeThroughTelescopics( "IronsightPos" ) then
			alpha = math.Approach(alpha, 0, FrameTime() * 5)
		else
			alpha = math.Approach(alpha, 1, FrameTime() * 5)
		end
		
		x, y = ScrW(), ScrH()
		old = render.GetRenderTarget()

		ang = self:getReticleAngles() --self:getTelescopeAngles()
		
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
		
		if l85scopemat then
			l85scopemat:SetTexture("$basetexture", self.ScopeRT)
		end
	end
end
--]]

--[[ OLD NOTES
-- Balanced with other meta CW 2.0 rifles: AK-74, AR-16, and G3A3. Should be good to add to Ground Control
-- The weapon is basically the firepower of a G3 and AK, the recoil of a G3 and AR, and the lethality of the G3 alone
-- basically a hybrid of all rifles listed above
-- It's mainly a mobility weapon, hence its lower accuracy (higher spread) on aim but lower spread while hipfiring and/or moving
-- funny because it has a built-in scope already for the model, so shouldn't the above statement be switched around? Nah, it keeps the weapon interesting - cheeki breeki
-- Comment in the Workshop page if any inconsistencies arise. Thanks, and have fun!
--]]

--[[
Perks of this weapon over the AK-74, AR-15, and G3A3:
Slow ramp up spread increase over full magazine emptying
Mobility accuracy not hugely affected
Medium fire rate and controllable recoil
SAKER suppressor and Grip attachments greatly decrease recoil without limiting handling by too much
2x SUSAT scope slightly reduces awareness and includes backup sights if needed
Quick spread recovery

Disadvantages:
Poor bullet chambering (26 damage per bullet) due to construction of rifle
Aim spread little higher than other rifles
Limited selection of attachments
Harsh muzzle flash when aiming in SUSAT scope
Reload times > 2 sec

Final Remarks:
The weapon is best used with the SAKER suppressor and Foregrip attachments, and Match grade rounds. While its damage is
comparable to that of an SMG and thus reduces the strength of it being a suitable military rifle,
its accuracy from hipfiring and moving along with low recoil makes up for it.

An alternative to restoring the rifle's suitable damage is using the Foregrip attachment and Magnum rounds,
slightly increasing the recoil but improving damage to 30. This way, you can also retain the added accuracy
boosts from the rifles bullpup rifle design.
--]]