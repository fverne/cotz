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
	self.ActiveOnce = true
	self:SetRenderMode( RENDERMODE_TRANSTEXTURE ) 
	self:SetColor(Color(0,0,0,0))

    local phys = self:GetPhysicsObject()
	if (phys:IsValid()) then
		phys:Sleep()
		phys:EnableMotion(false)
	end
end

-- function ENT:StartTouch(ent)
-- 	if not self.Active then return end
-- 	timer.Create("par_activated_once"..self:EntIndex(), 0.01, 1, function()
-- 		self:EmitSound("par_blast");
-- 		ParticleEffectAttach( "par_anomaly", PATTACH_ABSORIGIN_FOLLOW, self, 1 )
-- 		if IsValid(ent) and ent:IsRagdoll() and ent:GetNetVar("player") == nil then
-- 			local bodyexplodesounds = {"anomaly/anomaly_body_tear_1.wav", "anomaly/anomaly_body_tear_2.wav"}
-- 			ent:EmitSound(table.Random(bodyexplodesounds),100,98,1,CHAN_AUTO)
-- 			ParticleEffect("wick_gore_bloodsplash_new" , ent:GetPos(), Angle( 0, 0, 0 ) )
-- 			ent:Remove()
-- 		elseif ent.ixItemID and ix.item.instances[ent.ixItemID].isWeapon then
-- 			ent:Remove()
-- 		end
-- 		--util.BlastDamage( self, self, self:GetPos(), 100, 50)
-- 		--ent:TakeDamage(50, self, self)
-- 	end)
-- 	timer.Create("par_activated"..self:EntIndex(), 12, 1, function()
-- 		self:StopSound("par_blast");
-- 		self.Active = true
-- 		ParticleEffect("jarka_inactive", self:GetPos(), Angle(0,0,0), self)
-- 		self:StopParticles()
-- 	end)
-- 	self.Active = false
-- end

-- function ENT:Touch(activator)
-- 	--util.BlastDamage( self, self, self:GetPos(), 100, 2)
-- 	if self.cooldown < CurTime() then
-- 		activator:TakeDamage(30, self, self)
-- 		self.cooldown = CurTime() + 0.5
-- 	end
	
-- end

function ENT:Touch(ent)
	if not self.Active then return end
	if timer.Exists(self:EntIndex().."_par_activated_"..ent:EntIndex()) then return end
	if self.ActiveOnce then 
		timer.Create(self:EntIndex().."_par_activated_sound", 0, 1, function()
			self:EmitSound("par_blast")
			ParticleEffectAttach( "par_anomaly", PATTACH_ABSORIGIN_FOLLOW, self, 1 )
		end)	
		self.ActiveOnce = false
	end
	
	timer.Create(self:EntIndex().."_par_activated_"..ent:EntIndex(), 0, 1, function()  -- Timer for multiple entity damage
		ent:TakeDamage(30, self, self)
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

	timer.Create(self:EntIndex().."_par_cooldown", 0.5, 1, function()
		self.Active = true
	end)

	timer.Create(self:EntIndex().."_par_sound_cooldown", 11, 1, function()
		self:StopSound("par_blast")
		self:StopParticles()
		ParticleEffect("jarka_inactive", self:GetPos(), Angle(0,0,0), self)
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
	self:StopSound("par_blast")
	timer.Stop(self:EntIndex().."_par_cooldown")
	timer.Stop(self:EntIndex().."_par_sound_cooldown")
end