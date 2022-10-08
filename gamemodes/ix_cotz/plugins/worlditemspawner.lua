local PLUGIN = PLUGIN
PLUGIN.name = "World Item Spawner"
PLUGIN.author = "Black Tea (NS 1.0), Neon (NS 1.1), ported to ix by verne"
PLUGIN.desc = "World Item Spawner."
PLUGIN.itempoints = PLUGIN.itempoints or {}

PLUGIN.spawnrate = 300
PLUGIN.spawntime = 0
PLUGIN.saferadius = 512

ix.config.Add("worldSpawnerThreshold", 75, "How many items the worldspawner should keep the map populated with.", nil, {
	data = {min = 10, max = 200},
	category = "Spawning"
})

if SERVER then
	function PLUGIN:IsClear(position)
		for i,j in pairs (ents.FindInSphere( position, PLUGIN.saferadius )) do
			if j:IsPlayer() or j.bTemporary then
				return false
			end
		end
		return true
	end

	function PLUGIN:Think()
		if self.spawntime > CurTime() then return end
		self.spawntime = CurTime() + self.spawnrate

		local numitems = self:GetNumSpawnedItems()

		for i, j in RandomPairs(self.itempoints) do
			if (!j) then
				return
			end

			if (numitems > ix.config.Get("worldSpawnerThreshold",75)) then return end
			if ( !self:IsClear(j[1]) ) then continue end
	
			local data = {}
			data.start = j[1]
			data.endpos = data.start + Vector(0, 0, -64)
			data.filter = client
			data.mins = Vector(-32, -32, 0)
			data.maxs = Vector(32, 32, 32)
			local trace = util.TraceHull(data)
			
			local idat = ix.util.GetRandomItemFromPool(j[2])
			if math.random(101) <= 25 then -- Spread spawns out
				ix.item.Spawn(idat[1], j[1] + Vector( math.Rand(-8,8), math.Rand(-8,8), 20 ), function(item, ent) ent.bTemporary = true end, AngleRand(), idat[2] or {})
				numitems = numitems + 1
			end
		end
	end

	function PLUGIN:LoadData()
		self.itempoints = self:GetData() or {}
	end

	function PLUGIN:SaveData()
		self:SetData(self.itempoints)
	end

	function PLUGIN:GetNumSpawnedItems()
		local n = 0
		for k,v in pairs(ents.FindByClass("ix_item")) do
			if( v.bTemporary ) then
				n = n + 1
			end
		end

		return n
	end

else

	netstream.Hook("nut_DisplaySpawnPoints", function(data)
		for k, v in pairs(data) do
			local emitter = ParticleEmitter( v[1] )
			local smoke = emitter:Add( "sprites/glow04_noz", v[1] )
			smoke:SetVelocity( Vector( 0, 0, 1 ) )
			smoke:SetDieTime(10)
			smoke:SetStartAlpha(255)
			smoke:SetEndAlpha(255)
			smoke:SetStartSize(64)
			smoke:SetEndSize(64)
			smoke:SetColor(255,186,50)
			smoke:SetAirResistance(300)
		end
	end)

end

ix.command.Add("itemspawnadd", {
	superAdminOnly = true,
	arguments = {
		ix.type.string,
	},	
	OnRun = function(self, client, text)
		local trace = client:GetEyeTraceNoCursor()
		local hitpos = trace.HitPos + trace.HitNormal*5
		local spawngroup = text or "default"
		table.insert( PLUGIN.itempoints, { hitpos, spawngroup } )
		client:Notify( "You added ".. spawngroup .. " item spawner." )
	end
})

ix.command.Add("itemspawnremove", {
	superAdminOnly = true,
	arguments = {
		ix.type.number,
	},
	OnRun = function(self, client, arguments)
		local trace = client:GetEyeTraceNoCursor()
		local hitpos = trace.HitPos + trace.HitNormal*5
		local range = arguments or 128
		local mt = 0
		for k, v in pairs( PLUGIN.itempoints ) do
			local distance = v[1]:Distance( hitpos )
			if distance <= tonumber(range) then
				PLUGIN.itempoints[k] = nil
				mt = mt + 1
			end
		end
		client:Notify( mt .. " item spawners has been removed.")
	end
})

ix.command.Add("itemspawndisplay", {
	adminOnly = true,
	OnRun = function(self, client, arguments)
		if SERVER then
			netstream.Start(client, "nut_DisplaySpawnPoints", PLUGIN.itempoints)
			client:Notify( "Displayed All Points for 10 secs." )
		end
	end
})