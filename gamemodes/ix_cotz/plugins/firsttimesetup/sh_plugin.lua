PLUGIN.name = "First Time Setup"
PLUGIN.author = "gumlefar"
PLUGIN.description = "A plugin that lets you spawn in a map preset of containers and advanced vendors."

PLUGIN.map_presets = {}

ix.util.Include("sh_definitions.lua")

if SERVER then

	function PLUGIN:RunFirstTimeSetup()
		-- Spawn containers
		for _, containerdata in pairs(self.map_presets[game.GetMap()].containers) do
			self:SpawnContainer(containerdata)
		end

		ix.plugin.list["containers"]:SaveContainer()

		-- Spawn vendors
		for _, vendordata in pairs(self.map_presets[game.GetMap()].vendors) do
			self:SpawnVendor(vendordata)
		end
	end

	function PLUGIN:SpawnContainer(containerdata)
		local container = ents.Create("ix_container")
		container:SetPos(containerdata.position)
		container:SetAngles(containerdata.angles)
		container:SetModel(containerdata.model)
		container:SetSpawnCategory(containerdata.spawnCategory)
		container:SetCyclicalCategory(containerdata.cyclicalCategory)
		container:Spawn()

		ix.inventory.New(0, "container:" .. containerdata.model:lower(), function(inventory)
			-- we'll technically call this a bag since we don't want other bags to go inside
			inventory.vars.isBag = true
			inventory.vars.isContainer = true

			if (IsValid(container)) then
				container:SetInventory(inventory)
			end
		end)
	end

	function PLUGIN:SpawnVendor(vendordata)
		ix.util.SpawnAdvVendor(vendordata.template, vendordata.position, vendordata.angles)
	end

	function PLUGIN:SaveData()
		self:SetData(self.firstTimeSetupRun or false)
	end

	function PLUGIN:LoadData()
		self.firstTimeSetupRun = self:GetData() or false
	end
end



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
