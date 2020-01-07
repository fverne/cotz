if( SERVER ) then
	AddCSLuaFile( "shared.lua" );
end

if( CLIENT ) then
	SWEP.PrintName = "Bloodsucker Cloak";
	SWEP.Slot = 3;
	SWEP.SlotPos = 0;
	SWEP.DrawAmmo = false;
	SWEP.DrawCrosshair = false;
end

SWEP.Author			= "verne"
SWEP.Instructions	= ""
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Category		= "STALKER Weapons";
SWEP.HoldType 		= "normal"
SWEP.NormalHoldType = "normal"


SWEP.ViewModelFOV	= 60
SWEP.ViewModelFlip	= false

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.ViewModel    = "models/weapons/v_hands.mdl"
SWEP.WorldModel   = ""

resource.AddFile( "hgn/stalker/creature/bs/sucker_growl_1.wav" )

-------------Primary Fire Attributes----------------------------------------
function SWEP:PrimaryAttack()

	self.Weapon:SetNextSecondaryFire( CurTime() + 1 )	

	local TauntSound = Sound( "hgn/stalker/creature/bs/sucker_growl_1.wav" )

	self.Weapon:EmitSound( TauntSound )

	// The rest is only done on the server
	if (!SERVER) then return end

	self.Weapon:EmitSound( TauntSound )
end

-------------Secondary Fire Attributes-------------------------------------
SWEP.Secondary.Delay		= 0.5
SWEP.Secondary.Recoil		= 0
SWEP.Secondary.Damage		= 0
SWEP.Secondary.NumShots		= 1
SWEP.Secondary.Cone			= 0
SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic   	= false
SWEP.Secondary.Ammo         = "Pistol"

function SWEP:SecondaryAttack() // conceal yourself

if ( !self.conceal ) then
	self.Owner:SetMaterial("models/effects/vol_light001")
	self.Weapon:SetMaterial("models/effects/vol_light001")
	self.Owner:PrintMessage( HUD_PRINTCENTER, "Cloak On" )
	self.conceal = true
else
	self.Owner:SetMaterial("models/glass")
	self.Weapon:SetMaterial("models/glass")
	self.Owner:PrintMessage( HUD_PRINTCENTER, "Cloak Off" )
	self.conceal = false
end

end


function SWEP:OnRemove() --Disables cloak if the swep is removed
	if self.conceal then
		self.Owner:SetMaterial("models/glass")
		self.Weapon:SetMaterial("models/glass")
		self.Owner:PrintMessage( HUD_PRINTCENTER, "Cloak Off" )
		self.conceal = false
	end
end

function SWEP:OnDrop() --Disables cloak if the player drops the weapon
	if self.conceal then
		self.Owner:SetMaterial("models/glass")
		self.Weapon:SetMaterial("models/glass")
		self.Owner:PrintMessage( HUD_PRINTCENTER, "Cloak Off" )
		self.conceal = false
	end
end