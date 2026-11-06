AddCSLuaFile()
ENT.Base = "ix_sherpa_vendor"
ENT.Type = "anim"
ENT.PrintName = "Squad Quartermaster"
ENT.Spawnable = false
ENT.bNoPersist = true
ENT.AutomaticFrameAdvance = true

if SERVER then
	function ENT:Initialize()
		baseclass.Get("ix_sherpa_vendor").Initialize(self)
		self:SetMoveType(MOVETYPE_VPHYSICS)
	end
end
