local PLUGIN = PLUGIN
PLUGIN.name = "EventController"
PLUGIN.author = "some faggot"
PLUGIN.desc = "Makes events occur randomly on your server"

PLUGIN.eventdefs = PLUGIN.eventdefs or {}
PLUGIN.eventpoints = PLUGIN.eventpoints or {} -- EVENTPOINT STRUCTURE table.insert( PLUGIN.eventpoints, { position, name, difficulty } )

ix.util.Include("sh_eventdefs.lua")

PLUGIN.spawnratebase = 1800
PLUGIN.spawnrateplayer = 30
PLUGIN.spawnradius = 128
PLUGIN.populateAmount = 5

PLUGIN.pdachatter = true
PLUGIN.pdachatterchance = 100

PLUGIN.saferadius = 1000

local icon = Material("vgui/icons/news.png")

ix.chat.Register("eventpda", {
	CanSay = function(self, speaker, text)
		if IsValid(speaker) then
			if speaker:GetCharacter():HasFlags("N") or speaker:IsAdmin() then
				return true
			else
				return false
			end
		else
			return false
		end
	end,
	OnChatAdd = function(self, speaker, text)
		chat.AddText(Color(0,191,255), "[GPDA-SYSTEM] ", Color(0,241,255), icon, ": "..text)
	end,
	prefix = {"/eventpda"},
	CanHear = function(self, speaker, listener)
		local pda = listener:GetCharacter():GetData("pdaequipped", false)
		if pda then
			listener:EmitSound( "stalkersound/pda_alarm.wav", 55, 100, 1, CHAN_AUTO ) 
			return true
		else
			return false
		end
	end,
})

ix.chat.Register("eventpdainternal", {
	CanSay = function(self, speaker, text)
		local pda = speaker:GetCharacter():GetData("pdaequipped", false)
		if pda then
			speaker:EmitSound( "stalkersound/pda_alarm.wav", 55, 100, 1, CHAN_AUTO ) 
			return true
		else 
			return false
		end
		return false
	end,
	OnChatAdd = function(self, speaker, text)
		chat.AddText(Color(0,191,255), "[GPDA-SYSTEM] ", Color(0,241,255), icon, ": "..text)
	end,
	prefix = {},
	CanHear = function(self, speaker, listener)
		local pda = listener:GetCharacter():GetData("pdaequipped", false)
		if pda then
			return true
		else
			return false
		end
	end,
})

if SERVER then
	local spawntime = 1
	local populate = true
	
	local function isClear(position)
		
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
	
	local function spawnEvent(eventpoint, spawn)
		if isClear(eventpoint[1]) then
			--spawnents
			if spawn.entities then
				for k = 1, #spawn.entities do
					for i = 1, spawn.entities[k][2] do
						local position = eventpoint[1] + Vector( math.Rand(-PLUGIN.spawnradius,PLUGIN.spawnradius), math.Rand(-PLUGIN.spawnradius,PLUGIN.spawnradius), 64 )
						local data = {}
						data.start = position
						data.endpos = position
						data.mins = Vector(-16, -16, 0)
						data.maxs = Vector(16, 16, 71)
						local trace = util.TraceHull(data)
							
						if trace.Entity:IsValid() then
							continue
						end

						local newNPC = ents.Create(spawn.entities[k][1])
						newNPC:SetPos(position)
						newNPC:Spawn()
					end
				end
			end
			--spawnitems
			if spawn.items then
				for k = 1, #spawn.items do
					local position = eventpoint[1] + Vector( math.Rand(-PLUGIN.spawnradius,PLUGIN.spawnradius), math.Rand(-PLUGIN.spawnradius,PLUGIN.spawnradius), 32 )
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
			--spawn props
			if spawn.props then
				for k = 1, #spawn.props do
					for i = 1, spawn.props[k][2] do
						local position = eventpoint[1] + Vector( math.Rand(-PLUGIN.spawnradius,PLUGIN.spawnradius), math.Rand(-PLUGIN.spawnradius,PLUGIN.spawnradius), 32 )
						local data = {}
						data.start = position
						data.endpos = position
						data.mins = Vector(-16, -16, 0)
						data.maxs = Vector(16, 16, 71)
						local trace = util.TraceHull(data)
						
						if trace.Entity:IsValid() then
							continue
						end

						local prop = ents.Create( "prop_physics" )
						prop:SetModel( spawn.props[k][1] )
						prop:SetPos( position )
						prop:Spawn()
						timer.Simple(300, function() prop:Remove() end)
					end
				end
			end
			--spawn ragdolls
			if spawn.ragdolls then
				for k = 1, #spawn.ragdolls do
					for i = 1, spawn.ragdolls[k][2] do
						local position = eventpoint[1] + Vector( math.Rand(-PLUGIN.spawnradius,PLUGIN.spawnradius), math.Rand(-PLUGIN.spawnradius,PLUGIN.spawnradius), 32 )
						local data = {}
						data.start = position
						data.endpos = position
						data.mins = Vector(-16, -16, 0)
						data.maxs = Vector(16, 16, 71)
						local trace = util.TraceHull(data)
						
						if trace.Entity:IsValid() then
							continue
						end
						
						/*
						local ragdoll = ClientsideRagdoll( spawn.ragdolls[k][1] )
						ragdoll:SetPos( position )
						ragdoll:SetSkin(spawn.ragdolls[k][3])
						ragdoll:SetBodyGroups(spawn.ragdolls[k][4])
						ragdoll:SetNoDraw( false )
						ragdoll:DrawShadow( true )
						ragdoll:Fire( "FadeAndRemove", "", 300 )
						*/
						-- Serversided ragdolls, tough performance
						local ragdoll = ents.Create( "prop_ragdoll" )
						ragdoll:SetModel( spawn.ragdolls[k][1] )
						ragdoll:SetPos( position )
						ragdoll:Spawn()
						ragdoll:SetSkin(spawn.ragdolls[k][3])
						ragdoll:SetBodyGroups(spawn.ragdolls[k][4])
						ragdoll:SetCollisionGroup( COLLISION_GROUP_DEBRIS ) --minimal performance hit
						ragdoll:Fire( "FadeAndRemove", "", 300 )

					end
				end
			end
			--spawn loot
			if spawn.loot then
				for k = 1, #spawn.loot do
					for i = 1, spawn.loot[k][2] do
						local position = eventpoint[1] + Vector( math.Rand(-PLUGIN.spawnradius,PLUGIN.spawnradius), math.Rand(-PLUGIN.spawnradius,PLUGIN.spawnradius), 32 )
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
				end
			end
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
				
				spawnEvent(eventpoint,spawn)
			end
			
			populate = false
		end
		
		if spawntime > CurTime() then return end
		spawntime = CurTime() + (self.spawnratebase - (self.spawnrateplayer * #player.GetAll()))

		local eventpoint = table.Random(self.eventpoints)
		local spawn = table.Random(self.eventdefs)

		if (!eventpoint) then
			return
		end


		while table.Random(spawn.difficulty) != eventpoint[3] do
			spawn = table.Random(self.eventdefs)
		end

		spawnEvent(eventpoint, spawn)
		
		if self.pdachatter == true then
			if math.Rand(1,100) <= self.pdachatterchance then
				for k, ply in pairs( player.GetAll() ) do
					ix.chat.Send(ply, "eventpdainternal", Format(spawn.pdabroadcast, eventpoint[2]), true, ply)
				end
			end
		end

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