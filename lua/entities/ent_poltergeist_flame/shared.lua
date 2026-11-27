ENT.Type = "anim"
ENT.Base = "base_anim"
ENT.PrintName = "Poltergeist Flame"
ENT.Spawnable = false
ENT.AdminOnly = false

function ENT:SetupDataTables()
	self:NetworkVar("Bool", 0, "Erupting")
end
