AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )

include('shared.lua')

local anomalyID = tostring(math.Rand(1,2))
--Wake variables
ENT.WakeRange = 600
ENT.SleepTimer = 0
ENT.IsSleeping = true --starts the anomaly out sleeping so it doesn't use a ton of server assets

function ENT:SpawnFunction( ply, tr )
	if ( !tr.Hit ) then return end
	local SpawnPos = tr.HitPos + tr.HitNormal * 16
	local ent = ents.Create( self.ClassName )
	ent:SetPos( SpawnPos )
	ent:Spawn()
	ent:Activate()

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
	self.Entity:DrawShadow(false)

	self.DustSize = 200
	self.DustChange = 0

	local phys = self.Entity:GetPhysicsObject()
	if (phys:IsValid()) then
		phys:Wake()
	end
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

	if( self.DustSize > 350 )then
		self.DustSize = 120
	end

    for k, v in pairs( ents.FindInSphere( self.Entity:GetPos(), 300 ) ) do
			--If it is a valid entity and nearby
		if( v:IsValid() and v:GetPhysicsObject():IsValid() and v:GetPos( ):Distance( self:GetPos( ) ) <= 300 ) then

            local dir = v:GetPos() - self:GetPos()
			local force = 35
			local distance = dir:Length()			// The distance the phys object is from the ent
			local maxdistance = 300				// The max distance

			// Lessen the force from a distance

			local ratio = math.Clamp( (1 - (distance/maxdistance)), 0, 1 )

			// Set up the 'real' force and the offset of the force
			local vForce = -1*dir * (force * ratio)

			// Apply it!
			v:GetPhysicsObject():ApplyForceOffset( vForce, dir )

		end

		if( v:IsPlayer() and v:IsValid() and v:GetPos( ):Distance( self:GetPos( ) ) <= 370 ) then
		 local dir = v:GetPos() - self:GetPos()

		  v:SetVelocity(dir * -1.2)
		end
	end

	if(self.DustChange < CurTime() )then
	self.DustChange = CurTime() + 1.6
	self.DustSize = self.DustSize + 5

	--Let make it shake nearby players.
	local shake = ents.Create("env_shake")
	shake:SetKeyValue("duration", 1)
	shake:SetKeyValue("amplitude", 13)
	shake:SetKeyValue("radius", 500)
	shake:SetKeyValue("frequency", 800)
	shake:SetPos(self.Entity:GetPos())
	shake:Spawn()
	shake:Fire("StartShake","","0.6")
	shake:Fire("kill", "", 1)

	local brange = math.random( 64, 350 )
	local b = ents.Create( "point_hurt" )
	b:SetKeyValue("targetname", "pointhurt" )
	b:SetKeyValue("DamageRadius", brange )
	b:SetKeyValue("Damage",  math.random( 11, 19 ) )
	b:SetKeyValue("DamageDelay", "5" )
	b:SetKeyValue("DamageType", "DMG_ACID" )
	b:SetPos( self.Entity:GetPos() )
	b:Spawn()
	b:Fire("turnon", "", 0)
	b:Fire("turnoff", "", 1)
	b:Fire("kill", "", 1)
	
	local tonormlal = self.Entity:GetPos()+Vector( 0, 0, math.Rand( -100, 170) )
	local effectdata = EffectData()
	effectdata:SetStart( self.Entity:GetPos() + Vector( 0, 0, math.Rand( -100, 170) ) )
	effectdata:SetOrigin( self.Entity:GetPos() + Vector( 0, 0, math.Rand( -100, 170) ))
	effectdata:SetNormal(  tonormlal:GetNormal() )
	effectdata:SetScale( self.DustSize )
	effectdata:SetRadius( 16 )
	effectdata:SetMagnitude( 8 )
	util.Effect( "ThumperDust", effectdata )
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