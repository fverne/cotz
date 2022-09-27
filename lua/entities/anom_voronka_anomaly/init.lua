AddCSLuaFile("shared.lua")
AddCSLuaFile("cl_init.lua")
include("shared.lua")

hook.Add( "OnDamagedByExplosion", "DisableSound", function()
	return true
end )

sound.Add( {
	name = "voronka_blast",
	channel = CHAN_STATIC,
	volume = 1,
	level = 100,
	pitch = 100,
	sound = "anomaly/voronka_blast1.mp3"
} )

function ENT:Initialize()
	self:SetModel("models/props_junk/watermelon01.mdl")

	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)  
	self:SetSolid(SOLID_BBOX)	
	self:SetCollisionGroup(COLLISION_GROUP_WORLD)
	self:SetName("Electra Anomaly")
	self:SetTrigger(1)
	self.Active = true
	self:SetCollisionBounds( Vector( -100, -100, -5 ), Vector( 100, 100, 80 ) )
	self:SetNWBool("StopParticle", false)
	self:SetRenderMode( RENDERMODE_TRANSTEXTURE ) 
	self:SetColor(Color(0,0,0,0))

    local phys = self:GetPhysicsObject()
	if (phys:IsValid()) then
		phys:Sleep()
		phys:EnableMotion(false)
	end
end

function ENT:Think()
		for k,v in pairs(ents.FindInSphere(self:GetPos(),100)) do
			if v:IsPlayer() then
				v:SetVelocity( (self:GetPos() - v:GetPos()) * 4 )
			else
				local phys = v:GetPhysicsObject()
				if IsValid(phys) then
					phys:ApplyForceCenter( (self:GetPos() - v:GetPos()) * phys:GetMass() )
				end
			end
		end
	end

function ENT:StartTouch(ent)
	if not self.Active then return end
	timer.Create("voronka_activated_once", 0.01, 1, function()
		self:EmitSound("voronka_blast");
		ParticleEffect( "voronka_activated", self:GetPos(), Angle( 0, 0, 0 ) )
		self:StopParticles()
		self:SetNWBool("StopParticle", true)
		self:StopSound("voronka_idle")
	end)	
	timer.Create("voronka_recharge"..self:EntIndex(), 4, 1, function()
		self:SetNWBool("StopParticle", false)
		self.Active = true
	end)
	timer.Create("voronka_activated"..self:EntIndex(), 2.0, 1, function()
		ParticleEffect( "voronka_blast", self:GetPos(), Angle( 0, 0, 0 ) )
		util.BlastDamage( self, self, self:GetPos(), 120, 150)
		--ent:TakeDamage(1100, self, self)
		self.Active = false
	end)
	self.Active = false
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
	self:StopSound("voronka_idle")
	self.Timer = "voronka_" .. self:EntIndex()
	timer.Stop(self.Timer)
	timer.Stop("voronka_recharge"..self:EntIndex())
	timer.Stop("voronka_activated"..self:EntIndex())
end