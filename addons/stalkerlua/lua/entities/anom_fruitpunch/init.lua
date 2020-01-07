AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )

include('shared.lua')
local delayTime = 0
local anomalyID = tostring(math.Rand(1,2))

function ENT:SpawnFunction( ply, tr )
	if ( !tr.Hit ) then return end
	local SpawnPos = tr.HitPos + tr.HitNormal * 16
	local ent = ents.Create( self.ClassName )
	ent:SetPos( SpawnPos )
	ent:Spawn()
	ent:Activate()
	--timer.Create(anomalyID, 21600, 0, function()
	timer.Create(anomalyID, 10800 + math.random(10800), 0, function()
		if math.random(100) < 20 then
			local rnd = math.floor(math.Rand(1,101))
			if rnd > 1 and rnd < 25 then // 25 %
				nut.item.spawn("slime", tr.HitPos+(Vector( math.Rand(350,600), math.Rand(-350,600), 10 )), nil, AngleRand(), {})
			elseif  rnd > 25 and rnd < 45 then // 20 %
				nut.item.spawn("stoneblood", tr.HitPos+(Vector( math.Rand(350,600), math.Rand(-350,600), 10 )), nil, AngleRand(), {})
			elseif rnd > 45 and rnd < 65 then // 20 %
				nut.item.spawn("meatchunk", tr.HitPos+(Vector( math.Rand(350,600), math.Rand(-350,600), 10 )), nil, AngleRand(), {})
			elseif rnd > 65 and rnd < 85 then // 20 %
				nut.item.spawn("soul", tr.HitPos+(Vector( math.Rand(350,600), math.Rand(-350,600), 10 )), nil, AngleRand(), {})
			elseif rnd > 85 and rnd < 95 then // 13 %
				nut.item.spawn("slug", tr.HitPos+(Vector( math.Rand(350,600), math.Rand(-350,600), 10 )), nil, AngleRand(), {})
			elseif rnd > 95 and rnd < 101 then // 7 %
				nut.item.spawn("mica", tr.HitPos+(Vector( math.Rand(350,600), math.Rand(-350,600), 10 )), nil, AngleRand(), {})
			end
		end
	end )
	return ent
end

function ENT:OnRemove()
	timer.Destroy(anomalyID)
end

function ENT:Initialize()

	self.Entity:SetModel( "models/props_junk/watermelon01.mdl" ) --Set its model.
	//self.Entity:PhysicsInit( SOLID_NONE )      -- Make us work with physics,
	self.Entity:SetMoveType( MOVETYPE_NONE )   -- after all, gmod is a physics
	self.Entity:SetSolid( SOLID_NONE ) 	-- Toolbox
	self.Entity:SetKeyValue("rendercolor", "150 255 150")
	self.Entity:SetKeyValue("renderamt", "0")
	self.Entity:SetMaterial("models/props_combine/portalball001_sheet")
	MakeSprite( self.Entity, "15", "100 255 100", "sprites/glow1.vmt", "3", "255")
	MakeSprite( self.Entity, "23", "250 250 250", "sprites/glow1.vmt", "1", "150")
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
	if delayTime < CurTime() then
		delayTime = CurTime() + 1 
		for k, v in pairs( ents.FindInSphere( self.Entity:GetPos(), 400 )  ) do
			if v:IsPlayer() and v:IsValid() and v:GetPos( ):Distance( self:GetPos( ) ) <= 64 then
				local b = DamageInfo()
				b:SetDamage( math.random( 5, 11 ) )
				b:SetDamageType( DMG_ACID )

				v:TakeDamageInfo( b )
			
				self:EmitSound("ambient/levels/canals/toxic_slime_sizzle3.wav")
			end
		end
	end
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
