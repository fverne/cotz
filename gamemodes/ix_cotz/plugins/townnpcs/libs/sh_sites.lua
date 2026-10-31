local PLUGIN = PLUGIN
local KINDS = {"recovery", "sensor", "triangulation", "deadDrop", "defence"}

function PLUGIN:ConfigureSources()
	for _, kind in ipairs(KINDS) do
		local source = "town_" .. kind
		ix.jobs.field.sources[source] = {plugin = "townnpcs", key = kind .. "Points"}
		local settings = ix.jobs.field.settings[kind]
		for _, field in ipairs({"sources", "destinationSources", "attackSources"}) do
			if settings[field] then
				local found = false
				for _, name in ipairs(settings[field]) do if name == source then found = true end end
				if not found then settings[field][#settings[field] + 1] = source end
			end
		end
	end
end
