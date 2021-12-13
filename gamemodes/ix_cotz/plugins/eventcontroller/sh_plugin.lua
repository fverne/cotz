local PLUGIN = PLUGIN
PLUGIN.name = "EventController"
PLUGIN.author = "gumlefar"
PLUGIN.desc = "Makes events occur randomly on your server"

PLUGIN.eventdefs = PLUGIN.eventdefs or {}
PLUGIN.eventpoints = PLUGIN.eventpoints or {} -- EVENTPOINT STRUCTURE table.insert( PLUGIN.eventpoints, { position, name, difficulty } )

ix.util.Include("sh_eventdefs.lua")

PLUGIN.spawnradius = 750
PLUGIN.populateAmount = 7

PLUGIN.pdachatter = false 
PLUGIN.pdachatterchance = 100

PLUGIN.saferadius = 1500

PLUGIN.spawnrate = 30

local icon = Material("vgui/icons/news.png")

ix.config.Add("eventControllerThreshold", 70, "How many mutants should the controller keep on the map.", nil, {
	data = {min = 10, max = 100},
	category = "Spawning"
})

if SERVER then
	local spawntime = 1
	local populate = true
	
	function PLUGIN:IsClear(position)
		
		local currentdefs = {}
		local currentents = ents.FindInSphere( position, PLUGIN.saferadius )

		for i,j in pairs (currentents) do
			if j:IsPlayer() then
				return false
			elseif (string.sub(j:GetClass(), 1, 10) == "npc_mutant") then
				return false
			end
		end
		return true
	end
	
	function PLUGIN:spawnEvent(eventpoint, spawn)
		--spawnents
		if spawn.entities then
			for k = 1, #spawn.entities do
				for i = 1, spawn.entities[k][2] do
					local position = self:GetSpawnLocation( eventpoint[1] )
					local data = {}
					data.start = position
					data.endpos = position
					data.mins = Vector(-42, -42, 0)
					data.maxs = Vector(42, 42, 71)
					local trace = util.TraceHull(data)
							
					if trace.Entity:IsValid() then
						continue
					end

					local newNPC = ents.Create(spawn.entities[k][1])
					newNPC:SetPos(position)
					newNPC:Spawn()
					newNPC:DropToFloor()
				end
			end
		end
		--spawnitems
		if spawn.items then
			for k = 1, #spawn.items do
				local position = self:GetSpawnLocation( eventpoint[1] )
				local data = {}
				data.start = position
				data.endpos = position
				data.mins = Vector(-16, -16, 0)
				data.maxs = Vector(16, 16, 71)
				local trace = util.TraceHull(data)
					
				if trace.Entity:IsValid() then
					continue
				end
				ix.item.Spawn(spawn.items[k][1], position, nil, AngleRand(), spawn.items[k][2] or {})
			end
		end
			
		--spawn loot
		if spawn.loot then
			/*for k = 1, #spawn.loot do
				for i = 1, spawn.loot[k][2] do
					local position = self:GetSpawnLocation( eventpoint[1] )
					local data = {}
					data.start = position
					data.endpos = position
					data.mins = Vector(-16, -16, 0)
					data.maxs = Vector(16, 16, 71)
					local trace = util.TraceHull(data)
						
					if trace.Entity:IsValid() then
						continue
					end

					if math.random(100) <= spawn.lootChance then
						ix.item.Spawn(spawn.loot[k][1], position, nil, AngleRand(), spawn.loot[k][3] or {})
					end
				end
			end*/
		end
	end

	function PLUGIN:setSpawnTime(time)
		spawntime = time
	end
	
	function PLUGIN:setPopulate(bool)
		populate = bool
	end

	function PLUGIN:LoadData()
		self.eventpoints = self:GetData() or {}
	end

	function PLUGIN:SaveData()
		self:SetData(self.eventpoints)
	end

	function PLUGIN:GetSpawnLocation( pos )
		local tracegood = false
		local teleres
		local tracecnt = 0

		local firstTrace = util.TraceLine( {
				start = pos + Vector(0,0,64),
				endpos = pos + Vector(0,0,512),
				mask = MASK_ALL,
				ignoreworld = false
			} )

		repeat
			local trace = util.TraceHull( {
				start = firstTrace.HitPos - Vector(0,0,64),
				endpos = pos + Vector(math.random(-PLUGIN.spawnradius,PLUGIN.spawnradius),math.random(-PLUGIN.spawnradius,PLUGIN.spawnradius),-400),
				mins = Vector( -32, -32, 0 ),
				maxs = Vector( 32, 32, 64 ),
				mask = MASK_ALL,
				ignoreworld = false
			} )

			if not trace.HitSky then
				tracegood = true
				teleres = trace.HitPos + ( trace.HitNormal * 32 )
			end

			tracecnt = tracecnt + 1

			if tracecnt > 50 then
				tracegood = true
				teleres = pos + Vector(0,0,64) -- Teleport to original position if we cant find a position
			end

		until tracegood


		return teleres
	end
	
	function PLUGIN:Think()
		if populate then
			for i = 1, self.populateAmount do
				local eventpoint = table.Random(self.eventpoints)
				local spawn = table.Random(self.eventdefs)

				if (!eventpoint) then
					return
				end

				while table.Random(spawn.difficulty) != eventpoint[3] do
					spawn = table.Random(self.eventdefs)
				end
				
				self:spawnEvent(eventpoint,spawn)
			end
			
			populate = false
		end
		
		if spawntime > CurTime() then return end
		spawntime = CurTime() + self.spawnrate

		if( self:GetNumMutants() > ix.config.Get("eventControllerThreshold",35)) then return end

		local eventpoint = table.Random(self.eventpoints)
		if (!eventpoint) then
			return
		end
		if( !self:IsClear(eventpoint[1]) ) then return end

		local spawn = table.Random(self.eventdefs)
		local n = 0
		while table.Random(spawn.difficulty) != eventpoint[3] and n<15 do
			spawn = table.Random(self.eventdefs)
			n = n + 1
		end

		self:spawnEvent(eventpoint, spawn)
		
		if ix.progression.GetNPCFromName("'Mute'") then
			self.pdachatter = true
		else
			self.pdachatter = false
		end

		if self.pdachatter == true then
			if math.Rand(1,100) <= self.pdachatterchance then
				for k, ply in pairs( player.GetAll() ) do
					ix.chat.Send(ply, "eventpdainternal", Format(spawn.pdabroadcast, eventpoint[2]), true, ply)
					 // ply:EmitSound( "stalkersound/pda/pda.wav", 50, 100, 1, CHAN_AUTO )
				end
			end
		end

	end	

	function PLUGIN:GetNumMutants()
		return #ents.FindByClass("npc_mutant_*")
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

ix.command.Add("eventadd", {
	superAdminOnly = true,
	arguments = {
		ix.type.string,
		ix.type.number
	},
	OnRun = function(self, client, name, difficulty)
		local trace = client:GetEyeTraceNoCursor()
		local hitpos = trace.HitPos + trace.HitNormal*5
		local name = name or "UNNAMED AREA"
		local difficulty = difficulty or 1

		if isnumber(difficulty) then
			table.insert( PLUGIN.eventpoints, { hitpos, name, difficulty } )
			client:Notify( "Event area named '"..name.."' with difficulty "..difficulty.." succesfully added"  )
		else
			client:ChatPrint("Difficulty must be a number.")
		end
	end
})

ix.command.Add("eventremove", {
	superAdminOnly = true,
	OnRun = function(self, client, arguments)
		local trace = client:GetEyeTraceNoCursor()
		local hitpos = trace.HitPos + trace.HitNormal*5
		local range = arguments[1] or 128
		local mt = 0
		for k, v in pairs( PLUGIN.eventpoints ) do
			local distance = v[1]:Distance( hitpos )
			if distance <= tonumber(range) then
				PLUGIN.eventpoints[k] = nil
				mt = mt + 1
			end
		end
		client:Notify( mt .. " event locations has been removed.")
	end
})

ix.command.Add("eventdisplay", {
	adminOnly = true,
	OnRun = function(self, client, arguments)
		if SERVER then
			netstream.Start(client, "nut_DisplaySpawnPoints", PLUGIN.eventpoints)
			client:Notify( "Displayed All Points for 10 secs." )
		end
	end
})

ix.command.Add("eventforce", {
	adminOnly = true,
	OnRun = function(client, arguments)
		PLUGIN:setSpawnTime(1)
	end
})

ix.command.Add("eventpopulate", {
	adminOnly = true,
	--syntax = "<number amount>",
	OnRun = function(self, client, arguments)
		PLUGIN:setPopulate(true)
		--local amount = tonumber(arguments[1]) or 5
		--if isnumber(amount) then
		--	PLUGIN.populateAmount = arguments[1]
		--else
		--	client:ChatPrint("Amount must be a number.")
		--end
	end
})
