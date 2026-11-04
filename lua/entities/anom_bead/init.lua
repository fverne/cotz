AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include( 'shared.lua' )

--Wake variables
ENT.WakeRange = 2500
ENT.SleepTimer = 0
ENT.IsSleeping = true --starts the anomaly out sleeping so it doesn't use a ton of server assets


ENT.Pain = { Sound( "ambient/atmosphere/thunder1.wav" ),
Sound( "ambient/atmosphere/thunder2.wav" ),
Sound( "ambient/atmosphere/thunder3.wav" ),
Sound( "ambient/atmosphere/thunder4.wav" ),
Sound( "ambient/atmosphere/terrain_rumble1.wav" ),
Sound( "ambient/atmosphere/hole_hit4.wav" ),
Sound( "ambient/atmosphere/cave_hit5.wav" ) }

ENT.Rape = Sound( "npc/strider/striderx_alert5.wav" )
ENT.Die = Sound( "NPC_Strider.OpenHatch" )
ENT.Cook = Sound( "ambient.whoosh_large_incoming1" )
ENT.Distance = 700

function ENT:Initialize()

	self.Entity:SetModel( "models/props_phx/misc/smallcannonball.mdl" )

	self.Entity:PhysicsInit( SOLID_VPHYSICS )
	self.Entity:SetMoveType( MOVETYPE_VPHYSICS )
	self.Entity:SetSolid( SOLID_VPHYSICS )

	local phys = self.Entity:GetPhysicsObject()

	if IsValid( phys ) then

		phys:Wake()
		phys:SetMaterial( "gmod_silent" )

	end

	self.Entity:StartMotionController()

	self.Entity:EmitSound( self.Rape )

	self.SoundTime = 0

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


function ENT:PhysicsSimulate( phys, delta )
	if self.IsSleeping then return SIM_NOTHING end

	phys:Wake()

	local trace = {}
	trace.start = self.Entity:GetPos()
	trace.endpos = trace.start + Vector(0,0,-9000)
	trace.filter = self.Entity

	local tr = util.TraceLine( trace )

	local pos = tr.HitPos + tr.HitNormal * ( 150 + math.sin( CurTime() * 3 ) * 100 )

	phys:ApplyForceCenter( ( pos - self.Entity:GetPos() ):GetNormal() * phys:GetMass() * 50 )

	
end

function ENT:GetRadiationRadius()

	return 800

end

function ENT:ShouldWake(range)
	if ix and ix.eventController then
		return ix.eventController:HasPlayerNear(self:GetPos(), range)
	end

	for _, client in player.Iterator() do
		if self:GetPos():DistToSqr(client:GetPos()) <= range * range then
			return true
		end
	end

	return false
end

function ENT:OnTakeDamage( dmg )

end

function ENT:OnRemove()

	for k, v in player.Iterator() do

		if IsValid( v ) and v:Alive() and self.Entity:GetPos():Distance( v:GetPos() ) < self.Distance then

			local scale = 1 - math.Clamp( self.Entity:GetPos():Distance( v:GetPos() ) / self.Distance, 0, 1 )

			util.ScreenShake( v:GetPos(), scale * 25, scale * 25, 2, 100 )

			v:TakeDamage( 100 * scale, self.Entity )

			if scale > 0.5 then

				v:EmitSound( self.Cook )
				//v:SetModel( table.Random( GAMEMODE.Corpses ) )
				v:Kill()

			end

		end

	end

	local ed = EffectData()
	ed:SetOrigin( self.Entity:GetPos() )
	util.Effect( "bead_explode", ed, true, true )

	self.Entity:EmitSound( self.Die )

end

function ENT:Think()
	self.IsSleeping = not self:ShouldWake(self.WakeRange)
	local phys = self:GetPhysicsObject()
	if IsValid(phys) then
		phys:EnableMotion(not self.IsSleeping)
		if not self.IsSleeping then phys:Wake() end
	end

	if not self.IsSleeping and self.SoundTime < CurTime() then
		self.SoundTime = CurTime() + math.Rand(0.5, 1.5)
		self:EmitSound(table.Random(self.Pain), 100, math.random(200, 220))
	end
	self:NextThink(CurTime() + (self.IsSleeping and 1 or 0.5))

	return true
end

function ENT:Use( ply, caller )

end
