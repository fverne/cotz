AddCSLuaFile( "shared.lua" )
include('shared.lua')

local anomalyID = tostring(math.Rand(1,2))

function ENT:Initialize()

	self.Entity:SetModel( "models/props_junk/watermelon01.mdl" )
	//self.Entity:PhysicsInit( SOLID_NONE )
	self.Entity:SetMoveType( MOVETYPE_NONE )
	self.Entity:SetSolid( SOLID_NONE )
	self.Entity:SetKeyValue("rendercolor", "150 255 150")
	self.Entity:SetKeyValue("renderamt", "0")
	self.Entity:SetMaterial("models/props_combine/portalball001_sheet")
	self.Entity:DrawShadow( false )

    local phys = self.Entity:GetPhysicsObject()
	if (phys:IsValid()) then
		phys:Wake()
	end
end

function ENT:SpawnFunction( ply, tr )
	if ( !tr.Hit ) then return end
	local SpawnPos = tr.HitPos + tr.HitNormal * 16
	local ent = ents.Create( self.ClassName )
	ent:SetPos( SpawnPos )
	ent:Spawn()
	ent:Activate()
	// Spawns a random artifact every 4 hour
	--timer.Create(anomalyID, 14400, 0, function()
	timer.Create(anomalyID, 7200 + math.random(7200), 0, function()
		if math.random(100) < 20 then
			local rnd = math.floor(math.Rand(1,101))
			if rnd > 1 and rnd < 25 then // 25 %
				nut.item.spawn("battery", tr.HitPos+(Vector( math.Rand(-160,160), math.Rand(-160,160), 10 )), nil, AngleRand(), {})
			elseif  rnd > 25 and rnd < 50 then // 25 %
				nut.item.spawn("sparkler", tr.HitPos+(Vector( math.Rand(-160,160), math.Rand(-160,160), 10 )), nil, AngleRand(), {})
			elseif rnd > 50 and rnd < 65 then // 15 %
				nut.item.spawn("shell", tr.HitPos+(Vector( math.Rand(-160,160), math.Rand(-160,160), 10 )), nil, AngleRand(), {})
			elseif rnd > 65 and rnd < 80 then // 15 %
				nut.item.spawn("moonlight", tr.HitPos+(Vector( math.Rand(-160,160), math.Rand(-160,160), 10 )), nil, AngleRand(), {})
			elseif rnd > 80 and rnd < 95 then // 15 %
				nut.item.spawn("flash", tr.HitPos+(Vector( math.Rand(-160,160), math.Rand(-160,160), 10 )), nil, AngleRand(), {})
			elseif rnd > 95 and rnd < 101 then // 5 %
				nut.item.spawn("snowflake", tr.HitPos+(Vector( math.Rand(-160,160), math.Rand(-160,160), 10 )), nil, AngleRand(), {})
			end
		end
	end )

	return ent
end

function ENT:OnRemove()
	timer.Destroy(anomalyID)
end

function ENT:Think()

	local brange = math.random( 64, 350 )
		local b = ents.Create( "point_hurt" )
		b:SetKeyValue("targetname", "pointhurtfire" )
		b:SetKeyValue("DamageRadius", brange )
		b:SetKeyValue("Damage",  math.random( 11, 19 ) )
		b:SetKeyValue("DamageDelay", "5" )
		b:SetKeyValue("DamageType", "1048576" ) // acid
		b:SetPos( self.Entity:GetPos() )
		b:Spawn()
		b:Fire("turnon", "", 0)
		b:Fire("turnoff", "", 1)
		b:Fire("kill", "", 1)

		local tesla = ents.Create( "point_tesla" )
		tesla:SetPos( self.Entity:GetPos() )

		tesla:SetKeyValue("targetname", "electroanom" )
		tesla:SetKeyValue("m_flRadius", "200" )
		tesla:SetKeyValue("m_SourceEntityName", "electroanom" )
		tesla:SetKeyValue("m_Color", "255 255 255" )
		tesla:SetKeyValue("beamcount_min", "2" )
		tesla:SetKeyValue("beamcount_max", "4" )
		tesla:SetKeyValue("texture", "sprites/physbeam.vmt" )
		tesla:SetKeyValue("thick_min", "4" )
		tesla:SetKeyValue("thick_max", "8" )
		tesla:SetKeyValue("lifetime_min", "0.3" )
		tesla:SetKeyValue("lifetime_max", "0.8" )
		tesla:SetKeyValue("interval_min", "0" )
		tesla:SetKeyValue("interval_max", "1" )

		tesla:Spawn()
		tesla:Activate()

		tesla:SetParent(self.Entity)
		tesla:SetOwner(self.Entity);

		tesla:Fire("turnon", "", 0)
		tesla:Fire("DoSpark", "", 0)
		self:EmitSound("hgn/stalker/anom/electra_idle1.wav", 80, 50)
	
		for k, v in pairs( ents.FindInSphere( self.Entity:GetPos(), 300 ) ) do
			if( v:IsPlayer() and v:IsValid() and v:GetPos( ):Distance( self:GetPos( ) ) <= 400 ) then
				if math.random(1,10)==10 then
					self:EmitSound("hgn/stalker/anom/electra_blast1.mp3")
					local ed = EffectData()
					ed:SetOrigin( self.Entity:GetPos() + Vector( 0, 0, 5 ) )
					for i=0,5 do
						self:BigSpark()
					end
					util.Effect( "dust_burst", ed, true, true )
				end
			end
		end
		tesla:Fire("turnoff", "", 1)
		tesla:Fire("kill", "", 1)
end

function ENT:BigSpark()
	local tesla = ents.Create( "point_tesla" )
		tesla:SetPos( self.Entity:GetPos() )

		tesla:SetKeyValue("targetname", "electroanom" )
		tesla:SetKeyValue("m_flRadius", "300" )
		tesla:SetKeyValue("m_SourceEntityName", "electroanom" )
		tesla:SetKeyValue("m_Color", "255 255 255" )
		tesla:SetKeyValue("beamcount_min", "2" )
		tesla:SetKeyValue("beamcount_max", "4" )
		tesla:SetKeyValue("texture", "sprites/physbeam.vmt" )
		tesla:SetKeyValue("thick_min", "4" )
		tesla:SetKeyValue("thick_max", "8" )
		tesla:SetKeyValue("lifetime_min", "0.3" )
		tesla:SetKeyValue("lifetime_max", "0.5" )
		tesla:SetKeyValue("interval_min", "0" )
		tesla:SetKeyValue("interval_max", "0.1" )

		tesla:Spawn()
		tesla:Activate()

		tesla:SetParent(self.Entity)
		tesla:SetOwner(self.Entity);

		tesla:Fire("turnon", "", 0)
		tesla:Fire("DoSpark", "", 0)
		self:EmitSound("hgn/stalker/anom/electra_idle1.wav", 80, 50)
		tesla:Fire("turnoff", "", 1)
		tesla:Fire("kill", "", 1)
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
