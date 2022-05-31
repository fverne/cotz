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
else
    ENT.PopulateEntityInfo = true

    function ENT:OnPopulateEntityInfo(container)
        local name = container:AddRow("name")
        name:SetImportant()
        name:SetText("Noticeboard")
        name:SizeToContents()
        local descriptionText = self:GetNetVar("Description", "An old wooden noticeboard used to display notices. (Press E to interact)")

        if descriptionText ~= nil then
            local description = container:AddRow("Description")
            description:SetText(descriptionText)
            description:SizeToContents()
        end
    end
end