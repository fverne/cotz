AddCSLuaFile("shared.lua")
AddCSLuaFile("cl_init.lua")
include("shared.lua")


ENT.Exploding = false
ENT.TouchDamage = 35

function ENT:Initialize()
	self:SetModel( "models/props_phx/misc/smallcannonball.mdl" )
	self:PhysicsInit( SOLID_VPHYSICS )
	self:SetMoveType( MOVETYPE_VPHYSICS )
	self:SetSolid( SOLID_VPHYSICS )
	self:AddEFlags(EFL_NO_DAMAGE_FORCES)
	self:AddFlags(FL_GRENADE)
	self:SetCollisionGroup(COLLISION_GROUP_DISSOLVING)
	
	self:SetTrigger(true)
	
	self:SetHealth(100)
 
	local phys = self:GetPhysicsObject()

	if (phys:IsValid()) then
		phys:Wake()
		phys:EnableGravity(true)
	end
	
	self:SetModelScale(1)
	
	local TEMP_TrailStartSize = 45
	local TEMP_TrailEndSize = 1
		
	self.Exploding = false
	
	self:SetMaterial("models/props_c17/fisheyelens")
end

function ENT:Detonate(ent,data)
	self.Exploding = true
	
	local TEMP_TargetDamage = DamageInfo()
						
	TEMP_TargetDamage:SetDamage(self.TouchDamage)
	TEMP_TargetDamage:SetAttacker(self)
	TEMP_TargetDamage:SetDamageType(DMG_ACID)
	TEMP_TargetDamage:SetInflictor(self)
	TEMP_TargetDamage:SetDamagePosition(ent:NearestPoint(self:GetPos()))
	TEMP_TargetDamage:SetDamageForce(self:GetForward()*10000)
	ent:TakeDamageInfo(TEMP_TargetDamage)

	sound.Play("npc/antlion_grub/agrub_squish3.wav",self:GetPos())
	
	self.SetKill = true
end

function ENT:PhysicsCollide(data)
	if(data.HitEntity!=self:GetOwner()&&self.Exploding==false) then
		local TEMP_Trace = self:GetTouchTrace()
		local TEMP_Data = {}
		TEMP_Data.Pos = data.HitPos
		TEMP_Data.Norm = data.HitNormal
		
		self:Detonate(data.HitEntity,TEMP_Data)
	end
end

function ENT:StartTouch(ent)
	if(ent!=self:GetOwner()&&self.Exploding==false) then
		local TEMP_Trace = self:GetTouchTrace()
		local TEMP_Data = {}
		TEMP_Data.Pos = TEMP_Trace.HitPos
		TEMP_Data.Norm = TEMP_Trace.HitNormal
		
		self:Detonate(ent,TEMP_Data)
	end
end
		
function ENT:Think()
	if self.SetKill then
		self:Remove()
	end
end
