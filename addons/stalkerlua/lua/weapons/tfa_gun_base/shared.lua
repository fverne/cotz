ACT_VM_FIDGET_EMPTY = ACT_VM_FIDGET_EMPTY or ACT_CROSSBOW_FIDGET_UNLOADED

--[[BaseClass]]--
--[[Define Modules]]--
SWEP.SV_MODULES = {
	
}
SWEP.SH_MODULES = {
	"sh_bobcode.lua",
	"sh_anims.lua",
	"sh_bullet.lua",
	"sh_autodetection.lua",
	"sh_utilities.lua",
	"sh_effects.lua",
	"sh_attachments.lua"
}
SWEP.ClSIDE_MODULES = {
	"cl_viewbob.lua",
	"cl_effects.lua",
	"cl_hud.lua",
	"cl_mods.lua",
	"cl_rendertarget.lua"
}

SWEP.CSMuzzleFlashes			= false
SWEP.CSMuzzleX = false

SWEP.Category				= "" --The category.  Please, just choose something generic or something I've already done if you plan on only doing like one swep.
SWEP.Gun					= "tfa_gun_base" --Make sure this is unique.  
SWEP.Manufacturer = nil --Gun Manufactrer (e.g. Hoeckler and Koch )
SWEP.Author				= "TheForgottenArchitect" --DO NOT CHANGE, CUZ ITS ME.
SWEP.Contact				= "theforgottenarchitect" --Contact me on steam.  Leave a comment first.
SWEP.Purpose				= "" --Why do you want this?   Not really necesary.
SWEP.Instructions				= "" --Instructions on how to use, lol.  Not really necessary.
SWEP.MuzzleAttachment			= "1" 		-- Should be "1" for CSS models or "muzzle" for hl2 models
--SWEP.MuzzleAttachmentRaw = 1 --This will override whatever string you gave.  This is the raw attachment number.  This is overridden or created when a gun makes a muzzle event.
SWEP.ShellAttachment			= "2" 		-- Should be "2" for CSS models or "shell" for hl2 models
SWEP.DrawCrosshair			= true		-- Draw the crosshair?
SWEP.DrawCrosshairIS = false --Draw crosshair in ironsights
SWEP.ViewModelFOV			= 65		-- This controls how big the viewmodel looks.  Less is more.
SWEP.ViewModelFlip			= false		-- Set this to true for CSS models, or false for everything else (with a righthanded viewmodel.)  Note that this breaks c_arms if you set it to true.
SWEP.UseHands = false --Use c_hands a.k.a playermodel hands?  Disable for CS:S or HL2 direct ports, or anything containing v_arms.
SWEP.VMPos = Vector(0,0,0) --The viewmodel positional offset, constantly. 
SWEP.VMAng = Vector(0,0,0) --The viewmodel angular offset, constantly. 
SWEP.AllowViewAttachment = true --Allow the view to sway based on weapon attachment while reloading or drawing, IF THE CLIENT HAS IT ENABLED IN THEIR CONVARS!!!!11111oneoneELEVEN
SWEP.InspectPosDef = Vector(9.779, -11.658, -2.241)
SWEP.InspectAngDef = Vector(24.622, 42.915, 15.477)
--SWEP.InspectPos = Vector(0,0,0) --replace with a vector, in style of ironsights position, to be used for inspection
--SWEP.InspectAng= Vector(0,0,0) --replace with a vector, in style of ironsights angle, to be used for inspection
SWEP.FidgetLoop = true --Setting false will cancel inspection once the animation is done.  CS:GO style.
SWEP.Spawnable				= false --Can you, as a normal user, spawn this?
SWEP.AdminSpawnable			= false --Can an adminstrator spawn this?  Does not tie into your admin mod necessarily, unless its coded to allow for GMod's default ranks somewhere in its code.  Evolve and ULX should work, but try to use weapon restriction rather than these.
SWEP.HoldType 				= "smg"		-- This is how others view you carrying the weapon.

SWEP.Primary.Sound 			= Sound("")				-- This is the sound of the gun/bow, when you shoot.
SWEP.Primary.Round 			= ("")					-- What kind of bullet does it shoot?
SWEP.Primary.Cone			= 0.2					-- This is the accuracy of NPCs.  Not necessary in almost all cases, since I don't even think this base is compatible with NPCs.
SWEP.Primary.Recoil		= 1						-- This is the recoil multiplier.  Really, you should keep this at 1 and change the KickUp, KickDown, and KickHorizontal variables.  However, you can change this as a multiplier too.
SWEP.Primary.Damage		= 0.01					-- Damage, in standard damage points.
SWEP.DamageType = nil--See DMG enum.  This might be DMG_SHOCK, DMG_BURN, etc.
SWEP.Primary.Spread		= .01					--This is hip-fire acuracy.  Less is more (1 is horribly awful, .0001 is close to perfect)
SWEP.FiresUnderwater = false
 
--Attachments
 
SWEP.Attachments = {
}

--AnchorSystem

SWEP.VMAnchors = {
}

--[[

EXAMPLE 1:

SWEP.VMAnchors = {
	[1] = { bone = "muzzle",pos = Vector(0,0,0),ang = Vector(0,0,0) },
	[2] = { bone = "shell",pos = Vector(0,0,0),ang = Vector(0,0,0) }
}

EXAMPLE 2:

SWEP.VMAnchors = {
	["muzzle"] = { bone = "muzzle",pos = Vector(0,0,0),ang = Vector(0,0,0) },
	["shell"] = { bone = "shell",pos = Vector(0,0,0),ang = Vector(0,0,0) }
}
]]--

 
--TTT WILL be broken, but this prevents lua errors if you try to spawn these guns.

local gm = engine.ActiveGamemode()
if string.find(gm,"ttt") or string.find(gm,"terrorist") then
	SWEP.Kind = WEAPON_HEAVY
	SWEP.AutoSpawnable = false
	SWEP.AllowDrop = true
	SWEP.AmmoEnt = "item_ammo_smg1_ttt"
	SWEP.Base = "weapon_tttbase"
	DEFINE_BASECLASS("weapon_tttbase")
else
	SWEP.Base = "weapon_base"
	DEFINE_BASECLASS("weapon_base")
end

--[[

Unless you can do this manually, autodetect it.  If you decide to manually do these, uncomment this block and rmeove this line.

SWEP.Primary.SpreadMultiplierMax = 2.5 --How far the spread can expand when you shoot.
SWEP.Primary.SpreadIncrement = 1/3.5 --What percentage of the modifier is added on, per shot.
SWEP.Primary.SpreadRecovery = 3 --How much the spread recovers, per second.

]]--
SWEP.Primary.PenetrationMultiplier = 1
SWEP.Primary.NumShots	= 1 --The number of shots the gun/bow fires.  
SWEP.Primary.RPM				= 600					-- This is in Rounds Per Minute / RPM
SWEP.Primary.RPM_Semi				= nil					-- RPM for semi-automatic or burst fire.  This is in Rounds Per Minute / RPM
SWEP.Primary.ClipSize			= 0					-- This is the size of a clip
SWEP.Primary.DefaultClip			= 0					-- This is the number of bullets the gun gives you, counting a clip as defined directly above.
SWEP.DisableChambering = nil --Disable round-in-the-chamber

SWEP.Primary.KickUp			= 0					-- This is the maximum upwards recoil (rise)
SWEP.Primary.KickDown			= 0					-- This is the maximum downwards recoil (skeet)
SWEP.Primary.KickHorizontal			= 0					-- This is the maximum sideways recoil (no real term)
SWEP.Primary.StaticRecoilFactor = 0.5 	--Amount of recoil to directly apply to EyeAngles.  Enter what fraction or percentage (in decimal form) you want.  This is also affected by a convar that defaults to 0.5.

SWEP.Primary.Automatic			= true					-- Automatic/Semi Auto

SWEP.Primary.Ammo			= "none"					-- What kind of ammo

SWEP.Primary.Range = -1 -- The distance the bullet can travel in source units.  Set to -1 to autodetect based on damage/rpm.
SWEP.Primary.RangeFalloff = -1 -- The percentage of the range the bullet damage starts to fall off at.  Set to 0.8, for example, to start falling off after 80% of the range.

SWEP.Secondary.ClipSize			= 0					-- Size of a clip
SWEP.Secondary.DefaultClip			= 0					-- Default number of bullets in a clip
SWEP.Secondary.Automatic			= false					-- Automatic/Semi Auto
SWEP.Secondary.Ammo			= "none"
SWEP.Secondary.IronFOV			= 0					-- How much you 'zoom' in. Less is more!  Don't have this be <= 0 

SWEP.SprintFOVOffset = 3.75 --Add this onto the FOV when we're sprinting.

--Shell Eject 

SWEP.LuaShellEject = false
SWEP.LuaShellEjectDelay = 0
SWEP.LuaShellEffect = nil --Defaults to blowback

--Scoped vars.

SWEP.BoltAction			= false  --Unscope/sight after you shoot?
SWEP.Scoped				= false  --Draw a scope overlay?

SWEP.ScopeOverlayThreshold = 0.875 --Percentage you have to be sighted in to see the scope.
SWEP.BoltTimerOffset = 0.25 --How long you stay sighted in after shooting, with a bolt action.

--Revolver vars

SWEP.Revolver = false

--Shotgun Vars

SWEP.Shotgun = false
SWEP.KF2StyleShotgun = true --Allow empty reloads for shotguns?
SWEP.ShellTime			= .35 -- For shotguns.  How long it takes to insert a shell.

--Penetration Code

SWEP.MaxPenetrationCounter=4 --The maximum number of ricochets.  To prevent stack overflows.

-- Selective Fire Stuff

SWEP.SelectiveFire		= false --Allow selecting your firemode?
SWEP.DisableBurstFire	= false --Only bursting?
SWEP.OnlyBurstFire		= false --No auto, only burst?
SWEP.DefaultFireMode 	= "" --Default to auto or whatev

--Sighting Code
SWEP.IronSightsAng = Vector(0,0,0)
SWEP.IronSightsPos = Vector(0,0,0)
SWEP.RunSightsAng = Vector(0,0,0)
SWEP.RunSightsPos = Vector(0,0,0)
SWEP.ProceduralHolsterPos = Vector(3,0,-5)
SWEP.ProceduralHolsterAng = Vector(-40,-30,10)

SWEP.IronSightsSensitivity = 1
SWEP.CLNearWallProgress=0 --BASE DEPENDENT VALUE.  DO NOT CHANGE OR THINGS MAY BREAK.  NO USE TO YOU.
SWEP.CLRunSightsProgress=0 --BASE DEPENDENT VALUE.  DO NOT CHANGE OR THINGS MAY BREAK.  NO USE TO YOU.
SWEP.CLIronSightsProgress=0 --BASE DEPENDENT VALUE.  DO NOT CHANGE OR THINGS MAY BREAK.  NO USE TO YOU.
SWEP.CLCrouchProgress=0 --BASE DEPENDENT VALUE.  DO NOT CHANGE OR THINGS MAY BREAK.  NO USE TO YOU.
SWEP.CLJumpProgress=0 --BASE DEPENDENT VALUE.  DO NOT CHANGE OR THINGS MAY BREAK.  NO USE TO YOU.
SWEP.ProceduralHolsterFactor = 0 --BASE DEPENDENT VALUE.  DO NOT CHANGE OR THINGS MAY BREAK.  NO USE TO YOU.
SWEP.CLInspectingProgress=0
SWEP.CLSpreadRatio=1--BASE DEPENDENT VALUE.  DO NOT CHANGE OR THINGS MAY BREAK.  NO USE TO YOU.
SWEP.CLAmmoHUDProgress=0--BASE DEPENDENT VALUE.  DO NOT CHANGE OR THINGS MAY BREAK.  NO USE TO YOU.
SWEP.ShouldDrawAmmoHUD=false--THIS IS PROCEDURALLY CHANGED AND SHOULD NOT BE TWEAKED.  BASE DEPENDENT VALUE.  DO NOT CHANGE OR THINGS MAY BREAK.  NO USE TO YOU.
SWEP.IronRecoilMultiplier=0.5 --Multiply recoil by this factor when we're in ironsights.  This is proportional, not inversely.
SWEP.CrouchRecoilMultiplier=0.65  --Multiply recoil by this factor when we're crouching.  This is proportional, not inversely.
SWEP.JumpRecoilMultiplier=1.3  --Multiply recoil by this factor when we're crouching.  This is proportional, not inversely.
SWEP.WallRecoilMultiplier=1.1  --Multiply recoil by this factor when we're changing state e.g. not completely ironsighted.  This is proportional, not inversely.
SWEP.ChangeStateRecoilMultiplier=1.3  --Multiply recoil by this factor when we're crouching.  This is proportional, not inversely.
SWEP.CrouchAccuracyMultiplier=0.5--Less is more.  Accuracy * 0.5 = Twice as accurate, Accuracy * 0.1 = Ten times as accurate
SWEP.ChangeStateAccuracyMultiplier=1.5 --Less is more.  A change of state is when we're in the progress of doing something, like crouching or ironsighting.  Accuracy * 2 = Half as accurate.  Accuracy * 5 = 1/5 as accurate
SWEP.JumpAccuracyMultiplier=2--Less is more.  Accuracy * 2 = Half as accurate.  Accuracy * 5 = 1/5 as accurate
SWEP.WalkAccuracyMultiplier=1.35--Less is more.  Accuracy * 2 = Half as accurate.  Accuracy * 5 = 1/5 as accurate
SWEP.IronSightTime = 0.3 --The time to enter ironsights/exit it.
SWEP.RunSightTime = nil --Time to enter sprint/exit it
SWEP.NearWallTime = 0.25 --The time to pull up  your weapon or put it back down
SWEP.ToCrouchTime = 0.05 --The time it takes to enter crouching state
SWEP.WeaponLength = 40 --Almost 3 feet Feet.  This should be how far the weapon sticks out from the player.  This is used for calculating the nearwall trace.
SWEP.DefaultFOV=90 --BASE DEPENDENT VALUE.  DO NOT CHANGE OR THINGS MAY BREAK.  NO USE TO YOU.
SWEP.MoveSpeed = 1 --Multiply the player's movespeed by this.
SWEP.IronSightsMoveSpeed = 0.8 --Multiply the player's movespeed by this when sighting.
--VAnimation Support
SWEP.ShootWhileDraw=false --Can you shoot while draw anim plays?
SWEP.AllowReloadWhileDraw=false --Can you reload while draw anim plays?
SWEP.SightWhileDraw=false --Can we sight in while the weapon is drawing / the draw anim plays?
SWEP.AllowReloadWhileHolster=true --Can we interrupt holstering for reloading?
SWEP.ShootWhileHolster=true --Cam we interrupt holstering for shooting?
SWEP.SightWhileHolster=false --Cancel out "iron"sights when we holster?
SWEP.UnSightOnReload=true --Cancel out ironsights for reloading.
SWEP.AllowReloadWhileSprinting=false --Can you reload when close to a wall and facing it?
SWEP.AllowReloadWhileNearWall=false --Can you reload when close to a wall and facing it?
SWEP.SprintBobMult=1.5 -- More is more bobbing, proportionally.  This is multiplication, not addition.  You want to make this > 1 probably for sprinting.
SWEP.IronBobMult=0.0  -- More is more bobbing, proportionally.  This is multiplication, not addition.  You want to make this < 1 for sighting, 0 to outright disable.
SWEP.IronBobMultWalk=0.2  -- More is more bobbing, proportionally.  This is multiplication, not addition.  You want to make this < 1 for sighting, 0 to outright disable.
SWEP.ProceduralHolsterTime = 0.4 --Time to procedurally holster if no animation.  Set to 0 to disable.
--Advanced Projectile Support
SWEP.ProjectileEntity = nil --Entity to shoot
SWEP.ProjectileVelocity = 0 --Entity to shoot's velocity
SWEP.ProjectileModel = nil --Entity to shoot's model
--These holdtypes are used in ironsights.  Syntax:  DefaultHoldType=NewHoldType
SWEP.IronSightHoldTypes = { pistol = "revolver",
	smg = "rpg",
	grenade = "melee",
	ar2 = "rpg",
	shotgun = "ar2",
	rpg = "rpg",
	physgun = "physgun",
	crossbow = "ar2",
	melee = "melee2",
	slam = "camera",
	normal = "fist",
	melee2 = "magic",
	knife = "fist",
	duel = "duel",
	camera = "camera",
	magic = "magic",
	revolver = "revolver"
}
--These holdtypes are used while sprinting.  Syntax:  DefaultHoldType=NewHoldType
SWEP.SprintHoldTypes = { pistol = "normal",
	smg = "passive",
	grenade = "normal",
	ar2 = "passive",
	shotgun = "passive",
	rpg = "passive",
	physgun = "normal",
	crossbow = "passive",
	melee = "normal",
	slam = "normal",
	normal = "normal",
	melee2 = "melee",
	knife = "fist",
	duel = "normal",
	camera = "slam",
	magic = "normal",
	revolver = "normal"
}
--These holdtypes are used in reloading.  Syntax:  DefaultHoldType=NewHoldType
SWEP.ReloadHoldTypes = { pistol = "pistol",
	smg = "smg",
	grenade = "melee",
	ar2 = "ar2",
	shotgun = "shotgun",
	rpg = "ar2",
	physgun = "physgun",
	crossbow = "crossbow",
	melee = "pistol",
	slam = "smg",
	normal = "pistol",
	melee2 = "pistol",
	knife = "pistol",
	duel = "duel",
	camera = "pistol",
	magic = "pistol",
	revolver = "revolver"
}

SWEP.IronSightHoldTypeOverride=""  --This variable overrides the ironsights holdtype, choosing it instead of something from the above tables.  Change it to "" to disable.
SWEP.SprintHoldTypeOverride=""  --This variable overrides the sprint holdtype, choosing it instead of something from the above tables.  Change it to "" to disable.
SWEP.ReloadHoldTypeOverride=""  --This variable overrides the reload holdtype, choosing it instead of something from the above tables.  Change it to "" to disable.
--Override allowed VAnimations.  Necessary for lazy modelers/animators.
SWEP.ForceDryFireOff = true
SWEP.DisableIdleAnimations = true
SWEP.ForceEmptyFireOff = true
--Allowed VAnimations.  These are autodetected, so not really needed except as an extra precaution.  Don't change these until you get to the next category.
SWEP.CanDrawAnimate=true
SWEP.CanDrawAnimateEmpty=false
SWEP.CanDrawAnimateSilenced=false
SWEP.CanHolsterAnimate=true
SWEP.CanHolsterAnimateEmpty=false
SWEP.CanIdleAnimate=true
SWEP.CanIdleAnimateEmpty=false
SWEP.CanIdleAnimateSilenced=false
SWEP.CanShootAnimate=true
SWEP.CanShootAnimateSilenced=false
SWEP.CanReloadAnimate=true
SWEP.CanReloadAnimateEmpty=false
SWEP.CanReloadAnimateSilenced=false
SWEP.CanDryFireAnimate=false
SWEP.CanDryFireAnimateSilenced=false
SWEP.CanSilencerAttachAnimate=false
SWEP.CanSilencerDetachAnimate=false
SWEP.actlist = {
	ACT_VM_DRAW,
	ACT_VM_DRAW_EMPTY,
	ACT_VM_DRAW_SILENCED,
	ACT_VM_HOLSTER,
	ACT_VM_HOLSTER_EMPTY,
	ACT_VM_IDLE,
	ACT_VM_IDLE_EMPTY,
	ACT_VM_IDLE_SILENCED,
	ACT_VM_PRIMARYATTACK,
	ACT_VM_PRIMARYATTACK_1,
	ACT_VM_PRIMARYATTACK_EMPTY,
	ACT_VM_PRIMARYATTACK_SILENCED,
	ACT_VM_SECONDARYATTACK,
	ACT_VM_RELOAD,
	ACT_VM_RELOAD_EMPTY,
	ACT_VM_RELOAD_SILENCED,
	ACT_VM_ATTACH_SILENCER,
	ACT_VM_DETACH_SILENCER,
	ACT_VM_FIDGET,
	ACT_VM_FIDGET_EMPTY,
	ACT_SHOTGUN_RELOAD_START
}
 --If you really want, you can remove things from SWEP.actlist and manually enable animations and set their lengths.
SWEP.SequenceEnabled = {}
SWEP.SequenceLength = {}
SWEP.SequenceLengthOverride={} --Override this if you want to change the length of a sequence but not the next idle 
--WAnim Support
SWEP.ThirdPersonReloadDisable=false --Disable third person reload?  True disables.
--FX Stuff
--These are particle effects, not PCF files, that are played when you shoot.
SWEP.SmokeParticles = { pistol = "smoke_trail_controlled",
	smg = "smoke_trail_tfa",
	grenade = "smoke_trail_tfa",
	ar2 = "smoke_trail_tfa",
	shotgun = "smoke_trail_wild",
	rpg = "smoke_trail_tfa",
	physgun = "smoke_trail_tfa",
	crossbow = "smoke_trail_tfa",
	melee = "smoke_trail_tfa",
	slam = "smoke_trail_tfa",
	normal = "smoke_trail_tfa",
	melee2 = "smoke_trail_tfa",
	knife = "smoke_trail_tfa",
	duel = "smoke_trail_tfa",
	camera = "smoke_trail_tfa",
	magic = "smoke_trail_tfa",
	revolver = "smoke_trail_tfa",
	silenced = "smoke_trail_controlled"
}

SWEP.DoMuzzleFlash = true --Do a muzzle flash?
SWEP.CustomMuzzleFlash = true --Disable muzzle anim events and use our custom flashes?
SWEP.AutoDetectMuzzleAttachment = false --For multi-barrel weapons, detect the proper attachment?
SWEP.MuzzleFlashEffect = nil --Change to a string of your muzzle flash effect

SWEP.Tracer				= 0 --Bullet tracer.  TracerName overrides this.
SWEP.TracerName = nil --Change to a string of your tracer name,or lua effect if chosen
SWEP.TracerLua = false --Use lua effect, TFA Muzzle syntax
SWEP.TracerCount = nil --0 disables, otherwise, 1 in X chance
SWEP.TracerDelay = 0.01 --Delay for lua tracer effect

SWEP.ImpactEffect = nil--Impact Effect

--Event Table, used for custom events when a sequence is played

SWEP.EventTable = {}

--[[
example:
SWEP.EventTable = {
	[ACT_VM_RELOAD] = {
		{ ['time'] = 0.1, ['type'] = "lua", ['value'] = hifunc },
		{ ['time'] = 0.2, ['type'] = "sound", ['value'] = Sound("CryGauss.1") }
	}
}
]]--
--RT Stuff
	
local clearcol = Color(0,0,0,0)
local wepcol = Color(0,0,0,255)

SWEP.RTMaterialOverride = nil

SWEP.RTOpaque = false

SWEP.RTCode = function( self )
	
	return
	
end

--Callback system so that you can add onto base functions without copying

SWEP.Callback = {}

--Blowblack Function

SWEP.BlowbackEnabled = false --Enable Blowback?
SWEP.BlowbackVector = Vector(0,-1,0) --Vector to move bone <or root> relative to bone <or view> orientation.
SWEP.BlowbackCurrentRoot = 0 --Amount of blowback currently, for root
SWEP.BlowbackCurrent = 0 --Amount of blowback currently, for bones
SWEP.BlowbackBoneMods = nil --Viewmodel bone mods via SWEP Creation Kit
SWEP.Blowback_Only_Iron = true --Only do blowback on ironsights
SWEP.Blowback_PistolMode = false --Do we recover from blowback when empty?
SWEP.Blowback_PistolMode_Disabled = {
	[ACT_VM_RELOAD] = true,
	[ACT_VM_RELOAD_EMPTY] = true,
	[ACT_VM_DRAW_EMPTY] = true,
	[ACT_VM_IDLE_EMPTY] = true,
	[ACT_VM_HOLSTER_EMPTY] = true,
	[ACT_VM_DRYFIRE] = true
}
SWEP.Blowback_Shell_Enabled = true
SWEP.Blowback_Shell_Effect = "ShellEject"

--Stuff you shouldn't touch after this 
SWEP.EventTimer = 0 --Don't change this, base dependent and does nothing for users anyways.
SWEP.PenetrationCounter = 0 --BASE DEPENDENT VALUE.  DO NOT CHANGE OR THINGS MAY BREAK.  NO USE TO YOU.
SWEP.DrawTime = 1  --BASE DEPENDENT VALUE.  DO NOT CHANGE OR THINGS MAY BREAK.  NO USE TO YOU.
SWEP.TextCol = Color(255,255,255,255) --Primary text color
SWEP.TextColContrast = Color(32,32,32,255) --Secondary Text Color (used for shadow)
SWEP.ScopeScale = 0.5
SWEP.ReticleScale = 0.7
SWEP.Akimbo = false

SWEP.CustomBulletCallback = nil

SWEP.AnimCycle = 0 -- Start on the right

SWEP.IsTFAWeapon = true

for k,v in pairs(SWEP.SmokeParticles) do
	PrecacheParticleSystem(v)
end

SWEP.ConDamageMultiplier = 1

--[[  Quadratic Interpolation Functions  ]]--

local qerppower = 2

--[[ 
Function Name:  Power
Syntax: pow(number you want to take the power of, it's power)
Returns:  The number to the power you specify
Purpose:  Utility function
]]--
local function pow(num, power)
	return math.pow(num, power)
end

--[[ 
Function Name:  Qerp Inwards
Syntax: QerpIn(progress, your starting value, how much it should change, across what period)
Returns:  A number that you get when you quadratically fade into a value.  Kind of like a more advanced LERP.
Purpose:  Utility function / Animation
]]--

local function QerpIn(progress, startval, change, totaltime)
	if !totaltime then
		totaltime = 1
	end
	return startval + change * pow( progress/totaltime, qerppower)
end

--[[ 
Function Name:  Qerp Outwards
Syntax: QerpOut(progress, your starting value, how much it should change, across what period)
Returns:  A number that you get when you quadratically fade out of a value.  Kind of like a more advanced LERP.
Purpose:  Utility function / Animation
]]--

local function QerpOut(progress, startval, change, totaltime)
	if !totaltime then
		totaltime = 1
	end
	return startval - change * pow( progress/totaltime, qerppower)
end

--[[ 
Function Name:  Qerp
Syntax: Qerp(progress, starting value, ending value, period)
Note:  This is different syntax from QerpIn and QerpOut.  This uses a start and end value instead of a start value and change amount.
Returns:  A number that you get when you quadratically fade out of and into a value.  Kind of like a more advanced LERP.
Purpose:  Utility function / Animation
]]--

local function Qerp( progress, startval, endval, totaltime)
	change = endval - startval
	if !totaltime then
		totaltime = 1
	end
	if progress < totaltime / 2 then return QerpIn(progress, startval, change/2, totaltime/2) end
	return QerpOut(totaltime-progress, endval, change/2, totaltime/2)
end

--[[ 
Function Name:  QerpAngle
Syntax: QerpAngle(progress, starting value, ending value, period)
Returns:  The quadratically interpolated angle.
Purpose:  Utility function / Animation
]]--

function util_NormalizeAngles(a)
a.p = math.NormalizeAngle(a.p)
a.y = math.NormalizeAngle(a.y)
a.r = math.NormalizeAngle(a.r)
return a
end


local function QerpAngle( progress, startang, endang, totaltime )
	return util_NormalizeAngles(JuckeyLerpAngle(Qerp(progress,0,1,totaltime),startang,endang))
end

--[[ 
Function Name:  QerpVector
Syntax: QerpVector(progress, starting value, ending value, period)
Returns:  The quadratically interpolated vector.
Purpose:  Utility function / Animation
]]--

local myqerpvec = Vector()

local function QerpVector( progress, startang, endang, totaltime )
	if !totaltime then
		totaltime = 1
	end
	local startx, starty, startz, endx, endy, endz
	startx=startang.x
	starty=startang.y
	startz=startang.z
	endx=endang.x
	endy=endang.y
	endz=endang.z
	myqerpvec.x = Qerp(progress, startx, endx, totaltime)
	myqerpvec.y = Qerp(progress, starty, endy, totaltime)
	myqerpvec.z = Qerp(progress, startz, endz, totaltime)
	return myqerpvec
end

--[[  Standard SWEP Functions  ]]--


local vm,seq,act,sp
local host_timescale_cv,sv_cheats_cv,cl_vm_flip_cv,legacy_reloads_cv
local is,isr,rs,rsr,insp,inspr,tsv,crouchr,jumpr,ftv,ftvc,newratio,jv,rel_proc
local compensatedft,compensatedft_cr,compensatedft_sp
local heldentindex,heldent

--[[ 
Function Name:  ResetEvents
Syntax: self:ResetEvents()
Returns:  Nothing.
Purpose:  Cleans up events table.
]]--

function SWEP:ResetEvents()

	if self.Callback.ResetEvents then
		local val = self.Callback.ResetEvents(self)
		if val then return val end
	end
	
	if !self:OwnerIsValid() then return end
	
	if game.SinglePlayer() and !CLIENT then self:CallOnClient("ResetEvents","") end
	
	self.EventTimer = CurTime()
	
	for k,v in pairs(self.EventTable) do
		for l,b in pairs(v) do
			b.called = false
		end
	end
end

--[[ 
Function Name:  SetupDataTables
Syntax: Should not be manually called.
Returns:  Nothing.  Simple sets up DTVars to be networked.
Purpose:  Networking.  
]]--


function SWEP:SetupDataTables()

	if self.Callback.SetupDataTables then
		local val = self.Callback.SetupDataTables(self)
		if val then return val end
	end
	
	self:NetworkVar("Bool", 0, "IronSights")
	self:NetworkVar("Bool", 1, "IronSightsRaw")
	self:NetworkVar("Bool", 2, "Holstering")
	self:NetworkVar("Bool", 3, "Sprinting")
	self:NetworkVar("Bool", 4, "Drawing")
	self:NetworkVar("Bool", 5, "Reloading")
	self:NetworkVar("Bool", 6, "Shooting")
	self:NetworkVar("Bool", 7, "NearWall")
	self:NetworkVar("Bool", 8, "Silenced")
	self:NetworkVar("Bool", 9, "Bursting")
	self:NetworkVar("Bool", 10, "ChangingSilence")
	self:NetworkVar("Bool", 11, "FireModeChanging")
	self:NetworkVar("Bool", 12, "HUDThreshold")
	self:NetworkVar("Bool", 13, "ShotgunInsertingShell")
	self:NetworkVar("Bool", 14, "ShotgunPumping")
	self:NetworkVar("Bool", 15, "ShotgunNeedsPump")
	self:NetworkVar("Bool", 16, "ShotgunCancel")
	self:NetworkVar("Bool", 17, "BoltTimer")
	self:NetworkVar("Bool", 18, "CanHolster")
	self:NetworkVar("Bool", 19, "Inspecting")
	self:NetworkVar("Bool", 20, "Fidgeting")
	self:NetworkVar("Float",0, "DrawingEnd")
	self:NetworkVar("Float",1, "HolsteringEnd")
	self:NetworkVar("Float",2, "ReloadingEnd")
	self:NetworkVar("Float",3, "ShootingEnd")
	self:NetworkVar("Float",4, "NextIdleAnim")
	self:NetworkVar("Float",5, "NextBurst")
	self:NetworkVar("Float",6, "NextSilenceChange")
	self:NetworkVar("Float",7, "FireModeChangeEnd")
	self:NetworkVar("Float",8, "HUDThresholdEnd")
	self:NetworkVar("Float",9, "BoltTimerStart")
	self:NetworkVar("Float",10, "BoltTimerEnd")
	self:NetworkVar("Float",11, "IronSightsRatio")
	self:NetworkVar("Float",12, "RunSightsRatio")
	self:NetworkVar("Float",13, "CrouchingRatio")
	self:NetworkVar("Float",14, "JumpingRatio")
	self:NetworkVar("Float",15, "NearWallRatio")
	self:NetworkVar("Float",16, "SpreadRatio")
	self:NetworkVar("Float",17, "InspectingRatio")
	self:NetworkVar("Int",0, "FireMode")
	self:NetworkVar("Int",1, "BurstCount")	
end

--[[ 
Function Name:  InitDrawCode
Syntax: self:InitDrawCode("1 or 0, 1 or 0")
Notes:  the instr parameter is deprecated since client autodetection has been improved and is actually better than the server.
Returns:  Nothing
Purpose:  Standard SWEP Function
]]--

function SWEP:InitDrawCode( instr )

	if self.Callback.InitDrawCode then
		local val = self.Callback.InitDrawCode(self, instr)
		if val then return val end
	end

	if CLIENT then
		local t=string.Explode(",",instr,false)
		if t[1] then
			self.SequenceEnabled[ACT_VM_DRAW]=false
			if t[1]==1 then
				self.SequenceEnabled[ACT_VM_DRAW]=true
			end
		end
		if t[2] then
			self.SequenceEnabled[ACT_VM_DRAW_EMPTY]=false
			if t[2]==1 then
				self.SequenceEnabled[ACT_VM_DRAW_EMPTY]=true
			end
		end
	end	
	
	if (CurTime()<self:GetReloadingEnd()) then
		self:SetReloading(false)
		self:SetReloadingEnd(CurTime()-1)
	end

	
	if (CurTime()<self:GetHolsteringEnd()) then
		self:SetHolstering(false)
		self:SetHolsteringEnd(CurTime()-1)
	end
	
	
	local tmpact=self:GetActivity()
	if !self.LastDrawAnimTime then
		self.LastDrawAnimTime=-1
	end
	
	local success, anim
	if ( tmpact==0 or !(act==ACT_VM_DRAW or act==ACT_VM_DRAW_EMPTY or act==ACT_VM_DRAW_SILENCED) ) and ( CurTime()-self.LastDrawAnimTime > 0.2 )then
		self.LastDrawAnimTime = CurTime()
		success, anim = self:ChooseDrawAnim()
	end
	
	self:SetDrawing(success)
	
	if success then
		local vm = self.Owner:GetViewModel()
		local seq = vm:SelectWeightedSequence( anim )
		local seqtime = vm:SequenceDuration( seq )
		local dt = CurTime()+ ( self.SequenceLengthOverride[anim] or seqtime ) 
		if self.ShootWhileDraw==false then
			self:SetNextPrimaryFire(dt)
		end
		
		self:SetDrawingEnd(dt)
		self:SetNextIdleAnim(CurTime() + seqtime)
		local myhangtimev = 1
		if self:OwnerIsValid() then
			if SERVER then
				myhangtimev = self.Owner:GetInfoNum("cl_tfa_hud_hangtime",1)
			else
				myhangtimev = GetConVarNumber("cl_tfa_hud_hangtime",1)
			end
		end
		self:SetHUDThresholdEnd(CurTime()+seqtime+myhangtimev)
	end
end

--[[ 
Function Name:  InitHolsterCode
Syntax: self:InitHolsterCode("1 or 0, 1 or 0")
Notes:  the instr parameter is deprecated since client autodetection has been improved and is actually better than the server.
Returns:  Nothing
Purpose:  Standard SWEP Function
]]--

function SWEP:InitHolsterCode( instr )

	if self.Callback.InitHolsterCode then
		local val = self.Callback.InitHolsterCode(self, instr)
		if val then return val end
	end


	self.LastDrawAnimTime=-1

	if CLIENT then
		local t=string.Explode(",",instr,false)
		if t[1] then
			self.SequenceEnabled[ACT_VM_DRAW]=false
			if t[1]==1 then
				self.SequenceEnabled[ACT_VM_HOLSTER]=true
			end
		end
		if t[2] then
			self.SequenceEnabled[ACT_VM_HOLSTER_EMPTY]=false
			if t[2]==1 then
				self.SequenceEnabled[ACT_VM_HOLSTER_EMPTY]=true
			end
		end
	end	
	
	if SERVER or ( CLIENT and IsFirstTimePredicted() )then
		local ha, tact=self:ChooseHolsterAnim()
		local vm = self.Owner:GetViewModel()
		if (!ha) then
			self:SetCanHolster(true)
			self:Holster(self:GetNWEntity("SwitchToWep",nil))
			self:SetHolstering(false)
			return
		end
		
		local seqtime=self.SequenceLength[tact]
		
		self:SetNextIdleAnim(CurTime() + seqtime)
		
		local dt = CurTime()+ ( self.SequenceLengthOverride[tact] or  seqtime )
		
		if self.ShootWhileHolster==false then
			self:SetNextPrimaryFire( dt )
		end
	
		self:SetHolstering(true)
	
		self:SetHolsteringEnd(dt)
	end
end


--[[ 
Function Name:  InitHolsterCode
Syntax: self:InitHolsterCode("1 or 0, 1 or 0")
Notes:  the instr parameter is deprecated since client autodetection has been improved and is actually better than the server.
Returns:  Nothing
Purpose:  Standard SWEP Function
]]--

function SWEP:InitHolsterCodeProcedural( )

	if self.Callback.InitHolsterCodeProcedural then
		local val = self.Callback.InitHolsterCodeProcedural(self, instr)
		if val then return val end
	end

	self.LastDrawAnimTime=-1
	
	if SERVER or ( CLIENT and IsFirstTimePredicted() )then
		
		self:ChooseIdleAnim()
		
		local seqtime=self.ProceduralHolsterTime
		
		self:SetNextIdleAnim(CurTime() + seqtime)
		
		local dt = CurTime()+ self.ProceduralHolsterTime
		
		if self.ShootWhileHolster==false then
			self:SetNextPrimaryFire( dt )
		end
	
		self:SetHolstering(true)
	
		self:SetHolsteringEnd(dt)
	end
end

--[[ 
Function Name:  Precache
Syntax: Should not be normally called.
Returns:  Nothing.  Simply precaches models/sound.
Purpose:  Standard SWEP Function
]]--

function SWEP:Precache()

	if self.Callback.Precache then
		local val = self.Callback.Precache(self)
		if val then return val end
	end
	
	if self.Primary.Sound then
		util.PrecacheSound(self.Primary.Sound)
	end
	util.PrecacheModel(self.ViewModel)
	util.PrecacheModel(self.WorldModel)
end

--[[ 
Function Name:  Initialize
Syntax: Should not be normally called.
Notes:   Called after actual SWEP code, but before deploy, and only once.
Returns:  Nothing.  Sets the intial values for the SWEP when it's created. 
Purpose:  Standard SWEP Function
]]--

function SWEP:Initialize()

	if self.Callback.Initialize then
		local val = self.Callback.Initialize(self)
		if val then return val end
	end
	
	if (!self.Primary.Damage) or (self.Primary.Damage<=0.01) then
		self:AutoDetectDamage()
	end
	
	if !self.Primary.Accuracy then
		if self.Primary.ConeSpray then
			self.Primary.Accuracy  = ( 5 / self.Primary.ConeSpray) / 90
		else
			self.Primary.Accuracy = 0.01
		end
	end
	
	if !self.Primary.IronAccuracy then
		self.Primary.IronAccuracy = self.Primary.Accuracy * 0.2
	end
	
	if GetConVarNumber("tfa_bl_"..self:GetClass(),0)==1 then
		self.Spawnable				= false
		self.AdminSpawnable			= false
		
		if SERVER then
			timer.Simple(0, function()
				if IsValid(self) then
					if IsValid(self.Owner) then
						print("Blacklisted weapon was spawned by:")
						print(self.Owner)
						self.Owner:StripWeapon(self:GetClass())
						if self.Owner.SetAmmo then
							self.Owner:SetAmmo( math.Clamp(self:GetAmmoReserve()-self.Primary.DefaultClip,0,99999),self:GetPrimaryAmmoType())
						end
					end
				end
			end)
		end
	end
	
	if self.MuzzleAttachment == "1" then
		self.CSMuzzleFlashes = true
	end
	
	if self.Akimbo then
		self.AutoDetectMuzzleAttachment = true
		self.MuzzleAttachmentRaw = 2-self.AnimCycle
	end	
	
	self:CreateFireModes()
	
	self:AutoDetectMuzzle()
	
	self:AutoDetectRange()
	
	self.DefaultHoldType = self.HoldType
	self.ViewModelFOVDefault = self.ViewModelFOV
	
	self.DrawCrosshairDefault = self.DrawCrosshair
	
	self:SetUpSpread()
	
	self:CorrectScopeFOV( self.DefaultFOV and self.DefaultFOV or self.Owner:GetFOV() )
	
	if CLIENT then
		self:InitMods()
		self:IconFix()
	end
	
	self.drawcount=0
	self.drawcount2=0
	self.canholster=false
	
	self:DetectValidAnimations()
	self:SetDeploySpeed(self.SequenceLength[ACT_VM_DRAW])
	
	if !self.Primary.ClipMax then
		self.Primary.ClipMax = self.Primary.ClipSize * 3
	end
	
	self:ResetEvents()
	
	self:DoBodyGroups()
	
	self:InitAttachments()
	
	self.IsHolding = false
	
	if self.ViewModelFlipDefault == nil then
		self.ViewModelFlipDefault = self.ViewModelFlip
	end
	
	self:SetDrawing(true)
	self:ProcessHoldType()
end

--[[ 
Function Name:  Deploy
Syntax: self:Deploy()
Notes:  Called after self:Initialize().  Called each time you draw the gun.  This is also essential to clearing out old networked vars and resetting them.
Returns:  True/False to allow quickswitch.  Why not?  You should really return true.
Purpose:  Standard SWEP Function
]]--

function SWEP:Deploy()

	if self.Callback.Deploy then
		local val = self.Callback.Deploy(self)
		if val then return val end
	end
	
	if (!self.Primary.Damage) or (self.Primary.Damage<=0.01) then
		self:AutoDetectDamage()
	end
	
	if !self.Primary.Accuracy then
		if self.Primary.ConeSpray then
			self.Primary.Accuracy  = ( 5 / self.Primary.ConeSpray) / 90
		else
			self.Primary.Accuracy = 0.01
		end
	end
	
	if !self.Primary.IronAccuracy then
		self.Primary.IronAccuracy = self.Primary.Accuracy * 0.2
	end
	
	if self.MuzzleAttachment == "1" then
		self.CSMuzzleFlashes = true
	end
	
	self:CreateFireModes()

	self.ViewModelFOVDefault = self.ViewModelFOV
	self.DefaultFOV=self.Owner:GetFOV()
	
	if self.DrawCrosshairDefault==nil then
		self.DrawCrosshairDefault = self.DrawCrosshair
	end
	
	self.isfirstdraw=false
	if !self.hasdrawnbefore then
		self.hasdrawnbefore = true
		self.isfirstdraw=true
		--self.Primary.DefaultClip = 0
	end
	
	if self.isfirstdraw then
		self:SetDeploySpeed(self.SequenceLength[ACT_VM_DRAW])
	end
	
	self:ResetSightsProgress()
	
	self:DetectValidAnimations()
	
	self:AutoDetectRange()
	
	timer.Simple(0, function()
		if IsValid(self) then
			self:DetectValidAnimations()
			self:ChooseDrawAnim()
		end
	end)
	
	if self.Owner:KeyDown(IN_ATTACK2) and self.SightWhileDraw then
		self:SetIronSights(true)
	end
	
	if self.Owner:KeyDown(IN_SPEED) and self.Owner:GetVelocity():Length()>self.Owner:GetWalkSpeed() then
		self:SetSprinting(true)
	end
	
	self:SetHoldType(self.HoldType)
	
	self.OldIronsights=(false)
	self:SetIronSights(false)
	self:SetIronSightsRaw(false)
	self.OldSprinting=(false)
	self.OldSafety=(false)
	self:SetSprinting(false)
	self:SetShooting(false)
	self:SetChangingSilence(false)
	self:SetCanHolster(false)
	self:SetReloading(false)
	self:SetShotgunInsertingShell(false)
	self:SetShotgunCancel( false )
	self:SetShotgunPumping(false)
	self:SetShotgunNeedsPump(false )
	self:SetFireModeChanging( false ) 
	self:SetBoltTimer( false )
	self:SetReloadingEnd(CurTime()-1)
	self:SetShootingEnd(CurTime()-1)
	self:SetDrawingEnd(CurTime()-1)
	self:SetHolsteringEnd(CurTime()-1)
	self:SetNextSilenceChange(CurTime()-1)
	self:SetFireModeChangeEnd(CurTime()-1)
	self:SetHUDThreshold(true)
	self:SetHUDThresholdEnd(CurTime()+0.2)
	self:SetBoltTimerStart(CurTime()-1)
	self:SetBoltTimerEnd(CurTime()-1)
	self:SetDrawing(true)
	self:SetHolstering(false)
	self:SetInspecting(false)
	if self:GetSilenced()==nil then
		self:SetSilenced(self.Silenced and self.Silenced or 0)
	end
	self:SetIronSightsRatio(0)
	self:SetRunSightsRatio(0)
	self:SetCrouchingRatio(0)
	self:SetJumpingRatio(0)
	self:SetSpreadRatio(0)
	self:SetBurstCount(0)
	self:SetInspectingRatio(0)
	self:SetBursting(false)
	self:SetUpSpread()
	self:AutoDetectMuzzle()
	self.PenetrationCounter = 0
	if CLIENT or game.SinglePlayer() then
		self.CLSpreadRatio=1
		self.CLIronSightsProgress = 0
		self.CLRunSightsProgress = 0
		self.CLCrouchProgress = 0
		self.CLInspectingProgress = 0
		self.CLNearWallProgressProgress = 0
	end
	self:SetNextIdleAnim(CurTime()-1)
	local vm = self.Owner:GetViewModel()
	local drawtimerstring=(self.SequenceEnabled[ACT_VM_DRAW] and 1 or 0)..","..(self.SequenceEnabled[ACT_VM_DRAW_EMPTY] and 1 or 0)
	
	self:InitDrawCode(drawtimerstring)
	
	self:CorrectScopeFOV( self.DefaultFOV and self.DefaultFOV or self.Owner:GetFOV() )
	
	self.customboboffset=Vector(0,0,0)
	
	self:ResetEvents()
	
	if SERVER and IsValid(self.Owner) then
		self:CallOnClient("ResetEvents","")
	end
	
	self:UpdateConDamage()
	
	self.LastSys = SysTime()
	
	self.ProceduralHolsterFactor = 0
	
	self:DoBodyGroups()
	
	self:SetFidgeting(false)
	
	self.IsHolding = false
	
	if SERVER and IsValid(self.Owner) then
		self:CallOnClient("SelfSetHolding","")
	end
	
	if self.ViewModelFlipDefault == nil then
		self.ViewModelFlipDefault = self.ViewModelFlip
	end
	
	return true
end

--[[ 
Function Name:  OnRemove
Syntax: self:OnRemove()
Notes:  Resets bone mods and cleans up.
Returns:  Nil.
Purpose:  Standard SWEP Function
]]--

function SWEP:OnRemove()

	if self.Callback.OnRemove then
		local val = self.Callback.OnRemove(self)
		if val then return val end
	end
	
	if CLIENT then
		self:CleanModels(self.VElements) -- create viewmodels
		self:CleanModels(self.WElements) -- create worldmodels
	end
	
	if self.ResetBonePositions then
		self:ResetBonePositions()
	else
		self:CallOnClient("ResetBonePositions","")
	end

end

--[[ 
Function Name:  OnDrop
Syntax: self:OnDrop()
Notes:  Resets bone mods and cleans up.
Returns:  Nil.
Purpose:  Standard SWEP Function
]]--

function SWEP:OnDrop()

	if self.Callback.OnDrop then
		local val = self.Callback.OnDrop(self)
		if val then return val end
	end
	
	if self.Callback.OnDrop then
		self.Callback.OnDrop(self)
	end
	
	if CLIENT then
		self:CleanModels(self.VElements) -- create viewmodels
		self:CleanModels(self.WElements) -- create worldmodels
	end

	if self.ResetBonePositions then
		self:ResetBonePositions()
	else
		self:CallOnClient("ResetBonePositions","")
	end

end

--[[ 
Function Name:  CanPickup
Syntax: self:CanPickup( to pick up)
Notes:  For picking up props.
Returns:  True/False
Purpose:  Self explanitory
]]--

function SWEP:CanPickup(ent)
	local massLimit = 35
	local sizeLimit = 128
	
	--Must be valid
	if !IsValid(ent) then print("noent") return false end
		
	local count = ent:GetPhysicsObjectCount()

	--Must have a physics object
	if (!count) then
		print("no count")
		return false
	end
	
	local objectMass = 0
	local checkEnable = false
	
	if count>0 then
		for i=0, count-1 do
			local phys = ent:GetPhysicsObjectNum(i)
			if IsValid(phys) then
				objectMass = objectMass + phys:GetMass()
				
				if ( !phys:IsMoveable() ) then
					print(phys)
					return false
				end
				
			end
		end
	else
		local phys = ent:GetPhysicsObject()	
		
		if IsValid(phys) then
			objectMass = objectMass + phys:GetMass()
			
			if ( !phys:IsMoveable() ) then
				print(phys)
				return false
			end
			
		end	
	end
	
	if ( massLimit > 0 and objectMass > massLimit ) then
		print("toomass")
		return false
	end
	
	if ( sizeLimit > 0 ) then
		local size = ent:OBBMaxs() - ent:OBBMins()
		if ( size.x > sizeLimit or size.y > sizeLimit or size.z > sizeLimit ) then
			print("toobig")
			return false
		end
	end
	
	local itspos = (ent:GetPos()+ent:OBBCenter())
	local dist = itspos :Distance(self.Owner:GetShootPos())
	local ang1 = self.Owner:EyeAngles()
	local ang2 = (itspos-self.Owner:GetShootPos()):Angle()
	local angdif = ang1-ang2
	
	if dist>100 then return false end
	if math.abs(math.NormalizeAngle(angdif.p))>90-dist/4 or math.abs(math.NormalizeAngle(angdif.y))>90-dist/4 then return false end
	
	return hook.Call("PlayerCanPickupItem",GAMEMODE,self.Owner,ent)
end

--[[ 
Function Name:  Holster
Syntax: self:Holster( weapon entity to switch to )
Notes:  This is kind of broken.  I had to manually select the new weapon using ply:ConCommand.  Returning true is simply not enough.  This is also essential to clearing out old networked vars and resetting them.
Returns:  True/False to allow holster.  Useful for animations.
Purpose:  Standard SWEP Function
]]--

function SWEP:SelfSetHolding(arg)
	if arg=="true" then
		self.IsHolding = true
	else
		self.IsHolding = false
	end
end

function SWEP:Holster( switchtowep )

	

	if self.Callback.Holster then
		local val = self.Callback.Holster(self, switchtowep)
		if val then return val end
	end
	
	if self.WriteKills then
		self:WriteKills()
		
		if SERVER then self:CallOnClient("WriteKills","") end
	end
	
	if !self:OwnerIsValid() then return end
	
	self:SetShotgunCancel( true )
	
	self:CleanParticles()
	
	if SERVER then
		self:CallOnClient("CleanParticles","")
	end
	
	if IsValid(self.Owner:GetViewModel()) then
		self.Owner:GetViewModel():StopParticles()
	end
		
	self.PenetrationCounter = 0
	
	if self==switchtowep then
		return
	end
	
	if !IsValid(switchtowep) then
		switchtowep = self.Owner
	end
	
	if switchtowep then
		self:SetNWEntity("SwitchToWep",switchtowep)
	end
	
	self:SetReloading(false)
	self:SetDrawing(false)
	
	self:SetInspecting(false)
	
	if (CurTime()<self:GetDrawingEnd()) then
		self:SetDrawingEnd(CurTime()-1)
	end
	
	if (CurTime()<self:GetReloadingEnd()) then
		self:SetReloadingEnd(CurTime()-1)
	end
	local hasholsteringanim = self.SequenceEnabled[ACT_VM_HOLSTER] or self.SequenceEnabled[ACT_VM_HOLSTER_EMPTY]
	if self:GetCanHolster()==false then
		if hasholsteringanim then
			if !( self:GetHolstering() and CurTime()<self:GetHolsteringEnd() ) then
				local holstertimerstring=(self.SequenceEnabled[ACT_VM_HOLSTER] and 1 or 0)..","..(self.SequenceEnabled[ACT_VM_HOLSTER_EMPTY] and 1 or 0)
				self:InitHolsterCode(holstertimerstring)
			else
				if self:GetHolsteringEnd()-CurTime()<0.05 and self:GetHolstering() then
					self:SetCanHolster(true)
					self:Holster(self:GetNWEntity("SwitchToWep",switchtowep))
					if self.ResetBonePositions then
						self:ResetBonePositions()
					end
					return true
				end
			end
		else
			if !( self:GetHolstering() and CurTime()<self:GetHolsteringEnd() ) then
				self:InitHolsterCodeProcedural()
			else
				if self:GetHolsteringEnd()-CurTime()<0.05 and self:GetHolstering() then
					self:SetCanHolster(true)
					self:Holster(self:GetNWEntity("SwitchToWep",switchtowep))
					if self.ResetBonePositions then
						self:ResetBonePositions()
					end
					return true
				end
			end		
		end
	else
		self.DrawCrosshair = self.DrawCrosshairDefault or self.DrawCrosshair
		self:SendWeaponAnim( 0 )
		dholdt = self.DefaultHoldType and self.DefaultHoldType or self.HoldType
		self:SetHoldType( dholdt )
		self:SetHolstering(false)
		self:SetHolsteringEnd(CurTime()-0.1)
		local wep=self:GetNWEntity("SwitchToWep",switchtowep)
		--print(wep)
		if wep==self.Owner then
			--local pickuptrace = util.QuickTrace(self.Owner:GetShootPos(),self.Owner:GetAimVector()*92,function(ent) if ent==self.Owner or ent==self or ent:IsWorld() then return false end return true end)
			--if pickuptrace.Hit and pickuptrace.Fraction<1 and IsValid(pickuptrace.Entity) then
			local lhe = self.Owner:GetNWEntity("LastHeldEntity")
			if IsValid(lhe) then
				--[[
				local itspos = lhe:GetPos()
				local ang1 = self.Owner:EyeAngles()
				local ang2 = (lhe:GetPos()-self.Owner:GetShootPos()):Angle()
				local angdif = ang1-ang2
				local dist = lhe:GetPos():Distance(self.Owner:GetShootPos())
				if math.abs(math.NormalizeAngle(angdif.p))<=90-dist/4 and math.abs(math.NormalizeAngle(angdif.y))<=90-dist/4 and dist<100 then
				]]--
				--if self:CanPickup(lhe) then
					self.Owner:ConCommand("+use")
					self.IsHolding = true
					self:CallOnClient("SelfSetHolding","true")
					timer.Simple(0.1,function()
						if IsValid(self) and IsValid(self.Owner) then
							self.Owner:ConCommand("-use")
							if !IsValid(lhe) or ( lhe.IsPlayerHolding and !lhe:IsPlayerHolding() ) then
								self:Deploy()
								self.IsHolding = false
								self:CallOnClient("SelfSetHolding","")
							end	
						end
					end)
				--end
			else
				self:Deploy()
			end
		elseif IsValid( wep ) and IsValid(self.Owner) and self.Owner:HasWeapon( wep:GetClass() ) then
			if CLIENT or game.SinglePlayer() then
				
				if self.ResetBonePositions then
					self:ResetBonePositions()
				end
				
				self:ResetVMBodyGroups()
				
				self.Owner:ConCommand("use " .. wep:GetClass())
			end
		end
		return true
	end
end

--[[ 
Function Name:  AdjustMouseSensitivity
Syntax: Should not normally be called.
Returns:  SWEP sensitivity multiplier.
Purpose:  Standard SWEP Function
]]--

function SWEP:AdjustMouseSensitivity()

	if self.Callback.AdjustMouseSensitivity then
		local val = self.Callback.AdjustMouseSensitivity(self)
		if val then return val end
	end
	
	local sensval=1
	if self:GetIronSights() then
		sensval = sensval * GetConVarNumber("cl_tfa_scope_sensitivity",100)/100
		if GetConVarNumber("cl_tfa_scope_sensitivity_autoscale",1)==1 then
			sensval =  sensval*(self.Owner:GetFOV()/self.DefaultFOV)
		else
			sensval = sensval
		end
		if GetConVarNumber("sv_tfa_scope_gun_speed_scale",0)==1 then
			sensval = sensval * self.IronSightsMoveSpeed
		end
	end
	
	sensval = sensval * Lerp( CLIENT and self.CLIronSightsProgress or self:GetIronSightsRatio() , 1, self.IronSightsSensitivity)
	
	return sensval
end

--[[ 
Function Name:  TranslateFOV
Syntax: Should not normally be called.  Takes default FOV as parameter.
Returns:  New FOV.
Purpose:  Standard SWEP Function
]]--

function SWEP:TranslateFOV( fov )

	if self.Callback.TranslateFOV then
		local val = self.Callback.TranslateFOV(self, fov)
		if val then return val end
	end
	
	local nfov=Lerp(self.CLIronSightsProgress,fov,fov*(self.Secondary.IronFOV/90))
	return Lerp(self.CLRunSightsProgress,nfov,nfov+self.SprintFOVOffset)
end

--[[ 
Function Name:  Think
Syntax: self:Think()
Returns:  Nothing.
Notes:  This is blank.
Purpose:  Standard SWEP Function
]]--

function SWEP:Think()

	if self.Callback.Think then
		local val = self.Callback.Think(self)
		if val then return val end
	end
	
end


--[[ 
Function Name:  ViewModelFlip
Syntax: self:ViewModelFlip().  Called from Think2.
Returns:  Nothing.
Notes:  Allows you to toggle lefthanded.
Purpose:  Standard SWEP Function
]]--


local shouldflip
function SWEP:ViewModelFlipFunc()

	if !cl_vm_flip_cv then cl_vm_flip_cv = GetConVar("cl_tfa_viewmodel_flip") end

	local righthanded = true
	
	if SERVER and self.Owner:GetInfoNum("cl_tfa_viewmodel_flip",0)==1 then
		righthanded = false
	end
	if CLIENT and cl_vm_flip_cv:GetBool() then
		righthanded = false
	end
	
	shouldflip = self.ViewModelFlipDefault
	if !righthanded then
		shouldflip = !self.ViewModelFlipDefault
	end
	
	if self.ViewModelFlip!=shouldflip then self.ViewModelFlip = shouldflip end
end

--[[ 
Function Name:  Think2
Syntax: self:Think2().  Called from PlayerThink.
Returns:  Nothing.
Notes:  Essential for calling other important functions.  This is called from PlayerThink.  It's used because SWEP:Think() isn't always called.
Purpose:  Standard SWEP Function
]]--

function SWEP:Think2()
	if !self:OwnerIsValid() then return end

	if self.Callback.Think2 then
		local val = self.Callback.Think2(self)
		if val then return val end
	end
	
	self:ProcessEvents()
	self:ProcessFireMode()
	self:ProcessTimers()
	self:UserInput()
	self:IronsSprint()
	self:ProcessHoldType()
	self:ViewModelFlipFunc()
	if self.Owner:GetVelocity():Length()>self.Owner:GetWalkSpeed()*0.4 then
		--self:CleanParticles()
	end
end

--[[ 
Function Name:  PreDrawOpaqueRenderables
Syntax: self:PreDrawOpaqueRenderables()
Returns:  Nothing.
Notes: Does SWEP.Offset
Purpose:  Feature
]]--


function SWEP:PreDrawOpaqueRenderables()
	if self.Callback.PreDrawOpaqueRenderables then
		local val = self.Callback.PreDrawOpaqueRenderables(self)
		if val then return val end
	end
	--[[
	
	if CLIENT and !game.SinglePlayer() then
		local hand, offset, rotate

		local ply = self:GetOwner()

		if IsValid( ply ) and self.Offset and self.Offset.Pos and self.Offset.Ang then
			local handBone = ply:LookupBone( "ValveBiped.Bip01_R_Hand" )
			if handBone then
				if ply.SetupBones then ply:SetupBones() end
				local pos, ang = ply:GetBonePosition( handBone )
				pos = pos + ang:Forward() * self.Offset.Pos.Forward + ang:Right() * self.Offset.Pos.Right + ang:Up() * self.Offset.Pos.Up
				ang:RotateAroundAxis( ang:Up(), self.Offset.Ang.Up)
				ang:RotateAroundAxis( ang:Right(), self.Offset.Ang.Right )
				ang:RotateAroundAxis( ang:Forward(),  self.Offset.Ang.Forward )
				self:SetRenderOrigin( pos )
				self:SetRenderAngles( ang )
				if self.Offset.Scale and ( !self.MyModelScale or ( self.Offset and self.MyModelScale!=self.Offset.Scale ) ) then
					self:SetModelScale( self.Offset.Scale or 1, 0 )
					self.MyModelScale = self.Offset.Scale
				end
			end
		else
			self:SetRenderOrigin( nil )
			self:SetRenderAngles( nil )
			if !self.MyModelScale or self.MyModelScale!=1 then
				self:SetModelScale( 1, 0 )
				self.MyModelScale = 1
			end
		end
	end
	]]--
end

--[[ 
Function Name:  CycleFireMode
Syntax: self:CycleFireMode()
Returns:  Nothing.
Notes: Cycles to next firemode.
Purpose:  Feature
]]--

function SWEP:CycleFireMode()
	
	local fm = self:GetFireMode()
	fm = fm + 1
	if fm>=#self.FireModes then
		fm = 1
	end
	
	self:SetFireMode(fm)
	
	self.Weapon:EmitSound("Weapon_AR2.Empty")
	
	self.Weapon:SetNextBurst( CurTime()+math.max( 1/(self:GetRPM()/60), 0.25 ) )
	self.Weapon:SetNextPrimaryFire( CurTime()+math.max( 1/(self:GetRPM()/60), 0.25 ) )

	self:SetFireModeChanging( true )
	
	self:SetFireModeChangeEnd( CurTime() + math.max( 1/(self:GetRPM()/60), 0.25 ) )
end

--[[ 
Function Name:  CycleSafety
Syntax: self:CycleSafety()
Returns:  Nothing.
Notes: Toggles safety
Purpose:  Feature
]]--

function SWEP:CycleSafety()
	
	local fm = self:GetFireMode()
	if fm !=#self.FireModes then
		self.LastFireMode = fm
		self:SetFireMode(#self.FireModes)
	else
		self:SetFireMode(self.LastFireMode or 1)
	end
	
	self.Weapon:EmitSound("Weapon_AR2.Empty")
	
	self.Weapon:SetNextBurst( CurTime()+math.max( 1/(self:GetRPM()/60), 0.25 ) )
	self.Weapon:SetNextPrimaryFire( CurTime()+math.max( 1/(self:GetRPM()/60), 0.25 ) )

	self:SetFireModeChanging( true )

	self:SetFireModeChangeEnd( CurTime() + math.max( 1/(self:GetRPM()/60), 0.25 ) )
end

--[[ 
Function Name:  ProcessFireMode
Syntax: self:ProcessFireMode()
Returns:  Nothing.
Notes: Processes fire mode changing and whether the swep is auto or not.
Purpose:  Feature
]]--

function SWEP:ProcessFireMode()

	if self.Callback.ProcessFireMode then
		local val = self.Callback.ProcessFireMode(self)
		if val then return val end
	end
	
	if self.Owner:KeyPressed(IN_RELOAD) and self.Owner:KeyDown(IN_USE) and !(CLIENT and !IsFirstTimePredicted() ) then
		if self.SelectiveFire and !self.Owner:KeyDown(IN_SPEED) then
			self:CycleFireMode()
		elseif self.Owner:KeyDown(IN_SPEED) then
			self:CycleSafety()
		end
	end
	
	if string.find(string.lower(self.FireModes[self:GetFireMode()]),"auto") then
		self.Primary.Automatic = true
	else
		self.Primary.Automatic = false
	end
end

--[[ 
Function Name:  CanPrimaryAttack
Syntax: self:CanPrimaryAttack()
Returns:  True/false can we shoot
Notes: Set clip to -1 to use reserve.
Purpose:  Main SWEP function
]]--

function SWEP:CanPrimaryAttack()

	if ( self.Weapon:Clip1() <= 0 and self.Primary.ClipSize!=-1 ) then

		self:EmitSound( "Weapon_Pistol.Empty" )
		self:SetNextPrimaryFire(CurTime()+1/(self:GetRPM()/60))
		self:Reload()
		return false

	elseif (self.Primary.ClipSize==-1 and self.Weapon:Ammo1()<=0) then
		return false
	end

	return true

end

--[[ 
Function Name:  PrimaryAttack
Syntax: self:PrimaryAttack().  However, to shoot a bullet, ShootBulletInformation or ShootBullet should be called.  This is really only for when the player or the burst fire mechanism willingly fires.
Returns:  Nothing.
Notes: Called when you try to primaryattack.
Purpose:  Main SWEP function
]]--

function SWEP:PrimaryAttack()
	
	if self.Callback.PrimaryAttack then
		local val = self.Callback.PrimaryAttack(self)
		if val then return val end
	end
	
	if !self:OwnerIsValid() then return end
	
	self:UpdateConDamage()
	
	if ( self:GetHolstering() ) then
		if (self.ShootWhileHolster==false) then
			return
		else
			self:SetHolsteringEnd(CurTime()-0.1)
			self:SetHolstering(false)
		end
	end
	
	if (self:GetReloading() and self.Shotgun and !self:GetShotgunPumping() and !self:GetShotgunNeedsPump()) then
		self:SetShotgunCancel( true )
		--[[
		self:SetShotgunInsertingShell(true)
		self:SetShotgunPumping(false)
		self:SetShotgunNeedsPump(true)
		self:SetReloadingEnd(CurTime()-1)
		]]--
		return
	end
	
	if self:IsSafety() then 
		self.Weapon:EmitSound("Weapon_AR2.Empty")
		self.LastSafetyShoot = self.LastSafetyShoot or 0
		if CurTime()<self.LastSafetyShoot+0.2 then
			self:CycleSafety()		
		end
		self.LastSafetyShoot = CurTime()
		return 
	end
	
	if (self:GetChangingSilence()) then return end
	
	if (self:GetNearWallRatio()>0.05) then
		return
	end
	
	if !self:OwnerIsValid() then return end
	
	if self.FiresUnderwater == false and self.Owner:WaterLevel()>=3 then
		if self:CanPrimaryAttack() then
			self:SetNextPrimaryFire(CurTime()+0.5)
			self.Weapon:EmitSound("Weapon_AR2.Empty")
		end
		return
	end
	
	if (self.Owner:KeyDown(IN_USE) and self.CanBeSilenced and self.Owner:KeyPressed(ACT_VM_PRIMARYATTACK)  ) then
	
		if ( self:CanPrimaryAttack() and !self:GetChangingSilence() ) then
			--self:SetSilenced(!self:GetSilenced())
			local success, tanim = self:ChooseSilenceAnim(!self:GetSilenced())
			self:SetChangingSilence(true)
			self:SetNextSilenceChange(CurTime()+self.SequenceLength[tanim])
			self:SetNextPrimaryFire(CurTime()+1/(self:GetRPM()/60))
		end
		
		return
	end
	
	if self:GetNextPrimaryFire()>CurTime() then return end
	
	if self:GetReloading() then
		self:CompleteReload()
	end
	
	if !self:CanPrimaryAttack() then return end
	
	--if self.Owner:IsPlayer() then
		if  self:GetRunSightsRatio()<0.1 then--and self:GetReloading()==false then
			self.ProceduralHolsterFactor = 0
			self:SetHolstering(false)
			self:ResetEvents()
			self:SetInspecting(false)
			self:SetInspectingRatio(0)
			self:SetInspectingRatio(0)
			--self:SendWeaponAnim(0)
			self:ShootBulletInformation( SERVER or (CLIENT and IsFirstTimePredicted() ) ) 
			local success, tanim = self:ChooseShootAnim( SERVER or (CLIENT and IsFirstTimePredicted() ) ) -- View model animation
			if self:OwnerIsValid() and self.Owner.SetAnimation then
				self.Owner:SetAnimation( PLAYER_ATTACK1 ) -- 3rd Person Animation
			end
			self:TakePrimaryAmmo(1)
			self.PenetrationCounter = 0
			self:SetShooting(true)
			local vm = self.Owner:GetViewModel()
			if tanim then
				local seq = vm:SelectWeightedSequence(tanim)
				self:SetShootingEnd(CurTime()+vm:SequenceDuration( seq ))
			else
				self:SetShootingEnd(CurTime()+vm:SequenceDuration( ))
			end
			if self.BoltAction then
				self:SetBoltTimer(true)
				local t1, t2
				t1=CurTime()+self.BoltTimerOffset
				t2=CurTime()+vm:SequenceDuration( seq )
				if t1<t2 then
					self:SetBoltTimerStart(t1)
					self:SetBoltTimerEnd(t2)
				else
					self:SetBoltTimerStart(t2)
					self:SetBoltTimerEnd(t1)
				end
			end
	
			local CurrentCone, CurrentRecoil = self:CalculateConeRecoil()
			self:Recoil( CurrentRecoil, SERVER or (CLIENT and IsFirstTimePredicted())  )
			
			self:SetSpreadRatio(math.Clamp(self:GetSpreadRatio() + self.Primary.SpreadIncrement, 1, self.Primary.SpreadMultiplierMax))
			if ( CLIENT or game.SinglePlayer() ) and ( IsFirstTimePredicted() ) then
				self.CLSpreadRatio = math.Clamp(self.CLSpreadRatio + self.Primary.SpreadIncrement, 1, self.Primary.SpreadMultiplierMax)
			end
			self:SetBursting(true)
	
			self:SetNextBurst(CurTime()+1/(self:GetRPM()/60))
			self:SetBurstCount(self:GetBurstCount()+1)
			
			self:SetNextPrimaryFire(CurTime()+1/(self:GetRPM()/60))
			
			if !self:GetSilenced() then
				if self.Primary.Sound then
					self:PlaySound(self.Primary.SoundTable and self.Primary.SoundTable or self.Primary.Sound)
				end
			else
				if self.Primary.SilencedSound then
					self:PlaySound(self.Primary.SilencedSound)
				elseif self.Primary.Sound then
					self:PlaySound(self.Primary.SoundTable and self.Primary.SoundTable or self.Primary.Sound)
				end
			end
			
			if self.EjectionSmoke and ( SERVER or (CLIENT and IsFirstTimePredicted() ) )  then
				self:EjectionSmoke()
			end
			
			self:DoAmmoCheck()
		end
end

--[[ 
Function Name:  UserInput
Syntax: self:UserInput().  Call each think on client/server.
Returns:  Nothing.
Notes: Processes raw ironsights, sprinting, etc. before they're corrected in SWEP:IronsSprint()
Purpose:  Main SWEP function
]]--

function SWEP:UserInput()

	if self.Callback.UserInput then
		local val = self.Callback.UserInput(self)
		if val then return val end
	end
	
	self.OldIronsights=(self:GetIronSights())
	local is=false
	if IsValid(self.Owner) then
		if ( (CLIENT and GetConVarNumber("cl_tfa_ironsights_toggle",0)==0) or ( SERVER and self.Owner:GetInfoNum("cl_tfa_ironsights_toggle",0)==0) ) then
			if self.Owner:KeyDown(IN_ATTACK2) then
				is=true
			end
		else
			is=self:GetIronSightsRaw()
			if self.Owner:KeyPressed(IN_ATTACK2) then
				is=!is
			end
		end
	end
	
	if self.data and self.data.ironsights == 0 then
		is=false
	end
	
	self:SetIronSightsRaw(is)
	self:SetIronSights(is)
	self.OldSprinting=(self:GetSprinting())
	local spr=false
	if IsValid(self.Owner) then
		local isnumber = (is and 1 or 0)
		if self.Owner:KeyDown(IN_SPEED) and self.Owner:GetVelocity():Length()>self.Owner:GetWalkSpeed()*(self.MoveSpeed*(1-isnumber)+self.IronSightsMoveSpeed*(isnumber)) then
			spr=true
		end
	end
	
	self:SetSprinting(spr)
end

--[[ 
Function Name:  PlayerThink
Syntax: self:PlayerThink( player ).  Shouldn't be called manually usually, just on each think tick.
Returns:  Nothing.
Notes: Critical to processing the ironsights progress and stuff.
Purpose:  Main SWEP function
]]--

function SWEP:PlayerThink( ply )	

	if !legacy_reloads_cv then legacy_reloads_cv = GetConVar("sv_tfa_reloads_legacy") end
	
	if !vm then vm = self.Owner:GetViewModel() end
	if sp==nil then sp=game.SinglePlayer() end
	
	if !host_timescale_cv then host_timescale_cv = GetConVar("host_timescale") end
	if !sv_cheats_cv then sv_cheats_cv = GetConVar("sv_cheats") end
	
	if self.Callback.PlayerThink then
		local val = self.Callback.PlayerThink(self, ply)
		if val then return val end
	end
	
	heldentindex = self.Owner:GetNWInt("LastHeldEntityIndex",-1)
	heldent = Entity(heldentindex)
	
	if heldentindex!=-1 and IsValid(heldent) and heldent.IsPlayerHolding and !heldent:IsPlayerHolding() then
		self.Owner:SetNWInt("LastHeldEntityIndex",-1)
		heldent = nil
	end
	
	self:Think2()
	
	if SERVER then
		if self.PlayerThinkServer then
			self:PlayerThinkServer(ply)
		end
	end
	
	if CLIENT then
		self:PlayerThinkClient(ply)
	end

	if ply != self:GetOwner() then return end
	
	self:CalculateNearWallSH()
	
	is = self:GetIronSights() and 1 or 0
	insp = self:GetIronSights() and 1 or 0
	
	rel_proc = ( self:GetReloading() ) and !legacy_reloads_cv:GetBool()
	
	if self.Owner.TFACasting or ( self.Owner.tfacastoffset and self.Owner.tfacastoffset>0.1) then rel_proc = true end
	
	rs = ( ( self:GetSprinting() or self:IsSafety() ) and !rel_proc) and 1 or 0 
	
	
	isr=self:GetIronSightsRatio()
	rsr=self:GetRunSightsRatio()
	tsv = 1
	if sv_cheats_cv:GetBool() then tsv = tsv * host_timescale_cv:GetFloat() end
	tsv = tsv * game.GetTimeScale()
	inspr = self:GetInspectingRatio()
	
	if self:GetInspecting() then
		insp = 1
	end
	
	ftv = FrameTime()
	compensatedft = ftv / ( self.IronSightTime * 0.4 )
	compensatedft_sp = ftv / ( ( self.RunSightTime and self.RunSightTime or self.IronSightTime*2 ) * 0.4 )
	compensatedft_cr = ftv / self.ToCrouchTime
	
	
	newratio=math.Approach( isr, is, (is-isr)*compensatedft)
	self:SetIronSightsRatio( newratio )
	newratio=math.Approach( rsr, rs, (rs-rsr)*compensatedft_sp)
	self:SetRunSightsRatio( newratio )
	
	self:SetInspectingRatio( math.Approach( inspr, insp, ftv / self.IronSightTime) )
	
	self:SetCrouchingRatio( math.Approach( self:GetCrouchingRatio(), (self.Owner:Crouching() and 1 or 0), ftv / self.ToCrouchTime) )
	
	jv = !self.Owner:IsOnGround()
	
	self:SetJumpingRatio( math.Approach( self:GetJumpingRatio(), (jv and 1 or 0), ftv / self.ToCrouchTime) )
	
	if self.Primary.SpreadRecovery then
		self:SetSpreadRatio( math.Clamp( self:GetSpreadRatio() - self.Primary.SpreadRecovery*ftv, 1, self.Primary.SpreadMultiplierMax) )
	end
	
end

--[[ 
Function Name:  PlayerThinkServer
Syntax: self:PlayerThinkServer( player ).  Shouldn't be called manually, since it's called by SWEP:PlayerThink().
Returns:  Nothing.
Notes: Unused ATM.
Purpose:  Main SWEP function
]]--

function SWEP:PlayerThinkServer( ply )

	if self.Callback.PlayerThinkServer then
		local val = self.Callback.PlayerThinkServer(self, ply)
		if val then return val end
	end
	
	local nhf = 0
	local vm = ply:GetViewModel()
	
	if (self:GetHolstering()) then
	end
	
	local seq = 0
	local act = -1
	if IsValid(vm) then
		seq = vm:GetSequence()
		act = vm:GetSequenceActivity(act)
	end
	
	if act!=ACT_VM_HOLSTER and act!=ACT_VM_HOLSTER_EMPTY and self:GetHolstering() then
		nhf = 1
	end
	
	self.ProceduralHolsterFactor = math.Approach(self.ProceduralHolsterFactor,nhf,(nhf-self.ProceduralHolsterFactor)*FrameTime()*self.ProceduralHolsterTime*10)
end

--[[ 
Function Name:  PlayerThinkClient
Syntax: self:PlayerThinkClient( player ).  Shouldn't be called manually, since it's called by SWEP:PlayerThink().
Returns:  Nothing.
Notes: Unused ATM.
Purpose:  Main SWEP function
]]--

function SWEP:PlayerThinkClient( ply )

	if self.Callback.PlayerThinkClient then
		local val = self.Callback.PlayerThinkClient(self, ply)
		if val then return val end
	end
	
end

--[[
Function Name:  ProcessEvents
Syntax: self:ProcessEvents( ). 
Returns:  Nothing.
Notes: Critical for the event table to function.
Purpose:  Main SWEP function
]]--

function SWEP:ProcessEvents()
	
	if !self:OwnerIsValid() then return end

	if self.Callback.ProcessEvents then
		local val = self.Callback.ProcessEvents(self)
		if val then return val end
	end
	
	if game.SinglePlayer() and !CLIENT then self:CallOnClient("ProcessEvents","") end
	
	local vm = self.Owner:GetViewModel()
	
	if !IsValid(vm) then return end
	
	local actv = self.lastact--[[vm:GetSequenceActivity(vm:GetSequence())
	
	if actv==ACT_VM_RELOAD and self.SequenceEnabled[ACT_VM_RELOAD_EMPTY] and self:Clip1()==0 and !self:GetSilenced() then
		actv=ACT_VM_RELOAD_EMPTY
	end
	
	if self.BlowbackCurrentRoot>0.1 then
		actv=ACT_VM_PRIMARYATTACK
	end
	]]--

	local evtbl = self.EventTable[actv]
	
	
	
	if !self.lastlastact then
		self.lastlastact = 0
	end
	
	if self.lastlastact != self.lastact then
		self:ResetEvents()
	end
	
	self.lastlastact = self.lastact
	
	if evtbl then
		for k,v in pairs(evtbl) do
			if !v.called then
				if CurTime()>self.EventTimer+v.time then
					
					v.called = true
					
					if v.client == nil then
						v.client = true
					end
					
					if v.type == "lua" then
					
						if v.server == nil then
							v.server = true
						end	
						
						if ( v.client and CLIENT and (!v.client_predictedonly or self.Owner==LocalPlayer()) ) or ( v.server and SERVER ) then						
							if v.value then v.value(self,vm) end
						end
						
					elseif v.type == "snd" or v.type=="sound" then
					
						if v.server == nil then
							v.server = false
						end
						
						if SERVER then
							if v.client then
								net.Start("tfaSoundEvent")
								net.WriteEntity(self)
								net.WriteString(v.value or "")
								if game.SinglePlayer() then net.Broadcast() else net.SendOmit(self.Owner) end
							elseif v.server then
								if v.value and v.value!="" then
									self:EmitSound(v.value)
								end
							end
						end
						
						if CLIENT and v.client and self.Owner==LocalPlayer() and !game.SinglePlayer() then
							if v.value and v.value!="" then
								self:EmitSound(v.value)
							end
						end
						
					end
					
				end
			end
		end
	end
end

--[[ 
Function Name:  PlayerThinkClientFrame
Syntax: self:PlayerThinkClientFrame( player ).  Shouldn't be called manually, since it's called by before each frame.
Returns:  Nothing.
Notes: Critical for the clientside/predicted ironsights.
Purpose:  Main SWEP function
]]--

local rtime,RealFrameTime

function SWEP:PlayerThinkClientFrame( ply )
	
	
	if !legacy_reloads_cv then legacy_reloads_cv = GetConVar("sv_tfa_reloads_legacy") end
	
	if ply != self:GetOwner() then return end
	
	if !vm then vm = self.Owner:GetViewModel() end
	if sp==nil then sp=game.SinglePlayer() end
	
	if !host_timescale_cv then host_timescale_cv = GetConVar("host_timescale") end
	if !sv_cheats_cv then sv_cheats_cv = GetConVar("sv_cheats") end
	
	
	if self.Callback.PlayerThinkClientFrame then
		local val = self.Callback.PlayerThinkClientFrame(self, ply)
		if val then return val end
	end
	
	self.ShouldDrawAmmoHUD=( ply:KeyDown(IN_USE) and ply:KeyDown(IN_RELOAD) ) or self:GetReloading() or self:GetFireModeChanging() or self:GetHUDThreshold() or (self:GetBoltTimer() and CurTime()>self:GetBoltTimerStart() and CurTime()<self:GetBoltTimerEnd() )
	
	self:CalculateNearWallCLF()
	
	self:ViewModelFlipFunc()
	
	
	is = self:GetIronSights() and 1 or 0
	insp = self:GetInspecting() and 1 or 0
	
	rel_proc = ( self:GetReloading() ) and !legacy_reloads_cv:GetBool()
	if self.Owner.TFACasting or ( self.Owner.tfacastoffset and self.Owner.tfacastoffset>0.1) then rel_proc = true end
	
	rs = ( ( self:GetSprinting() or self:IsSafety() ) and !rel_proc) and 1 or 0 
	isr=self.CLIronSightsProgress
	rsr=self.CLRunSightsProgress
	inspr = self.CLInspectingProgress
	tsv = 1
	if sv_cheats_cv:GetBool() then tsv = tsv * host_timescale_cv:GetFloat() end
	tsv = tsv * game.GetTimeScale()
	rtime=RealTime()
	RealFrameTime = rtime-(self.lastrealtime or rtime)
	self.lastrealtime = rtime
	crouchr=self.CLCrouchProgress
	jumpr=self.CLJumpProgress
	ftv = math.max( RealFrameTime, 1/GetConVarNumber("fps_max",120))
	ftvc = tsv*ftv
	seq = 0
	act = -2
	if IsValid(vm) then
		seq = vm:GetSequence()
		act = vm:GetSequenceActivity(seq)
	end
	
	compensatedft = ftv / ( self.IronSightTime * 0.4 )
	compensatedft_sp = ftv / ( ( self.RunSightTime or self.IronSightTime*2 ) * 0.4 )
	compensatedft_cr = ftv / self.ToCrouchTime
	
	newratio=math.Approach( isr, is, (is-isr)*compensatedft)
	self.CLIronSightsProgress = newratio 
	newratio=math.Approach( rsr, rs, (rs-rsr)*compensatedft_sp)
	self.CLRunSightsProgress = newratio 
	newratio=math.Approach( crouchr, self.Owner:Crouching() and 1 or 0, compensatedft_cr)
	self.CLCrouchProgress = newratio 
	newratio=math.Approach( inspr, insp, (insp-inspr)*compensatedft)
	self.CLInspectingProgress = newratio 
	newratio=math.Approach( jumpr, 1 - (self.Owner:IsOnGround() and 1 or 0 ), compensatedft_cr)
	self.CLJumpProgress = newratio
	self.CLSpreadRatio = math.Clamp(self.CLSpreadRatio - self.Primary.SpreadRecovery * ftv, 1, self.Primary.SpreadMultiplierMax)
	self.CLAmmoHUDProgress = math.Approach( self.CLAmmoHUDProgress, (self.ShouldDrawAmmoHUD  or self:GetInspecting()) and 1 or 0, FrameTime() / GetConVarNumber("cl_tfa_hud_ammodata_fadein",0.2) )
	self:DoBobFrame()
	
	if !self.Blowback_PistolMode or self:Clip1()==-1 or self:Clip1()>0.1 or ( self.Blowback_PistolMode_Disabled[act] and act!=-1 and self.lastact!=-2) then
		self.BlowbackCurrent = math.Approach(self.BlowbackCurrent,0,self.BlowbackCurrent*RealFrameTime*15)
	end
	
	self.BlowbackCurrentRoot = math.Approach(self.BlowbackCurrentRoot,0,self.BlowbackCurrentRoot*RealFrameTime*15)
	
	local heldentindex = self.Owner:GetNWInt("LastHeldEntityIndex",-1)
	local heldent = Entity(heldentindex)
	
	if heldentindex!=-1 and IsValid(heldent) and heldent.IsPlayerHolding and !heldent:IsPlayerHolding() then
		self.Owner:SetNWInt("LastHeldEntityIndex",-1)
		heldent = nil
	end
	
	if self:IsHidden() then
		self.Owner:DrawViewModel(false)
		local vmod= self.Owner:GetViewModel()
		if IsValid(vmod) then
			if !self.hiddenHasYetToStopParticles then
				vmod:StopParticles()
				self.hiddenHasYetToStopParticles = true
			end
		end
	else
		if self.hiddenHasYetToStopParticles then
			self.hiddenHasYetToStopParticles = false
		end
		self.Owner:DrawViewModel(true)	
	end
	
	local nhf = 0
	
	if act!=ACT_VM_HOLSTER and act!=ACT_VM_HOLSTER_EMPTY and self:GetHolstering() then
		nhf = 1
	end
	
	self.ProceduralHolsterFactor = math.Approach(self.ProceduralHolsterFactor,nhf,(nhf-self.ProceduralHolsterFactor)*FrameTime()*self.ProceduralHolsterTime*10)
end

--[[ 
Function Name:  SecondaryAttack
Syntax: self:SecondaryAttack( ).
Returns:  Not sure that it returns anything.
Notes: Unused.  We process ironsights elsewhere.
Purpose:  Main SWEP function
]]--

function SWEP:SecondaryAttack()

	if self.Callback.SecondaryAttack then
		local val = self.Callback.SecondaryAttack(self)
		if val then return val end
	end
	return false
end

--[[ 
Function Name:  AltAttack
Syntax: self:AltAttack( ).
Returns:  Not sure that it returns anything.
Notes: This is called when you do +zoom
Purpose:  Main SWEP function
]]--

function SWEP:AltAttack()
--[[
	if self.Callback.AltAttack then
		local val = self.Callback.AltAttack(self)
		if val then return val end
	end
	
	return false
	]]--
end

--[[ 
Function Name:  CanCKeyInspect
Syntax: self:CanCKeyInspect( ).
Returns:  true/false.
Notes:  Can we do R-key inspection?
Purpose:  
]]--

local ckeyvar

function SWEP:CanCKeyInspect()
	if !ckeyvar then
		ckeyvar = GetConVar("cl_tfa_inspection_ckey")
	end
	if ckeyvar and CLIENT then
		if ckeyvar:GetBool() then return true end
	end
	if SERVER then
		if self:OwnerIsValid() then
			if self.Owner:GetInfoNum("cl_tfa_inspection_ckey",-1)==1 then return true end
		end
	end
	return false
end

--[[ 
Function Name:  Reload
Syntax: self:Reload( ).
Returns:  Not sure that it returns anything.
Notes:  This reloads the gun, and the way it does so is slightly hacky and depends on holdtype.  Revolvers should be the only guns using revolver holdtype for this to properly function.
Purpose:  Main SWEP function
]]--

function SWEP:Reload()

	if !legacy_reloads_cv then legacy_reloads_cv = GetConVar("sv_tfa_reloads_legacy") end

	if self.Callback.Reload then
		local val = self.Callback.Reload(self)
		if val then return val end
	end
	
	self:SetBurstCount(0)
	self:SetBursting(false)
	self:SetNextBurst(CurTime()-1)
	
	if self:GetReloading() then return end
	
	if (isbolttimer) and (CurTime()>self:GetBoltTimerStart()) and (CurTime()<self:GetBoldTimerEnd()) then
		return
	end
	
	if  ( GetConVarNumber("sv_tfa_allow_dryfire",1)==1 ) then
		if not self.Owner:KeyDown(IN_RELOAD) then
			local s, tanim = self:ChooseDryFireAnim()
			return
		end
	end
	
	
	if not ( self.Owner:KeyDown(IN_RELOAD) or self.Owner:KeyPressed(IN_ATTACK) ) then
		return
	end
	
	
	if (self:GetBursting()) then
		return
	end
	
	--if self.SelectiveFire then
		if IsValid(self.Owner) and self.Owner:KeyDown(IN_USE) then
			return
		end
	--end
	
	if self.AllowReloadWhileNearWall==false then
		if self:GetNearWallRatio()>0.05 then
			return
		end
	end
	
	if ( self:GetHolstering() ) then
		if (self.AllowReloadWhileHolster==false) then
			return
		else
			self:SetHolsteringEnd(CurTime()-0.1)
			self:SetHolstering(false)
		end
	end
	
	if (self:GetDrawing() ) and self.AllowReloadWhileDraw==false then
		return
	end
	
	if (self:GetSprinting() ) and ( !self.AllowReloadWhileSprinting and legacy_reloads_cv:GetBool() ) then
		return
	end
	
	if (CurTime()<self:GetReloadingEnd()) then
		self:SetReloadingEnd(CurTime()-1)
	end
	
	if (self:GetChangingSilence()) then return end
	
	if self.Primary.ClipSize==-1 then return end
	
	if ( self:Clip1() < (self.Primary.ClipSize + ( self:CanChamber() and 1 or 0 ) * (self.Akimbo and 2 or 1)  ) and self.Owner:GetAmmoCount( self.Primary.Ammo ) > 0 ) then
		
		self:SetFidgeting(false)
		self:SetReloading(true)
		
		--self:ProcessTimers()
	
		if self.UnSightOnReload then
			self:SetIronSights(false)
		end
		
		self:ProcessHoldType()
		
		self:SetInspecting(false)
		--self:SetInspectingRatio(0)
		
		--self:DefaultReload( ACT_VM_RELOAD )
		
		local success, tanim
		
		if !self.Shotgun then
			success, tanim = self:ChooseReloadAnim()
		else
			success, tanim = self:ChooseShotgunReloadAnim()
			self:SetShotgunInsertingShell(false)
			self:SetShotgunPumping(false)
		end
		
		timer.Simple(0, function()
			if !IsValid(self) or !self:OwnerIsValid() then return end
			self:SetHoldType(self.DefaultHoldType and self.DefaultHoldType or self.HoldType)
			if !self.ThirdPersonReloadDisable and ( SERVER or ( CLIENT and !self:IsFirstPerson()  ) )  then
				self.Owner:SetAnimation( PLAYER_RELOAD ) -- 3rd Person Animation
			end
		end)
		
		if (CLIENT) then
			timer.Simple(0, function()
				if !IsValid(self) or !self:OwnerIsValid() then return end
				if !self.ThirdPersonReloadDisable and ( SERVER or ( CLIENT and !self:IsFirstPerson()  ) ) then
					self.Owner:SetAnimation( PLAYER_RELOAD ) -- 3rd Person Animation
				end
			end)
		end
		local AnimationTime = self.Owner:GetViewModel():SequenceDuration()
		local dt = CurTime() + ( self.SequenceLengthOverride[tanim] or ( AnimationTime ) )
		self.prevdrawcount=self.drawcount
		self:SetReloadingEnd(dt)
		self.ReloadingTime = dt
		self:SetNextPrimaryFire( dt )
		self:SetNextSecondaryFire( dt )
		self:SetNextIdleAnim(CurTime() + AnimationTime)
		
	elseif !self:CanCKeyInspect() and self.SequenceEnabled[ACT_VM_FIDGET] and !self:GetIronSights() and !self:GetSprinting() and !self:GetFidgeting() and !self:GetInspecting() then
		if self:Clip1()>=1 then
			self:SetFidgeting(true)
			self:SetNextIdleAnim(-1)
		end
	end	
end

--[[ 
Function Name:  Sway
Syntax: self:Sway( ang ).
Returns:  New angle.
Notes:  This is used for calculating the swep viewmodel sway.
Purpose:  Main SWEP function
]]--

local oldang = Angle()
local anga = Angle()
local angb = Angle()
local angc = Angle()
local posfac = 0.75

local gunswaycvar = GetConVar("cl_tfa_gunbob_intensity")

function SWEP:Sway(pos,ang)

	if !self:OwnerIsValid() then return pos,ang end
	
	ang:Normalize()
	
	if !self.timescale_cv then self.timescale_cv = GetConVar("host_timescale") end
	if !self.cheat_cv then self.cheat_cv = GetConVar("sv_cheats") end
	
	local ft = ( SysTime() - ( self.LastSys or SysTime() ) )*game.GetTimeScale()
	
	if ft>FrameTime() then ft = FrameTime() end
	
	ft = math.Clamp(ft,0,1/30)
	
	if self.cheat_cv and self.timescale_cv and self.cheat_cv:GetBool() then ft = ft * self.timescale_cv:GetFloat() end
	
	self.LastSys = SysTime()
	--angrange = our availalbe ranges
	--rate = rate to restore our angle to the proper one
	--fac = factor to multiply by
	--each is interpolated from normal value to the ironsights value using iron sights ratio
	
	local angrange = Lerp(self:GetIronSightsRatio(),7.5,2.5) * gunswaycvar:GetFloat()
	local rate = Lerp(self:GetIronSightsRatio(),15,30)
	local fac = Lerp(self:GetIronSightsRatio(),0.6,0.15)
	
	--calculate angle differences
	
	anga = self.Owner:EyeAngles() - oldang
	oldang = self.Owner:EyeAngles()
	
	angb.y = angb.y + (0-angb.y)*ft*5
	angb.p = angb.p + (0-angb.p)*ft*5
	
	--fix jitter
	
	if angb.y < 50 and anga.y > 0 and anga.y < 25 then angb.y = angb.y + anga.y/5 end
	if angb.y > -50 and anga.y < 0 and anga.y > -25 then angb.y = angb.y + anga.y/5 end
	if angb.p < 50 and anga.p < 0 and anga.p < 25 then angb.p = angb.p - anga.p/5 end
	if angb.p > -50 and anga.p > 0 and anga.p > -25 then angb.p = angb.p - anga.p/5 end
	
	--limit range
	
	angb.p = math.Clamp(angb.p,-angrange,angrange)
	angb.y = math.Clamp(angb.y,-angrange,angrange)
	
	--recover
	
	angc.y = angc.y + (angb.y/15 - angc.y)*ft*rate
	angc.p = angc.p + (angb.p/15 - angc.p)*ft*rate
	
	--finally, blend it into the angle
	
	ang:RotateAroundAxis(oldang:Up(),angc.y*15*(self.ViewModelFlip and -1 or 1)*fac)
	ang:RotateAroundAxis(oldang:Right(),angc.p*15*fac)
	ang:RotateAroundAxis(oldang:Forward(),angc.y*10*fac)
	
	pos:Add( oldang:Right() * angc.y*posfac )
	pos:Add( oldang:Up() * -angc.p*posfac )
	
	return pos,util_NormalizeAngles(ang)
end

--[[ 
Function Name:  GetViewModelPosition
Syntax: self:GetViewModelPosition(pos, ang ).
Returns:  New position and angle.
Notes:  This is used for calculating the swep viewmodel position.  However, don't put per-frame logic in this.  Instead do that in PlayerThinkClientFrame
Purpose:  Main SWEP function
]]--

local cl_tfa_viewmodel_offset_x = GetConVar("cl_tfa_viewmodel_offset_x")
local cl_tfa_viewmodel_offset_y = GetConVar("cl_tfa_viewmodel_offset_y")
local cl_tfa_viewmodel_offset_z = GetConVar("cl_tfa_viewmodel_offset_z")
local fovmod_add = GetConVar("cl_tfa_viewmodel_offset_fov")
local fovmod_mult = GetConVar("cl_tfa_viewmodel_multiplier_fov")
	
local ang2=Angle()
local ang3=Angle()
local ang4=Angle()
local ang5=Angle()

local hidevec = Vector(0,0,-10000)

function SWEP:GetViewModelPosition(pos, ang)

	if self.Callback.GetViewModelPosition then
		local val,val2 = self.Callback.GetViewModelPosition(self, pos, ang)
		if val then return val,val2 end
	end
	--[[
	
	ang:Normalize()
	
	if !self.OldAng then
		self.OldAng = ang
	end
	
	
	local newang = ang * 1
	
	ang.p = math.Approach(self.OldAng.p,ang.p, (ang.p - self.OldAng.p) * FrameTime() * 15)
	ang.y = math.Approach(self.OldAng.y,ang.y, (ang.y - self.OldAng.y) * FrameTime() * 15)
	ang.r = math.Approach(self.OldAng.r,ang.r, (ang.r - self.OldAng.r) * FrameTime() * 15)
	
	self.OldAng = ang
	
	]]--
	
	if !self.ogviewmodelfov then self.ogviewmodelfov = self.ViewModelFOV end
	
	
	local vmfov = self.ogviewmodelfov * fovmod_mult:GetFloat()
	vmfov = vmfov + fovmod_add:GetFloat()
	self.ViewModelFOV = vmfov
	
	
	pos,ang = self:Sway(pos,ang)
	
	if self:IsHidden() then return pos + hidevec end
	
	local isp=math.Clamp(self.CLIronSightsProgress,0,1)--self:GetIronSightsRatio()
	local rsp=math.Clamp(self.CLRunSightsProgress,0,1)--self:GetRunSightsRatio()
	local nwp=math.Clamp(self.CLNearWallProgress,0,1)--self:GetNearWallRatio()
	local inspectrat=math.Clamp(self.CLInspectingProgress,0,1)--self:GetInspectingRatio()
	local tmp_ispos = self.SightsPos and self.SightsPos or self.IronSightsPos
	local tmp_isa = self.SightsAng and self.SightsAng or self.IronSightsAng
	local tmp_rspos = self.RunSightsPos and self.RunSightsPos or tmp_ispos
	local tmp_rsa  = self.RunSightsAng and self.RunSightsAng or tmp_isa
	
	if !self.InspectPos then
		self.InspectPos = self.InspectPosDef * 1
		if self.ViewModelFlip then
			self.InspectPos.x= self.InspectPos.x * -1
		end
	end
	
	if ! self.InspectAng then
		self.InspectAng = self.InspectAngDef * 1
		
		if self.ViewModelFlip then
			self.InspectAng.x= self.InspectAngDef.x * 1
			self.InspectAng.y= self.InspectAngDef.y * -1
			self.InspectAng.z= self.InspectAngDef.z * -1
		end
		
	end
	
	local tmp_inspectpos = self.InspectPos
	
	local tmp_inspecta  = self.InspectAng
	
	local opos=pos*1
	
	if tmp_isa==nil then 
		return
	end
	
	ang:RotateAroundAxis(ang:Right(), 		self.VMAng.x)
	 --The viewmodel angular offset, constantly. 
	ang:RotateAroundAxis(ang:Up(), 		self.VMAng.y)
	ang:RotateAroundAxis(ang:Forward(), 	self.VMAng.z)
	
	ang:Normalize()
	
	ang2.p = ang.p
	ang3.p = ang.p
	ang4.p = ang.p
	ang5.p = ang.p
	ang2.y = ang.y
	ang3.y = ang.y
	ang4.y = ang.y
	ang5.y = ang.y
	ang2.r = ang.r
	ang3.r = ang.r
	ang4.r = ang.r
	ang5.r = ang.r
	
	--[[
	self.SwayScale 	= Lerp(isp,1,self.IronBobMult)
	self.SwayScale  = Lerp(rsp,self.SwayScale,self.SprintBobMult)
	]]--
	
	--self.BobScale 	= Lerp(isp,1,self.IronBobMult)
	--self.BobScale  = Lerp(rsp,self.BobScale,self.SprintBobMult)
	self.BobScale = 0 
	self.SwayScale = 0
	
	local mvfac = self.Owner:GetVelocity():Length()/self.Owner:GetRunSpeed()
	
	self.BobScaleCustom 	= Lerp(isp,1,Lerp(mvfac,self.IronBobMult,self.IronBobMultWalk))
	self.BobScaleCustom  = Lerp(rsp,self.BobScaleCustom,self.SprintBobMult)
	self.BobScaleCustom  = Lerp(self.CLInspectingProgress,self.BobScaleCustom,0.2)
	
	ang2:RotateAroundAxis(ang2:Right(), 		tmp_isa.x)
	ang2:RotateAroundAxis(ang2:Up(), 		tmp_isa.y)
	ang2:RotateAroundAxis(ang2:Forward(), 	tmp_isa.z)
	
	ang=QerpAngle(isp, ang, ang2)
	
	ang3:RotateAroundAxis(ang3:Right(), 		tmp_rsa.x)
	ang3:RotateAroundAxis(ang3:Up(), 		tmp_rsa.y)
	ang3:RotateAroundAxis(ang3:Forward(), 	tmp_rsa.z)
	
	ang=QerpAngle(rsp, ang, ang3)
	
	local tmp_nwsightsang = tmp_rsa
	if self.NearWallSightsAng then
		tmp_nwsightsang = self.NearWallSightsAng
	end
	
	ang4:RotateAroundAxis(ang4:Right(), 		tmp_nwsightsang.x)
	ang4:RotateAroundAxis(ang4:Up(), 		tmp_nwsightsang.y)
	ang4:RotateAroundAxis(ang4:Forward(), 	tmp_nwsightsang.z)
	
	ang=QerpAngle(nwp, ang, ang4)
	
	ang5:RotateAroundAxis(ang5:Right(), 		tmp_inspecta.x)
	ang5:RotateAroundAxis(ang5:Up(), 		tmp_inspecta.y)
	ang5:RotateAroundAxis(ang5:Forward(), 	tmp_inspecta.z)
	
	ang=QerpAngle(inspectrat, ang, ang5)
	
	opos:Add( ang:Right() * (self.VMPos.x) )
	opos:Add( ang:Forward() * (self.VMPos.y) )
	opos:Add( ang:Up() * (self.VMPos.z) )
	
	pos:Add( ang:Right() * (self.VMPos.x) )
	pos:Add( ang:Forward() * (self.VMPos.y) )
	pos:Add( ang:Up() * (self.VMPos.z) )
	
	target = pos * 1 -- Copy pos to target
	target:Add( ang:Right() * (tmp_ispos.x) )
	target:Add( ang:Forward() * (tmp_ispos.y) )
	target:Add( ang:Up() * (tmp_ispos.z) )
		
	pos=QerpVector( isp, pos, target)
	
	target = pos * 1 -- Copy pos to target
	target:Add( ang:Right() * (tmp_rspos.x) )
	target:Add( ang:Forward() * (tmp_rspos.y) )
	target:Add( ang:Up() * (tmp_rspos.z) )
		
	pos=QerpVector( rsp, pos, target)
	
	local tmp_nwsightspos = tmp_rspos
	if self.NearWallSightsPos then
		tmp_nwsightspos = self.NearWallSightsPos
	end
	
	target = opos * 1 -- Copy pos to target
	target:Add( ang:Right() * (tmp_nwsightspos.x) )
	target:Add( ang:Forward() * (tmp_nwsightspos.y) )
	target:Add( ang:Up() * (tmp_nwsightspos.z) )
		
	pos=QerpVector( nwp, pos, target)
	
	target = opos * 1 -- Copy pos to target
	target:Add( ang:Right() * (tmp_inspectpos.x) )
	target:Add( ang:Forward() * (tmp_inspectpos.y) )
	target:Add( ang:Up() * (tmp_inspectpos.z) )
		
	pos=QerpVector( inspectrat, pos, target)
	
	if self.BlowbackEnabled then
		--if !(  self.Blowback_PistolMode and !( self:Clip1()==-1 or self:Clip1()>0 ) ) then
			pos:Add( ang:Right() * (self.BlowbackVector.x) * self.BlowbackCurrentRoot )
			pos:Add( ang:Forward() * (self.BlowbackVector.y) * self.BlowbackCurrentRoot )
			pos:Add( ang:Up() * (self.BlowbackVector.z) * self.BlowbackCurrentRoot)
		--end
	end
	
	--Start viewbob code
	
	local gunbobintensity = GetConVarNumber("cl_tfa_gunbob_intensity",1) * 0.65 * 0.66
	
	pos, ang = self:CalculateBob( pos, ang, gunbobintensity)
	
	local qerp1 = Lerp(self.CLIronSightsProgress and self.CLIronSightsProgress or 0,0,self.ViewModelFlip and 1 or -1)*15
	
	if !ang then return end 
	
	ang:RotateAroundAxis(ang:Forward(),-Qerp(self.CLIronSightsProgress and self.CLIronSightsProgress or 0,qerp1,0))
	
	--End viewbob code
	
	--Start scope compensation code
	
	if self.CLIronSightsProgress > self.ScopeOverlayThreshold and self.Scoped then
		--pos:Add( ang:Up() * (-10) )
	end
	
	pos:Add(ang:Right() * cl_tfa_viewmodel_offset_x:GetFloat() * (1-isp) * (self.ViewModelFlip and -1 or 1) )
	pos:Add(ang:Forward() * cl_tfa_viewmodel_offset_y:GetFloat() * (1-isp) )
	pos:Add(ang:Up() * cl_tfa_viewmodel_offset_z:GetFloat() * (1-isp) )
	
	if self:GetDrawing() then
		self.ProceduralHolsterFactor = 0
	end
	
	pos:Add(ang:Right() * self.ProceduralHolsterFactor * self.ProceduralHolsterPos.x * (self.ViewModelFlip and -1 or 1) )
	pos:Add(ang:Forward() * self.ProceduralHolsterFactor * self.ProceduralHolsterPos.y )
	pos:Add(ang:Up() * self.ProceduralHolsterFactor * self.ProceduralHolsterPos.z )
	
	ang:RotateAroundAxis(ang:Right(), self.ProceduralHolsterFactor * self.ProceduralHolsterAng.x )
	ang:RotateAroundAxis(ang:Up(), self.ProceduralHolsterFactor * self.ProceduralHolsterAng.y * (self.ViewModelFlip and -1 or 1) )
	ang:RotateAroundAxis(ang:Forward(), self.ProceduralHolsterFactor * self.ProceduralHolsterAng.z * (self.ViewModelFlip and -1 or 1) )
	
	ang:Normalize()
	
	return pos, ang 
end

--[[ Generic Backend Functions  ]]--

function SWEP:GetPrimaryAmmoType() 
	return self.PRimary.Ammo and self.Primary.Ammo or ""
end

--[[ 
Function Name:  CalculateConeRecoil
Syntax: self:CalculateConeRecoil().
Returns:  Spray cone, Recoil
Notes:  This is serverside/shared.  For per-frame, like used for the HUD, use ClientCalculateConeRecoil
Purpose:  Main SWEP function
]]--

function SWEP:CalculateConeRecoil()

	if self.Callback.CalculateConeRecoil then
		local val,val2 = self.Callback.CalculateConeRecoil(self)
		if val then return val,val2 end
	end
	
	if !IsValid(self) then return 0, 0 end
	if !IsValid(self.Owner) then return 0, 0 end
	local CurrentRecoil
	local CurrentCone
	local basedamage
	local tmpiron=self:GetIronSights()
	local dynacc = false 
	local isr=self:GetIronSightsRatio()
	
	if GetConVarNumber("sv_tfa_dynamicaccuracy",1)==1 and ( !(self.Primary.NumShots>1) ) then
		dynacc=true
	end
	
	local isr_1=math.Clamp(isr*2,0,1)
	local isr_2=math.Clamp((isr-0.5)*2,0,1)
	
	local acv = self.Primary.Spread or self.Primary.Accuracy
	local recv = self.Primary.Recoil * 5
	
	if dynacc then
		CurrentCone = Lerp( isr_2, Lerp(isr_1, acv, acv*self.ChangeStateAccuracyMultiplier) , self.Primary.IronAccuracy)
		CurrentRecoil = Lerp( isr_2, Lerp(isr_1, recv, recv*self.ChangeStateRecoilMultiplier) , recv*self.IronRecoilMultiplier)
	else
		CurrentCone = Lerp(isr,acv,self.Primary.IronAccuracy)
		CurrentRecoil = Lerp(isr,recv,recv*self.IronRecoilMultiplier)
	end
	
	local crc_1=math.Clamp(self:GetCrouchingRatio()*2,0,1)
	local crc_2=math.Clamp((self:GetCrouchingRatio()-0.5)*2,0,1)
	
	if dynacc then
		CurrentCone = Lerp( crc_2, Lerp(crc_1, CurrentCone, CurrentCone*self.ChangeStateAccuracyMultiplier) , CurrentCone * self.CrouchAccuracyMultiplier)
		CurrentRecoil = Lerp( crc_2, Lerp(crc_1, CurrentRecoil, self.Primary.Recoil*self.ChangeStateRecoilMultiplier) , CurrentRecoil * self.CrouchRecoilMultiplier)
	end
	
	local ovel = self.Owner:GetVelocity():Length()
	local vfc_1 = math.Clamp(ovel/180,0,1)
	
	if dynacc then
		CurrentCone = Lerp( vfc_1, CurrentCone, CurrentCone * self.WalkAccuracyMultiplier )
		CurrentRecoil = Lerp( vfc_1, CurrentRecoil, CurrentRecoil * self.WallRecoilMultiplier )
	end
	
	local jr = self:GetJumpingRatio()
	
	if dynacc then
		CurrentCone = Lerp(jr, CurrentCone, CurrentCone * self.JumpAccuracyMultiplier)
		CurrentRecoil = Lerp(jr, CurrentRecoil, CurrentRecoil * self.JumpRecoilMultiplier)
	end
	
	CurrentCone = CurrentCone * self:GetSpreadRatio()
	
	return CurrentCone, CurrentRecoil
end

--[[ 
Function Name:  ClientCalculateConeRecoil
Syntax: self:ClientCalculateConeRecoil().
Returns:  Spray cone, Recoil
Notes:  This is clientside and should only be called there.
Purpose:  Main SWEP function
]]--

function SWEP:ClientCalculateConeRecoil()
	if !IsValid(self) then return 0, 0 end
	if !IsValid(self.Owner) then return 0, 0 end

	if self.Callback.ClientCalculateConeRecoil then
		local val,val2 = self.Callback.ClientCalculateConeRecoil(self)
		if val then return val,val2 end
	end
	
	local CurrentRecoil
	local CurrentCone
	local basedamage
	local tmpiron=self:GetIronSights()
	local dynacc = false 
	local isr=self.CLIronSightsProgress
	
	if GetConVarNumber("sv_tfa_dynamicaccuracy",1)==1 and ( !(self.Primary.NumShots>1) ) then
		dynacc=true
	end
	
	local isr_1=math.Clamp(isr*2,0,1)
	local isr_2=math.Clamp((isr-0.5)*2,0,1)
	
	local acv = self.Primary.Spread or self.Primary.Accuracy
	local recv = self.Primary.Recoil * 5
	
	if dynacc then
		CurrentCone = Lerp( isr_2, Lerp(isr_1, acv, acv*self.ChangeStateAccuracyMultiplier) , self.Primary.IronAccuracy)
		CurrentRecoil = Lerp( isr_2, Lerp(isr_1, recv, recv*self.ChangeStateRecoilMultiplier) , recv*self.IronRecoilMultiplier)
	else
		CurrentCone = Lerp(isr,acv,self.Primary.IronAccuracy)
		CurrentRecoil = Lerp(isr,recv,recv*self.IronRecoilMultiplier)
	end
	
	local crc_1=math.Clamp(self.CLCrouchProgress*2,0,1)
	local crc_2=math.Clamp((self.CLCrouchProgress-0.5)*2,0,1)
	
	if dynacc then
		CurrentCone = Lerp( crc_2, Lerp(crc_1, CurrentCone, CurrentCone*self.ChangeStateAccuracyMultiplier) , CurrentCone * self.CrouchAccuracyMultiplier)
		CurrentRecoil = Lerp( crc_2, Lerp(crc_1, CurrentRecoil, self.Primary.Recoil*self.ChangeStateRecoilMultiplier) , CurrentCone * self.CrouchRecoilMultiplier)
	end
	
	local ovel = self.Owner:GetVelocity():Length()
	local vfc_1 = math.Clamp(ovel/180,0,1)
	
	if dynacc then
		CurrentCone = Lerp( vfc_1, CurrentCone, CurrentCone * self.WalkAccuracyMultiplier )
		CurrentRecoil = Lerp( vfc_1, CurrentRecoil, CurrentRecoil * self.WallRecoilMultiplier )
	end
	
	local jr = self.CLJumpProgress
	
	if dynacc then
		CurrentCone = Lerp(jr, CurrentCone, CurrentCone * self.JumpAccuracyMultiplier)
		CurrentRecoil = Lerp(jr, CurrentRecoil, CurrentRecoil * self.JumpRecoilMultiplier)
	end
	
	CurrentCone = CurrentCone * self.CLSpreadRatio
	
	return CurrentCone, CurrentRecoil
end

--[[ 
Function Name:  CalculateNearWallSH
Syntax: self:CalculateNearWallSH().
Returns:  Nothing.  However, calculates nearwall for the server.
Notes:  This is the server/shared equivalent of CalculateNearWallCLF.
Purpose:  Feature
]]--

function SWEP:CalculateNearWallSH()

	if !IsValid(self.Owner) then return end

	if self.Callback.CalculateNearWallSH then
		local val = self.Callback.CalculateNearWallSH(self)
		if val then return val end
	end
	
	local vnearwall
	
	vnearwall=false
	
	local tracedata = {}
	tracedata.start=self.Owner:GetShootPos()
	tracedata.endpos=tracedata.start+self.Owner:EyeAngles():Forward()*self.WeaponLength
	tracedata.mask=MASK_SHOT
	tracedata.ignoreworld=false
	tracedata.filter=self.Owner
	local traceres=util.TraceLine(tracedata)
	if traceres.Hit then
		if traceres.Fraction>0 and traceres.Fraction<1 then
			if traceres.MatType!=MAT_FLESH and traceres.MatType!=MAT_GLASS and !( IsValid(traceres.Entity) and traceres.Entity:IsNPC() )then
				vnearwall = true
			end
		end
	end
	
	if GetConVarNumber("sv_tfa_near_wall",1)==0 then
		vnearwall = false
	end
	
	if self.Owner.GetBashing and self.Owner:GetBashing() then vnearwall=false end
	
	self:SetNearWallRatio( math.Approach( self:GetNearWallRatio(), vnearwall and 1 or 0 , FrameTime() / self.NearWallTime ) )
	
end

--[[ 
Function Name:  CalculateNearWallCLF
Syntax: self:CalculateNearWallCLF().  This is called per-frame.
Returns:  Nothing.  However, calculates nearwall for the client.
Notes:  This is clientside only.
Purpose:  Feature
]]--

function SWEP:CalculateNearWallCLF()

	if !( CLIENT or game.SinglePlayer() ) then return end
	if !IsValid(self.Owner) then return end

	if self.Callback.CalculateNearWallCLF then
		local val = self.Callback.CalculateNearWallCLF(self)
		if val then return val end
	end
	
	local vnearwall
	
	vnearwall=false
	local tracedata = {}
	tracedata.start=self.Owner:GetShootPos()
	tracedata.endpos=tracedata.start+self.Owner:EyeAngles():Forward()*self.WeaponLength
	tracedata.mask=MASK_SHOT
	tracedata.ignoreworld=false
	tracedata.filter=self.Owner
	local traceres=util.TraceLine(tracedata)
	if traceres.Hit then
		if traceres.Fraction>0 and traceres.Fraction<1 then
			if traceres.MatType!=MAT_FLESH and traceres.MatType!=MAT_GLASS and !( IsValid(traceres.Entity) and traceres.Entity:IsNPC() )then
				vnearwall = true
			end
		end
	end
	
	if GetConVarNumber("sv_tfa_near_wall",1)==0 then
		vnearwall = false
	end
	
	if self.Owner.GetBashing and self.Owner:GetBashing() then vnearwall=false end
	
	self.CLNearWallProgress =  math.Approach( self.CLNearWallProgress, vnearwall and 1 or 0 , FrameTime() / self.NearWallTime )
end

--[[ 
Function Name:  IronsSprint
Syntax: self:IronsSprint().  This is called per-think.
Returns:  Nothing. 
Notes:  This corrects ironsights so that you can't sight and sprint at the same time, etc.
Purpose:  Feature.
]]--

function SWEP:IronsSprint()

	if self.Callback.IronsSprint then
		local val = self.Callback.IronsSprint(self)
		if val then return val end
	end
	
	if !self:OwnerIsValid() then return end
	
	local is,oldis,spr, rld, dr, hl, nw, isbolttimer, insp, fidg, shooting,seq,act,vm
	spr=self:GetSprinting()
	is=self:GetIronSights()
	oldis=self.OldIronsights
	rld=self:GetReloading()
	dr=self:GetDrawing()
	hl=self:GetHolstering()
	insp = self:GetInspecting()
	ischangingsilence = self:GetChangingSilence()
	isbolttimer = self:GetBoltTimer()
	shooting = self:GetShooting()
	nw = false
	fidg = self:GetFidgeting()
	vm = self.Owner:GetViewModel()
	seq = vm:GetSequence()
	act = vm:GetSequenceActivity(seq or 0)
	
	if act==ACT_VM_HOLSTER or act==ACT_VM_HOLSTER_EMPTY or self.ProceduralHolsterFactor>0.5 or self.IsHolding then hl = true end
	
	if self.Owner.TFACasting or ( self.Owner.tfacastoffset and self.Owner.tfacastoffset>0.1) then spr = false end
	
	if self:Clip1() ==  0 and (GetConVarNumber("sv_tfa_allow_dryfire",1)==0) then
		if self:GetBursting() then
			self:SetBursting(false)
			self:SetNextBurst(CurTime() - 1)
			self:SetBurstCount(0)
		end
	elseif self:Clip1() < 0 and IsValid(self.Owner) and self:GetAmmoReserve()<=0 and (GetConVarNumber("sv_tfa_allow_dryfire",1)==0) then
		if self:GetBursting() then
			self:SetBursting(false)
			self:SetNextBurst(CurTime() - 1)
			self:SetBurstCount(0)
		end
	end
		
	if self:GetNearWallRatio()>0.01 then
		nw = true
	end
	
	if (self.IsHolding) then
		is=false
	end
	
	if (isbolttimer) and (CurTime()>self:GetBoltTimerStart()) and (CurTime()<self:GetBoltTimerEnd()) then
		is=false	
	end
	
	if (spr) then
		is=false
		insp = false
		self:SetInspecting(false)
		self:SetBursting(false)
		self:SetNextBurst(CurTime() - 1)
		self:SetBurstCount(0)
	end
	
	if (is) then
		if fidg then self:ChooseIdleAnim() self:SetFidgeting(false) end
	end
	
	if (shooting) then
		if fidg then self:SetFidgeting(false) end
	end
	
	if (insp) then
		is = false
	end
	
	if ( self:IsSafety() ) then
		is=false
		self:SetInspecting(false)
		self:SetBursting(false)
		self:SetNextBurst(CurTime() - 1)
		self:SetBurstCount(0)
	end
	
	if (ischangingsilence) then
		is=false
		self:SetBursting(false)
		self:SetNextBurst(CurTime() - 1)
		self:SetBurstCount(0)
	end
	
	if self.UnSightOnReload then
		if (rld) then
			is=false
			self:SetInspecting(false)
			self:SetInspectingRatio(0)
		end
	end
		
	if (dr) then
		if !self.SightWhileDraw then
			self:SetInspecting(false)
			self:SetInspectingRatio(0)
			is=false
			if fidg then self:SetFidgeting(false) end
		end
	end
		
	if (hl) then
		self:SetInspecting(false)
		self:SetInspectingRatio(0)
		self:SetBursting(false)
		if !self.SightWhileHolster then
			is=false
		end
		if fidg then self:SetFidgeting(false) end
	end
	
	if (nw) then
		is=false
		self:SetInspecting(false)
		self:SetBursting(false)
		if fidg then self:ChooseIdleAnim() self:SetFidgeting(false) end
	end
	
	if (oldis!=is) and ( ( CLIENT and IsFirstTimePredicted() ) or ( SERVER and game.SinglePlayer() ) ) then
		if (is==false) then
			self:EmitSound("TFA.IronOut")
		else
			self:EmitSound("TFA.IronIn")
		end
	end
	
	self:SetIronSights(is)
	self:SetSprinting(spr)
	if ( (CLIENT and GetConVarNumber("cl_tfa_ironsights_resight",0)==0) or ( SERVER and self.Owner:GetInfoNum("cl_tfa_ironsights_resight",0)==0) ) then
		self:SetIronSightsRaw(is)
	end
end

--[[ 
Function Name:  ProcessHoldType
Syntax: self:ProcessHoldType().  This is called per-think.
Returns:  Nothing. 
Notes:  This calculates your holdtype.
Purpose:  Feature.
]]--

local dynholdtypecvar = GetConVar("sv_tfa_holdtype_dynamic",1)

function SWEP:ProcessHoldType()

	if self.Callback.ProcessHoldType then
		local val = self.Callback.ProcessHoldType(self)
		if val then return val end
	end
	
	if !self.DefaultHoldType then self.DefaultHoldType = self.HoldType or "ar2" end
	if !self.SprintHoldType then
		self.SprintHoldType = self.SprintHoldTypes[self.DefaultHoldType] or "passive"
		if self.SprintHoldTypeOverride and self.SprintHoldTypeOverride!="" then
			self.SprintHoldType = self.SprintHoldTypeOverride
		end
	end
	if !self.IronHoldType then
		self.IronHoldType = self.IronSightHoldTypes[self.DefaultHoldType] or "rpg"
		if self.IronSightHoldTypeOverride and self.IronSightHoldTypeOverride!="" then
			self.IronHoldType = self.IronSightHoldTypeOverride
		end
	end
	if !self.ReloadHoldType then
		self.ReloadHoldType = self.ReloadHoldTypes[self.DefaultHoldType] or "rpg"
		if self.ReloadHoldTypeOverride and self.ReloadHoldTypeOverride!="" then
			self.ReloadHoldType = self.ReloadHoldTypeOverride
		end
	end
	
	
	local curhold,targhold
	curhold = self:GetHoldType()
	targhold = self.DefaultHoldType
	
	if self:GetIronSights() then targhold = self.IronHoldType end
	if self:GetSprinting() or self:GetHolstering() or self:IsSafety() then targhold = self.SprintHoldType end
	if self:GetReloading() then targhold = self.ReloadHoldType end
	
	if targhold != curhold then self:SetHoldType(targhold) end
end

function SWEP:CompleteReload()

	if self.Callback.CompleteReload then
		local val = self.Callback.CompleteReload(self)
		if val then return val end
	end
	
	if !self.Shotgun then
		local hudhangtime = 1
		
		if self:OwnerIsValid() then
			if SERVER then
				hudhangtime = self.Owner:GetInfoNum("cl_tfa_hud_hangtime",1)
			else
				hudhangtime = GetConVarNumber("cl_tfa_hud_hangtime",1)
			end
			
			local maxclip=self.Primary.ClipSize
			local curclip = self:Clip1()
			local amounttoreplace=math.min(maxclip-curclip+( ( (self:Clip1()>0) and self:CanChamber() ) and 1 or 0 ) * (self.Akimbo and 2 or 1),self.Owner:GetAmmoCount(self.Primary.Ammo))
			self:SetClip1(curclip+amounttoreplace)
			self.Owner:RemoveAmmo(amounttoreplace, self.Primary.Ammo)
		end
		
		self:SetReloading(false)
		self:SetBurstCount(0)
		self:SetBursting(false)
		self:SetHUDThreshold(true)
		self:SetHUDThresholdEnd(CurTime() + hudhangtime)
	end
end

--[[ 
Function Name:  ProcessTimers
Syntax: self:ProcessTimers().  This is called per-think.
Returns:  Nothing.  However, calculates OMG so much stuff what is this horrible hacky code that allows you to use bolt action snipers, shotguns, and normal guns all in the same base?!!!111oneoneone
Notes:  This is essential.
Purpose:  Don't remove this, seriously.
]]--
function SWEP:ProcessTimers()

	if self.Callback.ProcessTimers then
		local val = self.Callback.ProcessTimers(self)
		if val then return val end
	end
	
	local isreloading,isshooting,isdrawing,isholstering, issighting, issprinting, htv, hudhangtime, isbolttimer, isinspecting, isfidgeting
	
	isreloading=self:GetReloading()
	isshooting=self:GetShooting()
	isdrawing=self:GetDrawing()
	isholstering=self:GetHolstering()
	issighting=self:GetIronSights()
	issprinting=self:GetSprinting()
	isbursting = self:GetBursting()
	ischangingsilence = self:GetChangingSilence()
	isfiremodechanging = self:GetFireModeChanging()
	isinspecting = self:GetInspecting()
	htv = self:GetHUDThreshold()
	isfidgeting = self:GetFidgeting()
	hudhangtime = 1
	
	if isfidgeting then
		self:SetHUDThreshold(true)
		self:SetHUDThresholdEnd(CurTime() + hudhangtime)
	end
	
	--[[
	if self.DisableIdleAnimations and !isinspecting then
		self:SetNextIdleAnim(CurTime()+30)
	end
	]]--
	if self:OwnerIsValid() then
		if SERVER then
			hudhangtime = self.Owner:GetInfoNum("cl_tfa_hud_hangtime",1)
		else
			hudhangtime = GetConVarNumber("cl_tfa_hud_hangtime",1)
		end
	end
	isbolttimer = self:GetBoltTimer()
	if isdrawing and CurTime()>self:GetDrawingEnd() then
		local vm = self.Owner:GetViewModel()
		if IsValid(vm) then
			self.DefaultAtt = vm:GetAttachment(self:GetFPMuzzleAttachment())
		end
		self:SetDrawing(false)
		isdrawing=false
	end
	if isbolttimer and CurTime()>self:GetBoltTimerEnd() then
		self:SetBoltTimer(false)
		self:SetBoltTimerStart(CurTime()-1)
		self:SetBoltTimerEnd(CurTime()-1)
	end
	if isreloading and CurTime()>self:GetReloadingEnd() then
		if !self.Shotgun then
			self:CompleteReload()
			isreloading = false
		else
			if (self:GetShotgunInsertingShell() == false) then
				if !self:GetShotgunPumping() then
					if self.StartAnimInsertShell then
						local maxclip=self.Primary.ClipSize
						local curclip = self:Clip1()
						local ammopool = self:GetAmmoReserve()
						local amounttoreplace=1
						self:SetClip1(curclip+amounttoreplace)
						self.Owner:RemoveAmmo(amounttoreplace, self.Primary.Ammo)
						self.StartAnimInsertShell = false
						self:SetReloading(true)
						self:SetReloadingEnd(CurTime()+0)
						self:SetNextPrimaryFire( CurTime() + 0.01 )
					else
						self:SetShotgunInsertingShell(true)
						self.Weapon:SendWeaponAnim(ACT_VM_RELOAD)
						self:ResetEvents()
						if IsValid(self.Owner) then
							local vm = self.Owner:GetViewModel()
							if !self.ShellTime and IsValid(vm) then
								self:SetReloadingEnd(CurTime()+vm:SequenceDuration( vm:SelectWeightedSequence(ACT_VM_RELOAD) ) )
								self:SetNextPrimaryFire( CurTime()+ ( self.SequenceLengthOverride[ACT_VM_RELOAD] and self.SequenceLengthOverride[ACT_VM_RELOAD] or  vm:SequenceDuration( vm:SelectWeightedSequence(ACT_VM_RELOAD) ) )  )
							else
								self:SetReloadingEnd(CurTime()+self.ShellTime)
								self:SetNextPrimaryFire( CurTime()+ self.ShellTime )
							end
						else
							self:SetReloadingEnd(CurTime()+self.ShellTime)
							self:SetNextPrimaryFire( CurTime()+ self.ShellTime )
						end
						self:SetReloading(true)
						isreloading=true
					end
				else
					self:SetReloading(false)
					self:SetShotgunPumping(false)
					self:SetReloadingEnd(CurTime()-1)
					self:SetNextPrimaryFire( CurTime() + 0.01 )
					isreloading=false
					self:SetHUDThreshold(true)
					self:SetHUDThresholdEnd(CurTime() + hudhangtime)
				end
			else
				local maxclip=self.Primary.ClipSize
				local curclip = self:Clip1()
				local ammopool = self:GetAmmoReserve()
				if curclip>=maxclip or ammopool<=0 or self:GetShotgunNeedsPump() then
					self:SetShotgunInsertingShell(false)
					self:SendWeaponAnim(ACT_SHOTGUN_RELOAD_FINISH)
					if IsValid(self.Owner) then
						local vm = self.Owner:GetViewModel()
						if IsValid(vm) then
							self:SetReloadingEnd(CurTime()+vm:SequenceDuration( vm:SelectWeightedSequence(ACT_SHOTGUN_RELOAD_FINISH) ) )
							self:SetNextPrimaryFire( CurTime()+ ( self.SequenceLengthOverride[ACT_SHOTGUN_RELOAD_FINISH] and self.SequenceLengthOverride[ACT_SHOTGUN_RELOAD_FINISH] or  vm:SequenceDuration( vm:SelectWeightedSequence(ACT_SHOTGUN_RELOAD_FINISH) ) )  )
						else
							self:SetReloadingEnd(CurTime()+self.ShellTime)
							self:SetNextPrimaryFire( CurTime()+ self.ShellTime )
						end
					else
						self:SetReloadingEnd(CurTime()+self.ShellTime)
						self:SetNextPrimaryFire( CurTime()+ self.ShellTime )
					end
					self:SetReloading(true)
					self:SetShotgunPumping(true)
					self:SetShotgunNeedsPump(false)
				else
					local amounttoreplace=1
					self:SetClip1(curclip+amounttoreplace)
					self.Owner:RemoveAmmo(amounttoreplace, self.Primary.Ammo)
					curclip = self:Clip1()
					if (curclip<maxclip) then
						self.Weapon:SendWeaponAnim(ACT_VM_RELOAD)
						self:ResetEvents()
						self:SetReloading(true)
						self:SetShotgunInsertingShell(true)
						if IsValid(self.Owner) then
							local vm = self.Owner:GetViewModel()
							if !self.ShellTime and IsValid(vm) then
								self:SetReloadingEnd(CurTime()+vm:SequenceDuration( vm:SelectWeightedSequence(ACT_VM_RELOAD) ) )
								self:SetNextPrimaryFire( CurTime()+ ( self.SequenceLengthOverride[ACT_VM_RELOAD] and self.SequenceLengthOverride[ACT_VM_RELOAD] or  vm:SequenceDuration( vm:SelectWeightedSequence(ACT_VM_RELOAD) ) )  )
							else
								self:SetReloadingEnd(CurTime()+self.ShellTime)
								self:SetNextPrimaryFire( CurTime()+ self.ShellTime )
							end
						else
							self:SetReloadingEnd(CurTime()+self.ShellTime)
							self:SetNextPrimaryFire( CurTime()+ self.ShellTime )
						end
					else
						self:SetReloadingEnd(CurTime()-1)
						self:SetNextPrimaryFire( CurTime() + 0.01 )
						self:SetReloading(true)
						self:SetShotgunInsertingShell(true)
					end
					if self:GetShotgunCancel() then
						self:SetShotgunCancel( false )
						self:SetReloading(true)
						self:SetShotgunNeedsPump( true )
						self:SetReloadingEnd(CurTime()-1)
						self:SetNextPrimaryFire( CurTime() + 0.01 )
					end
				end
			end
		end
	end
	if isholstering and CurTime()>self:GetHolsteringEnd() then
		self:SetCanHolster(true)
		self:Holster(self:GetNWEntity("SwitchToWep",nil))
		self:SetHolstering(false)
		isholstering=false
	end
	if isbursting then
		if CurTime()>self:GetNextBurst() then
			local maxbursts = 1
			local firemode = self.FireModes[self:GetFireMode()]
			local bpos = string.find(firemode,"Burst")
			if bpos then
				maxbursts = tonumber(string.sub(firemode,1,bpos-1)) or 3
			end
			if self:GetBurstCount() >= maxbursts then
				self:SetBursting(false)
				self:SetBurstCount(0)
			else
				self:PrimaryAttack()
			end
		end
	end
	if isshooting and CurTime()>self:GetShootingEnd() then
		self:SetShooting(false)
		isshooting=false
	end
	if isfiremodechanging and CurTime() > self:GetFireModeChangeEnd() then
		self:SetFireModeChanging(false)
		self:SetFireModeChangeEnd(CurTime() - 1)
		self:SetHUDThreshold(true)
		self:SetHUDThresholdEnd(CurTime() + hudhangtime)
	end
	if ischangingsilence and CurTime()>self:GetNextSilenceChange() then
		self:SetSilenced(!self:GetSilenced())
		self:SetChangingSilence(false)
		self:SetNextSilenceChange(CurTime() - 1)
	end
	if htv and CurTime()>self:GetHUDThresholdEnd() then
		self:SetHUDThreshold(false)
		self:SetHUDThresholdEnd(CurTime() - 1)
	end
	if ( isreloading or isshooting or isdrawing or isholstering or ischangingsilence or isfiremodechanging ) then
		--donothing
	else
		if self:GetNextIdleAnim()<CurTime() then
			if self.lastact == ACT_VM_FIDGET or self.lastact == ACT_VM_FIDGET_EMPTY then
				self:SetFidgeting(false)
				isfidgeting = false
				self.lastact = 0
				self:ChooseIdleAnim()
				return
			end
			local success, tanim 
			if isfidgeting then
				success, tanim = self:ChooseInspectAnim()
			elseif !self.DisableIdleAnimations then
				success, tanim = self:ChooseIdleAnim()
			end
			local animtime = self.SequenceLength[tanim]
			if animtime then
				self:SetNextIdleAnim( CurTime() + animtime)
			else
				self:SetNextIdleAnim( CurTime() +1 )
			end
		end
	end
end

function SWEP:ToggleInspect()

	if self.Callback.ToggleInspect then
		local val = self.Callback.ToggleInspect(self)
		if val then return val end
	end
	
	if self:CanCKeyInspect() and self:GetRunSightsRatio()<0.1 and self:GetNearWallRatio()<0.1 and !self:GetDrawing() and !self:GetHolstering() and !self:GetReloading() and !self:GetFidgeting() and !self:GetIronSights() and self.SequenceEnabled[ACT_VM_FIDGET] then
		self:SetInspecting(false)
		if CLIENT then
			net.Start("tfaInspect")
			net.WriteBool(false)
			net.SendToServer()
		end
		self:SetFidgeting(true)
		self:SetNextIdleAnim(-1)
		return
	end
	
	if !self:GetIronSights() and self:GetRunSightsRatio()<0.1 and self:GetNearWallRatio()<0.1 and !self:GetDrawing() and !self:GetHolstering() and !self:GetReloading() and !self:GetFidgeting() then
	
		local oldinsp = self:GetInspecting()
		self:SetInspecting(!oldinsp)
		if CLIENT then
			net.Start("tfaInspect")
			net.WriteBool(!oldinsp)
			net.SendToServer()
		end
		self:SetNextIdleAnim( CurTime() - 1)
		
	end
end

function SWEP:ShotgunInterrupt()

	if self.Callback.ShotgunInterrupt then
		local val = self.Callback.ShotgunInterrupt(self)
		if val then return val end
	end
	
	if (self:GetReloading() and self.Shotgun and !self:GetShotgunPumping() and !self:GetShotgunNeedsPump()) then
		if CLIENT then
			net.Start("tfaShotgunInterrupt")
			net.SendToServer()
		end
	end
	self:SetShotgunCancel( true )
end

