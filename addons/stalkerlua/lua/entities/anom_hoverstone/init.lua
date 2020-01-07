
AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include( 'shared.lua' )

ENT.Models = { "models/props_debris/concrete_column001a_chunk01.mdl",
"models/props_debris/concrete_column001a_chunk02.mdl",
"models/props_debris/concrete_column001a_chunk03.mdl",
"models/props_debris/concrete_column001a_chunk04.mdl",
"models/props_debris/concrete_chunk01b.mdl",
"models/props_debris/concrete_chunk02a.mdl",
"models/props_debris/concrete_chunk03a.mdl",
"models/props_debris/concrete_chunk06d.mdl",
"models/props_debris/concrete_chunk07a.mdl",
"models/props_debris/concrete_chunk08a.mdl",
"models/props_debris/concrete_chunk09a.mdl",
"models/props_debris/concrete_spawnchunk001a.mdl",
"models/props_debris/concrete_spawnchunk001b.mdl",
"models/props_debris/concrete_spawnchunk001e.mdl",
"models/props_debris/concrete_spawnchunk001f.mdl",
"models/props_wasteland/rockgranite03a.mdl",
"models/props_wasteland/rockgranite03b.mdl",
"models/props_wasteland/rockgranite03c.mdl",
"models/props_junk/Rock001a.mdl" }

ENT.BumpSounds = { Sound( "ambient/materials/metal4.wav" ),
Sound( "ambient/levels/canals/critter5.wav" ),
Sound( "ambient/machines/station_train_squeel.wav" ) }

function ENT:Initialize()

	self.Entity:SetModel( table.Random( self.Models ) )

	self.Entity:PhysicsInit( SOLID_VPHYSICS )
	self.Entity:SetMoveType( MOVETYPE_VPHYSICS )
	self.Entity:SetSolid( SOLID_VPHYSICS )

	local phys = self.Entity:GetPhysicsObject()

	if IsValid( phys ) then

		phys:SetMaterial( "wood" )
		phys:Wake()

	end

	self.Entity:StartMotionController()

	self.Active = false
	self.Distance = math.random( 100, 400 )
	self.Scale = math.Rand( 10, 20 )

end

function ENT:SpawnFunction( ply, tr )
	if ( !tr.Hit ) then return end
	local SpawnPos = tr.HitPos + tr.HitNormal * 16
	local ent = ents.Create( self.ClassName )
	ent:SetPos( SpawnPos )
	ent:Spawn()
	ent:Activate()
	timer.Simple( 1800, function() ent:Remove() end ) 
	return ent
end

function ENT:GetRadiationRadius()

	return 100

end

function ENT:PhysicsSimulate( phys, delta )

	if not self.Active then return SIM_NOTHING end

	if self.ReActivate then

		self.ReActivate = false

		phys:ApplyForceCenter( Vector( 0, 0, 1 ) * ( phys:GetMass() * self.Scale ) )

	end

	local trace = {}
	trace.start = self.Entity:GetPos()
	trace.endpos = trace.start + Vector( 0, 0, -1000 )
	trace.filter = self.Entity

	local tr = util.TraceLine( trace )

	local dist = tr.HitPos:Distance( tr.StartPos )
	local scale = math.Clamp( 150 - dist, 0.25, 150 ) / 150

	if tr.Hit then

		phys:ApplyForceCenter( tr.HitNormal * ( phys:GetMass() * ( scale * self.Scale ) ) )

	end

end

function ENT:Think()

	local active = false

	for k,v in pairs( player.GetAll() ) do

		if v:GetPos():Distance( self.Entity:GetPos() ) < 2000 then

			active = true

		end

	end

	self.Active = active

	if active == false then

		self.ReActivate = true

	else

		local phys = self.Entity:GetPhysicsObject()

		if IsValid( phys ) then

			phys:Wake()

		end

	end

end

function ENT:OnTakeDamage( dmg )

	if dmg:GetAttacker():IsPlayer() then

		local phys = self.Entity:GetPhysicsObject()

		if IsValid( phys ) then

			phys:ApplyForceCenter( VectorRand() * ( phys:GetMass() * self.Scale * 2 ) )

		end

		if math.random(1,10) == 1 then

			self.Entity:EmitSound( table.Random( self.BumpSounds ), 100, math.random( 140, 180 ) )

		end

	end

end

function ENT:PhysicsCollide( data, phys )

	if data.HitEntity:IsPlayer() then

		//data.HitEntity:SetBleeding( true )
		data.HitEntity:TakeDamage( 0, self.Entity )

	end

	if data.DeltaTime > 0.15 and math.random(1,10) == 1 then

		self.Entity:EmitSound( table.Random( self.BumpSounds ), 100, math.random( 100, 150 ) )

	end

end

function ENT:Use( ply, caller )

end

-- Called when a player attempts to use a tool.
function ENT:CanTool(player, trace, tool)
	return false;
end;

function ENT:OnPhysgunReload(entity, player)
	return false;
end;
