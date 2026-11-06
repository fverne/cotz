SWEP.PrintName = "Camera"
SWEP.Author = "COTZ"
SWEP.Category = "COTZ"
SWEP.Instructions = "Left-click to take a picture."
SWEP.Spawnable = true
SWEP.AdminOnly = true
SWEP.Slot = 5
SWEP.SlotPos = 1
SWEP.DrawAmmo = false
SWEP.DrawCrosshair = false
SWEP.UseHands = true
SWEP.ViewModel = "models/weapons/infra/c_camera.mdl"
SWEP.WorldModel = "models/weapons/infra/w_camera.mdl"
SWEP.ViewModelFOV = 45
SWEP.BobScale = 0
SWEP.SwayScale = 0
SWEP.HoldType = "pistol"
-- Preserve the original camera pose when Helix lowers weapons, including its alternate lowering mode.
-- SWEP.LowerAngles = angle_zero
-- SWEP.LowerAngles2 = angle_zero
SWEP.FireWhenLowered = true
SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "none"
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "none"

function SWEP:Initialize()
	self:SetHoldType(self.HoldType)
end

function SWEP:Deploy()
	self:SendWeaponAnim(ACT_VM_DRAW)
	if SERVER then self:EmitSound("items/deploy.wav", 60, 100, 0.33) end

	return true
end

function SWEP:Holster()
	if SERVER then self:EmitSound("items/holster.wav", 60, 100, 0.33) end

	return true
end

function SWEP:PrimaryAttack()
	local plugin = ix.plugin.Get("camera")
	if not plugin then return end
	self:SetNextPrimaryFire(CurTime() + plugin.photoCooldown)
	if CLIENT then return end

	plugin:TakePhoto(self:GetOwner(), self)
end

function SWEP:SecondaryAttack()
end

function SWEP:Reload()
end

function SWEP:FireAnimationEvent()
	-- INFRA model events reference its global sounds and muzzle flash; feedback is owned here.
	return true
end

function SWEP:TranslateFOV(fov)
	return fov
end

if CLIENT then
	function SWEP:PostDrawViewModel(viewModel)
		if self:GetOwner() ~= LocalPlayer() then return end
		local plugin = ix.plugin.Get("camera")
		if not plugin then return end

		plugin:DrawCameraScreen(viewModel, self.ViewModelFOV)
	end
end
