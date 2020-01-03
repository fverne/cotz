local PLUGIN = PLUGIN
PLUGIN.name = "Anomaly Controller"
PLUGIN.author = "some faggot"
PLUGIN.desc = "Allows for randomly spawning anomaly entities"

PLUGIN.anomalydefs = PLUGIN.anomalydefs or {}
PLUGIN.anomalypoints = PLUGIN.anomalypoints or {} -- ANOMALYPOINTS STRUCTURE table.insert( PLUGIN.eventpoints, { position, radius, anoms } )

PLUGIN.spawnrate = 900
PLUGIN.spawnchance = 1

ix.util.Include("sh_anomalydefs.lua")

if SERVER then
	local spawntime = 1

	function PLUGIN:Think()
		if spawntime > CurTime() then return end
		spawntime = CurTime() + self.spawnrate - #player.GetAll()*5

		for i, j in pairs(self.anomalypoints) do
			
			if (!j) then
				return
			end

			if math.random(1001) > self.spawnchance then
				return
			end

			local data = {}
			data.start = j[1]
			data.endpos = data.start + Vector(0, 0, -64)
			data.filter = client
			data.mins = Vector(-32, -32, 0)
			data.maxs = Vector(32, 32, 32)
			local trace = util.TraceHull(data)

			if trace.Entity:IsValid() then
				if !(trace.Entity:GetClass() == "ix_storage") then
					continue
				end
			end
			
			local rand = math.random(101)
			local rarityselector = 0
			local anomalyselector = 0

			if rand <= 70 then
				rarityselector = 0
			elseif rand <= 90 then
				rarityselector = 1
			elseif rand <= 100 then
				rarityselector = 2
			else return end

			for k,v in pairs(ents.FindInSphere(j[1], 400)) do
				if (string.sub(v:GetClass(), 1, 5) == "anom_") then
					for i=1,5 do
						if self.anomalydefs[i].entityname == v:GetClass() then
							anomalyselector = i
							break
						end
					end
				end
			end

			if anomalyselector == 0 then return end

			local idat = 0

			if rarityselector == 0 then
				idat = table.Random(self.anomalydefs[anomalyselector].commonArtifacts)
			elseif rarityselector == 1 then
				idat = table.Random(self.anomalydefs[anomalyselector].rareArtifacts)
			else
				idat = table.Random(self.anomalydefs[anomalyselector].veryRareArtifacts)
			end

			ix.item.Spawn(idat, j[1] + Vector( math.Rand(-8,8), math.Rand(-8,8), 20 ), nil, AngleRand(), {})

		end
	end


	function PLUGIN:cleanAnomalies()
		for k, v in pairs( ents.GetAll() ) do
			if (string.sub(v:GetClass(), 1, 5) == "anom_") then
				v:Remove()
			end
		end
	end

	function PLUGIN:spawnAnomalies()
		if CurTime() > 5 then
			spawntime = 1
		end
			
		for k, v in pairs(self.anomalypoints) do
			local selectedAnoms = {}
			for i=1, #self.anomalydefs do
				if string.sub(v[3],i,i) == "1" then
					table.insert( selectedAnoms, self.anomalydefs[i])
				end
			end

			local entity = table.Random(selectedAnoms)
			for i = 1, math.ceil(v[2]/entity.interval) do
				local position = v[1] + Vector( math.Rand(-v[2],v[2]), math.Rand(-v[2],v[2]), math.Rand(10,20) )
				local data = {}
				data.start = position
				data.endpos = position
				data.mins = Vector(-16, -16, 0)
				data.maxs = Vector(16, 16, 71)
				local trace = util.TraceHull(data)

				if trace.Entity:IsValid() then
					continue
				end
				
				local spawnedent = ents.Create(entity.entityname)
				spawnedent:SetPos(position)
				spawnedent:Spawn()
			end
			
			--Passive damage component
			--local spawnedent = ents.Create("anom_passive")
			--spawnedent:SetPos(v[1] + Vector(0,0,32))
			--spawnedent:setNetVar("range", v[2])
			--spawnedent:Spawn()
			--Passive damage component end
			
		end
	end

	function PLUGIN:LoadData()
		self.anomalypoints = self:GetData() or {}

		self:cleanAnomalies()
		self:spawnAnomalies()
	end

	function PLUGIN:SaveData()
		self:SetData(self.anomalypoints)
	end

else

	netstream.Hook("ix_DisplaySpawnPoints", function(data)
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

ix.command.Add("anomalyadd", {
	superAdminOnly = true,
	arguments = {
		ix.type.number,
		ix.type.string
	},
	OnRun = function(self, client, radius, anomalies)
		local trace = client:GetEyeTraceNoCursor()
		local hitpos = trace.HitPos + trace.HitNormal*5
		local radius = radius or 128
		local anomalies = anomalies or 1111111111111111111
		if (!radius or !isnumber(radius) or radius < 0) then
			return "@invalidArg", 2
		end

		
		table.insert( PLUGIN.anomalypoints, { hitpos, radius, anomalies } )
		client:Notify( "Anomaly point successfully added" )
	end
})

ix.command.Add("anomalyremove", {
	superAdminOnly = true,
	arguments = {
		ix.type.number
	},
	OnRun = function(self, client, range)
		local trace = client:GetEyeTraceNoCursor()
		local hitpos = trace.HitPos + trace.HitNormal*5
		local range = range or 128
		local mt = 0
		for k, v in pairs( PLUGIN.anomalypoints ) do
			local distance = v[1]:Distance( hitpos )
			if distance <= tonumber(range) then
				PLUGIN.anomalypoints[k] = nil
				mt = mt + 1
			end
		end
		if mt > 0 then
			client:Notify( mt .. " anomaly locations has been removed.")
		else
			client:Notify( "No anomaly spawn points found at location.")
		end
	end
})

ix.command.Add("anomalydisplay", {
	adminOnly = true,
	OnRun = function(self, client, arguments)
		if SERVER then
			netstream.Start(client, "ix_DisplaySpawnPoints", PLUGIN.anomalypoints)
			client:Notify( "Displayed All Points for 10 secs." )
		end
	end
})

ix.command.Add("anomalyentremove", {
	adminOnly = true,
	arguments = {
		ix.type.number
	},	
	OnRun = function(self, client, range)
		local trace = client:GetEyeTraceNoCursor()
		local hitpos = trace.HitPos + trace.HitNormal*5
		local range = range or 128
		local mt = 0
		for k, v in pairs( ents.FindInSphere(hitpos, range) ) do
			if (string.sub(v:GetClass(), 1, 5) == "anom_") then
				v:Remove()
				mt = mt + 1
			end
		end
		if mt > 0 then
			client:Notify( "Removed " .. mt .. " anomalies.")
		else
			client:Notify( "No anomalies found at location.")
		end
	end
})