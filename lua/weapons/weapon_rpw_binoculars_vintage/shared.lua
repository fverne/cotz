SWEP.ANIMPOSTDELAY			= 0.1

if (SERVER) then
	AddCSLuaFile( "shared.lua" )
	SWEP.Weight				= 5
	SWEP.AutoSwitchTo		= true
	SWEP.AutoSwitchFrom		= true
end

SWEP.Category 				= "RP Weapons" 

SWEP.Base					= "weapon_rpw_binoculars"

SWEP.Spawnable     			= true
SWEP.AdminSpawnable  		= true

SWEP.UseHands				= true
SWEP.ViewModel				= "models/weapons/c_binoculars_ger.mdl"
SWEP.WorldModel				= "models/weapons/w_binoculars_ger.mdl"

SWEP.HoldType				= "slam"
SWEP.HoldTypeRaised			= "camera"

SWEP.Primary.ClipSize		= -1
SWEP.Primary.DefaultClip	= -1
SWEP.Primary.Ammo 			= "none"
SWEP.Primary.Automatic		= false

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Ammo 		= false
SWEP.Secondary.Automatic 	= true

SWEP.Zoom_Interval			= 2.5
SWEP.Zoom_Current			= 0
SWEP.Zoom_Min				= 2.5
SWEP.Zoom_Max				= 5
SWEP.Zoom_Delta				= 0.1
SWEP.Zoom_Zooming			= false
SWEP.Zoom_InZoom			= false

SWEP.Zoom_TransitionTime	= nil

SWEP.Zoom_Sound_In				= "weapons/sniper/sniper_zoomin.wav"
SWEP.Zoom_Sound_Out				= "weapons/sniper/sniper_zoomout.wav"
SWEP.Zoom_Sound_Cloth			= "foley/alyx_hug_eli.wav"

SWEP.HasNightVision			= false

SWEP.WalkSpeed				= 250
SWEP.RunSpeed				= 500

SWEP.WalkSpeedMod			= 250

SWEP.SpeedMult				= 0.6

SWEP.UUID					= nil