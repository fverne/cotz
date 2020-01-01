SWEP.Base = "tfa_nmrimelee_base"
SWEP.Category = "TFA NMRIH"
SWEP.Spawnable = true
SWEP.AdminSpawnable = true

SWEP.PrintName = "Baseball Bat"

SWEP.ViewModel			= "models/weapons/tfa_nmrih/v_me_bat_metal.mdl" --Viewmodel path
SWEP.ViewModelFOV = 50

SWEP.WorldModel			= "models/weapons/tfa_nmrih/w_me_bat_metal.mdl" --Viewmodel path
SWEP.HoldType = "melee2"
SWEP.DefaultHoldType = "melee2"
SWEP.Offset = { --Procedural world model animation, defaulted for CS:S purposes.
        Pos = {
        Up = -4.7,
        Right = 1,
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
SWEP.Primary.Sound = ""--Sound("Weapon_Melee.HatchetLight")
SWEP.Secondary.Sound = ""--Sound("Weapon_Melee.FireaxeHeavy")

SWEP.MoveSpeed = 0.9
SWEP.IronSightsMoveSpeed  = SWEP.MoveSpeed

SWEP.InspectPos = Vector(4.84, 1.424, -3.131)
SWEP.InspectAng = Vector(17.086, 3.938, 14.836)

SWEP.Primary.RPM = 50
SWEP.Primary.Damage = 25
SWEP.Secondary.BashDelay = 0.3
SWEP.ViewModelBoneMods = {
	["ValveBiped.Bip01_R_Finger1"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0.254, 0.09), angle = Angle(15.968, -11.193, 1.437) },
	["ValveBiped.Bip01_R_Finger0"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(3.552, 4.526, 0) },
	["Thumb04"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(6, 0, 0) },
	["Middle04"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(-8.212, 1.121, 1.263) },
	["Pinky05"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(11.793, 4.677, 11.218) }
}

SWEP.Primary.Blunt = true
SWEP.Secondary.Blunt = true