SWEP.Base = "tfa_nmrimelee_base"
SWEP.Category = "TFA NMRIH"
SWEP.Spawnable = true
SWEP.AdminSpawnable = true

SWEP.PrintName = "Crowbar"

SWEP.ViewModel			= "models/weapons/tfa_nmrih/v_me_crowbar.mdl" --Viewmodel path
SWEP.ViewModelFOV = 50

SWEP.WorldModel			= "models/weapons/tfa_nmrih/w_me_crowbar.mdl" --Viewmodel path
SWEP.HoldType = "melee"
SWEP.DefaultHoldType = "melee"
SWEP.Offset = { --Procedural world model animation, defaulted for CS:S purposes.
        Pos = {
        Up = -6,
        Right = 1.5,
        Forward = 3.5,
        },
        Ang = {
        Up = -1,
        Right = 5,
        Forward = 178
        },
		Scale = 1.0
}
SWEP.Primary.Ammo = "Pistol"
SWEP.Primary.Sound = Sound("Weapon_Melee.CrowbarLight")
SWEP.Secondary.Sound = Sound("Weapon_Melee.CrowbarHeavy")

SWEP.MoveSpeed = 0.975
SWEP.IronSightsMoveSpeed  = SWEP.MoveSpeed

SWEP.InspectPos = Vector(-3.086, -6.5, 7.236)
SWEP.InspectAng = Vector(-8.443, 11.651, 12.725)

SWEP.Primary.Blunt = true
SWEP.Primary.Damage = 30
SWEP.Primary.Reach = 60
SWEP.Primary.RPM = 100
SWEP.Primary.SoundDelay = 0.15
SWEP.Primary.Delay = 0.3
SWEP.Primary.Window = 0.2

SWEP.Secondary.Blunt = true
SWEP.Secondary.RPM = 60 -- Delay = 60/RPM, this is only AFTER you release your heavy attack
SWEP.Secondary.Damage = 60
SWEP.Secondary.Reach = 60	
SWEP.Secondary.SoundDelay = 0.1
SWEP.Secondary.Delay = 0.3

SWEP.Secondary.BashDamage = 50
SWEP.Secondary.BashDelay = 0.35
SWEP.Secondary.BashLength = 50