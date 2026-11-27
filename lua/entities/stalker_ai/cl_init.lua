include( "shared.lua" )

-- Mutants use translucent render modes and client material effects. RENDERGROUP_BOTH drew each one
-- twice per frame (Draw in the opaque pass, then DrawTranslucent); the translucent pass alone is enough.
ENT.RenderGroup = RENDERGROUP_TRANSLUCENT

function ENT:Draw()
	self:DrawModel()
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