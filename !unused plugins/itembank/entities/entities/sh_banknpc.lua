ENT.Type = "anim"
ENT.PrintName = "Bank NPC"
ENT.Category = "Helix"
ENT.Spawnable = true
ENT.AdminOnly = true

function ENT:Initialize()
    if (SERVER) then
        self:SetModel("models/z-o-m-b-i-e/st/shkaf/st_seif_02.mdl")
	self:SetUseType(SIMPLE_USE)
        self:SetSolid(SOLID_BBOX)
        self:SetUseType(SIMPLE_USE)
        local physObj = self:GetPhysicsObject()

        if (IsValid(physObj)) then
            physObj:EnableMotion(true)
            physObj:Wake()
        end
    end
end

if (CLIENT) then
ENT.PopulateEntityInfo = true

function ENT:OnPopulateEntityInfo(tooltip)
    surface.SetFont("ixIconsSmall")

    local title = tooltip:AddRow("name")
    title:SetImportant()
    title:SetText("Usable safe")
    title:SetBackgroundColor(ix.config.Get("color"))
    title:SizeToContents()

    local description = tooltip:AddRow("description")
    description:SetText("An old safe. Seems like it can safely hold your items.")
    description:SizeToContents()
end
end

function ENT:Use(activator)
  netstream.Start(activator, "OpenBankingTeller")
end