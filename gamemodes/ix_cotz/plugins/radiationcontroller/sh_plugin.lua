local PLUGIN = PLUGIN
PLUGIN.name = "Radiation Controller"
PLUGIN.author = "verne"
PLUGIN.desc = "Allows for randomly spawning radiation entities"

PLUGIN.radiationdefs = PLUGIN.radiationdefs or {}
PLUGIN.radiationpoints = PLUGIN.radiationpoints or {} -- ANOMALYPOINTS STRUCTURE table.insert( PLUGIN.eventpoints, { position, radius, anoms } )

ix.util.Include("sh_radiationdefs.lua")

if SERVER then
	local spawntime = 1

	function PLUGIN:cleanRadiation()
		for k, v in pairs( ents.GetAll() ) do
			if (string.sub(v:GetClass(), 1, 4) == "rad_") then
				v:Remove()
			end
		end
	end

	function PLUGIN:spawnRadiation()
			
			for k, v in pairs(self.radiationpoints) do
				local selectedRadiation = {}
				for i=1, #self.radiationdefs do
					if string.sub(v[3],i,i) == "1" then
						table.insert( selectedRadiation, self.radiationdefs[i])
					end
				end

				local entity = table.Random(selectedRadiation)
				local position = v[1]
				local data = {}
				data.start = position
				data.endpos = position
				data.mins = Vector(-16, -16, 0)
				data.maxs = Vector(16, 16, 71)
				local trace = util.TraceHull(data)

				if trace.Entity:IsValid() then
					continue
				end

				if entity.name == "Nil" then
					continue
				end

				local spawnedent = ents.Create(entity.entityname)
				spawnedent:SetPos(position)
				spawnedent:Spawn()
				
				--Passive damage component
				--local spawnedent = ents.Create("anom_passive")
				--spawnedent:SetPos(v[1] + Vector(0,0,32))
				--spawnedent:setNetVar("range", v[2])
				--spawnedent:Spawn()
				--Passive damage component end
				
			end
		end

	function PLUGIN:LoadData()
		self.radiationpoints = self:GetData() or {}

		self:cleanRadiation()
		self:spawnRadiation()
	end

	function PLUGIN:SaveData()
		self:SetData(self.radiationpoints)
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

ix.command.Add("radiationadd", {
	superAdminOnly = true,
	arguments = {
		ix.type.string
	},
	OnRun = function(self, client, radiation)
		local trace = client:GetEyeTraceNoCursor()
		local hitpos = trace.HitPos + trace.HitNormal*5
		local radius = 0
		local radiation = radiation or 11111

		
		table.insert( PLUGIN.radiationpoints, { hitpos, radius, radiation } )
		client:Notify( "Radiation point successfully added" )
	end
})

ix.command.Add("radiationremove", {
	superAdminOnly = true,
	arguments = {
		ix.type.number
	},
	OnRun = function(self, client, range)
		local trace = client:GetEyeTraceNoCursor()
		local hitpos = trace.HitPos + trace.HitNormal*5
		local range = range or 128
		local mt = 0
		for k, v in pairs( PLUGIN.radiationpoints ) do
			local distance = v[1]:Distance( hitpos )
			if distance <= tonumber(range) then
				PLUGIN.radiationpoints[k] = nil
				mt = mt + 1
			end
		end
		if mt > 0 then
			client:Notify( mt .. " radiation locations has been removed.")
		else
			client:Notify( "No radiation spawn points found at location.")
		end
	end
})

ix.command.Add("radiationdisplay", {
	adminOnly = true,
	OnRun = function(self, client, arguments)
		if SERVER then
			netstream.Start(client, "ix_DisplaySpawnPoints", PLUGIN.radiationpoints)
			client:Notify( "Displayed All Points for 10 secs." )
		end
	end
})

ix.command.Add("radiationentremove", {
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
			if (string.sub(v:GetClass(), 1, 4) == "rad_") then
				v:Remove()
				mt = mt + 1
			end
		end
		if mt > 0 then
			client:Notify( "Removed " .. mt .. " radiation entities.")
		else
			client:Notify( "No radiation entities found at location.")
		end
	end
})