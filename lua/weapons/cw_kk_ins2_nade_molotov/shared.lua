if not CustomizableWeaponry then return end

AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
AddCSLuaFile("sh_soundscript.lua")
include("sh_sounds.lua")
include("sh_soundscript.lua")

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "Molotov"
	SWEP.CSMuzzleFlashes = true
	SWEP.DrawAmmo = false

	SWEP.SelectIcon = surface.GetTextureID("vgui/inventory/weapon_molotov")

	SWEP.AttachmentModelsVM = {
		["fx_light"] = {model = "models/maxofs2d/cube_tool.mdl", pos = Vector(), angle = Angle(), size = Vector(0.01, 0.01, 0.01), attachment = "lighter", active = true, nodraw = true},
		["fx_rag"] = {model = "models/maxofs2d/cube_tool.mdl", pos = Vector(-0.67614, 0.05519, -0.63427), angle = Angle(), size = Vector(0.01, 0.01, 0.01), attachment = "rag", active = true, nodraw = true},
	}

	SWEP.AttachmentModelsWM = {}

	SWEP.MoveType = 2
	SWEP.ViewModelMovementScale = 0.8
	SWEP.DisableSprintViewSimulation = true

end

SWEP.Attachments = CustomizableWeaponry_KK.ins2.slowGrenadeMenu

SWEP.CanRestOnObjects = false
SWEP.projectileClass = "cw_kk_ins2_projectile_molotov"

SWEP.Animations = {
	pullpin = "pullback_high",
	throw = "throw",

	pull_short = "pullback_low",
	throw_short = "lowthrow",

	base_pickup = "base_draw",
	base_draw = "base_draw",
	base_idle = "base_idle",
	base_holster = "base_holster",
	base_sprint = "base_sprint",
	base_safe = "base_down",
	base_crawl = "base_crawl",
}

SWEP.SpeedDec = 5

SWEP.Slot = 4
SWEP.SlotPos = 0
SWEP.NormalHoldType = "grenade"
SWEP.RunHoldType = "normal"
SWEP.FireModes = {"semi"}
SWEP.Base = "cw_kk_ins2_base_nade"
SWEP.Category = "Ethereal Thrown"

SWEP.Author			= "Lt. Taylor"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModelFOV	= 70
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/weapons/v_molotov.mdl"
SWEP.WorldModel		= "models/weapons/w_molotov.mdl"

SWEP.WMPos = Vector(3.891, 2.295, -1.765)
SWEP.WMAng = Angle(-28.962, 155.365, 180)

SWEP.Spawnable			= CustomizableWeaponry_KK.ins2.isContentMounted4(SWEP)
SWEP.AdminSpawnable		= CustomizableWeaponry_KK.ins2.isContentMounted4(SWEP)

SWEP.Primary.Ammo			= "Incendiary"

SWEP.fuseTime = 0
SWEP.timeToThrow = 1.5
SWEP.maxVelDelay = 2

SWEP.timeToThrowShort = 1.5
SWEP.swapTimeShort = 0.8
SWEP.maxVelDelayShort = 2

SWEP.canCook = false // this one detonates on impact

SWEP.projectileTrailParticles = "molotov_trail"

if CLIENT then
	local m
	local muz = {}

	function SWEP:getMuzzlePosition()
		if self.Owner:ShouldDrawLocalPlayer() then
			m = self.Owner:GetBoneMatrix(self.Owner:LookupBone("ValveBiped.Bip01_R_Hand"))
			muz.Pos = m:GetTranslation()
			muz.Ang = m:GetAngles()
			return muz
		end

		m = self.CW_VM:GetAttachment(2)

		if self.CustomizeMenuAlpha > 0 then
			offset = self.HUD_3D2DOffsetMenu
		else
			offset = self.HUD_3D2DOffset
		end

		pos = m.Pos
		ang = EyeAngles()

		pos = pos + ang:Right() * offset.x
		pos = pos + ang:Up() * offset.y
		pos = pos + ang:Forward() * offset.z

		muz.Pos = pos
		muz.Ang = m.Ang
		return muz
	end
end
