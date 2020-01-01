
------------------------------
------------------------------
------------------------------
--	STALKER Bolt Throwing SWep
--	Author:	V92
--	Date: 2014/04/27
--
--	Throws bolts, detects hazards
------------------------------
------------------------------
------------------------------

AddCSLuaFile()

if !ConVarExists("VNT_STALKER_Bolt_Ammo")	then CreateConVar("VNT_STALKER_Bolt_Ammo", 0,  { FCVAR_REPLICATED, FCVAR_ARCHIVE } )	end

sound.Add({	name		= "V92_Uni_QuickMove",
	channel		= CHAN_WEAPON,
	level		= 100,
	volume		= 1.0,
	pitch		= { 95, 105 },
	sound		= "jessev92/weapons/univ/throw_gren.wav",
})

sound.Add({	name		= "V92_Uni_Draw",
	channel		= CHAN_BODY,
	level		= 75,
	volume		= 1.0,
	pitch		= { 95, 105 },
	sound		= "jessev92/weapons/univ/draw1.wav",
})

sound.Add({	name		= "V92_Uni_Holster",
	channel		= CHAN_BODY,
	level		= 75,
	volume		= 1.0,
	pitch		= { 95, 105 },
	sound		= "jessev92/weapons/univ/holster1.wav",
})

SWEP.ViewModelFOV			= 70
SWEP.ViewModelFlip			= false
SWEP.ViewModel				= Model("models/jessev92/stalker/weapons/bolt_c.mdl")
SWEP.WorldModel				= Model("models/jessev92/stalker/weapons/bolt_w.mdl")
SWEP.UseHands				= true
SWEP.Spawnable				= true
SWEP.AdminOnly				= false

if (CLIENT) then
	local	_SELFENTNAME	= "stalker_bolt"
	local	_INFONAME		= "Bolt"
	SWEP.Category			= "S.T.A.L.K.E.R."
	SWEP.PrintName			= _INFONAME
	SWEP.Author   			= "V92"
	SWEP.Contact        	= "Steam @ Lucky9Two"
	SWEP.Instructions 		= "Throw into anomalies to detect danger"
	SWEP.Slot 				= 5
	SWEP.SlotPos 			= 92
	SWEP.ViewModelFOV		= 60
	SWEP.WepSelectIcon 		= surface.GetTextureID("vgui/hud/" .. _SELFENTNAME )
	SWEP.BounceWeaponIcon   = false

	language.Add( _SELFENTNAME, _INFONAME )	
	language.Add( "stkbolt_ammo", "Bolts" )	
	killicon.Add( _SELFENTNAME, "vgui/entities/".. _SELFENTNAME , Color( 255, 255, 255 ) )
end

SWEP.UseDel = CurTime()

function SWEP:IdleTiming()
	self:SendWeaponAnim(ACT_VM_FIDGET)
end

function SWEP:Initialize()
	self:SetWeaponHoldType( "knife" )
end

function SWEP:PrimaryAttack()
	if (self.UseDel < CurTime()) then
		self.UseDel = CurTime() + 3
		self:SendWeaponAnim( ACT_VM_PULLBACK_HIGH )
		self.Owner:DoAttackEvent( )	
		if (SERVER) then
			timer.Simple( 0.3, function()
				self:EmitSound( Sound("weapons/slam/throw.wav", 100, 100 ) )
				local bolt = ents.Create( "ent_stalker_bolt" )	
				bolt:SetPos(self.Owner:GetShootPos() + self.Owner:GetAimVector() * 10)
				bolt:SetAngles(self.Owner:EyeAngles())
				bolt:Spawn()
				bolt:SetOwner( self.Owner )
				bolt:Fire("kill", "", 12)
				bolt:GetPhysicsObject():ApplyForceCenter( self.Owner:GetVelocity() + self.Owner:GetAimVector() * 5000)
				bolt:GetPhysicsObject():AddAngleVelocity(Vector(math.random(-500,500),math.random(-500,500),math.random(-500,500)))		
				bolt:GetPhysicsObject():SetMass(1)
			end)
		end
		timer.Simple( 0.75, function()	
			self:SendWeaponAnim( ACT_VM_IDLE )	
		end)
	end
end

function SWEP:SecondaryAttack()
	if (self.UseDel < CurTime()) then
		self.UseDel = CurTime() + 3
		self:SendWeaponAnim( ACT_VM_PULLBACK_LOW )
		self.Owner:DoAttackEvent( )	
		if (SERVER) then
			timer.Simple( 0.3, function()
				self:EmitSound( Sound("weapons/slam/throw.wav", 100, 100 ) )
				local bolt = ents.Create( "ent_stalker_bolt" )	
				bolt:SetPos(self.Owner:GetShootPos() + self.Owner:GetAimVector() * 10)
				bolt:SetAngles(self.Owner:EyeAngles())
				bolt:Spawn()
				bolt:SetOwner( self.Owner )
				bolt:Fire("kill", "", 12)
				bolt:GetPhysicsObject():ApplyForceCenter( self.Owner:GetVelocity() + self.Owner:GetAimVector() * 2500)
				bolt:GetPhysicsObject():AddAngleVelocity(Vector(math.random(-500,500),math.random(-500,500),math.random(-500,500)))		
				bolt:GetPhysicsObject():SetMass(1)
			end)
		end
		timer.Simple( 0.75, function()	
			self:SendWeaponAnim( ACT_VM_IDLE )	
		end)
	end
end

function SWEP:Holster()
	self:SendWeaponAnim( ACT_VM_HOLSTER ) 
	return true
end

function SWEP:Deploy()
	self:SendWeaponAnim( ACT_VM_DRAW )
	timer.Simple( 0.75, function()	
		self:SendWeaponAnim( ACT_VM_IDLE )	
	end)
	return true
end

game.AddAmmoType( 
{
    name        =   "stkbolt",
    dmgtype     =    DMG_CLUB 
})

SWEP.Primary.Delay				= 0
SWEP.Primary.Recoil				= 0
SWEP.Primary.Damage				= 0
SWEP.Primary.NumShots			= 0
SWEP.Primary.Cone				= 0	
SWEP.Primary.ClipSize			= -1
SWEP.Primary.DefaultClip		= -1
SWEP.Primary.Automatic   		= false
SWEP.Primary.Ammo         		= "stkbolt"
SWEP.Secondary.Delay			= 0
SWEP.Secondary.Recoil			= 0
SWEP.Secondary.Damage			= 0
SWEP.Secondary.NumShots			= 0
SWEP.Secondary.Cone		  		= 0
SWEP.Secondary.ClipSize			= -1
SWEP.Secondary.DefaultClip		= -1
SWEP.Secondary.Automatic   		= false
SWEP.Secondary.Ammo         	= "none"
