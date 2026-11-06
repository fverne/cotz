AddCSLuaFile()
ENT.Base = "ix_vendor_adv"
ENT.Type = "anim"
ENT.PrintName = "Vendor - Sherpa"
ENT.Category = "Helix"
ENT.Spawnable = true
ENT.AdminOnly = true
ENT.bNoPersist = true
ENT.AutomaticFrameAdvance = true

function ENT:Initialize()
	baseclass.Get("ix_vendor_adv").Initialize(self)
	if SERVER then
		self:SetSherpa(true)
		self:SetDisplayName("Quartermaster")
		self:SetSoundGroup("nosound")
		self.dialogueid = "sherpa"
	end
end

function ENT:CanAccess(client)
	if self.ixHideout then
		return ix.plugin.Get("hideouts"):IsNearUtility(client, self) and not self.cotzVendorHeld
	end

	return self:CanTalkTo(client)
end

if SERVER then
	function ENT:SpawnFunction(client, trace)
		local entity = ents.Create("ix_sherpa_vendor")
		entity:SetPos(trace.HitPos)
		entity:SetAngles(Angle(0, client:EyeAngles().y + 180, 0))
		entity:Spawn()
		ix.sherpa.EnsureIdentity(entity)
		ix.plugin.Get("vendor_adv"):SaveData()

		return entity
	end
end
