if not CustomizableWeaponry then return end

AddCSLuaFile()
AddCSLuaFile("sh_soundscript.lua")
include("sh_soundscript.lua")

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "HL2 HE Grenade"
	SWEP.CSMuzzleFlashes = true
	SWEP.DrawAmmo = false

	SWEP.SelectFont = "CW_SelectIcons2"
	SWEP.IconLetter = "k"

	SWEP.AttachmentModelsVM = {}
	SWEP.AttachmentModelsWM = {}

	SWEP.ViewModelMovementScale = 0.8
	SWEP.DisableSprintViewSimulation = true
end

SWEP.Attachments = CustomizableWeaponry_KK.ins2.slowGrenadeMenu

SWEP.CanRestOnObjects = false
SWEP.projectileClass = "npc_grenade_frag"

SWEP.Animations = {
	pullpin = "pullbackhigh",
	throw = "throw",

	pull_cook = "pullbackhighbake",
	throw_cook = "bakethrow",

	pull_short = "pullbacklow",
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
SWEP.Category = "CW 2.0 KK INS2"

SWEP.Author			= "Spy"
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModelFOV	= 70
SWEP.ViewModelFlip	= false
-- SWEP.ViewModel		= "models/weapons/v_m18.mdl"
SWEP.ViewModel		= "models/weapons/v_cw_kk_ins2_m18.mdl"
SWEP.WorldModel		= "models/weapons/w_m18.mdl"

SWEP.WMPos = Vector(3.891, 2.295, -1.765)
SWEP.WMAng = Angle(-28.962, 155.365, 180)

SWEP.Spawnable			= CustomizableWeaponry_KK.ins2.isContentMounted4(SWEP)
SWEP.AdminSpawnable		= CustomizableWeaponry_KK.ins2.isContentMounted4(SWEP)
SWEP.AdminOnly			= true

SWEP.Primary.Ammo			= "Frag Grenades"

SWEP.fuseTime = 4

SWEP.timeToThrow = 0.9

SWEP.timeToThrowCook = 1.3

SWEP.timeToThrowShort = 0.9

SWEP.projectileTrailParticles = "npc_grenade_frag"
PrecacheParticleSystem(SWEP.projectileTrailParticles)

if CLIENT then
	CustomizableWeaponry_KK.ins2.welementThink:add("cw_kk_ins2_nade_hl2", "grenade")
	-- CustomizableWeaponry_KK.ins2.welementThink:add("cw_kk_ins2_nade_hl2", "grenadewtrail")
end

local v = Vector(0, 0, 150)

function SWEP:applyThrowVelocity(grenade)
	local forward, up = self:getThrowVelocityMods()

	CustomizableWeaponry.quickGrenade:applyThrowVelocity(self.Owner, grenade, 800 * forward, v * up)
end

function SWEP:fuseProjectile(grenade)
	grenade._kkFixAttacker = self.lastOwner

	local time

	if self.cookTime then
		time = math.Clamp((self.cookTime + self.fuseTime) - CurTime(), 0, self.fuseTime)
	else
		time = self.fuseTime
	end

	grenade:Fire("sETtIMER", time)
end
