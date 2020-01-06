if not CustomizableWeaponry then return end
if not CustomizableWeaponry_KK.HOME then return end

AddCSLuaFile()
AddCSLuaFile("sh_soundscript.lua")
include("sh_soundscript.lua")

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "Flare"

	SWEP.SelectIcon = surface.GetTextureID("vgui/inventory/cw_kk_ins2_nade_kk")

	SWEP.AttachmentModelsVM = {
		["fuze"] = {model = "models/weapons/v_cw_kk_ins2_m213.mdl", pos = Vector(), angle = Angle(), size = Vector(1, 1, 1), merge = true, hideVM = true, active = true},
		["nade"] = {model = "models/props_junk/flare.mdl", pos = Vector(0, 0, -0.4017), angle = Angle(0, -5.9132, 0), size = Vector(0.5, 0.5, 0.5), bone = "Weapon_M84", active = true},
	}

	SWEP.AttachmentModelsWM = {
		["flare_fuze"] = {model = "models/weapons/v_cw_kk_ins2_m213.mdl", pos = Vector(-23.0194, -3.093, -8.5511), angle = Angle(-0.0477, 5.0981, -102.3934), size = Vector(2, 2, 2), attachment = "fuse", active = true},
	}

	SWEP.MoveType = 2
	SWEP.ViewModelMovementScale = 0.8
	SWEP.DisableSprintViewSimulation = true
end

SWEP.Attachments = CustomizableWeaponry_KK.ins2.slowGrenadeMenu

SWEP.CanRestOnObjects = false
SWEP.projectileClass = "kk_flare"

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
SWEP.ViewModel		= "models/weapons/v_m84.mdl"
SWEP.WorldModel		= "models/props_junk/flare.mdl"

SWEP.WMPos = Vector(2.391, 1.295, 1)
SWEP.WMAng = Angle(-28.962, 155.365, 180)

SWEP.Spawnable			= CustomizableWeaponry_KK.ins2.isContentMounted4(SWEP)
SWEP.AdminSpawnable		= CustomizableWeaponry_KK.ins2.isContentMounted4(SWEP)
SWEP.AdminOnly		= true

SWEP.Primary.Ammo			= "M213 Flare"

SWEP.canCook = false

SWEP.HolsterTime = 0.6

SWEP.fuseTime = 0

SWEP.timeToThrow = 0.9

SWEP.timeToThrowCook = 1.3

SWEP.timeToThrowShort = 0.9

if CLIENT then
	CustomizableWeaponry_KK.ins2.welementThink:add("flare_fuze", function(wep, welement)
		welement:SetBodygroup(1, wep.dt.PinPulled and 1 or 0)
	end)
end
