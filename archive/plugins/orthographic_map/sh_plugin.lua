local PLUGIN = PLUGIN
PLUGIN.name = "PDA Map"
PLUGIN.author = "armdupe"
PLUGIN.description = "A map for the PDA that is based off the games. Mostly featureless at the moment."
ix.util.Include("derma/cl_pdamap.lua")
ix.util.Include("derma/cl_pdamarkeredit.lua")

ix.config.Add("PDAOrthographicMap", true, "If true, the pda map will appear in the encylopedia tab.", nil, {
    category = "1development"
})

ix.mapscales = {
    ["rp_marsh_cs"] = {
        ["min"] = 2.5,
        ["max"] = 4.6,
    },
    ["rp_waystation"] = {
        ["min"] = 1.8,
        ["max"] = 3.1,
    },
    ["rp_salvation_2_haven"] = {
        ["min"] = 1.8,
        ["max"] = 5,
    },    
}

function PLUGIN:PopulateHelpMenu(tabs)
    if ix.config.Get("PDAOrthographicMap", true) then
        tabs["map"] = function(container)

            ix.pdaMapBackground = vgui.Create("DFrame")
            ix.pdaMapBackground:SetSize()
            ix.pdaMapBackground:SetTitle("")
            ix.pdaMapBackground:SetSize(1333, 750)
            ix.pdaMapBackground:SetDraggable(false)
            ix.pdaMapBackground:ShowCloseButton(false)
            ix.pdaMapBackground:SetPos(ScrW() / 2 - 666, ScrH() / 2 - 375)

            ix.pdaMapBackground.Paint = function(pnl, w, h)
                surface.SetDrawColor(235, 235, 235, 50)
                surface.DrawRect(64, 64, w - 128, h - 132)
                surface.SetDrawColor(255, 255, 255, 255)
                surface.SetMaterial(Material("cotz/panels/pda.png"))
                surface.DrawTexturedRect(0, 0, w, h)
            end

            local mapFrame = vgui.Create("ixPDAMap")
            ix.gui.lastHelpMenuTab = "readme"
            ix.gui.menu:Hide()
        end
    end
end