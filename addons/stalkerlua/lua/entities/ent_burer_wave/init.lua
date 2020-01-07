AddCSLuaFile("shared.lua")
AddCSLuaFile("cl_init.lua")
include("shared.lua")


ENT.Exploding = false
ENT.TouchDamage = 73

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
		phys:EnableGravity(false)
	end
	
	self:SetModelScale(1.25)
	
	local TEMP_TrailStartSize = 45
	local TEMP_TrailEndSize = 1
		
	util.SpriteTrail( self, 0, Color(245,245,245,15), true, TEMP_TrailStartSize, TEMP_TrailEndSize, 0.2, 
	1/(TEMP_TrailStartSize/TEMP_TrailEndSize)*0.5, "trails/smoke.vmt" )
	
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
	
	local TEMP_Own = self
	
	if(IsValid(self:GetOwner())) then
		TEMP_Own = self:GetOwner()
	end
	
	util.BlastDamageInfo( TEMP_TargetDamage, data.Pos, 20)
	
	sound.Play("Stalker.BurerWave.Collide",self:GetPos())
	
	local TEMP_CEffectData = EffectData()
	TEMP_CEffectData:SetOrigin(self:GetPos())
	TEMP_CEffectData:SetScale(100)
	TEMP_CEffectData:SetAngles(data.Norm:Angle())
	TEMP_CEffectData:SetNormal(data.Norm)
	util.Effect( "ThumperDust", TEMP_CEffectData, false, true )
	self:Fire("kill","",0.1)
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
	self.TouchDamage = self.TouchDamage-0.5
	
	if(self.TouchDamage<10) then
		self:Remove()
	end
end

