local PLUGIN = PLUGIN
PLUGIN.name = "Orthographic Map"
PLUGIN.author = "armdupe"
PLUGIN.description = "A orthographic map for the PDA that is based off the games. Mostly featureless at the moment."
ix.util.Include("derma/cl_pdamap.lua")
ix.util.Include("derma/cl_pdamarkeredit.lua")

function PLUGIN:PopulateHelpMenu(tabs)
    tabs["map"] = function(container)
        local mapFrame = vgui.Create("ixPDAMap")
        ix.gui.lastHelpMenuTab = "readme"
        ix.gui.menu:Hide()
    end
end