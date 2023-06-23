PLUGIN.name = "First Time Setup"
PLUGIN.author = "gumlefar"
PLUGIN.description = "A plugin that lets you spawn in a map preset of containers and advanced vendors, and set initial plugin data."

PLUGIN.map_presets = {}

ix.util.Include("sh_rp_marsh_cs.lua")
ix.util.Include("sh_rp_salvation_2_haven.lua")
ix.util.Include("sh_rp_waystation.lua")

if SERVER then

	PLUGIN.PluginDataDeployFunctions = {
		["anomalycontroller"] = function(payload)
			ix.plugin.list["anomalycontroller"].anomalypoints = payload
		end,
		["boxspawner"] = function(payload)
			ix.plugin.list["boxspawner"].boxpoints = payload
		end,
		["eventcontroller"] = function(payload)
			ix.plugin.list["eventcontroller"].eventpoints = payload
		end,
		["eventcontrolleradv"] = function(payload)
			ix.plugin.list["eventcontrolleradv"].eventpoints = payload
		end,
		["hidestashspawner"] = function(payload)
			ix.plugin.list["hidestashspawner"].stashspawnpoints = payload
		end,
		["radiationcontroller"] = function(payload)
			ix.plugin.list["radiationcontroller"].radiationpoints = payload
		end,
		["simplecrossserver"] = function(payload)
			ix.plugin.list["simplecrossserver"].loadpoints = payload
		end,
		["worlditemspawner"] = function(payload)
			ix.plugin.list["worlditemspawner"].itempoints = payload
		end,
	}

	PLUGIN.PluginDataGetFunctions = {
		["anomalycontroller"] = function()
			return ix.plugin.list["anomalycontroller"].anomalypoints
		end,
		["boxspawner"] = function()
			return ix.plugin.list["boxspawner"].boxpoints
		end,
		["eventcontroller"] = function()
			return ix.plugin.list["eventcontroller"].eventpoints
		end,
		["eventcontrolleradv"] = function()
			return ix.plugin.list["eventcontrolleradv"].eventpoints
		end,
		["hidestashspawner"] = function()
			return ix.plugin.list["hidestashspawner"].stashspawnpoints
		end,
		["radiationcontroller"] = function()
			return ix.plugin.list["radiationcontroller"].radiationpoints
		end,
		["simplecrossserver"] = function()
			return ix.plugin.list["simplecrossserver"].loadpoints
		end,
		["worlditemspawner"] = function()
			return ix.plugin.list["worlditemspawner"].itempoints
		end,
	}

	PLUGIN.PluginDataFormatFunctions = {
		["anomalycontroller"] = function(id, data)
			return "{ Vector("..data[1].x..","..data[1].y..","..data[1].z..") , "..tostring(data[2]).." , \""..tostring(data[3]).."\" }, \n"
		end,
		["boxspawner"] = function(id, data)
			if data[3] then
				return "{ Vector("..data[1].x..","..data[1].y..","..data[1].z..") , "..tostring(data[2]).." , \""..tostring(data[3]).."\" }, \n"
			else
				return "{ Vector("..data[1].x..","..data[1].y..","..data[1].z..") , "..tostring(data[2]).." }, \n"
			end
		end,
		["eventcontroller"] = function(id, data)
			return "{ Vector("..data[1].x..","..data[1].y..","..data[1].z..") , \""..data[2].."\" , "..data[3].." }, \n"
		end,
		["eventcontrolleradv"] = function(id, data)
			return "[\""..id.."\"] = { Vector("..data[1].x..","..data[1].y..","..data[1].z..") , \""..data[2].."\" }, \n"
		end,
		["hidestashspawner"] = function(id, data)
			return "{ Vector("..data[1].x..","..data[1].y..","..data[1].z..") , \""..data[2].."\" }, \n"
		end,
		["radiationcontroller"] = function(id, data)
			return "{ Vector("..data[1].x..","..data[1].y..","..data[1].z..") , \""..data[2].."\" }, \n"
		end,
		["simplecrossserver"] = function(id, data)
			return "{ Vector("..data[1].x..","..data[1].y..","..data[1].z..") , \""..data[2].."\" , \""..data[3].."\" }, \n"
		end,
		["worlditemspawner"] = function(id, data)
			return "{ Vector("..data[1].x..","..data[1].y..","..data[1].z..") , \""..data[2].."\" ), \n"
		end,
	}

	function PLUGIN:RunFirstTimeSetup()
		-- Spawn containers
		for _, containerdata in pairs(self.map_presets[game.GetMap()].containers) do
			self:SpawnContainer(containerdata)
		end

		-- Spawn generic entities ; Another plugin needs to persist them
		for _, entitydata in pairs(self.map_presets[game.GetMap()].entities) do
			self:SpawnEntity(entitydata)
		end

		ix.plugin.list["containers"]:SaveContainer()

		-- Spawn vendors
		for _, vendordata in pairs(self.map_presets[game.GetMap()].vendors) do
			self:SpawnVendor(vendordata)
		end

		-- Init all plugin data
		for pluginid, func in pairs(self.PluginDataDeployFunctions) do
			func(self.map_presets[game.GetMap].plugindata[pluginid])
		end

		self.firstTimeSetupRun = true
	end

	function PLUGIN:SpawnContainer(containerdata)
		local container = ents.Create("ix_container")
		container:SetPos(containerdata.position)
		container:SetAngles(containerdata.angles)
		container:SetModel(containerdata.model)
		container:SetSpawnCategory(containerdata.spawnCategory)
		container:SetCyclicalCategory(containerdata.cyclicalCategory)

		container:Spawn()

		local physObject = container:GetPhysicsObject()

		if (IsValid(physObject)) then
			physObject:Sleep()
			physObject:EnableMotion(false)
		end

		ix.inventory.New(0, "container:" .. containerdata.model:lower(), function(inventory)
			-- we'll technically call this a bag since we don't want other bags to go inside
			inventory.vars.isBag = true
			inventory.vars.isContainer = true

			if (IsValid(container)) then
				container:SetInventory(inventory)
			end
		end)

		if(containerdata.model == "models/props_borealis/bluebarrel001.mdl")then
			container:SetCollisionGroup( COLLISION_GROUP_WORLD )
        	container.CollisionGroup = COLLISION_GROUP_WORLD
			container:GetPhysicsObject():EnableCollisions(false)
		end
	end

	function PLUGIN:SpawnVendor(vendordata)
		ix.util.SpawnAdvVendor(vendordata.template, vendordata.position, vendordata.angles)
	end

	function PLUGIN:SpawnEntity(entitydata)
		local ent = ents.Create(entitydata.class)
		ent:SetPos(entitydata.position)
		ent:SetAngles(entitydata.angles)
		ent:Spawn()

		local physObject = ent:GetPhysicsObject()

		if (IsValid(physObject)) then
			physObject:Sleep()
			physObject:EnableMotion(false)
		end

	function PLUGIN:SaveData()
		self:SetData({self.firstTimeSetupRun} or {false})
	end

	function PLUGIN:LoadData()
		self.firstTimeSetupRun = self:GetData()[1] or false
	end
end

ix.command.Add("FTSGetEntityVars", {
	adminOnly = true,
	OnRun = function(self, client)
		local trace = client:GetEyeTraceNoCursor()
		local ent = trace.Entity

		if (ent and ent:IsValid()) then

			local entitydata = {}
			entitydata.class = ent:GetClass()
			entitydata.position = ent:GetPos()
			entitydata.angles = ent:GetAngles()

			netstream.Start(client, "ix_clientSidePrintEntityVars", entitydata)
		else
			client:Notify("Not looking at an entity.")
		end
	end
})

ix.command.Add("FTSGetContainerVars", {
	adminOnly = true,
	OnRun = function(self, client)
		local trace = client:GetEyeTraceNoCursor()
		local ent = trace.Entity

		if (ent and ent:IsValid() and ent:GetClass() == "ix_container") then

			local containerdata = {}
			containerdata.model = ent:GetModel()
			containerdata.position = ent:GetPos()
			containerdata.angles = ent:GetAngles()
			containerdata.spawnCategory = ent:GetSpawnCategory()
			containerdata.cyclicalCategory = ent:GetCyclicalCategory()

			netstream.Start(client, "ix_clientSidePrintContainerVars", containerdata)
		else
			client:Notify("Not looking at a container.")
		end
	end
})

ix.command.Add("FTSRunFirstTimeSetup", {
	adminOnly = true,
	arguments = bit.bor(ix.type.bool, ix.type.optional),
	OnRun = function(self, client, override)
		if (not ix.plugin.list["firsttimesetup"].firstTimeSetupRun) or override then
			ix.plugin.list["firsttimesetup"]:RunFirstTimeSetup()
		else
			client:Notify("First time setup has already been run on this map, put 'true' as an argument to this function to override and run anyway")
		end
	end
})

ix.command.Add("FTSShowContainerSpawns", {
	adminOnly = true,
	arguments = bit.bor(ix.type.bool, ix.type.optional),
	OnRun = function(self, client, override)
		if SERVER then
			local containers = {}
			for k, v in pairs( ix.plugin.list["firsttimesetup"].map_presets["rp_marsh_cs"].containers ) do
				table.insert(containers, v.position)
			end

			netstream.Start(client, "ix_DisplayFTSContainers", containers)
			client:Notify( "Displayed All Points for 10 secs." )
		end
	end
})

ix.command.Add("FTSDumpPluginData", {
	adminOnly = true,
	OnRun = function(self, client, override)
		if SERVER then

			file.CreateDir("FTSDump")

			for pluginid, func in pairs(ix.plugin.list["firsttimesetup"].PluginDataGetFunctions) do
				local data = func()
				local filename = "FTSDump/"..pluginid..".txt"
				print(filename)

				if (file.Exists(filename, "DATA" )) then
					file.Delete(filename)
				end
				file.Write(filename, pluginid.."\n")

				for k, record in pairs(data) do
					file.Append(filename, ix.plugin.list["firsttimesetup"].PluginDataFormatFunctions[pluginid](k, record))
				end
			end
		end
	end
})

if (CLIENT) then
	netstream.Hook("ix_clientSidePrintContainerVars", function(data)
		print("-----------------CONTAINER VARS START-----------------")
		print("    {")
		print("      model = \""..data.model.."\",")
		print("      position = Vector("..data.position.x..","..data.position.y..","..data.position.z.."),")
		print("      angles = Angle("..data.angles.x..","..data.angles.y..","..data.angles.z.."),")
		print("      spawnCategory = \""..data.spawnCategory.."\",")
		print("      cyclicalCategory = \""..data.cyclicalCategory.."\",")
		print("    },")
		print("-----------------CONTAINER VARS END-----------------")
	end)

	netstream.Hook("ix_clientSidePrintEntityVars", function(data)
		print("-----------------ENTITY VARS START-----------------")
		print("    {")
		print("      class = \""..data.class.."\",")
		print("      position = Vector("..data.position.x..","..data.position.y..","..data.position.z.."),")
		print("      angles = Angle("..data.angles.x..","..data.angles.y..","..data.angles.z.."),")
		print("    },")
		print("-----------------ENTITY VARS END-----------------")
	end)

	netstream.Hook("ix_DisplayFTSContainers", function(data)
		for k, v in pairs(data) do
			local emitter = ParticleEmitter( v )
			local smoke = emitter:Add( "sprites/glow04_noz", v )
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
