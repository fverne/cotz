local PLUGIN = PLUGIN
AddCSLuaFile()

ENT.Type = "anim"
ENT.PrintName = "Notice Board"
ENT.Category = "Helix"
ENT.Spawnable = true
ENT.AdminOnly = true

if (SERVER) then
	function ENT:Initialize()
		self:SetModel("models/hunter/plates/plate1x2.mdl")
		self:SetSolid(SOLID_VPHYSICS)
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetUseType(SIMPLE_USE)
		self:SetMaterial("models/props/CS_militia/roofbeams02")

		local physObj = self:GetPhysicsObject()

		if (IsValid(physObj)) then
			physObj:EnableMotion(true)
			physObj:Wake()
		end
	end

	function ENT:Use(activator)
		PLUGIN:OpenNoticeBoard(activator)
	end

	function ENT:OnRemove()

	end
end