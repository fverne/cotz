AddCSLuaFile()
ENT.Base = "ix_sherpa_vendor"
ENT.Type = "anim"
ENT.PrintName = "Squad Quartermaster"
ENT.Spawnable = false
ENT.bNoPersist = true
ENT.AutomaticFrameAdvance = true

if SERVER then
	function ENT:Initialize()
		-- Helix registers plugin entities after GMod may have populated the baseclass cache.
		scripted_ents.GetStored("ix_sherpa_vendor").t.Initialize(self)
		self:SetMoveType(MOVETYPE_VPHYSICS)
	end
end
