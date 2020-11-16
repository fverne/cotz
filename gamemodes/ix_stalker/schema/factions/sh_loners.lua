
-- You can define factions in the factions/ folder. You need to have at least one faction that is the default faction - i.e the
-- faction that will always be available without any whitelists and etc.

FACTION.name = "Loners"
FACTION.description = "Regular inhabitants of the zone."
FACTION.isDefault = true
FACTION.color = Color(142, 142, 142)
FACTION.models = {
	{"models/stalkerisaac/playermodel/male_01_anorak.mdl", 1, "0000021"},
	{"models/stalkerisaac/playermodel/male_01_anorak.mdl", 2, "0000021"},
	{"models/stalkerisaac/playermodel/male_01_anorak.mdl", 3, "0000021"},
	{"models/stalkerisaac/playermodel/male_01_anorak.mdl", 4, "0000021"},
	{"models/stalkerisaac/playermodel/male_01_anorak.mdl", 5, "0000021"},
	{"models/stalkerisaac/playermodel/male_01_anorak.mdl", 6, "0000021"},
	{"models/stalkerisaac/playermodel/male_01_anorak.mdl", 7, "0000021"},
	{"models/stalkerisaac/playermodel/male_01_anorak.mdl", 8, "0000021"},
--	{"models/stalkerisaac/playermodel/male_01_anorak.mdl", 9, "0000021"},
--	{"models/stalkerisaac/playermodel/male_01_anorak.mdl", 10, "0000021"},
--	{"models/stalkerisaac/playermodel/male_01_anorak.mdl", 11, "0000021"},
--	{"models/stalkerisaac/playermodel/male_01_anorak.mdl", 12, "0000021"}, --merc
	{"models/stalkerisaac/playermodel/male_01_anorak.mdl", 13, "0000021"},
	{"models/stalkerisaac/playermodel/male_01_anorak.mdl", 14, "0000021"},
	{"models/stalkerisaac/playermodel/male_01_anorak.mdl", 15, "0000021"},
	{"models/stalkerisaac/playermodel/male_01_anorak.mdl", 16, "0000021"},
	{"models/stalkerisaac/playermodel/male_01_anorak.mdl", 17, "0000021"},
	{"models/stalkerisaac/playermodel/male_01_anorak.mdl", 18, "0000021"},
	{"models/stalkerisaac/playermodel/male_01_anorak.mdl", 19, "0000021"},
	{"models/stalkerisaac/playermodel/male_01_anorak.mdl", 20, "0000021"},
	{"models/stalkerisaac/playermodel/male_01_anorak.mdl", 21, "0000021"},
	{"models/stalkerisaac/playermodel/male_01_anorak.mdl", 22, "0000021"},
	{"models/stalkerisaac/playermodel/male_01_anorak.mdl", 23, "0000021"},
--	{"models/stalkerisaac/playermodel/male_01_anorak.mdl", 24, "0000021"},
	{"models/stalkerisaac/playermodel/male_01_anorak.mdl", 25, "0000021"},
	{"models/stalkerisaac/playermodel/male_01_anorak.mdl", 26, "0000021"},
	{"models/stalkerisaac/playermodel/male_01_anorak.mdl", 27, "0000021"},
	{"models/stalkerisaac/playermodel/male_01_anorak.mdl", 28, "0000021"},
	{"models/stalkerisaac/playermodel/male_01_anorak.mdl", 29, "0000021"},
	{"models/stalkerisaac/playermodel/male_01_anorak.mdl", 30, "0000021"},
	{"models/stalkerisaac/playermodel/male_01_anorak.mdl", 31, "0000021"},
	{"models/stalkerisaac/playermodel/male_01_anorak.mdl", 32, "0000021"},
}


-- You should define a global variable for this faction's index for easy access wherever you need. FACTION.index is
-- automatically set, so you can simply assign the value.

-- Note that the player's team will also have the same value as their current character's faction index. This means you can use
-- client:Team() == FACTION_CITIZEN to compare the faction of the player's current character.
FACTION_LONERS = FACTION.index
