SWEP.Base = "tfa_nmrimelee_base"
SWEP.Category = "TFA NMRIH - CotZ"
SWEP.Spawnable = true
SWEP.AdminSpawnable = true

SWEP.PrintName = "Survival Knife"

SWEP.ViewModel			= "models/weapons/tfa_nmrih/me_survivalknife/v_me_survivalknife.mdl" --Viewmodel path
SWEP.ViewModelFOV = 50

SWEP.Slot = 1

SWEP.WorldModel			= "models/bf4_sweps/w_knife_dive.mdl" --Viewmodel path
SWEP.HoldType = "knife"
SWEP.DefaultHoldType = "knife"
SWEP.Offset = { --Procedural world model animation, defaulted for CS:S purposes.
        Pos = {
        Up = -1,
        Right = 1,
        Forward = 35,
        },
        Ang = {
        Up = -90,
        Right = 180,
        Forward = 90
        },
		Scale = 1.3
}

SWEP.Primary.Sound = Sound("Weapon_KitKnife.SwingLight")
SWEP.Secondary.Sound = Sound("Weapon_KitKnife.SwingHeavy")

SWEP.MoveSpeed = 1.0
SWEP.IronSightsMoveSpeed  = SWEP.MoveSpeed

SWEP.InspectPos = Vector(9.649, -18.091, 0.6)
SWEP.InspectAng = Vector(26.03, 61.206, 28.141)

SWEP.Primary.Reach = 40
SWEP.Primary.RPM = 85
SWEP.Primary.SoundDelay = 0.1
SWEP.Primary.Delay = 0.25
SWEP.Primary.Damage = 60

SWEP.Secondary.RPM = 60 -- Delay = 60/RPM, this is only AFTER you release your heavy attack
SWEP.Secondary.Damage = 90
SWEP.Secondary.Reach = 40
SWEP.Secondary.SoundDelay = 0.05
SWEP.Secondary.Delay = 0.25

SWEP.Secondary.BashDamage = 20
SWEP.Secondary.BashDelay = 0.1
SWEP.Secondary.BashLength = 54
SWEP.Secondary.BashDamageType = DMG_GENERIC
SWEP.Secondary.BashHitSound = ""