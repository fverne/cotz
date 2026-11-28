local PLUGIN = PLUGIN

-- Selects every definition that has a category.
local ALL_SELECTOR = "all"

local function normalizeSelector(text)
	return (string.lower(tostring(text)):gsub("[^%w]", ""))
end

local function splitWords(text)
	local words = {}

	for word in string.gmatch(text or "", "%S+") do
		words[#words + 1] = word
	end

	return words
end

-- Maps each selector (definition name, category or "all") to its definitions. Definitions without a category
-- cannot be selected by name either; legacy masks still reach them by index.
function PLUGIN:GetAnomalySelectors()
	local selectors = {[ALL_SELECTOR] = {}}

	for _, definition in ipairs(self.anomalydefs) do
		if definition.category then
			local category = normalizeSelector(definition.category)
			selectors[category] = selectors[category] or {}

			table.insert(selectors[category], definition)
			table.insert(selectors[ALL_SELECTOR], definition)
			selectors[normalizeSelector(definition.name)] = {definition}
		end
	end

	return selectors
end

-- Returns the sorted category and anomaly selectors, for feedback to admins.
function PLUGIN:GetAnomalySelectorNames()
	local categories, anomalies = {ALL_SELECTOR}, {}
	local seen = {}

	for _, definition in ipairs(self.anomalydefs) do
		local category = definition.category and normalizeSelector(definition.category)

		if category and not seen[category] then
			seen[category] = true
			categories[#categories + 1] = category
		end

		if category then
			anomalies[#anomalies + 1] = normalizeSelector(definition.name)
		end
	end

	table.sort(categories)
	table.sort(anomalies)

	return categories, anomalies
end

-- Resolves a point's stored selection into a list of unique definitions, plus any selectors it did not know.
-- Selections are space-separated selectors ("fire burner2"); strings of only 0 and 1 are the old per-index
-- masks ("0011" allows definitions 3 and 4), which the map presets and older saves still use.
function PLUGIN:ResolveAnomalySelection(selection)
	local text = tostring(selection or "")
	local definitions, unknown, added = {}, {}, {}

	local function add(definition)
		if added[definition] then return end

		added[definition] = true
		definitions[#definitions + 1] = definition
	end

	if string.match(text, "^[01]+$") then
		for index = 1, #text do
			if string.sub(text, index, index) == "1" and self.anomalydefs[index] then
				add(self.anomalydefs[index])
			end
		end

		return definitions, unknown
	end

	local selectors = self:GetAnomalySelectors()

	for _, word in ipairs(splitWords(text)) do
		local matches = selectors[normalizeSelector(word)]

		if not matches then
			unknown[#unknown + 1] = word
		end

		for _, definition in ipairs(matches or {}) do
			add(definition)
		end
	end

	return definitions, unknown
end

-- Parses /anomalyadd input. A leading number is the radius. Helix strips quotes from arguments, so a quoted
-- "burner 2" arrives as two words; a word that is not a selector by itself is joined with the next one.
-- Returns the radius (or nil), the normalized selectors and any words that did not match.
function PLUGIN:ParseAnomalySelection(text)
	local words = splitWords(text)
	local selectors = self:GetAnomalySelectors()
	local radius
	local chosen, unknown, seen = {}, {}, {}
	local index = 1

	if words[1] and tonumber(words[1]) then
		radius = tonumber(words[1])
		index = 2
	end

	while index <= #words do
		local selector = normalizeSelector(words[index])
		local joined = words[index + 1] and selector .. normalizeSelector(words[index + 1])

		if not selectors[selector] and joined and selectors[joined] then
			selector = joined
			index = index + 1
		end

		if selectors[selector] and not seen[selector] then
			seen[selector] = true
			chosen[#chosen + 1] = selector
		elseif not selectors[selector] then
			unknown[#unknown + 1] = words[index]
		end

		index = index + 1
	end

	return radius, chosen, unknown
end
