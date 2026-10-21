AddCSLuaFile("shared.lua")
include("shared.lua")

ENT.cooldown = 0

hook.Add( "OnDamagedByExplosion", "DisableSound", function()
	return true
end )

sound.Add( {
	name = "jarka_blast",
	channel = CHAN_STATIC,
	volume = 0.5,
	level = 100,
	pitch = 100,
	sound = "anomaly/jarka_blast.wav"
} )

function ENT:Initialize()
	self:SetModel("models/props_junk/watermelon01.mdl")
	
	self.Active = true
	self.ActiveOnce = true
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)  
	self:SetSolid(SOLID_BBOX)	
	self:SetCollisionGroup(COLLISION_GROUP_WORLD)
	self:SetName("Jarka Anomaly")
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

function ENT:Touch(ent)
	if not self.Active then return end
	if timer.Exists(self:EntIndex().."_jarka_activated_"..ent:EntIndex()) then return end
	if self.ActiveOnce then 
		timer.Create(self:EntIndex().."_jarka_activated_sound", 0, 1, function()
			self:EmitSound("jarka_blast")
			ParticleEffectAttach( "jarka_activated", PATTACH_ABSORIGIN_FOLLOW, self, 1 )
		end)	
		self.ActiveOnce = false
	end
	
	timer.Create(self:EntIndex().."_jarka_activated_"..ent:EntIndex(), 0, 1, function()  -- Timer for multiple entity damage
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

	timer.Create(self:EntIndex().."_jarka_cooldown", 0.5, 1, function()
		self.Active = true
	end)

	timer.Create(self:EntIndex().."_jarka_sound_cooldown", 11, 1, function()
		self:StopSound("jarka_blast")
		self:StopParticles()
		print("yes")
		ParticleEffect("jarka_inactive", self:GetPos(), Angle(0,0,0), self)
		self.ActiveOnce = true
	end)
end

-- 

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
	self:StopSound("jarka_blast")
	timer.Stop(self:EntIndex().."_jarka_cooldown")
	timer.Stop(self:EntIndex().."_jarka_sound_cooldown")
end