AddCSLuaFile("shared.lua")
AddCSLuaFile("cl_init.lua")
include("shared.lua")

hook.Add( "OnDamagedByExplosion", "DisableSound", function()
	return true
end )

sound.Add( {
	name = "tramplin_blast",
	channel = CHAN_STATIC,
	volume = 1,
	level = 100,
	pitch = 100,
	sound = "anomaly/tramplin_blast.wav"
} )

function ENT:Initialize()
	self:SetModel("models/props_junk/watermelon01.mdl")

	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)  
	self:SetSolid(SOLID_BBOX)	
	self:SetCollisionGroup(COLLISION_GROUP_WORLD)
	self:SetName("Tramplin Anomaly")
	self:SetTrigger(1)
	self:SetCollisionBounds( Vector( -60, -60, -5 ), Vector( 60, 60, 80 ) )
	self:SetNWBool("StopParticle", false)
	self.Active = true
	self:SetRenderMode( RENDERMODE_TRANSTEXTURE ) 
	self:SetColor(Color(0,0,0,0))

    local phys = self:GetPhysicsObject()
	if (phys:IsValid()) then
		phys:Sleep()
		phys:EnableMotion(false)
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

function ENT:Think()
		for k,v in pairs(ents.FindInSphere(self:GetPos()+Vector(0,0,300),300)) do
			if v == self then return end
			if v:IsPlayer() then
				v:SetVelocity( (self:GetPos()+Vector(0,0,300) - v:GetPos()) * 1.5)
			end
		end
end

function ENT:StartTouch( ply )
	if not self.Active == true then 
	timer.Create("tramplin_activated_once", 0.01, 1, function()
		self:EmitSound("tramplin_blast");
		ParticleEffect( "tramplin_activated", self:GetPos(), Angle( 0, 0, 0 ) )
		self:StopParticles()
		self:StopSound("tramplin_idle")
		self:SetNWBool("StopParticle", true)
		self.Active = true
	end)
	timer.Create("tramplin_stop_sound"..self:EntIndex(), 2, 1, function()
		self:StopSound("tramplin_idle")
	end)
	timer.Create("tramplin_recharge"..self:EntIndex(), 6.7, 1, function()
		self:SetNWBool("StopParticle", false)
	self.Active = false
	end)
	timer.Create("tramplin_activated"..self:EntIndex(), 6, 1, function()
		ParticleEffect( "tramplin_blast", self:GetPos(), Angle( 0, 0, 0 ) )
		util.BlastDamage( self, self, self:GetPos()+Vector(50,50,300), 250, 400)
		if IsValid(ent) and ent:IsRagdoll() then
			ent:Remove()
		end
		--ply:TakeDamage(99999, self, self)
	end)
	end
end

function ENT:OnRemove()
	self.Timer = "tramplin_" .. self:EntIndex()
	self:StopSound("tramplin_idle")
	timer.Stop(self.Timer)
	timer.Stop("tramplin_recharge"..self:EntIndex())
	timer.Stop("tramplin_activated"..self:EntIndex())
	timer.Stop("tramplin_stop_sound"..self:EntIndex())
end