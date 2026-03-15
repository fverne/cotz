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
	self.Active = true
	self.ActiveOnce = true
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)  
	self:SetSolid(SOLID_BBOX)	
	self:SetCollisionGroup(COLLISION_GROUP_WORLD)
	self:SetName("Kisel' Anomaly")
	self:SetTrigger(1)
	self:SetCollisionBounds( Vector( -60, -60, -5 ), Vector( 60, 60, 80 ) )
	self:SetRenderMode( RENDERMODE_TRANSTEXTURE ) 
	self:SetColor(Color(0,0,0,0))

    local phys = self:GetPhysicsObject()
	if (phys:IsValid()) then
		phys:Sleep()
		phys:EnableMotion(false)
	end
end

-- function ENT:StartTouch(ent)
-- 	timer.Create("kisel_activated_once", 0.01, 1, function()
-- 		self:SetNWBool("Activated", true)
-- 		self:EmitSound("bfuzz_hit");
-- 		--util.BlastDamage( self, self, self:GetPos(), 100, 70)
-- 		ent:TakeDamage(40, self, self)
-- 		if IsValid(ent) and ent:IsRagdoll() and ent:GetNetVar("player") == nil then
-- 			local bodyexplodesounds = {"anomaly/anomaly_body_tear_1.wav", "anomaly/anomaly_body_tear_2.wav"}
-- 			ent:EmitSound(table.Random(bodyexplodesounds),100,98,1,CHAN_AUTO)
-- 			ParticleEffect("wick_gore_bloodsplash_new" , ent:GetPos(), Angle( 0, 0, 0 ) )
-- 			ent:Remove()
-- 		elseif ent.ixItemID and ix.item.instances[ent.ixItemID].isWeapon then
-- 			ent:Remove()
-- 		end
-- 	end)	
-- 	timer.Create("kisel_recharge", 0.5, 0, function()
-- 		self:SetNWBool("Activated", false)
-- 	end)
-- 	timer.Create("kisel_activated", 0.65, 0, function()
-- 		self:SetNWBool("Activated", true)
-- 		self:EmitSound("bfuzz_hit");
-- 		--util.BlastDamage( self, self, self:GetPos(), 100, 70)
-- 		ent:TakeDamage(70, self, self)
-- 		if IsValid(ent) and ent:IsRagdoll() and ent:GetNetVar("player") == nil then
-- 			ent:Remove()
-- 		end
-- 	end)
-- end

-- function ENT:EndTouch()
-- 	timer.Stop("kisel_activated")
-- 	timer.Stop("kisel_recharge")
-- 	self.Timer = "kisel_" .. self:EntIndex()
-- 	timer.Create( self.Timer, 0.5, 1, function()
-- 		self:SetNWBool("Activated", false)
-- 	end)
-- end

function ENT:Touch(ent)
	if not self.Active then return end
	if timer.Exists(self:EntIndex().."_kisel_activated_"..ent:EntIndex()) then return end
	if self.ActiveOnce then 
		timer.Create(self:EntIndex().."_kisel_activated_sound", 0, 1, function()
			self:SetNWBool("Activated", true)
			self:EmitSound("bfuzz_hit");
		end)	
		self.ActiveOnce = false	
	end
	
	timer.Create(self:EntIndex().."_kisel_activated_"..ent:EntIndex(), 0, 1, function()  -- Timer for multiple entity damage
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
	timer.Create(self:EntIndex().."_kisel_cooldown", 0.65, 1, function()
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
	timer.Stop(self:EntIndex().."_kisel_cooldown")
	self:StopSound("buzz_idle")
end