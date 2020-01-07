AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )

include('shared.lua')

ENT.AutomaticFrameAdvance = true 
local delayTime = 0
local anomalyID = tostring(math.Rand(1,2))

function ENT:SpawnFunction( ply, tr )
	if ( !tr.Hit ) then return end
	local SpawnPos = tr.HitPos + Vector(0,-30,-95)
	local ent = ents.Create( self.ClassName )
	ent:SetPos( SpawnPos )
	ent:Spawn()
	ent:Activate()
	--timer.Create(anomalyID, 14400, 0, function()
	timer.Create(anomalyID, 7200 + math.random(7200), 0, function()
		if math.random(100) < 20 then
			local rnd = math.floor(math.Rand(1,101))
			if rnd > 1 and rnd < 50 then // 50 %
				nut.item.spawn("thorn", tr.HitPos+(Vector( math.Rand(-160,160), math.Rand(-160,160), 10 )), nil, AngleRand(), {})
			elseif  rnd > 50 and rnd < 85 then // 35 %
				nut.item.spawn("crystalthorn", tr.HitPos+(Vector( math.Rand(-160,160), math.Rand(-160,160), 10 )), nil, AngleRand(), {})
			elseif rnd > 85 and rnd < 101 then // 15 %
				nut.item.spawn("urchin", tr.HitPos+(Vector( math.Rand(-160,160), math.Rand(-160,160), 10 )), nil, AngleRand(), {})
			end
		end
	end )	return ent
	
end

function ENT:OnRemove()
	timer.Destroy(anomalyID)
end


function ENT:Initialize()

	self.Entity:SetModel( "models/tnb/props/cloth.mdl" ) --Set its model.
	//self.Entity:PhysicsInit( SOLID_NONE )      -- Make us work with physics,
	self.Entity:SetMoveType( MOVETYPE_NONE )   -- after all, gmod is a physics
	self.Entity:SetSolid( SOLID_NONE ) 	-- Toolbox
	
    local phys = self.Entity:GetPhysicsObject()
	if (phys:IsValid()) then
		phys:Wake()
	end
	self.Entity:ResetSequenceInfo() 
end

function ENT:Think()
	self.Entity:SetSequence("light_wind")
//	self.Entity:SetSequence("strong_wind")
	if delayTime < CurTime() then
		delayTime = CurTime() + 0.3
		for k, v in pairs( ents.FindInBox( self:GetPos() + Vector(-32,-32,0), self:GetPos() + Vector(32,32,-220))) do
			
			if v:IsPlayer() and v:Alive() and v:IsValid() then
				local b = DamageInfo()
				b:SetDamage( 20 )
				b:SetDamageType( DMG_ACID )
				b:SetAttacker( self.Entity )
				b:SetInflictor( self.Entity )

				v:TakeDamageInfo( b )
			
			self:EmitSound("ambient/levels/canals/toxic_slime_sizzle3.wav")
			end
	end
	end
	self:NextThink(CurTime())
	return true
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

