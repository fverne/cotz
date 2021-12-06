if (SERVER) then
	AddCSLuaFile( "shared.lua" )
	SWEP.Weight				= 5
	SWEP.AutoSwitchTo		= true
	SWEP.AutoSwitchFrom		= true
end

SWEP.Category 				= "RP Weapons" 

SWEP.Spawnable     			= true
SWEP.AdminSpawnable  		= true

SWEP.UseHands				= true
SWEP.ViewModel				= "models/weapons/c_binoculars.mdl"
SWEP.WorldModel				= "models/weapons/w_binocularsbp.mdl"

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

SWEP.Zoom_Interval			= 2
SWEP.Zoom_Current			= 0
SWEP.Zoom_Min				= 2
SWEP.Zoom_Max				= 8
SWEP.Zoom_Delta				= 0.2
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

function SWEP:PrimaryAttack()
	if ( self.Zoom_Interval == 0 or self.Zoom_Min == self.Zoom_Max) then return end
	if ( self.Owner:KeyDown( IN_USE ) and self.HasNightVision ) then
		if ( self.HasNightVision ) then
			if self:GetNWBool( "nvon", true ) then 
				self:SetNWBool( "nvon", false )
				self:EmitSound( "items/flashlight1.wav", 60, 100 )
			else
				self:SetNWBool( "nvon", true )
				self:EmitSound( "items/flashlight1.wav", 60, 120 )
			end
		end
	elseif (self.Zoom_InZoom) then
		if (self.Zoom_Current >= self.Zoom_Max) then
			sound.Play( self.Zoom_Sound_Out, self.Owner:GetPos() )
			self.Zoom_Current = self.Zoom_Min
			self.Owner:SetFOV(90/self.Zoom_Current, self.Zoom_Delta)
		elseif ((self.Zoom_Current+self.Zoom_Interval)>= self.Zoom_Max) then
			sound.Play( self.Zoom_Sound_In, self.Owner:GetPos() )
			self.Zoom_Current = self.Zoom_Max
			self.Owner:SetFOV(90/self.Zoom_Current, self.Zoom_Delta)
		else
			sound.Play( self.Zoom_Sound_In, self.Owner:GetPos() )
			self.Zoom_Current = self.Zoom_Current + self.Zoom_Interval
			self.Owner:SetFOV(90/self.Zoom_Current, self.Zoom_Delta)
		end
	end
end

function SWEP:SecondaryAttack()
end

function SWEP:Deploy()
	self:SendWeaponAnim( ACT_VM_DRAW )
	self:SetNextPrimaryFire( CurTime() + self:SequenceDuration() )
	self.WalkSpeed = self.Owner:GetWalkSpeed()
	self.RunSpeed = self.Owner:GetRunSpeed()
	self.WalkSpeedMod = self.WalkSpeed * self.SpeedMult
	self.Zoom_Current = self.Zoom_Min
	self.Zoom_InZoom = false
	self.Zoom_Zooming = false
	self:SetHoldType( self.HoldType )
	self:Idle()
end

function SWEP:Initialize()
	self.UUID = tostring(self:EntIndex())
	self.Zoom_Current = self.Zoom_Interval
	self:SetHoldType( self.HoldType )
end

function SWEP:Holster()
	if self.Zoom_Zooming then return false end
		if (self.Zoom_InZoom) then
			self.Owner:SetFOV( 0, self.Zoom_Delta )
		end
		self.Zoom_InZoom = false
		self.Zoom_Current = self.Zoom_Min
		self.Owner:SetDSP( 0, false )
		self.Owner:DrawViewModel( true, 0 )
		self.Owner:SetRunSpeed(self.RunSpeed)
		self.Owner:SetWalkSpeed(self.WalkSpeed)
	self:StopIdle()
	return true
end

function SWEP:Think()

	if self.Owner:KeyPressed( IN_ATTACK2 ) then
		if !(self.Zoom_Zooming) then
			self:SetZoom()
		end
	end
		
	if self.Owner:KeyReleased( IN_ATTACK2 ) then
		if !(self.Zoom_Zooming) then
			self:EndZoom()
		end
	end

	if ( self.Owner:KeyReleased( IN_ATTACK ) || ( !self.Owner:KeyDown( IN_ATTACK ) && self.Sound ) ) then		
		self:Idle()
	end
	
	if ( self.Owner:KeyPressed( IN_USE ) and ( self.Zoom_InZoom ) ) then
		timer.Simple( 0.01, function()
			if !(self:IsValid()) then return end
			self.Owner:DrawViewModel( false, 0 )
		end)
	end
	
end

function SWEP:SetZoom()
	self.Zoom_Zooming = true
	self:StopIdle()
	
	self:SendWeaponAnim( ACT_VM_PRIMARYATTACK )
	self:EmitSound(self.Zoom_Sound_Cloth, 50, 110)
	self.Owner:SetRunSpeed(self.WalkSpeedMod)
	self.Owner:SetWalkSpeed(self.WalkSpeedMod)
	self:SetHoldType( self.HoldTypeRaised )
	timer.Simple(self:SequenceDuration()*4/5, function()
		if !self:IsValid() then return end
		self.Zoom_InZoom = true
		self.Zoom_Current = self.Zoom_Interval
		self.Owner:DrawViewModel( false, 0 )
		self.Owner:SetFOV( 90/self.Zoom_Current, self.Zoom_Delta )
		self.Owner:SetDSP( 30, false )
	end)
	timer.Simple(self:SequenceDuration(), function()
		if !self:IsValid() then return end
		self.Zoom_Zooming = false
	end)
end

function SWEP:EndZoom()
	self.Zoom_Zooming = true
	
	self:SendWeaponAnim( ACT_VM_SECONDARYATTACK )
	self:EmitSound(self.Zoom_Sound_Cloth, 50, 90)
	self.Owner:SetRunSpeed(self.RunSpeed)
	self.Owner:SetWalkSpeed(self.WalkSpeed)
	self:SetHoldType( self.HoldType )
	timer.Simple(self:SequenceDuration()*1/5, function()
		if !self:IsValid() then return end
		self.Zoom_InZoom = false
		self.Zoom_Current = self.Zoom_Interval
		self.Owner:DrawViewModel( true, 0 )
		self.Owner:SetFOV( 0, self.Zoom_Delta )
		self.Owner:SetDSP( 0, false )
	end)
	timer.Simple(self:SequenceDuration(), function()
		if !self:IsValid() then return end
		self.Zoom_Zooming = false
		self:Idle()
	end)
end

function SWEP:DoIdleAnimation()
	self:SendWeaponAnim( ACT_VM_IDLE )
end

function SWEP:DoIdle()
	self:DoIdleAnimation()

	timer.Adjust( "weapon_idle" .. self:EntIndex(), self:SequenceDuration(), 0, function()
		if ( !IsValid( self ) ) then timer.Destroy( "weapon_idle" .. self:EntIndex() ) return end

		self:DoIdleAnimation()
	end )
end

function SWEP:StopIdle()
	timer.Destroy( "weapon_idle" .. self:EntIndex() )
end

function SWEP:Idle()
	if ( CLIENT || !IsValid( self.Owner ) ) then return end
	timer.Create( "weapon_idle" .. self:EntIndex(), self:SequenceDuration() - 0.2, 1, function()
		if ( !IsValid( self ) ) then return end
		self:DoIdle()
	end )
end