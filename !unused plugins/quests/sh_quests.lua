local PLUGIN = PLUGIN
//
local QUEST = {}
QUEST.uid = "metal"
QUEST.name = "Scrap Metal"
QUEST.intro = "If you find me some scrap metal, I'll reward you with coin.\nFive scrap metal for twenty coins."
QUEST.outro = "Thank you, here is your reward."
QUEST.reminder = "Five scrap metal for twenty coins, don't try to haggle."
QUEST.required = {["j_scrap_metals"] = 5}
QUEST.reward = {["coin_10"] = 2}

QUESTS:Register(QUEST)
//
local QUEST = {}
QUEST.uid = "wood"
QUEST.name = "Scrap Wood"
QUEST.intro = "If you find me some scrap wood, I'll reward you with coin.\nEight scrap wood for twenty coins."
QUEST.outro = "Thank you, here is your reward."
QUEST.reminder = "Eight scrap wood for twenty coins, don't try to haggle."
QUEST.required = {["j_scrap_wood"] = 8}
QUEST.reward = {["coin_10"] = 2}

QUESTS:Register(QUEST)
//
local QUEST = {}
QUEST.uid = "plastic"
QUEST.name = "Scrap Plastic"
QUEST.intro = "If you find me some scrap plastic, I'll reward you with coin.\nFour scrap plastic for ten coins."
QUEST.outro = "Thank you, here is your reward."
QUEST.reminder = "Four scrap plastic for ten coins, don't try to haggle."
QUEST.required = {["j_scrap_plastics"] = 4}
QUEST.reward = {["coin_10"] = 1}

QUESTS:Register(QUEST)
//
local QUEST = {}
QUEST.uid = "drill"
QUEST.name = "Power Drill"
QUEST.intro = "I lost my tools on an expedition, if you find a power drill, I'll pay you for it.\nIf you give me the drill I'll give you ten coins."
QUEST.outro = "Thank you, here is your reward."
QUEST.reminder = "Five scrap metal for twenty coins, don't try to haggle."
QUEST.required = {["j_drill"] = 1}
QUEST.reward = {["coin_10"] = 1}

QUESTS:Register(QUEST)
