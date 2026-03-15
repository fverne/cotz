AddCSLuaFile("shared.lua")
AddCSLuaFile("cl_init.lua")
include("shared.lua")

hook.Add( "OnDamagedByExplosion", "DisableSound", function()
	return true
end )

sound.Add( {
	name = "bfuzz_hit",
	channel = CHAN_STATIC,
	volume = 1,
	level = 100,
	pitch = 100,
	sound = "anomaly/bfuzz_hit.mp3"
} )

function ENT:Initialize()
	self:SetModel("models/props_junk/watermelon01.mdl")

	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)  
	self:SetSolid(SOLID_BBOX)	
	self:SetCollisionGroup(COLLISION_GROUP_WORLD)
	self.Active = true
	self.ActiveOnce = true
	self:SetTrigger(1)
	self:SetName("Gazirovka Anomaly")
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

-- function ENT:StartTouch(ent)
-- 	timer.Create("gazirovka_activated_once"..self:EntIndex(), 0.01, 1, function()
-- 		self:EmitSound("bfuzz_hit")
-- 		ParticleEffect( "gazirovka_activated", self:GetPos(), Angle( 0, 0, 0 ) )
-- 		--util.BlastDamage( self, self, self:GetPos(), 100, 110)
-- 		ent:TakeDamage(70, self, self)
-- 		if IsValid(ent) and ent:IsRagdoll() and ent:GetNetVar("player") == nil then
-- 			ent:Remove()
-- 		end
-- 		self:StopParticles()
-- 		self:SetNWBool("StopParticle", true)
-- 	end)	
-- 	timer.Create("gazirovka_recharge"..self:EntIndex(), 1.95, 0, function()
-- 		self:SetNWBool("StopParticle", false)
-- 	end)
-- 	timer.Create("gazirovka_activated"..self:EntIndex(), 2.0, 0, function()
-- 		self:EmitSound("bfuzz_hit")
-- 		self:StopSound("buzz_idle")
-- 		ParticleEffect( "gazirovka_activated", self:GetPos(), Angle( 0, 0, 0 ) )
-- 		--util.BlastDamage( self, self, self:GetPos(), 100, 110)
-- 		ent:TakeDamage(70, self, self)
-- 		if IsValid(ent) and ent:IsRagdoll() and ent:GetNetVar("player") == nil then
-- 			local bodyexplodesounds = {"anomaly/anomaly_body_tear_1.wav", "anomaly/anomaly_body_tear_2.wav"}
-- 			ent:EmitSound(table.Random(bodyexplodesounds),100,98,1,CHAN_AUTO)
-- 			ParticleEffect("wick_gore_bloodsplash_new" , ent:GetPos(), Angle( 0, 0, 0 ) )
-- 			ent:Remove()
-- 		elseif ent.ixItemID and ix.item.instances[ent.ixItemID].isWeapon then
-- 			ent:Remove()
-- 		end
-- 		self:StopParticles()
-- 		self:SetNWBool("StopParticle", true)
-- 	end)
-- end

-- function ENT:EndTouch()
-- 	timer.Stop("gazirovka_activated"..self:EntIndex())
-- 	timer.Stop("gazirovka_recharge"..self:EntIndex())
-- 	self.Timer = "gazirovka_" .. self:EntIndex()
-- 	timer.Create( self.Timer, 1.9, 1, function()
-- 		ParticleEffect("gazirovka", self:GetPos(), Angle(0,0,0), self)
-- 		self:SetNWBool("Activated", false)
-- 	end)
-- end

function ENT:Touch(ent)
	if not self.Active then return end
	if timer.Exists(self:EntIndex().."_gazirovka_activated_"..ent:EntIndex()) then return end
	if self.ActiveOnce then 
		timer.Create(self:EntIndex().."_gazirovka_activated_sound", 0, 1, function()
			self:SetNWBool("Activated", true)
			self:EmitSound("bfuzz_hit");
			self:StopParticles()
			self:SetNWBool("StopParticle", true)
			self:StopSound("buzz_idle")
		end)	
		self.ActiveOnce = false	
	end
	
	timer.Create(self:EntIndex().."_gazirovka_activated_"..ent:EntIndex(), 0, 1, function()  -- Timer for multiple entity damage
		ent:TakeDamage(40, self, self)
		if IsValid(ent) and ent:IsRagdoll() and ent:GetNetVar("player") == nil then
			local bodyexplodesounds = {"anomaly/anomaly_body_tear_1.wav", "anomaly/anomaly_body_tear_2.wav"}
			ent:EmitSound(table.Random(bodyexplodesounds),100,98,1,CHAN_AUTO)
			ParticleEffect("wick_gore_bloodsplash_new" , ent:GetPos(), Angle( 0, 0, 0 ) )
			ent:Remove()
		elseif ent.ixItemID and ix.item.instances[ent.ixItemID].isWeapon then
			ent:Remove()
		end
		self.Active = false
	end)	
	timer.Create(self:EntIndex().."_gazirovka_cooldown", 1.9, 1, function()
		self:SetNWBool("StopParticle", false)
		self:SetNWBool("Activated", false)
		self.Active = true
		self.ActiveOnce = true
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
	timer.Stop(self:EntIndex().."_gazirovka_cooldown")
	self:StopSound("buzz_idle")
end