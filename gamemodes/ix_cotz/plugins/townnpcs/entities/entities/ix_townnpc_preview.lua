ENT.Type = "anim"
ENT.Base = "ix_vendor_adv"
ENT.PrintName = "Town NPC posing preview"
ENT.Spawnable = false
ENT.isVendor = false
ENT.bNoPersist = true
ENT.AutomaticFrameAdvance = true

function ENT:CanAccess()
	return false
end

function ENT:CanTalkTo()
	return false
end

function ENT:Use()
end

if CLIENT then
	function ENT:Think()
		local animation = self:GetTownSpawnAnim()
		if self.townSpawnAnim ~= animation or self:IsSequenceFinished() then self:SetAnim() end
		self:SetNextClientThink(CurTime())

		return true
	end
end
