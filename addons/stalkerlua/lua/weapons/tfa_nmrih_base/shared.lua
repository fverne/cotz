DEFINE_BASECLASS("tfa_bash_base")

SWEP.Slot = 2
SWEP.SlotPos = 73

SWEP.LuaShellEject = true

SWEP.ForceDryFireOff = false --Disables dryfire.  Set to false to enable them.
SWEP.DisableIdleAnimations = true --Disables idle animations.  Set to false to enable them.
SWEP.ForceEmptyFireOff = false --Disables empty fire animations.  Set to false to enable them.

SWEP.Secondary.BashSound = Sound("Weapon_Crowbar.Shove")
SWEP.Secondary.BashDelay = 0.05
SWEP.ViewModelFOV = 50
SWEP.UseHands = true
SWEP.ViewModelBoneMods = {
	["ValveBiped.Bip01_R_Finger1"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0.254, 0.09), angle = Angle(15.968, -11.193, 1.437) },
	["ValveBiped.Bip01_R_Finger0"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(3.552, 4.526, 0) },
	["Thumb04"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(6, 0, 0) }
}

SWEP.KF2StyleShotgun = false --Allow empty reloads for shotguns?

SWEP.Offset = { --Procedural world model animation, defaulted for CS:S purposes.
        Pos = {
        Up = -3,
        Right = 1,
        Forward = 3.5,
        },
        Ang = {
        Up = -1,
        Right = -2,
        Forward = 178
        },
		Scale = 1.1
}

SWEP.MoveSpeed = 0.9
SWEP.IronSightsMoveSpeed  = SWEP.MoveSpeed * 0.8
