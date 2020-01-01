AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )

include('shared.lua')

function ENT:SpawnFunction( ply, tr )
	if ( !tr.Hit ) then return end
	local SpawnPos = tr.HitPos + tr.HitNormal * 16
	local ent = ents.Create( self.ClassName )
	ent:SetPos( SpawnPos )
	ent:Spawn()
	ent:Activate()
//	timer.Create("batteryTimer", 5, 0, function() nut.item.spawn("battery", tr.HitPos+(Vector( math.Rand(-100,100), math.Rand(-100,100), 10 )), nil, AngleRand(), {}) end )
	return ent
end

function ENT:Initialize()

	self.Entity:SetModel( "models/props_junk/watermelon01.mdl" ) --Set its model.
	//self.Entity:PhysicsInit( SOLID_NONE )      -- Make us work with physics,
	self.Entity:SetMoveType( MOVETYPE_NONE )   -- after all, gmod is a physics
	self.Entity:SetSolid( SOLID_NONE ) 	-- Toolbox
	self.Entity:SetKeyValue("rendercolor", "150 255 150")
	self.Entity:SetKeyValue("renderamt", "0")
	self.Entity:SetMaterial("models/props_combine/portalball001_sheet")
	MakeSprite( self.Entity, "15", "100 100 100", "sprites/glow1.vmt", "10", "255")
	MakeSprite( self.Entity, "23", "250 250 250", "sprites/glow1.vmt", "5", "150")
        local phys = self.Entity:GetPhysicsObject()
	if (phys:IsValid()) then
		phys:Wake()
	end
end

function MakeSprite( Entity, fx, color, spritePath, scale, transity)
	local Sprite = ents.Create("env_sprite");
	Sprite:SetPos( Entity:GetPos() );
	Sprite:SetKeyValue( "renderfx", fx )
	Sprite:SetKeyValue( "model", spritePath)
	Sprite:SetKeyValue( "scale", scale)
	Sprite:SetKeyValue( "spawnflags", "1")
	Sprite:SetKeyValue( "angles", "0 0 0")
	Sprite:SetKeyValue( "rendermode", "9")
	Sprite:SetKeyValue( "renderamt", transity)
	Sprite:SetKeyValue( "rendercolor", color )

	Sprite:Spawn()
	Sprite:Activate()
	Sprite:SetParent( Entity )
end

function ENT:Think()

    for k, v in pairs( ents.FindInSphere( self.Entity:GetPos(), 400 )  ) do
			--If it is a valid entity and nearby
		if v:GetClass() != "anom_physicspush" then -- if the entity isnt a anom_physicspush
			if( v:IsValid() and v:GetPhysicsObject():IsValid() and v:GetPos( ):Distance( self:GetPos( ) ) <= 300 ) then

				local dir = self:GetPos() - v:GetPos()
				local force = 35

				// Lessen the force from a distance

				// Set up the 'real' force and the offset of the force
				local newForce = -1 * dir * force

				// Apply it!
				--v:GetPhysicsObject():ApplyForceOffset( newForce, dir )
				v:GetPhysicsObject():SetVelocity( newForce )

			end

			if( v:IsPlayer() and v:IsValid() and v:GetPos( ):Distance( self:GetPos( ) ) <= 350 ) then
				local dir = v:GetPos() - self:GetPos()
				v:SetVelocity(dir * 5)
			end
		end

	if v:IsPlayer() and v:IsValid() and v:GetPos( ):Distance( self:GetPos( ) ) <= 1200 then
		self:EmitSound("hgn/stalker/anom/gravy_blast1.mp3")

		local brange = math.random( 120, 570 )
		local b = ents.Create( "point_hurt" )
		b:SetKeyValue("targetname", "fier" )
		b:SetKeyValue("DamageRadius", brange )
		b:SetKeyValue("Damage",  math.random( 11, 19 ) )
		b:SetKeyValue("DamageDelay", "5" )
		b:SetKeyValue("DamageType", "1048576" )
		b:SetPos( self.Entity:GetPos() )
		b:Spawn()
		b:Fire("turnon", "", 0)
		b:Fire("turnoff", "", 1)
		b:Fire("kill", "", 1)
		end
	end

		local shake = ents.Create("env_shake")
		shake:SetKeyValue("duration", 1)
		shake:SetKeyValue("amplitude", 20)
		shake:SetKeyValue("radius", 900)
		shake:SetKeyValue("frequency", 100)
		shake:SetPos(self:GetPos())
		shake:Spawn()
		shake:Fire("StartShake","","0.6")
		shake:Fire("kill", "", 1)

		local exp = ents.Create("env_smoketrail")
			exp:SetKeyValue("startsize","400")
			exp:SetKeyValue("endsize","128")
			exp:SetKeyValue("spawnradius","64")
			exp:SetKeyValue("minspeed","1")
			exp:SetKeyValue("maxspeed","2")
			exp:SetKeyValue("startcolor","120 220 220")
			exp:SetKeyValue("endcolor","220 140 220")
			exp:SetKeyValue("opacity",".8")
			exp:SetKeyValue("spawnrate","10")
			exp:SetKeyValue("lifetime","1")
			exp:SetPos(self.Entity:GetPos())
			exp:SetParent(self.Entity)
		    exp:Spawn()
		exp:Fire("kill","",0.5)
end

function ENT:Use( activator, caller, type, value )
end

function ENT:KeyValue( key, value )
end

function ENT:OnTakeDamage( dmginfo )
end

function ENT:StartTouch( entity )
end

function ENT:EndTouch( entity )
end

function ENT:Touch( entity )
end

function MakeSprite( Entity, fx, color, spritePath, scale, transity)
	local Sprite = ents.Create("env_sprite");
	Sprite:SetPos( Entity:GetPos() );
	Sprite:SetKeyValue( "renderfx", fx )
	Sprite:SetKeyValue( "model", spritePath)
	Sprite:SetKeyValue( "scale", scale)
	Sprite:SetKeyValue( "spawnflags", "1")
	Sprite:SetKeyValue( "angles", "0 0 0")
	Sprite:SetKeyValue( "rendermode", "9")
	Sprite:SetKeyValue( "renderamt", transity)
	Sprite:SetKeyValue( "rendercolor", color )

	Sprite:Spawn()
	Sprite:Activate()
	Sprite:SetParent( Entity )
end
