
-- You can define factions in the factions/ folder. You need to have at least one faction that is the default faction - i.e the
-- faction that will always be available without any whitelists and etc.

FACTION.name = "Loners"
FACTION.description = "Regular inhabitants of the zone."
FACTION.isDefault = true
FACTION.color = Color(142, 142, 142)
-- New characters start in the plain sweater; suits supply every other outfit.
FACTION.models = {
	{ix.suitAppearance.SWEATER_MODEL, 0, "000"},
}


-- You should define a global variable for this faction's index for easy access wherever you need. FACTION.index is
-- automatically set, so you can simply assign the value.

-- Note that the player's team will also have the same value as their current character's faction index. This means you can use
-- client:Team() == FACTION_CITIZEN to compare the faction of the player's current character.
FACTION_LONERS = FACTION.index
