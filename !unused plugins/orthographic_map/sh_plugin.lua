local PLUGIN = PLUGIN
PLUGIN.name = "Orthographic Map"
PLUGIN.author = "armdupe"
PLUGIN.description = "A orthographic map for the PDA that is based off the games. Mostly featureless at the moment."
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
            local mapFrame = vgui.Create("ixPDAMap")
            ix.gui.lastHelpMenuTab = "readme"
            ix.gui.menu:Hide()
        end
    end
end