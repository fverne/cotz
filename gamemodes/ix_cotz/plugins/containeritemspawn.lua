PLUGIN.name = "Container Item Spawner"
PLUGIN.author = "gumlefar"
PLUGIN.desc = "Spawns items in containers."

ix.config.Add("containerSpawnChanceFlat", 1, "How many percent to spawn with zero players on the server.", nil, {
	data = {min = 0, max = 100},
	category = "Containers"
})

ix.config.Add("containerSpawnChanceScaling", 0.5, "How much the probability for spawning should be scaled per player.", nil, {
	data = {min = 0, max = 10},
	category = "Containers"
})

ix.config.Add("containerSpawnRate", 900, "How many seconds between each attempted spawn.", nil, {
	data = {min = 10, max = 43200},
	category = "Containers"
})

ix.config.Add("containerSpawnMaxItems", 1, "How many items the spawner will at most spawn in a container.", nil, {
	data = {min = 1, max = 10},
	category = "Containers"
})

ix.config.Add("containerSpawnMaxItemsPerRun", 10, "How many items the spawner will at most spawn in any given attempt.", nil, {
	data = {min = 1, max = 50},
	category = "Containers"
})

if SERVER then
	local spawntime = 1

	function PLUGIN:Think()
		if spawntime > CurTime() then return end

		spawntime = CurTime() + ix.config.Get("containerSpawnRate", 900) + math.random(ix.config.Get("containerSpawnRate", 900)/2)

		local spawncnt = 0

		for k, v in pairs( ents.FindByClass( "ix_container" ) ) do
			if spawncnt >= ix.config.Get("containerSpawnMaxItemsPerRun", 10) then break end
			if v.spawnCategory != nil then
				if math.random(101) <= ix.config.Get("containerSpawnChanceFlat", 1) + (ix.config.Get("containerSpawnChanceScaling", 0.5) * player.GetCount()) then
					local idat = ix.util.GetRandomItemFromPool(v.spawnCategory)

					if ix.item.inventories[v:GetID()]:GetItemCountNonSpecific(true) < ix.config.Get("containerSpawnMaxItems", 1) then
						v:GetInventory():Add(idat[1], 1, idat[2] or {})
						spawncnt = spawncnt + 1
					end
				end
			end
		end
	end
end


ix.command.Add("containerspawnadd", {
	adminOnly = true,
	arguments = {
		ix.type.string
	},
	OnRun = function(self, client, spawngroup)
		local trace = client:GetEyeTraceNoCursor()
		local ent = trace.Entity

		if (ent and ent:IsValid() and ent:GetClass() == "ix_container") then
			local spawnCat = spawngroup

			ent.spawnCategory = spawnCat
			client:Notify("Storage spawngroup set to "..spawnCat)
		else
			client:NotifyLocalized("invalid", "Entity")
		end
	end
})

ix.command.Add("containerspawnremove", {
	adminOnly = true,
	OnRun = function(self, client)
		local trace = client:GetEyeTraceNoCursor()
		local ent = trace.Entity

		if (ent and ent:IsValid() and ent:GetClass() == "ix_container") then

			ent.spawnCategory = nil
			client:Notify("Storage will no longer spawn items")
		else
			client:NotifyLocalized("invalid", "Entity")
		end
	end
})