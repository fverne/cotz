SWEP.PrintName		= "Unarmed"
SWEP.Spawnable		= false
SWEP.AdminSpawnable	= false
SWEP.HoldType		= "camera"

SWEP.ViewModel		= "models/weapons/v_hands.mdl"
SWEP.WorldModel		= "models/props_lab/box01a.mdl"
SWEP.ViewModelFOV	= 50
SWEP.UseHands		= true

SWEP.Weight		= 5
SWEP.AutoSwitchTo	= true
SWEP.AutoSwitchFrom	= false

SWEP.Primary.ClipSize		= -1
SWEP.Primary.DefaultClip	= -1
SWEP.Primary.Ammo		= "none"

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Ammo		= "none"

if SERVER then
	SWEP.LastOwner 			= nil
end





function SWEP:Initialize( Owner )
	self:SetHoldType( self.HoldType )
end



function SWEP:Equip( Owner )
	if !IsValid(Owner) or CLIENT then return end

	self.LastOwner = Owner
end



function SWEP:PrimaryAttack()
	return false
end
	

	
function SWEP:SecondaryAttack()
	return false
end


function SWEP:Deploy()
	if SERVER then
		self.LastOwner = self.Owner
		self.Owner:DrawViewModel( false, 0)
		self.Owner:CrosshairDisable()
	end
end



function SWEP:Holster()
	if SERVER then
		self.LastOwner:DrawViewModel( true, 0)
		self.Owner:CrosshairEnable()
	end
	return true
end



function SWEP:OnRemove()
	if SERVER then
		self.LastOwner:CrosshairEnable()
		self.LastOwner:DrawViewModel( true, 0)
	end
	return true
end



function SWEP:DrawWorldModel()
	return false
end