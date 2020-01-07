--Inspired by Zoey's flashlight.
--This SWEP started out as a small modification of Devilsson2010's FlashlightV2.
--Eventually, I completely rewrote the weapon, recreating the function of
--Zoey's now defunct Zombie Master flashlight.


AddCSLuaFile ()

if ( SERVER ) then
	SWEP.Weight = 5
	SWEP.AutoSwitchTo = false
	SWEP.AutoSwitchFrom = false
end
	
if ( CLIENT ) then
	fltexturevar = CreateConVar( "cl_flashlight_texture", "effects/flashlight001", { FCVAR_ARCHIVE, FCVAR_USERINFO, FCVAR_DONTRECORD }, "Path to flashlight texture, set in the options menu." )
	flashlight_r = CreateConVar( "cl_flashlight_r", "255", { FCVAR_ARCHIVE, FCVAR_USERINFO, FCVAR_DONTRECORD }, "0-255 Flashlight color's red component, set in the options menu." )
	flashlight_g = CreateConVar( "cl_flashlight_g", "255", { FCVAR_ARCHIVE, FCVAR_USERINFO, FCVAR_DONTRECORD }, "0-255 Flashlight color's green component, set in the options menu." )
	flashlight_b = CreateConVar( "cl_flashlight_b", "255", { FCVAR_ARCHIVE, FCVAR_USERINFO, FCVAR_DONTRECORD }, "0-255 Flashlight color's blue component, set in the options menu." )
	SWEP.PrintName = "Handheld Flashlight"
	SWEP.Slot = 0
	SWEP.SlotPos = 7
	SWEP.DrawAmmo = false
	SWEP.DrawCrosshair = false
	SWEP.WeaponIcon = surface.GetTextureID("weapons/weapon_flashlight")
	killicon.Add( "weapon_flashlight", "weapons/weapon_flashlight_kill", Color( 255, 80, 0, 255 ) ) 
	function SWEP:DrawWeaponSelection(x, y, wide, tall, alpha)
		surface.SetDrawColor( 355, 340, 0, 255 )
		surface.SetTexture( self.WeaponIcon )
		surface.DrawTexturedRect( x + wide * 0.15, y, wide / 1.5, tall )
	end
end

SWEP.Author = "Paynamia"
SWEP.Contact = ""
SWEP.Purpose = ""
SWEP.Instructions = "Primary fire attacks. Secondary fire toggles the light."

SWEP.Spawnable = true
SWEP.AdminSpawnable = true
SWEP.UseHands = true
SWEP.HoldType 				= "pistol"
SWEP.NormalHoldType 		= "pistol"

SWEP.ViewModel = "models/weapons/c_flashlight_zm.mdl"
SWEP.WorldModel = "models/weapons/w_flashlight_zm.mdl"

SWEP.Category = "STALKER Misc"
SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Damage = 10
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "Pistol"

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false 
SWEP.Secondary.Ammo = "none"
SWEP.Active = false

SWEP.SetNextReload = CurTime()
	
local SwingSound = Sound( "weapons/slam/throw.wav" )
local HitSound = Sound( "Computer.ImpactHard" )
local SwitchSound = Sound( "HL2Player.FlashLightOn" )

function SWEP:Precache()
	util.PrecacheSound( "weapons/slam/throw.wav" )
	util.PrecacheSound( "Computer.ImpactHard" )
	util.PrecacheSound( "HL2Player.FlashLightOn" )
end

function SWEP:Reload() 
	if self.SetNextReload > CurTime() then return end
	local flrefresh = self.Owner:GetInfoNum( "cl_flashlight_allow_refresh", 0 )
	if flrefresh != 0 then
		SafeRemoveEntity ( self.projectedlight )
		if ( SERVER ) then
			if IsValid( self.projectedlight ) then
				self.projectedlight:Fire("kill")
			end
		end
		--self.projectedlight = nil

		self:BuildLight( 0.01 )
		
		self.SetNextReload = ( CurTime() + 1 )
		self:SetNextSecondaryFire( CurTime() + 0.23 )
	end
end

function SWEP:Holster( wep )
	if not IsFirstTimePredicted() then return end
	self.Owner:AllowFlashlight( true )
	self.Owner:Flashlight( false )
	self.Owner:AllowFlashlight( false )
	self.Active = false
return true
end
	
function SWEP:PrimaryAttack()
/*	self.Owner:SetAnimation( PLAYER_ATTACK1 )
	if ( !SERVER ) then return end
	
	-- Apparently we need this because it won't work right in multiplayer.
	-- I assume that refers to the timer, but I have no idea.
	local vm = self.Owner:GetViewModel()
	vm:ResetSequence( vm:LookupSequence( "idle01" ) )
	
	timer.Simple( 0, function()
		if ( !IsValid( self ) || !IsValid( self.Owner ) || !self.Owner:GetActiveWeapon() || self.Owner:GetActiveWeapon() != self ) then return end
		
		local vm = self.Owner:GetViewModel()
		vm:ResetSequence( vm:LookupSequence( "hitcenter1" ) )

		timer.Simple( (vm:SequenceDuration() - 0.2), function()
			if ( !IsValid( self ) || !IsValid( self.Owner ) || !self.Owner:GetActiveWeapon() || self.Owner:GetActiveWeapon() != self ) then return end
			local vm = self.Owner:GetViewModel()
			vm:SetSequence( vm:LookupSequence( "idle01" ) )
		end )
	end )
	
	timer.Simple( 0.39, function()
		if ( !IsValid( self ) || !IsValid( self.Owner ) || !self.Owner:GetActiveWeapon() || self.Owner:GetActiveWeapon() != self ) then return end
		self.Owner:EmitSound( SwingSound )
	end )
	
	timer.Simple( 0.45, function()
		if ( !IsValid( self ) || !IsValid( self.Owner ) || !self.Owner:GetActiveWeapon() || self.Owner:GetActiveWeapon() != self ) then return end
		local tr = util.TraceLine( {
			start = self.Owner:GetShootPos(),
			endpos = self.Owner:GetShootPos() + self.Owner:GetAimVector() * 64,
			filter = self.Owner
		} )

		if ( !IsValid( tr.Entity ) ) then 
			tr = util.TraceHull( {
				start = self.Owner:GetShootPos(),
				endpos = self.Owner:GetShootPos() + self.Owner:GetAimVector() * 64,
				filter = self.Owner,
				--mins = self.Owner:OBBMins() / 3,
				--maxs = self.Owner:OBBMaxs() / 3
				mins = Vector( -10, -10, -8 ),
				maxs = Vector( 10, 10, 8 )
			} )
		end
		if ( tr.Hit ) then self.Owner:EmitSound( HitSound ) end
		if ( IsValid( tr.Entity ) ) then
			local dmginfo = DamageInfo()
			dmginfo:SetDamage( self.Primary.Damage )
			dmginfo:SetDamageForce( self.Owner:GetForward() * 29984 )
			dmginfo:SetDamageType( 128 )
			dmginfo:SetInflictor( self )
			local attacker = self.Owner
			if ( !IsValid( attacker ) ) then attacker = self end
			dmginfo:SetAttacker( attacker )

			tr.Entity:TakeDamageInfo( dmginfo )
		end
	end )
	self:SetNextPrimaryFire( CurTime() + 1 )*/
end 

function SWEP:SecondaryAttack()
	if ( !IsValid( self ) || !IsValid( self.Owner ) || !self.Owner:GetActiveWeapon() || self.Owner:GetActiveWeapon() != self || !SERVER ) then return end
	self.Active = !self.Active
	if ( self.Active ) then
		self.Owner:AllowFlashlight( true )
		self.Owner:Flashlight(true)
		self.Owner:AllowFlashlight( false )
	else
		self.Owner:AllowFlashlight( true )
		self.Owner:Flashlight(false)
		self.Owner:AllowFlashlight( false )
	end
	
	self.Owner:EmitSound( SwitchSound )
	
	-- Apparently we need this because it won't work right in multiplayer.
	local vm = self.Owner:GetViewModel()
	vm:ResetSequence( vm:LookupSequence( "idle01" ) )
	timer.Simple( 0, function()
		if ( !IsValid( self ) || !IsValid( self.Owner ) || !self.Owner:GetActiveWeapon() || self.Owner:GetActiveWeapon() != self ) then return end
		
		local vm = self.Owner:GetViewModel()
		vm:ResetSequence( vm:LookupSequence( "trigger" ) )

		timer.Simple( vm:SequenceDuration(), function()
			if ( !IsValid( self ) || !IsValid( self.Owner ) || !self.Owner:GetActiveWeapon() || self.Owner:GetActiveWeapon() != self ) then return end
			local vm = self.Owner:GetViewModel()
			vm:SetSequence( vm:LookupSequence( "idle01" ) )
		end )
	end )
	self:SetNextSecondaryFire( CurTime() + 0.23 )
end

function SWEP:Initialize()
	self:SetWeaponHoldType( "slam" )
end

function SWEP:Think()
end

function SWEP:Deploy()
	local vm = self.Owner:GetViewModel()
	self:SetNextSecondaryFire( CurTime() + 0.835 )
	self:SetNextPrimaryFire( CurTime() + 0.835 )
	self.SetNextReload = ( CurTime() + 1.835 )
	vm:ResetSequence( vm:LookupSequence( "draw" ) )

	return true
end

function SWEP:BuildLight( delay )
	local vm = self.Owner:GetViewModel()
	local fltexturevar = self.Owner:GetInfo( "cl_flashlight_texture" )
	local flashlight_r = self.Owner:GetInfoNum( "cl_flashlight_r", 255 )
	local flashlight_g = self.Owner:GetInfoNum( "cl_flashlight_g", 255 )
	local flashlight_b = self.Owner:GetInfoNum( "cl_flashlight_b", 255 )
	
	local r = math.Clamp( flashlight_r, 0, 255 )
	local g = math.Clamp( flashlight_g, 0, 255 )
	local b = math.Clamp( flashlight_b, 0, 255 )
	timer.Simple( delay, function()
		if ( !IsValid( self ) || !IsValid( self.Owner ) || !self.Owner:GetActiveWeapon() || self.Owner:GetActiveWeapon() != self || !SERVER ) then return end
		self.projectedlight = ents.Create( "env_projectedtexture" )
		self.projectedlight:SetParent( vm )
		self.projectedlight:SetPos( self.Owner:GetShootPos() )
		self.projectedlight:SetAngles( self.Owner:GetAngles() )
		self.projectedlight:SetKeyValue( "enableshadows", 1 )
		self.projectedlight:SetKeyValue( "nearz", 4 )
		self.projectedlight:SetKeyValue( "farz", 750.0 )
		self.projectedlight:SetKeyValue( "lightcolor", Format( "%i %i %i 255", r, g, b ) )
		self.projectedlight:SetKeyValue( "lightfov", 70 )
		self.projectedlight:Spawn()
		self.projectedlight:Input( "SpotlightTexture", NULL, NULL, fltexturevar )
		self.projectedlight:Fire("setparentattachment", "light", 0.01)
		self.Owner:EmitSound( SwitchSound )
	end )
	self.Active = true
end

