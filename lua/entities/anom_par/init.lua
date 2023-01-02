AddCSLuaFile("shared.lua")
include("shared.lua")

ENT.cooldown = 0

hook.Add( "OnDamagedByExplosion", "DisableSound", function()
	return true
end )

sound.Add( {
	name = "par_blast",
	channel = CHAN_STATIC,
	volume = 0.5,
	level = 100,
	pitch = 100,
	sound = "anomaly/par_blast.wav"
} )

function ENT:Initialize()
	self:SetModel("models/props_junk/watermelon01.mdl")

	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)  
	self:SetSolid(SOLID_BBOX)	
	self:SetCollisionGroup(COLLISION_GROUP_WORLD)
	self:SetName("Steam Anomaly")
	self:SetTrigger(1)
	self:SetCollisionBounds( Vector( -60, -60, -5 ), Vector( 60, 60, 80 ) )
	self.Active = true
	self:SetRenderMode( RENDERMODE_TRANSTEXTURE ) 
	self:SetColor(Color(0,0,0,0))

    local phys = self:GetPhysicsObject()
	if (phys:IsValid()) then
		phys:Sleep()
		phys:EnableMotion(false)
	end
end

function ENT:StartTouch(ent)
	if not self.Active then return end
	timer.Create("par_activated_once"..self:EntIndex(), 0.01, 1, function()
		self:EmitSound("par_blast");
		ParticleEffectAttach( "par_anomaly", PATTACH_ABSORIGIN_FOLLOW, self, 1 )
		if IsValid(ent) and ent:IsRagdoll() then
			ent:Remove()
		end
		--util.BlastDamage( self, self, self:GetPos(), 100, 50)
		--ent:TakeDamage(50, self, self)
	end)
	timer.Create("par_activated"..self:EntIndex(), 12, 1, function()
		self:StopSound("par_blast");
		self.Active = true
		ParticleEffect("jarka_inactive", self:GetPos(), Angle(0,0,0), self)
		self:StopParticles()
	end)
	self.Active = false
end

function ENT:Touch(activator)
	--util.BlastDamage( self, self, self:GetPos(), 100, 2)
	if self.cooldown < CurTime() then
		activator:TakeDamage(30, self, self)
		self.cooldown = CurTime() + 0.5
	end
	
end

function ENT:SpawnFunction( ply, tr, ClassName, activator )
	if ( !tr.Hit ) then return end
	local SpawnPos = tr.HitPos + Vector(0, 0, 4)
	local SpawnAng = tr.HitNormal:Angle()
	SpawnAng.p = SpawnAng.p +90
	local ent = ents.Create( ClassName )
	ent:SetPos( SpawnPos )
	ent:SetAngles( SpawnAng )
	ent:Spawn()
	ent:Activate()
	ent:SetTrigger( 1 )
	ent:SetColor( Color( 0, 0, 0, 0 ) )
	ent:SetRenderMode( RENDERMODE_TRANSALPHA ) 
	return ent
end

function ENT:OnRemove()
	self:StopSound("par_blast")
	self:StopSound("par_idle")
	timer.Stop("par_activated"..self:EntIndex())
	Active = true
end