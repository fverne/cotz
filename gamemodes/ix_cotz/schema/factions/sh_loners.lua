
-- You can define factions in the factions/ folder. You need to have at least one faction that is the default faction - i.e the
-- faction that will always be available without any whitelists and etc.

FACTION.name = "Loners"
FACTION.description = "Regular inhabitants of the zone."
FACTION.isDefault = true
FACTION.color = Color(142, 142, 142)
FACTION.models = {
	{"models/stalkerisaac/playermodel/male_01_anorak.mdl", 0, "000000000"},
	{"models/stalkerisaac/playermodel/male_01_anorak.mdl", 1, "000000000"},
	{"models/stalkerisaac/playermodel/male_01_anorak.mdl", 2, "000000000"},
	{"models/stalkerisaac/playermodel/male_01_anorak.mdl", 3, "000000000"},
	{"models/stalkerisaac/playermodel/male_01_anorak.mdl", 4, "000000000"},
	{"models/stalkerisaac/playermodel/male_01_anorak.mdl", 5, "000000000"},
	{"models/stalkerisaac/playermodel/male_01_anorak.mdl", 6, "000000000"},
	{"models/stalkerisaac/playermodel/male_01_anorak.mdl", 7, "000000000"},
	{"models/stalkerisaac/playermodel/male_01_anorak.mdl", 8, "000000000"},
--	{"models/stalkerisaac/playermodel/male_01_anorak.mdl", 9, "000000000"}, -- clear sky
--	{"models/stalkerisaac/playermodel/male_01_anorak.mdl", 10, "000000000"}, -- duty
--	{"models/stalkerisaac/playermodel/male_01_anorak.mdl", 11, "000000000"}, -- freedom
--	{"models/stalkerisaac/playermodel/male_01_anorak.mdl", 12, "000000000"}, -- merc
	{"models/stalkerisaac/playermodel/male_01_anorak.mdl", 13, "000000000"},
	{"models/stalkerisaac/playermodel/male_01_anorak.mdl", 14, "000000000"},
	{"models/stalkerisaac/playermodel/male_01_anorak.mdl", 15, "000000000"},
	{"models/stalkerisaac/playermodel/male_01_anorak.mdl", 16, "000000000"},
	-- {"models/stalkerisaac/playermodel/male_01_anorak.mdl", 17, "000000000"},
	-- {"models/stalkerisaac/playermodel/male_01_anorak.mdl", 18, "000000000"},
	-- {"models/stalkerisaac/playermodel/male_01_anorak.mdl", 19, "000000000"},
	-- {"models/stalkerisaac/playermodel/male_01_anorak.mdl", 20, "000000000"},
	{"models/stalkerisaac/playermodel/male_01_anorak.mdl", 21, "000000000"},
	{"models/stalkerisaac/playermodel/male_01_anorak.mdl", 22, "000000000"},
	{"models/stalkerisaac/playermodel/male_01_anorak.mdl", 23, "000000000"},
--	{"models/stalkerisaac/playermodel/male_01_anorak.mdl", 24, "000000000"}, -- nazi
	{"models/stalkerisaac/playermodel/male_01_anorak.mdl", 25, "000000000"},
	{"models/stalkerisaac/playermodel/male_01_anorak.mdl", 26, "000000000"},
	{"models/stalkerisaac/playermodel/male_01_anorak.mdl", 27, "000000000"},
	{"models/stalkerisaac/playermodel/male_01_anorak.mdl", 28, "000000000"},
	{"models/stalkerisaac/playermodel/male_01_anorak.mdl", 29, "000000000"},
	{"models/stalkerisaac/playermodel/male_01_anorak.mdl", 30, "000000000"},
	{"models/stalkerisaac/playermodel/male_01_anorak.mdl", 31, "000000000"},
	{"models/stalkerisaac/playermodel/male_01_anorak.mdl", 32, "000000000"},
}


-- You should define a global variable for this faction's index for easy access wherever you need. FACTION.index is
-- automatically set, so you can simply assign the value.

-- Note that the player's team will also have the same value as their current character's faction index. This means you can use
-- client:Team() == FACTION_CITIZEN to compare the faction of the player's current character.
FACTION_LONERS = FACTION.index
