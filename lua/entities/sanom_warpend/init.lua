
AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include( 'shared.lua' )

ENT.ZapRadius = 400

function ENT:Initialize()
	
	self.Entity:SetMoveType( MOVETYPE_NONE )
	self.Entity:SetSolid( SOLID_NONE )
	
	self.Entity:SetCollisionGroup( COLLISION_GROUP_DEBRIS_TRIGGER )
	self.Entity:SetTrigger( true )
	self.Entity:SetNotSolid( true )
	self.Entity:DrawShadow( false )	
		
	self.Entity:SetCollisionBounds( Vector( -150, -150, -150 ), Vector( 150, 150, 150 ) )
	self.Entity:PhysicsInitBox( Vector( -150, -150, -150 ), Vector( 150, 150, 150 ) )
	
end

function ENT:SpawnFunction( ply, tr )
	if ( !tr.Hit ) then return end
	local SpawnPos = tr.HitPos + tr.HitNormal * 16
	local ent = ents.Create( self.ClassName )
	ent:SetPos( SpawnPos )
	ent:Spawn()
	ent:Activate()
	return ent
end