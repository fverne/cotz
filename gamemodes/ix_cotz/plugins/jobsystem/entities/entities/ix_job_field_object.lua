ENT.Type = "anim"
ENT.Base = "base_anim"
ENT.PrintName = "Field task equipment"
ENT.Spawnable = false
ENT.bNoPersist = true

if SERVER then
	function ENT:Initialize()
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetSolid(SOLID_VPHYSICS)
		self:SetUseType(SIMPLE_USE)
		self:SetMoveType(MOVETYPE_NONE)
		local physics = self:GetPhysicsObject()
		if IsValid(physics) then physics:EnableMotion(false) end
	end

	function ENT:Use(client)
		if client:IsPlayer() then ix.jobs.field.Collect(client, self) end
	end

	function ENT:OnTakeDamage(damage)
		ix.jobs.field.DefenceDamage(self, damage)
	end
else
	function ENT:Draw()
		self:DrawModel()
	end

	function ENT:OnPopulateEntityInfo(tooltip)
		local title = tooltip:AddRow("name")
		title:SetImportant()
		title:SetText(self.PrintName)
		title:SizeToContents()
		local description = tooltip:AddRow("description")
		description:SetText("Assigned equipment. Only the stalker on this task can collect it with Use.")
		description:SizeToContents()
	end
end
