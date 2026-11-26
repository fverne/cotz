local PLUGIN = PLUGIN

local TRENCHCOAT = "suit_trenchcoat"
-- Factory finish of each former colour item, kept so owned coats stay their colour.
local COAT_COLOURS = {
	{id = "suit_trenchcoat_black", skin = 1},
	{id = "suit_trenchcoat_brown", skin = 0},
	{id = "suit_trenchcoat_green", skin = 4},
	{id = "suit_trenchcoat_tan", skin = 6},
}
-- Old Sky-3 became Sky-5. A new Sky-3 reuses these IDs, and only its items carry `skyLineVersion`.
local SKY_RENAMES = {
	{from = "suit_cs3", to = "suit_cs5"},
	{from = "suit_cs3_ecologist", to = "suit_cs5_ecologist"},
}

-- Each statement is a single UPDATE that no longer matches what it changed, so running it again, on
-- every server, is harmless. None needs a SELECT first, which keeps them ahead of item loading in the
-- query queue.
function PLUGIN:GetSuitMigrationQueries(adapter)
	local queries = {}
	for _, coat in ipairs(COAT_COLOURS) do
		local colour = "\"legacyCoatSkin\":" .. coat.skin
		-- Saved item data is a JSON object; an item without any is stored as NULL, "[]" or "{}".
		local prefix = "'{" .. colour .. ",'"
		local joined = adapter == "sqlite" and prefix .. " || SUBSTR(data, 2)"
			or "CONCAT(" .. prefix .. ", SUBSTR(data, 2))"
		queries[#queries + 1] = "UPDATE ix_items SET data = CASE WHEN data LIKE '{\"%' THEN " .. joined
			.. " ELSE '{" .. colour .. "}' END, unique_id = '" .. TRENCHCOAT .. "' WHERE unique_id = '"
			.. coat.id .. "'"
	end
	for _, rename in ipairs(SKY_RENAMES) do
		queries[#queries + 1] = "UPDATE ix_items SET unique_id = '" .. rename.to .. "' WHERE unique_id = '"
			.. rename.from .. "' AND (data IS NULL OR data NOT LIKE '%\"skyLineVersion\"%')"
	end

	return queries
end

function PLUGIN:DatabaseConnected()
	-- A new SQLite database has no item table yet, and nothing to convert.
	if mysql.module == "sqlite" and not sql.TableExists("ix_items") then return end
	for _, query in ipairs(self:GetSuitMigrationQueries(mysql.module)) do
		mysql:RawQuery(query)
	end
end
