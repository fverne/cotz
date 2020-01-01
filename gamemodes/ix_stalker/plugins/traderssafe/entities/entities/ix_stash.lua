ENT.Type = "anim"
ENT.PrintName = "Safe (Traders have an item for this)"
ENT.Author = "Black Tea"
ENT.Spawnable = true
ENT.AdminOnly = false
ENT.Category = "Helix"
ENT.RenderGroup 		= RENDERGROUP_BOTH

if (SERVER) then
	function ENT:Initialize()
		self:SetModel("models/kek1ch/dev_rukzak.mdl")
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetMoveType(MOVETYPE_VPHYSICS)
		self:SetUseType(SIMPLE_USE)
		local physicsObject = self:GetPhysicsObject()

		if (IsValid(physicsObject)) then
			physicsObject:Wake()
		end
	end

	function ENT:OnRemove()
	end

	function ENT:Use(activator)
		requestStash(activator)
	end
else
	function ENT:Draw()
		self:DrawModel()
	end
	
	function ENT:onShouldDrawEntityInfo()
		return true
	end

	function ENT:onDrawEntityInfo(alpha)
		local position = self:LocalToWorld(self:OBBCenter()):ToScreen()
		local x, y = position.x, position.y

		ix.util.DrawText(L"Safe", x, y, ColorAlpha(ix.config.Get("color"), alpha), 1, 1, nil, alpha * 0.65)
		ix.util.DrawText(L"OOC safe used by admins", x, y + 16, ColorAlpha(color_white, alpha), 1, 1, "ixSmallFont", alpha * 0.65)
	end
end