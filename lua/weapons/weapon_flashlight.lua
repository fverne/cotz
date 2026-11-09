--Inspired by Zoey's flashlight.
--This SWEP started out as a small modification of Devilsson2010's FlashlightV2.
--Eventually, I completely rewrote the weapon, recreating the function of
--Zoey's now defunct Zombie Master flashlight.


AddCSLuaFile ()

if ( SERVER ) then
	SWEP.Weight = 5
	SWEP.AutoSwitchTo = false
	SWEP.AutoSwitchFrom = false
end
	
if ( CLIENT ) then
	SWEP.PrintName = "Handheld Flashlight"
	SWEP.Slot = 0
	SWEP.SlotPos = 7
	SWEP.DrawAmmo = false
	SWEP.DrawCrosshair = false
	SWEP.WeaponIcon = surface.GetTextureID("weapons/weapon_flashlight")
	killicon.Add( "weapon_flashlight", "weapons/weapon_flashlight_kill", Color( 255, 80, 0, 255 ) ) 
	function SWEP:DrawWeaponSelection(x, y, wide, tall, alpha)
		surface.SetDrawColor( 355, 340, 0, 255 )
		surface.SetTexture( self.WeaponIcon )
		surface.DrawTexturedRect( x + wide * 0.15, y, wide / 1.5, tall )
	end
end

SWEP.Author = "Paynamia"
SWEP.Contact = ""
SWEP.Purpose = ""
SWEP.Instructions = "Primary fire attacks. Secondary fire toggles the light."

SWEP.Spawnable = true
SWEP.AdminSpawnable = true
SWEP.UseHands = true
SWEP.HoldType 				= "pistol"
SWEP.NormalHoldType 		= "pistol"

SWEP.ViewModel = "models/weapons/c_flashlight_zm.mdl"
SWEP.WorldModel = "models/weapons/w_flashlight_zm.mdl"

SWEP.Category = "STALKER Misc"
SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Damage = 10
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "Pistol"

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false 
SWEP.Secondary.Ammo = "none"

local SWITCH_SOUND = Sound("HL2Player.FlashLightOn")
local SWITCH_DELAY = 0.23
local DRAW_DELAY = 0.835

function SWEP:Reload()
end

function SWEP:Holster()
	if SERVER then
		self:SetNWBool("cotz/flashlight/active", false)
	end

	return true
end

function SWEP:OnDrop()
	if SERVER then
		self:SetNWBool("cotz/flashlight/active", false)
	end
end

function SWEP:PrimaryAttack()
end

function SWEP:SecondaryAttack()
	self:SetNextSecondaryFire(CurTime() + SWITCH_DELAY)

	if not SERVER then return end

	local owner = self:GetOwner()
	if not IsValid(owner) or not owner:Alive() or owner:GetActiveWeapon() ~= self then return end

	self:SetNWBool("cotz/flashlight/active", not self:GetNWBool("cotz/flashlight/active", false))
	owner:EmitSound(SWITCH_SOUND)

	local viewModel = owner:GetViewModel()
	if not IsValid(viewModel) then return end

	viewModel:ResetSequence(viewModel:LookupSequence("trigger"))
	timer.Simple(viewModel:SequenceDuration(), function()
		if not IsValid(self) or not IsValid(owner) then return end
		if self:GetOwner() ~= owner or owner:GetActiveWeapon() ~= self then return end

		local currentViewModel = owner:GetViewModel()
		if IsValid(currentViewModel) then
			currentViewModel:ResetSequence(currentViewModel:LookupSequence("idle01"))
		end
	end)
end

function SWEP:Initialize()
	self:SetHoldType("slam")
end

function SWEP:Deploy()
	self:SetNextSecondaryFire(CurTime() + DRAW_DELAY)
	self:SetNextPrimaryFire(CurTime() + DRAW_DELAY)

	if SERVER then
		self:SetNWBool("cotz/flashlight/active", false)
	end

	local owner = self:GetOwner()
	local viewModel = IsValid(owner) and owner:GetViewModel()
	if IsValid(viewModel) then
		viewModel:ResetSequence(viewModel:LookupSequence("draw"))
	end

	return true
end
