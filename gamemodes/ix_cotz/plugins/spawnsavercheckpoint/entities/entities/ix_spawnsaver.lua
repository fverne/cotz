local PLUGIN = PLUGIN
AddCSLuaFile()

ENT.Type = "anim"
ENT.PrintName = "Bedroll (Spawn Saver)"
ENT.Category = "Helix"
ENT.Spawnable = true
ENT.AdminOnly = true

if (SERVER) then
	function ENT:Initialize()
		self:SetModel("models/lostsignalproject/items/misc/sleeping_bag_merger.mdl")
		self:SetSolid(SOLID_VPHYSICS)
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetUseType(SIMPLE_USE)

		local physObj = self:GetPhysicsObject()

		if (IsValid(physObj)) then
			physObj:EnableMotion(false)
			physObj:Sleep()
		end
	end

	function ENT:Use(activator)
		activator:GetCharacter():SetData("savedspawn", {self:GetPos() + Vector(0,0,24), Angle(), game.GetMap()})
        activator:Notify("Spawn Set")
	end

	function ENT:OnRemove()

	end
else
    ENT.PopulateEntityInfo = true

    function ENT:OnPopulateEntityInfo(container)
        local name = container:AddRow("name")
        name:SetImportant()
        name:SetText("Bed Roll")
        name:SizeToContents()
        local descriptionText = self:GetNetVar("Description", "A bedroll, used to make a quick and dirty camp for sleeping. (Press E to set spawn)")

        if descriptionText ~= nil then
            local description = container:AddRow("Description")
            description:SetText(descriptionText)
            description:SizeToContents()
        end
    end
end