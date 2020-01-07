include( "shared.lua" )

ENT.RenderGroup = RENDERGROUP_BOTH

function ENT:Draw()
	self.Entity:DrawModel()
end

function ENT:DrawTranslucent()
	self:Draw()
end


net.Receive("STALKERNPCRagdoll",function()
	local TEMP_ENT = net.ReadEntity()

	if(IsValid(TEMP_ENT)&&TEMP_ENT!=nil&&TEMP_ENT!=NULL) then
		local Doll = TEMP_ENT:BecomeRagdollOnClient()
		
		Doll:SetMaterial("")
		Doll:SetColor(Color(255,255,255,255))
		Doll:RemoveAllDecals()
		Doll:DrawShadow(true)
	end
end)