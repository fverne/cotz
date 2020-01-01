
-- You can define factions in the factions/ folder. You need to have at least one faction that is the default faction - i.e the
-- faction that will always be available without any whitelists and etc.

FACTION.name = "Loners"
FACTION.description = "Regular inhabitants of the zone."
FACTION.isDefault = true
FACTION.color = Color(110, 80, 0)
FACTION.models = {
	{"models/stalkerisaac/playermodel/male_01_anorak.mdl", 1, "000002"},
	{"models/stalkerisaac/playermodel/male_01_anorak.mdl", 2, "000002"},
	{"models/stalkerisaac/playermodel/male_01_anorak.mdl", 3, "000002"},
	{"models/stalkerisaac/playermodel/male_01_anorak.mdl", 4, "000002"},
	{"models/stalkerisaac/playermodel/male_01_anorak.mdl", 5, "000002"},
	{"models/stalkerisaac/playermodel/male_01_anorak.mdl", 6, "000002"},
	{"models/stalkerisaac/playermodel/male_01_anorak.mdl", 7, "000002"},
	{"models/stalkerisaac/playermodel/male_01_anorak.mdl", 8, "000002"},
--	{"models/stalkerisaac/playermodel/male_01_anorak.mdl", 9, "000002"},
--	{"models/stalkerisaac/playermodel/male_01_anorak.mdl", 10, "000002"},
--	{"models/stalkerisaac/playermodel/male_01_anorak.mdl", 11, "000002"},
--	{"models/stalkerisaac/playermodel/male_01_anorak.mdl", 12, "000002"}, --merc
	{"models/stalkerisaac/playermodel/male_01_anorak.mdl", 13, "000002"},
	{"models/stalkerisaac/playermodel/male_01_anorak.mdl", 14, "000002"},
	{"models/stalkerisaac/playermodel/male_01_anorak.mdl", 15, "000002"},
	{"models/stalkerisaac/playermodel/male_01_anorak.mdl", 16, "000002"},
	{"models/stalkerisaac/playermodel/male_01_anorak.mdl", 17, "000002"},
	{"models/stalkerisaac/playermodel/male_01_anorak.mdl", 18, "000002"},
	{"models/stalkerisaac/playermodel/male_01_anorak.mdl", 19, "000002"},
	{"models/stalkerisaac/playermodel/male_01_anorak.mdl", 20, "000002"},
	{"models/stalkerisaac/playermodel/male_01_anorak.mdl", 21, "000002"},
	{"models/stalkerisaac/playermodel/male_01_anorak.mdl", 22, "000002"},
	{"models/stalkerisaac/playermodel/male_01_anorak.mdl", 23, "000002"},
--	{"models/stalkerisaac/playermodel/male_01_anorak.mdl", 24, "000002"},
	{"models/stalkerisaac/playermodel/male_01_anorak.mdl", 25, "000002"},
	{"models/stalkerisaac/playermodel/male_01_anorak.mdl", 26, "000002"},
	{"models/stalkerisaac/playermodel/male_01_anorak.mdl", 27, "000002"},
	{"models/stalkerisaac/playermodel/male_01_anorak.mdl", 28, "000002"},
	{"models/stalkerisaac/playermodel/male_01_anorak.mdl", 29, "000002"},
	{"models/stalkerisaac/playermodel/male_01_anorak.mdl", 30, "000002"},
	{"models/stalkerisaac/playermodel/male_01_anorak.mdl", 31, "000002"},
	{"models/stalkerisaac/playermodel/male_01_anorak.mdl", 32, "000002"},
}

-- You should define a global variable for this faction's index for easy access wherever you need. FACTION.index is
-- automatically set, so you can simply assign the value.

-- Note that the player's team will also have the same value as their current character's faction index. This means you can use
-- client:Team() == FACTION_CITIZEN to compare the faction of the player's current character.
FACTION_LONERS = FACTION.index
