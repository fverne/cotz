
AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include( 'shared.lua' )

ENT.Damage = 80
ENT.Blast = Sound( "physics/nearmiss/whoosh_huge2.wav" )
ENT.Blast2 = Sound( "ambient/levels/citadel/portal_beam_shoot5.wav" )
local anomalyID = tostring(math.Rand(1,2))
--Wake variables
ENT.WakeRange = 600
ENT.SleepTimer = 0
ENT.IsSleeping = true --starts the anomaly out sleeping so it doesn't use a ton of server assets


function ENT:Initialize()
	
	self.Entity:SetMoveType( MOVETYPE_NONE )
	self.Entity:SetSolid( SOLID_NONE )
	self.Entity:SetModel( "models/props_junk/watermelon01.mdl" )
	self.Entity:SetKeyValue("renderamt", "0")
	self.Entity:SetMaterial("models/props_combine/portalball001_sheet")
	self.Entity:SetCollisionGroup( COLLISION_GROUP_DEBRIS_TRIGGER )
	self.Entity:SetTrigger( true )
	self.Entity:SetNotSolid( true )
	self.Entity:DrawShadow( false )

	self.Entity:SetCollisionBounds( Vector( -50, -50, -50 ), Vector( 50, 50, 50 ) )
	self.Entity:PhysicsInitBox( Vector( -50, -50, -50 ), Vector( 50, 50, 50 ) )

	self.LastHit = 0

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
				nut.item.spawn("stoneflower", tr.HitPos+(Vector( math.Rand(-160,160), math.Rand(-160,160), 10 )), nil, AngleRand(), {})
			elseif  rnd > 25 and rnd < 50 then // 25 %
				nut.item.spawn("jellyfish", tr.HitPos+(Vector( math.Rand(-160,160), math.Rand(-160,160), 10 )), nil, AngleRand(), {})
			elseif rnd > 50 and rnd < 70 then // 20 %
				nut.item.spawn("nightstar", tr.HitPos+(Vector( math.Rand(-160,160), math.Rand(-160,160), 10 )), nil, AngleRand(), {})
			elseif rnd > 70 and rnd < 83 then // 13 %
				nut.item.spawn("kolobok", tr.HitPos+(Vector( math.Rand(-160,160), math.Rand(-160,160), 10 )), nil, AngleRand(), {})
			elseif rnd > 83 and rnd < 96 then // 13 %
				nut.item.spawn("bubble", tr.HitPos+(Vector( math.Rand(-160,160), math.Rand(-160,160), 10 )), nil, AngleRand(), {})
			elseif rnd > 96 and rnd < 101 then // 4 %
				nut.item.spawn("firefly", tr.HitPos+(Vector( math.Rand(-160,160), math.Rand(-160,160), 10 )), nil, AngleRand(), {})
			end
		end
	end )
	
	return ent
end

function ENT:GetRadiationRadius()

	return 100

end

function ENT:OnRemove()
	timer.Destroy(anomalyID)
end

function ENT:Think()

	if self.SleepTimer < CurTime() then
		if self:ShouldWake(self.WakeRange) then
			self.IsSleeping = false
			self.SleepTimer = CurTime() + 5
		else
			self.IsSleeping = true
			self.SleepTimer = CurTime() + 5
		end
	end

	if self.IsSleeping then return end

	if self.BounceTime and self.BounceTime < CurTime() then

		self.BounceTime = nil

		local tbl = player.GetAll()
		tbl = table.Add( tbl, ents.FindByClass( "prop_phys*" ) )
		tbl = table.Add( tbl, ents.FindByClass( "prop_veh*" ) )
		tbl = table.Add( tbl, ents.FindByClass( "npc*" ) )

		local ed = EffectData()
		ed:SetOrigin( self.Entity:GetPos() + Vector( 0, 0, 5 ) )
		util.Effect( "dust_burst", ed, true, true )

		self.Entity:EmitSound( self.Blast2, 100, 70 )

		for k,ent in pairs( tbl ) do

			if ent:GetPos():Distance( self.Entity:GetPos() ) < 100 then

				if ent:IsPlayer() then

					local dir = ( ent:GetPos() - self.Entity:GetPos()  ):GetNormal()

					ent:SetVelocity( dir * 2000 )
						local d = DamageInfo()
						d:SetDamage( self.Damage )
						d:SetDamageType( DMG_ACID )

					ent:TakeDamageInfo( d )

				elseif string.find( ent:GetClass(), "npc" ) then

					ent:TakeDamage( self.Damage )

				elseif string.find( ent:GetClass(), "prop" ) then

					local phys = ent:GetPhysicsObject()

					if IsValid( phys ) then

						local dir = ( self.Entity:GetPos() - ent:GetPos() ):GetNormal()

						phys:ApplyForceCenter( dir * phys:GetMass() * 500 )

					end

				end

			end

		end

	end

end

function ENT:ShouldWake( range )
	local entities = ents.FindInSphere(self:GetPos(), range)
	for _,v in pairs(entities) do
		if v:IsPlayer() then
			return true
		end
	end
	return false
end

function ENT:Touch( ent )

	if self.LastHit > CurTime() then return end

	self.LastHit = CurTime() + 2
	self.BounceTime = CurTime() + 0.5

	self.Entity:EmitSound( self.Blast, 150, 150 )

end
