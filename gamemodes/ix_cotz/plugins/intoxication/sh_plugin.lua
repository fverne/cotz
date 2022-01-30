local PLUGIN = PLUGIN
PLUGIN.name = "Intoxication"
PLUGIN.author = "armdupe*"
PLUGIN.description = "No more vodka anti rad meta."

local playerMeta = FindMetaTable("Player")

ix.util.Include("sv_plugin.lua")
ix.util.Include("cl_plugin.lua")

function playerMeta:GetDrunkLevel()
    return (self:GetLocalVar("drunklevel")) or 0
end

ix.config.Add("intoxicationUpdateTime", 30, "The amount of seconds in between think updates.", nil, {
    data = {
        min = 1,
        max = 60
    },
    category = "intoxication"
})

ix.config.Add("intoxicationRecoverRate", 5, "The percentage that is removed from a character's blood alcohol content per think.", nil, {
    data = {
        min = 1,
        max = 100
    },
    category = "intoxication"
})

ix.config.Add("intoxicationEffectAlpha", 0.03, "How much alpha to change per frame for motion blur effects.", nil, {
    data = {
        min = 0.01,
        max = 1
    },
    category = "intoxication"
})

ix.config.Add("intoxicationEffectDelay", 0, "Determines the amount of time between frames to capture for motion blur.", nil, {
    data = {
        min = 0,
        max = 1
    },
    category = "intoxication"
})