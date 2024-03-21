AddCSLuaFile("shared.lua")
AddCSLuaFile("cl_init.lua")
include("shared.lua")

hook.Add( "OnDamagedByExplosion", "DisableSound", function()
	return true
end )

sound.Add( {
	name = "electra_idle",
	channel = CHAN_STATIC,
	volume = 0.3,
	level = 70,
	pitch = 100,
	sound = "anomaly/electra_idle1.wav"
} )

sound.Add( {
	name = "electra_blast",
	channel = CHAN_STATIC,
	volume = 1,
	level = 100,
	pitch = 100,
	sound = "anomaly/electra_blast1.mp3"
} )

function ENT:Initialize()
	self:SetModel("models/props_junk/watermelon01.mdl")

	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)  
	self:SetSolid(SOLID_BBOX)	
	self:SetCollisionGroup(COLLISION_GROUP_WORLD)
	self:SetName("Electra Anomaly")
	self:SetTrigger(1)
	self:SetCollisionBounds( Vector( -60, -60, -5 ), Vector( 60, 60, 80 ) )
	self:SetNWBool("StopParticle", false)
	self:SetRenderMode( RENDERMODE_TRANSTEXTURE ) 
	self:SetColor(Color(0,0,0,0))

    local phys = self:GetPhysicsObject()
	if (phys:IsValid()) then
		phys:Sleep()
		phys:EnableMotion(false)
	end
end

function ENT:StartTouch(ent)
	timer.Create("electra_activated_once_type2"..self:EntIndex(), 0.01, 1, function()
		self:EmitSound("electra_blast")
		ParticleEffect( "electra_activated", self:GetPos(), Angle( 0, 0, 0 ) )
		--util.BlastDamage( self, self, self:GetPos(), 200, 110)
		ent:TakeDamage(70, self, self)
		if IsValid(ent) and ent:IsRagdoll() and ent:GetNetVar("player") == nil then
			local bodyexplodesounds = {"anomaly/anomaly_body_tear_1.wav", "anomaly/anomaly_body_tear_2.wav"}
			ent:EmitSound(table.Random(bodyexplodesounds),100,98,1,CHAN_AUTO)
			ParticleEffect("wick_gore_bloodsplash_new" , ent:GetPos(), Angle( 0, 0, 0 ) )
			ent:Remove()
		elseif ent.ixItemID and ix.item.instances[ent.ixItemID].isWeapon then
			ent:Remove()
		end
		self:StopParticles()
		self:SetNWBool("StopParticle", true)
		self:StopSound("electra_idle")
	end)	
	timer.Create("electra_recharge_type2"..self:EntIndex(), 1.95, 0, function()
		self:SetNWBool("StopParticle", false)
	end)
	timer.Create("electra_activated_type2"..self:EntIndex(), 2.0, 0, function()
		self:EmitSound("electra_blast")
		self:StopSound("electra_idle")
		ParticleEffect( "electra_activated", self:GetPos(), Angle( 0, 0, 0 ) )
		--util.BlastDamage( self, self, self:GetPos(), 200, 110)
		ent:TakeDamage(70, self, self)
		if IsValid(ent) and ent:IsRagdoll() and ent:GetNetVar("player") == nil then
			ent:Remove()
		end
		self:StopParticles()
		self:SetNWBool("StopParticle", true)
	end)
end

function ENT:EndTouch()
	timer.Stop("electra_activated_type2"..self:EntIndex())
	timer.Stop("electra_recharge_type2"..self:EntIndex())
	self.Timer = "electra_type2_" .. self:EntIndex()
	timer.Create( self.Timer, 1.9, 1, function()
		self:SetNWBool("StopParticle", false)
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
	self.Timer = "electra_type2_" .. self:EntIndex()
	self:StopSound("electra_idle")
	timer.Stop(self.Timer)
	timer.Stop("electra_recharge_type2"..self:EntIndex())
	timer.Stop("electra_activated_type2"..self:EntIndex())
end