AddCSLuaFile("shared.lua")
AddCSLuaFile("cl_init.lua")
include("shared.lua")

function ENT:Initialize()
	if ( CLIENT ) then return end
	self:SetModel("models/props_junk/watermelon01.mdl")

	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)  
	self:SetSolid(SOLID_BBOX)	
	self:SetCollisionGroup(COLLISION_GROUP_WORLD)
	self:SetName("Teleport Anomaly")
	self:SetTrigger(1)
	self:SetCollisionBounds( Vector( -60, -60, -5 ), Vector( 60, 60, 80 ) )
	self:SetNWBool("StopParticle", false)
	self:SetRenderMode( RENDERMODE_TRANSTEXTURE ) 
	self:SetColor(Color(0,0,0,0))
	self.Entered = false

    local phys = self:GetPhysicsObject()
	if (phys:IsValid()) then
		phys:Sleep()
		phys:EnableMotion(false)
	end
end

function ENT:StartTouch( ply )
	
	if ply:IsPlayer() then
		if self.Entered == false then
			local dest = ents.FindByName("anomaly_"..self:GetTpDest())
			if dest[1] ~= nil then
				ply:SetPos(dest[1]:GetPos()+dest[1]:GetAngles():Forward()*-70)
				self:EmitSound( "tele.wav", 100 )
				dest[1]:EmitSound( "anomaly/teleport_incoming.mp3", 70 )
				ply:ScreenFade(1, Color(255,255,255), 1, 0.5)
				ply:SetEyeAngles((dest[1]:GetPos() - ply:GetPos()):Angle()+Angle(0,180,0))
				dest[1].Entered = true
				timer.Simple(2,function() dest[1].Entered = false end)
				--print(dest[1], "unentered")
			end
		end
	end
		
end

function ENT:EndTouch( ply )
end

function ENT:Think()
	if CLIENT then return end

	self:SetName(self:GetTpName() ~= "" and "anomaly_"..self:GetTpName() or "NO_EXIT"..self:EntIndex())

end