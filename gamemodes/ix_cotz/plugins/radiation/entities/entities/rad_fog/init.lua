
AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include( 'shared.lua' )

ENT.WaitTime = 5
ENT.KillRadius = 1200
ENT.Damage = 5

function ENT:Initialize()
	
	self.Entity:SetMoveType( MOVETYPE_NONE )
	self.Entity:SetSolid( SOLID_NONE )
	
	self.Entity:SetCollisionGroup( COLLISION_GROUP_DEBRIS_TRIGGER )
	self.Entity:SetTrigger( true )
	self.Entity:SetNotSolid( true )
	self.Entity:DrawShadow( false )	

	self.Timer = CurTime() + self.WaitTime
	
	local trace = {}
	trace.start = self.Entity:GetPos()
	trace.endpos = trace.start + Vector(1200,1200,0)
	local tr = util.TraceLine( trace )
	
	self.Left = trace.start + Vector(1200,1200,0)
	
	if tr.Hit then
	
	--	self.Left = tr.HitPos
	
	end
	
	trace = {}
	trace.start = self.Entity:GetPos()
	trace.endpos = trace.start + Vector(-1200,-1200,0)
	tr = util.TraceLine( trace )
	
	self.Right = trace.start + Vector(-1200,-1200,0)
	
	if tr.Hit then
	
	--	self.Right = tr.HitPos
	
	end
	
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