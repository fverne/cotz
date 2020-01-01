ENT.Base 			= "base_entity"
ENT.Type 			= "ai"

ENT.PrintName		= "STALKER SNPC"
ENT.Author			= "ERROR"
ENT.Contact			= ""
ENT.Purpose			= ""
ENT.Instructions	= "Edited KIlling Floor SNPC's base"

ENT.AutomaticFrameAdvance = false

function ENT:OnRemove()
end

function ENT:PhysicsCollide( data, physobj )
end

function ENT:PhysicsUpdate( physobj )
end

function ENT:SetAutomaticFrameAdvance( bUsingAnim )
	self.AutomaticFrameAdvance = bUsingAnim
end