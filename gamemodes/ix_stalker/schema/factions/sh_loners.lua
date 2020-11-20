
-- You can define factions in the factions/ folder. You need to have at least one faction that is the default faction - i.e the
-- faction that will always be available without any whitelists and etc.

FACTION.name = "Loners"
FACTION.description = "Regular inhabitants of the zone."
FACTION.isDefault = true
FACTION.color = Color(142, 142, 142)
FACTION.models = {
	{"models/stalkerisaac/playermodel/male_01_anorak.mdl", 1, "00000201"},
	{"models/stalkerisaac/playermodel/male_01_anorak.mdl", 2, "00000201"},
	{"models/stalkerisaac/playermodel/male_01_anorak.mdl", 3, "00000201"},
	{"models/stalkerisaac/playermodel/male_01_anorak.mdl", 4, "00000201"},
	{"models/stalkerisaac/playermodel/male_01_anorak.mdl", 5, "00000201"},
	{"models/stalkerisaac/playermodel/male_01_anorak.mdl", 6, "00000201"},
	{"models/stalkerisaac/playermodel/male_01_anorak.mdl", 7, "00000201"},
	{"models/stalkerisaac/playermodel/male_01_anorak.mdl", 8, "00000201"},
--	{"models/stalkerisaac/playermodel/male_01_anorak.mdl", 9, "00000201"},
--	{"models/stalkerisaac/playermodel/male_01_anorak.mdl", 10, "00000201"},
--	{"models/stalkerisaac/playermodel/male_01_anorak.mdl", 11, "00000201"},
--	{"models/stalkerisaac/playermodel/male_01_anorak.mdl", 12, "00000201"}, --merc
	{"models/stalkerisaac/playermodel/male_01_anorak.mdl", 13, "00000201"},
	{"models/stalkerisaac/playermodel/male_01_anorak.mdl", 14, "00000201"},
	{"models/stalkerisaac/playermodel/male_01_anorak.mdl", 15, "00000201"},
	{"models/stalkerisaac/playermodel/male_01_anorak.mdl", 16, "00000201"},
	{"models/stalkerisaac/playermodel/male_01_anorak.mdl", 17, "00000201"},
	{"models/stalkerisaac/playermodel/male_01_anorak.mdl", 18, "00000201"},
	{"models/stalkerisaac/playermodel/male_01_anorak.mdl", 19, "00000201"},
	{"models/stalkerisaac/playermodel/male_01_anorak.mdl", 20, "00000201"},
	{"models/stalkerisaac/playermodel/male_01_anorak.mdl", 21, "00000201"},
	{"models/stalkerisaac/playermodel/male_01_anorak.mdl", 22, "00000201"},
	{"models/stalkerisaac/playermodel/male_01_anorak.mdl", 23, "00000201"},
--	{"models/stalkerisaac/playermodel/male_01_anorak.mdl", 24, "00000201"},
	{"models/stalkerisaac/playermodel/male_01_anorak.mdl", 25, "00000201"},
	{"models/stalkerisaac/playermodel/male_01_anorak.mdl", 26, "00000201"},
	{"models/stalkerisaac/playermodel/male_01_anorak.mdl", 27, "00000201"},
	{"models/stalkerisaac/playermodel/male_01_anorak.mdl", 28, "00000201"},
	{"models/stalkerisaac/playermodel/male_01_anorak.mdl", 29, "00000201"},
	{"models/stalkerisaac/playermodel/male_01_anorak.mdl", 30, "00000201"},
	{"models/stalkerisaac/playermodel/male_01_anorak.mdl", 31, "00000201"},
	{"models/stalkerisaac/playermodel/male_01_anorak.mdl", 32, "00000201"},
}


-- You should define a global variable for this faction's index for easy access wherever you need. FACTION.index is
-- automatically set, so you can simply assign the value.

-- Note that the player's team will also have the same value as their current character's faction index. This means you can use
-- client:Team() == FACTION_CITIZEN to compare the faction of the player's current character.
FACTION_LONERS = FACTION.index
