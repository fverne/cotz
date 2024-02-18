AddCSLuaFile("shared.lua")
AddCSLuaFile("cl_init.lua")
include("shared.lua")

hook.Add( "OnDamagedByExplosion", "DisableSound", function()
	return true
end )

sound.Add( {
	name = "myasorubka_blast",
	channel = CHAN_STATIC,
	volume = 1,
	level = 100,
	pitch = 100,
	sound = "anomaly/myasorubka_blast1.mp3"
} )

function ENT:Initialize()
	self:SetModel("models/props_junk/watermelon01.mdl")

	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)  
	self:SetSolid(SOLID_BBOX)	
	self:SetCollisionGroup(COLLISION_GROUP_WORLD)
	self:SetName("Tramplin Anomaly 2")
	self:SetTrigger(1)
	self:SetCollisionBounds( Vector( -60, -60, -5 ), Vector( 60, 60, 40 ) )
	self:SetRenderMode( RENDERMODE_TRANSTEXTURE ) 
	self:SetColor(Color(0,0,0,0))
	self:SetNWBool("StopParticle", false)

    local phys = self:GetPhysicsObject()
	if (phys:IsValid()) then
		phys:Sleep()
		phys:EnableMotion(false)
	end
end

function ENT:StartTouch(ent)
	self:EmitSound("anomaly/anomaly_gravy_hit1.mp3")
	timer.Create("myasorubka_activated_once_type2", 0.1, 1, function()
		self:EmitSound("myasorubka_blast")
		ParticleEffect( "myasorubka_activated", self:GetPos() + Vector( 0, 0, 41 ), Angle( 0, 0, 0 ) )
		--util.BlastDamage( self, self, self:GetPos(), 150, 150)
		ent:TakeDamage(75, self, self)
		if IsValid(ent) and ent:IsRagdoll() and ent:GetNetVar("player") == nil then
			ent:Remove()
		end
		self:StopParticles()
		self:SetNWBool("StopParticle", true)
	end)	
	timer.Create("myasorubka_activated_type2", 1.4, 0, function()
		self:EmitSound("myasorubka_blast")
		ParticleEffect( "myasorubka_activated", self:GetPos() + Vector( 0, 0, 41 ), Angle( 0, 0, 0 ) )
		--util.BlastDamage( self, self, self:GetPos(), 150, 150)
		ent:TakeDamage(75, self, self)
		if IsValid(ent) and ent:IsRagdoll() and ent:GetNetVar("player") == nil then
			ent:Remove()
		end
		self:StopParticles()
		self:SetNWBool("StopParticle", true)
	end)
end

function ENT:EndTouch()
	timer.Stop("myasorubka_activated_type2")
	timer.Stop("myasorubka_recharge_type2")
	self.Timer = "myasorubka_type2" .. self:EntIndex()
	timer.Create( self.Timer, 0.5, 1, function()
		self:SetNWBool("StopParticle", false)
		self:SetNWBool("Activated", false)
	end)
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
	self.Timer = "myasorubka_type2" .. self:EntIndex()
	self:StopSound("myasorubka_idle")
	timer.Stop(self.Timer)
	timer.Stop("myasorubka_activated_type2")
	timer.Stop("myasorubka_recharge_type2")
end