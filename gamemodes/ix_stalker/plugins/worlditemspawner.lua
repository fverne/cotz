local PLUGIN = PLUGIN
PLUGIN.name = "World Item Spawner"
PLUGIN.author = "Black Tea (NS 1.0), Neon (NS 1.1), ported to ix by verne"
PLUGIN.desc = "World Item Spawner."
PLUGIN.itempoints = PLUGIN.itempoints or {}

PLUGIN.spawngroups = {
	["default"] = {
		{"medic_medkit_2"},
	},
}

--PLUGIN.spawnchance = 0.5 + (1 * #player.GetAll())
PLUGIN.spawnrate = 750
PLUGIN.maxitems = 1
PLUGIN.itemsperspawn = 1
PLUGIN.spawneditems = PLUGIN.spawneditems or {}

if SERVER then
	local spawntime = 1

	function PLUGIN:ItemShouldSave(entity)
		return (!entity.generated)
	end

	function PLUGIN:Think()
		if spawntime > CurTime() then return end
		spawntime = CurTime() + self.spawnrate + math.random(self.spawnrate/2)
		for k, v in ipairs(self.spawneditems) do
			if (!v:IsValid()) then
				table.remove(self.spawneditems, k)
			end
		end

		if #self.spawneditems >= self.maxitems then return end

		for i = 1, self.itemsperspawn do
			if #self.spawneditems >= self.maxitems then
					table.remove(self.spawneditems)
			return
			end
			for i, j in pairs(self.itempoints) do

				if (!j) then
					return
				end
	
				local data = {}
				data.start = j[1]
				data.endpos = data.start + Vector(0, 0, -64)
				data.filter = client
				data.mins = Vector(-32, -32, 0)
				data.maxs = Vector(32, 32, 32)
				local trace = util.TraceHull(data)
			
				local idat = ix.util.GetRandomItemFromPool(j[2])
				if math.random(101) <= (0 + math.sqrt(1.7 * #player.GetAll())) then
					ix.item.Spawn(idat[1], j[1] + Vector( math.Rand(-8,8), math.Rand(-8,8), 20 ), nil, AngleRand(), idat[2] or {})
				end
			end
		end
	end

	function PLUGIN:LoadData()
		self.itempoints = self:GetData() or {}
	end

	function PLUGIN:SaveData()
		self:SetData(self.itempoints)
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