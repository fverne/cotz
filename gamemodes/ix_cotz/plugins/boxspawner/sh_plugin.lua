local PLUGIN = PLUGIN
PLUGIN.name = "BoxSpawner"
PLUGIN.author = "gumlefar"
PLUGIN.desc = "Spawns boxes at set locations"

PLUGIN.boxpoints = PLUGIN.boxpoints or {}

PLUGIN.spawnrate = 300

PLUGIN.saferadius = 1024
PLUGIN.boxchance = 10

PLUGIN.boxtypes = {
	"ix_entbox",
	"ix_wood_entbox",
}

ix.config.Add("boxSpawnerThreshold", 50, "How many boxes should the controller keep on the map.", nil, {
	data = {min = 0, max = 200},
	category = "Spawning"
})

if SERVER then
	local spawntime = 1
	
	local function isClear(position)
		local currentents = ents.FindInSphere( position, PLUGIN.saferadius )

		for i,j in pairs (currentents) do
			if j:IsPlayer() then
				return false
			end
		end

		local nearby = ents.FindInSphere( position, 20 )
		for i,j in pairs (nearby) do
			if string.find(j:GetClass(), "entbox") or string.find(j:GetClass(), "ix_item") then
				return false
			end
		end
		return true
	end
	
	function PLUGIN:spawnBoxes()
		local n_boxes = self:GetNumBoxes()
		local max_boxes = ix.config.Get("boxSpawnerThreshold",50)

		for _,v in RandomPairs(self.boxpoints) do
			if (n_boxes > max_boxes) then return end

			local pos = v[1]
			local boxtype = self.boxtypes[v[2]]
			local customgroup = v[3] or nil
			if(isClear(v[1])) then
				local box = ents.Create(boxtype)
				box.CustomSpawngroup = customgroup
				box:SetPos(pos)
				box:Spawn()
				box:PhysWake()
			end

			n_boxes = n_boxes + 1
		end
	end

	function PLUGIN:LoadData()
		self.boxpoints = self:GetData() or {}
	end

	function PLUGIN:SaveData()
		self:SetData(self.boxpoints)
	end
	
	function PLUGIN:Think()
		if spawntime > CurTime() then return end
		spawntime = CurTime() + self.spawnrate
		if( self:GetNumBoxes() > ix.config.Get("boxSpawnerThreshold",50)) then return end

		self:spawnBoxes()
	end	

	function PLUGIN:GetNumBoxes()
		local combinedtable = {}

		for k,v in pairs(self.boxtypes) do
			table.Add(combinedtable, ents.FindByClass(v))
		end

		return #combinedtable
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

ix.command.Add("boxspawnadd", {
	superAdminOnly = true,
	arguments = {
		ix.type.number,
		bit.bor(ix.type.string, ix.type.optional)
	},
	OnRun = function(self, client, boxtype, customgroup)
		local trace = client:GetEyeTraceNoCursor()
		local hitpos = trace.HitPos + trace.HitNormal*5
		local boxtype = boxtype or 1
		local customgroup = customgroup or nil

		table.insert( PLUGIN.boxpoints, { hitpos, boxtype, customgroup } )
		if(customgroup)then
			client:Notify( "Boxspawner added, spawning '"..PLUGIN.boxtypes[boxtype].."' with custom group "..customgroup.." succesfully added"  )
		else
			client:Notify( "Boxspawner added, spawning '"..PLUGIN.boxtypes[boxtype].."' succesfully added"  )
		end
	end
})

ix.command.Add("boxspawnremove", {
	superAdminOnly = true,
	arguments = {
		bit.bor(ix.type.number, ix.type.optional)
	},
	OnRun = function(self, client, range)
		local trace = client:GetEyeTraceNoCursor()
		local hitpos = trace.HitPos + trace.HitNormal*32
		local range = range or 128

		local mt = 0
		for k, v in pairs( PLUGIN.boxpoints ) do
			local distance = v[1]:Distance( hitpos )
			if distance <= tonumber(range) then
				PLUGIN.boxpoints[k] = nil
				mt = mt + 1
			end
		end
		client:Notify( mt .. " boxspawners has been removed.")
	end
})

ix.command.Add("boxspawndisplay", {
	adminOnly = true,
	OnRun = function(self, client, arguments)
		if SERVER then
			netstream.Start(client, "nut_DisplaySpawnPoints", PLUGIN.boxpoints)
			client:Notify( "Displayed All Points for 10 secs." )
		end
	end
})

ix.command.Add("boxspawnforce", {
	adminOnly = true,
	OnRun = function(client, arguments)
		PLUGIN:spawnBoxes()
	end
})