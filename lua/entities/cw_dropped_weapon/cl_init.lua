include("shared.lua")
ENT.dataRequestTime = 0

function ENT:Initialize()
end

function ENT:getMainText()
	return self.weaponName
end

function ENT:Think()
	if self.inRange and (not self.containedAttachments or not self.weaponName) then
		if CurTime() > self.dataRequestTime then
			RunConsoleCommand("cw_request_wep_data", self:EntIndex())
			self.dataRequestTime = CurTime() + 1
		end
	end
end

net.Receive("CW_DROPPED_WEAPON_ATTACHMENTS", function()
	local entity = net.ReadEntity()
	local attachments = net.ReadTable()
	entity.containedAttachments = attachments
	entity.weaponName = weapons.GetStored(entity:GetWepClass()).PrintName
	
	entity:setupAttachmentDisplayData()
end)