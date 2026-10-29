AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )

include('shared.lua')
local damage = 5

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
end

function ENT:Initialize()

	self.Entity:SetModel( "models/props_junk/watermelon01.mdl" ) --Set its model.
	//self.Entity:PhysicsInit( SOLID_NONE )      -- Make us work with physics,
	self.Entity:SetMoveType( MOVETYPE_NONE )   -- after all, gmod is a physics
	self.Entity:SetSolid( SOLID_NONE ) 	-- Toolbox
	self.Entity:SetKeyValue("rendercolor", "150 255 150")
	self.Entity:SetKeyValue("renderamt", "0")
	self.Entity:SetMaterial("models/props_combine/portalball001_sheet")
	
        local phys = self.Entity:GetPhysicsObject()
	if (phys:IsValid()) then
		phys:Wake()
	end
	
	self.cotzNextDamage = CurTime() + (self:EntIndex() % 10) * 0.02
end

function ENT:Think()
	local damageRange = math.max(self:GetNetVar("range", 600), 1)
	if ix and ix.eventController and not ix.eventController:HasPlayerNear(self:GetPos(), damageRange + 1000) then
		self:NextThink(CurTime() + 1)

		return true
	end
	if CurTime() >= (self.cotzNextDamage or 0) then
		self.cotzNextDamage = CurTime() + 0.2
		for _, v in player.Iterator() do
			if self:GetPos():DistToSqr(v:GetPos()) <= damageRange * damageRange then
				local dist = v:GetPos():Distance(self.Entity:GetPos())
				local scale = 1 - (dist / damageRange)
				
				
				local b = DamageInfo()
				b:SetDamage( damage * scale )
				b:SetDamageType( DMG_ACID )

				v:TakeDamageInfo( b )
			end
		end
	end
	self:NextThink(self.cotzNextDamage)

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
