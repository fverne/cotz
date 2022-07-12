local PLUGIN = PLUGIN
PLUGIN.name = "Orthographic Map"
PLUGIN.author = "armdupe"
PLUGIN.desc = "A orthographic map for the PDA that is based off the games. Mostly featureless at the moment."
ix.util.Include("derma/cl_pdamap.lua")

function PLUGIN:PopulateHelpMenu(tabs)
    tabs["map"] = function(container)
        local mapFrame = vgui.Create("pdaMap")
        ix.gui.lastHelpMenuTab = "readme"
        ix.gui.menu:Hide()
    end
end