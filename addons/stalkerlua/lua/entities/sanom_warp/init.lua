
AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include( 'shared.lua' )

ENT.Teleport = Sound( "ambient/levels/labs/teleport_weird_voices1.wav" )
ENT.Teleport2 = Sound( "ambient/levels/citadel/portal_beam_shoot6.wav" )
ENT.Appear = Sound( "ambient/levels/citadel/weapon_disintegrate4.wav" )
ENT.Triggered = Sound( "npc/turret_floor/active.wav" )

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

function ENT:GetRadiationRadius()

	return 200
end

function ENT:Touch( ent ) 
	
	if self.SetOff then return end
	
	if ent:IsPlayer() or string.find( ent:GetClass(), "npc" ) or string.find( ent:GetClass(), "prop_phys" ) then
	
		self.SetOff = CurTime() + 0.5
		
		self.Entity:EmitSound( self.Triggered, 100, math.random(90,110) )
	end
end 

function ENT:Think()

	if self.SetOff and self.SetOff < CurTime() then
	
		self.Entity:EmitSound( self.Teleport2, 100, math.random(110,130) )
	
		local tbl = ents.FindByClass( "prop_phys*" )
		tbl = table.Add( tbl, ents.FindByClass( "prop_veh*" ) )
		tbl = table.Add( tbl, ents.FindByClass( "npc*" ) )
		tbl = table.Add( tbl, player.GetAll() )
		
		for k,v in pairs( tbl ) do
			
			if v:GetPos():Distance( self.Entity:GetPos() ) < self.ZapRadius then
				
				self.Entity:TeleportEnt( v )
				
			end
		end
		
		self.SetOff = nil
	end
end

function ENT:ChooseDestination()

	local min, max

	for k,v in pairs( ents.FindByClass( "sanom_warpend" ) ) do
	
		local trace = {}
		trace.start = v:GetPos()
		trace.endpos = trace.start + Vector(0,0,90000)
		trace.filter = v
		
		local tr = util.TraceLine( trace )
	
		if tr.HitSky then 
		
			local left = {}
			left.start = tr.HitPos
			left.endpos = left.start + Vector( 100, 0, 0 )
			
			local right = {}
			right.start = tr.HitPos
			right.endpos = right.start + Vector( -100, 0, 0 )
			
			local ltr = util.TraceLine( left )
			local rtr = util.TraceLine( right )
			
			local north = {}
			north.start = ltr.HitPos
			north.endpos = north.start + Vector( 0, 100, 0 )
			
			local south = {}
			south.start = rtr.HitPos
			south.endpos = south.start + Vector( 0, -100, 0 )
			
			local ntr = util.TraceLine( north )
			local str = util.TraceLine( south )
			
			local max = Vector( ltr.HitPos.x, ntr.HitPos.y, tr.HitPos.z - 5 )
			local min = Vector( rtr.HitPos.x, str.HitPos.y, tr.HitPos.z - 5 )
			
			local trace = {}
			trace.start = Vector( math.random( min.x, max.x ), math.random( min.y, max.y ), min.z )
			trace.endpos = Vector( math.random( min.x, max.x ), math.random( min.y, max.y ), min.z - 90000 )
				
			local tr = util.TraceLine( trace )
					
			return tr.HitPos + Vector( 0, 0, 100 )
		end
	end
end

function ENT:TeleportEnt( ent )

	local min, max = ent:WorldSpaceAABB()

	local ed = EffectData()
	ed:SetOrigin( min )
	ed:SetStart( max )
	ed:SetMagnitude( ent:BoundingRadius() )
	util.Effect( "prop_teleport", ed )

	if string.find( ent:GetClass(), "prop" ) then
	
		local phys = ent:GetPhysicsObject()
		
		if not IsValid( phys ) or not phys:IsMoveable() then return end
	
		ent:SetPos( self.Entity:ChooseDestination() )
		
		local phys = ent:GetPhysicsObject()
		
		if IsValid( phys ) then
		
			local vec = VectorRand()
			vec.z = 0.1
		
			phys:ApplyForceCenter( vec * 1000 )
		
		end
	else
	
		if ent:IsPlayer() and IsValid( ent:GetVehicle() ) then

			umsg.Start( "GrenadeHit", ent )
			umsg.End()
		
			ent:SetDSP( 47 )
			
			timer.Simple( 5, function( ply ) if IsValid( ply ) then ply:SetDSP( 0 ) end end, ent )
		
			return 
			
		end
		
		ent:SetPos( self.Entity:ChooseDestination() )
		
		local vec = VectorRand()
		vec.z = 0.1
		
		
		if ent:IsPlayer() and ent:Alive() then
		
			umsg.Start( "GrenadeHit", ent )
			umsg.End()
		
			ent:SetDSP( 47 )
			ent:EmitSound( self.Teleport, 100, math.random(150,170) )
			
			timer.Simple( 5, function( ply ) if IsValid( ply ) then ply:SetDSP( 0 ) end end, ent )
		
		end
	end
	
	ent:EmitSound( self.Appear, 100, math.random(90,110) )
end