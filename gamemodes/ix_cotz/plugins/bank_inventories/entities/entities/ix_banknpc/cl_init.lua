ENT.PrintName = "Bank NPC"
ENT.Author = "gm1003 ツ"
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