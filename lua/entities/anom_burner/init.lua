AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include( 'shared.lua' )

ENT.Damage = 4
ENT.Blast = Sound( "hgn/stalker/anom/burner_blow.mp3" )
ENT.Death = Sound( "ambient/fire/mtov_flame2.wav" )
ENT.Burn = Sound( "Fire.Plasma" )
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

	self.Entity:SetCollisionBounds( Vector( -100, -100, -100 ), Vector( 100, 100, 100 ) )
	self.Entity:PhysicsInitBox( Vector( -100, -100, -100 ), Vector( 100, 100, 100 ) )

	self.BurnTime = 0
end

function ENT:OnRemove()
	timer.Destroy(anomalyID)
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
			if rnd > 1 and rnd < 40 then // 40 %
				nut.item.spawn("droplet", tr.HitPos+(Vector( math.Rand(-160,160), math.Rand(-160,160), 10 )), nil, AngleRand(), {})
			elseif  rnd > 40 and rnd < 60 then // 20 %
				nut.item.spawn("fireball", tr.HitPos+(Vector( math.Rand(-160,160), math.Rand(-160,160), 10 )), nil, AngleRand(), {})
			elseif rnd > 60 and rnd < 80 then // 20 %
				nut.item.spawn("mamasbeads", tr.HitPos+(Vector( math.Rand(-160,160), math.Rand(-160,160), 10 )), nil, AngleRand(), {})
			elseif rnd > 80 and rnd < 88 then // 8 %
				nut.item.spawn("crystal", tr.HitPos+(Vector( math.Rand(-160,160), math.Rand(-160,160), 10 )), nil, AngleRand(), {})
			elseif rnd > 88 and rnd < 96 then // 8 %
				nut.item.spawn("eye", tr.HitPos+(Vector( math.Rand(-160,160), math.Rand(-160,160), 10 )), nil, AngleRand(), {})
			elseif rnd > 96 and rnd < 101 then // 4 %
				nut.item.spawn("flame", tr.HitPos+(Vector( math.Rand(-160,160), math.Rand(-160,160), 10 )), nil, AngleRand(), {})
			end
		end
	end )
	return ent
end


function ENT:SetArtifact( ent )

	self.Artifact = ent
end

function ENT:GetArtifact()

	return self.Artifact or NULL
end

function ENT:GetRadiationRadius()

	return 200
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

	if self.BurnTime and self.BurnTime >= CurTime() then

		local tbl = player.GetAll()
		tbl = table.Add( tbl, ents.FindByClass( "npc*" ) )

		for k,ent in pairs( tbl ) do

			if ent:GetPos():Distance( self.Entity:GetPos() ) < 150 then

				if ent:IsPlayer() then

					local dmg = DamageInfo()
					dmg:SetDamage( self.Damage )
					dmg:SetDamageType( DMG_ACID )
					dmg:SetAttacker( self.Entity )
					dmg:SetInflictor( self.Entity )

					ent:TakeDamageInfo( dmg )

				elseif string.find( ent:GetClass(), "npc" ) then

					ent:TakeDamage( self.Damage )

				end

			end

		end

	elseif self.BurnTime and self.BurnTime < CurTime() then

		self.BurnTime = nil

		self.Entity:StopSound( self.Burn )
		self.Entity:EmitSound( self.Death, 150, 100 )

		self.Entity:SetNWBool( "Burn", false )

	end

end

function ENT:Touch( ent )

	if ent == self.Entity:GetArtifact() then return end

	if self.BurnTime != nil then

		if self.BurnTime >= CurTime() then

			return

		end

	end

	self.BurnTime = CurTime() + 10

	self.Entity:SetNWBool( "Burn", true )

	self.Entity:EmitSound( self.Blast, 150, 100 )
	self.Entity:EmitSound( self.Burn, 100, 100 )
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

function ENT:UpdateTransmitState()

	return TRANSMIT_ALWAYS
end
