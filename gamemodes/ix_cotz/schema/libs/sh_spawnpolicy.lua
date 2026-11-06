ix.spawnPolicy = ix.spawnPolicy or {}
ix.spawnPolicy.maps = {"rp_marsh_cs", "rp_garbage_cotz", "rp_waystation", "rp_pripyat_remaster"}

function ix.spawnPolicy.Register(key)
	for _, map in ipairs(ix.spawnPolicy.maps) do
		local data = table.Copy(ix.config.stored[key].data.data or {})
		data.min = -1
		ix.config.Add(key .. "_" .. map, -1, "Map override: -1 inherits the shared setting.", nil, {
			category = "Spawning: " .. map,
			data = data,
		})
	end
end

function ix.spawnPolicy.Get(key, default, map)
	local value = ix.config.Get(key .. "_" .. (map or game.GetMap()), -1)
	if value < 0 then return ix.config.Get(key, default) end

	return value
end
