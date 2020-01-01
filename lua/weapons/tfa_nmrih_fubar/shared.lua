SWEP.Base = "tfa_nmrimelee_base"
SWEP.Category = "TFA NMRIH"
SWEP.Spawnable = true
SWEP.AdminSpawnable = true

SWEP.PrintName = "Fubar"

SWEP.ViewModel			= "models/weapons/tfa_nmrih/v_me_fubar.mdl" --Viewmodel path
SWEP.ViewModelFOV = 50

SWEP.WorldModel			= "models/weapons/tfa_nmrih/w_me_fubar.mdl" --Viewmodel path
SWEP.HoldType = "melee2"
SWEP.DefaultHoldType = "melee2"
SWEP.Offset = { --Procedural world model animation, defaulted for CS:S purposes.
        Pos = {
        Up = -2,
        Right = 0.5,
        Forward = 0.5,
        },
        Ang = {
        Up = -1,
        Right = 5,
        Forward = 178
        },
		Scale = 1.0
}
SWEP.Primary.Ammo = "Pistol"
SWEP.MoveSpeed = 0.9
SWEP.IronSightsMoveSpeed  = SWEP.MoveSpeed

SWEP.InspectPos = Vector(5.3, 1.7, -3.131)
SWEP.InspectAng = Vector(17.086, 3.938, 14.836)

SWEP.Primary.Blunt = true
SWEP.Primary.Damage = 60
SWEP.Primary.Reach = 90
SWEP.Primary.RPM = 40
SWEP.Primary.SoundDelay = 0.3
SWEP.Primary.Delay = 0.5
SWEP.Primary.Window = 0.3

SWEP.Secondary.Blunt = true
SWEP.Secondary.RPM = 40 -- Delay = 60/RPM, this is only AFTER you release your heavy attack
SWEP.Secondary.Damage = 90
SWEP.Secondary.Reach = 100
SWEP.Secondary.SoundDelay = 0.1
SWEP.Secondary.Delay = 0.4

SWEP.Secondary.BashDamage = 50
SWEP.Secondary.BashDelay = 0.4
SWEP.Secondary.BashLength = 70