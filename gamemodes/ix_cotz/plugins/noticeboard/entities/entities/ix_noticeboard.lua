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
		self:AddProps()

		local physObj = self:GetPhysicsObject()

		if (IsValid(physObj)) then
			physObj:EnableMotion(true)
			physObj:Wake()
		end
	end

    function ENT:AddProps()
        local Up = 2
        local note1 = ents.Create("prop_dynamic")
        note1:SetPos(self:GetPos() + Vector(-10, 30, 0) + self:GetUp() * Up)
        note1:SetAngles(Angle(180, 0, 0))
        note1:SetModel("models/lostsignalproject/items/quest/notes_letter_1.mdl")
        note1:SetCollisionGroup(20)
        note1:SetParent(self)
        note1:Spawn()
        note1:DeleteOnRemove(self)
        local note2 = ents.Create("prop_dynamic")
        note2:SetPos(self:GetPos() + Vector(0, 10, 0) + self:GetUp() * Up)
        note2:SetAngles(Angle(180, 10, 0))
        note2:SetModel("models/lostsignalproject/items/quest/notes_paper_2.mdl")
        note2:SetCollisionGroup(20)
        note2:SetParent(self)
        note2:Spawn()
        note2:DeleteOnRemove(self)
        local note3 = ents.Create("prop_dynamic")
        note3:SetPos(self:GetPos() + Vector(-10, -15, 0) + self:GetUp() * Up)
        note3:SetAngles(Angle(180, 50, 0))
        note3:SetModel("models/lostsignalproject/items/quest/notes_paper_1.mdl")
        note3:SetCollisionGroup(20)
        note3:SetParent(self)
        note3:Spawn()
        note3:DeleteOnRemove(self)
        local note4 = ents.Create("prop_dynamic")
        note4:SetPos(self:GetPos() + Vector(10, -20, 0) + self:GetUp() * Up)
        note4:SetAngles(Angle(180, 20, 0))
        note4:SetModel("models/lostsignalproject/items/quest/notes_photo.mdl")
        note4:SetCollisionGroup(20)
        note4:SetParent(self)
        note4:Spawn()
        note4:DeleteOnRemove(self)
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