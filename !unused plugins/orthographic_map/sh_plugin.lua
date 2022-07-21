local PLUGIN = PLUGIN
PLUGIN.name = "Orthographic Map"
PLUGIN.author = "armdupe"
PLUGIN.description = "A orthographic map for the PDA that is based off the games. Mostly featureless at the moment."
ix.util.Include("derma/cl_pdamap.lua")
ix.util.Include("derma/cl_pdamarkeredit.lua")

ix.config.Add("PDAOrthographicMap", true, "If true, the pda map will appear in the encylopedia tab.", nil, {
    category = "1development"
})

function PLUGIN:PopulateHelpMenu(tabs)
    if ix.config.Get("PDAOrthographicMap", true) then
        tabs["map"] = function(container)
            local mapFrame = vgui.Create("ixPDAMap")
            ix.gui.lastHelpMenuTab = "readme"
            ix.gui.menu:Hide()
        end
    end
end