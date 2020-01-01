SWEP.Base = "tfa_nmrimelee_base"
SWEP.Category = "TFA NMRIH"
SWEP.Spawnable = true
SWEP.AdminSpawnable = true

SWEP.PrintName = "Lead Pipe"

SWEP.ViewModel			= "models/weapons/tfa_nmrih/v_me_pipe_lead.mdl" --Viewmodel path
SWEP.ViewModelFOV = 50

SWEP.WorldModel			= "models/weapons/tfa_nmrih/w_me_pipe_lead.mdl" --Viewmodel path
SWEP.HoldType = "melee"
SWEP.DefaultHoldType = "melee"
SWEP.Offset = { --Procedural world model animation, defaulted for CS:S purposes.
        Pos = {
        Up = -5,
        Right = 2,
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
SWEP.Primary.Sound = ""--Sound("Weapon_Melee.PipeLeadLight")
SWEP.Secondary.Sound = ""--Sound("Weapon_Melee.PipeLeadHeavy")

SWEP.MoveSpeed = 0.97
SWEP.IronSightsMoveSpeed  = SWEP.MoveSpeed

SWEP.InspectPos = Vector(-3.418, -6.433, 8.241)
SWEP.InspectAng = Vector(-9.146, 9.145, 17.709)

SWEP.Primary.Blunt = true
SWEP.Primary.Damage = 20
SWEP.Primary.Reach = 60
SWEP.Primary.RPM = 90
SWEP.Primary.SoundDelay = 0
SWEP.Primary.Delay = 0.3
SWEP.Primary.Window = 0.2

SWEP.Secondary.Blunt = true
SWEP.Secondary.RPM = 60 -- Delay = 60/RPM, this is only AFTER you release your heavy attack
SWEP.Secondary.Damage = 40
SWEP.Secondary.Reach = 60	
SWEP.Secondary.SoundDelay = 0.1
SWEP.Secondary.Delay = 0.3

SWEP.Secondary.BashDamage = 50
SWEP.Secondary.BashDelay = 0.35
SWEP.Secondary.BashLength = 50

SWEP.ViewModelBoneMods = {
	["ValveBiped.Bip01_R_Finger1"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0.254, 0.09), angle = Angle(15.968, -11.193, 1.437) },
	["ValveBiped.Bip01_R_Finger0"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(3.552, 4.526, 0) },
	["Thumb04"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(6, 0, 0) },
	["Maglite"] = { scale = Vector(0.009, 0.009, 0.009), pos = Vector(0, 0, -30), angle = Angle(0, 0, 0) }
}