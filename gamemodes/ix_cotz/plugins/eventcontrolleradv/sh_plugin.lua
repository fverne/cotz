local PLUGIN = PLUGIN
PLUGIN.name = "EventController - Adv"
PLUGIN.author = "gumlefar"
PLUGIN.desc = "Makes events occur randomly on your server. More intricate and complex configuration possible."

PLUGIN.eventdefs = PLUGIN.eventdefs or {}
PLUGIN.eventpoints = PLUGIN.eventpoints or {} -- EVENTPOINT STRUCTURE table.insert( PLUGIN.eventpoints, { position, name, difficulty } )

ix.util.Include("sh_eventdefs.lua")

ix.config.Add("eventControllerAdvThreshold", 5, "How many events can be active at any one time.", nil, {
	data = {min = 1, max = 50},
	category = "Spawning"
})

PLUGIN.updaterate = 5
PLUGIN.noSpaceRate = 450

PLUGIN.spawnratebase = 900
PLUGIN.spawnrateplayer = 30
PLUGIN.spawnradius = 128
PLUGIN.populateAmount = 5

PLUGIN.saferadius = 1000

PLUGIN.currentEvents = {} --To keep track of and update running events

PLUGIN.spawntime = CurTime() + 30
PLUGIN.updatetime = CurTime() + 30
PLUGIN.populate = false

local icon = Material("vgui/icons/news.png")

ix.chat.Register("eventpda", {
	CanSay = function(self, speaker, text)
		if IsValid(speaker) then
			if speaker:IsAdmin() or speaker:GetCharacter():HasFlags("N") then
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
		listener:EmitSound( "stalkersound/pda/pda_news.wav", 55, 100, 0.2, CHAN_AUTO ) 

		return true
	end,
})

ix.chat.Register("eventpdainternal", {
	CanSay = function(self, speaker, text)
	speaker:EmitSound( "stalkersound/pda/pda_news.wav", 55, 100, 0.2, CHAN_AUTO ) 

		return true
		/*if pda then
			speaker:EmitSound( "stalkersound/pda/pda_news.wav", 55, 100, 0.2, CHAN_AUTO ) 
			return true
		else 
			return false
		end
		return false*/
	end,
	OnChatAdd = function(self, speaker, text)
		chat.AddText(Color(0,191,255), "[GPDA-SYSTEM] ", Color(0,241,255), icon, ": "..text)
	end,
	prefix = {},
	CanHear = function(self, speaker, listener)

		return true
		/*if pda then
			return true
		else
			return false
		end*/
	end,
})

if SERVER then	
	local function isClear(position)
		
		local currentdefs = {}
		local currentents = ents.FindInSphere( position, PLUGIN.saferadius )

		for i,j in pairs (currentents) do
			if j:IsPlayer() then
				return false
			end
		end
		return true
	end
	
	function PLUGIN:spawnEvent(eventpoint, spawn)
		if isClear(eventpoint[1]) then
			key = spawn.key
			if(!self.currentEvents[key]) then
				self.currentEvents[key] = {}
				self.currentEvents[key].data = {}
				self.currentEvents[key].eventpoint = eventpoint
				self.currentEvents[key].eventDef = spawn.key


				local tmpfunc = self.eventdefs[spawn.key].funcPrestart
				local data = tmpfunc(self.currentEvents[key])
				self.currentEvents[key] = data
				tmpfunc = self.eventdefs[spawn.key].funcStart
				data = tmpfunc(self.currentEvents[key])
				self.currentEvents[key] = data
			end
		end
	end

	function PLUGIN:setSpawnTime(time)
		self.spawntime = time
	end
	
	function PLUGIN:setPopulate(bool)
		self.populate = bool
	end

	function PLUGIN:LoadData()
		self.eventpoints = self:GetData() or {}
	end

	function PLUGIN:SaveData()
		self:SetData(self.eventpoints)
	end
	
	function PLUGIN:Think()

		if self.populate then
			for i = 1, self.populateAmount do
				local spawn = table.Random(self.eventdefs)
				if (!spawn) then
					print("No spawn found")
					return
				end
				--if !table.IsEmpty(self.eventpoints) then return end
				local eventpoint = self.eventpoints[table.Random(spawn.allowedPoints)]

				if (!eventpoint) then
					print("No eventpoint found")
					return
				end
				
				print("spawned forced event")
				self:spawnEvent(eventpoint,spawn)
			end
			
			self.populate = false
		end
		
		if (self.updatetime < CurTime() ) then
			for k,v in pairs( self.currentEvents) do
				local tmpfunc = self.eventdefs[v.eventDef].funcUpdate
				v = tmpfunc(v)
				self.currentEvents[k] = v

				tmpfunc = self.eventdefs[v.eventDef].funcShouldEnd
				if tmpfunc(v) then
					tmpfunc = self.eventdefs[v.eventDef].funcEnd
					v = tmpfunc(v)
					self.currentEvents[k] = nil
				end
			end

			self.updatetime = CurTime() + self.updaterate
		end


		if self.spawntime > CurTime() then return end

		if #self.currentEvents > ix.config.Get("maxActiveEvents", 5) then 
			self.spawntime = CurTime() + self.noSpaceRate
			return 
		end

		self.spawntime = CurTime() + (self.spawnratebase - (self.spawnrateplayer * #player.GetAll()))

		local spawn = table.Random(self.eventdefs)
		if (!spawn) then
			return
		end
		local eventpoint = self.eventpoints[table.Random(spawn.allowedPoints)]

		if (!eventpoint) then
			return
		end

		self:spawnEvent(eventpoint, spawn)

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

ix.command.Add("eventadvadd", {
	superAdminOnly = true,
	arguments = {
		ix.type.string,
		ix.type.string,
	},
	OnRun = function(self, client, name, internalname)
		local trace = client:GetEyeTraceNoCursor()
		local hitpos = trace.HitPos + trace.HitNormal*5
		local name = name or "UNNAMED AREA"
		local internalname = internalname or "UNDEFINED_INTERNAL_NAME"

		PLUGIN.eventpoints[internalname] = {hitpos,name}
		client:Notify( "Event area named '"..name.."'("..internalname..") succesfully added" )
	end
})

ix.command.Add("eventadvremove", {
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

ix.command.Add("eventadvdisplay", {
	adminOnly = true,
	OnRun = function(self, client, arguments)
		if SERVER then
			netstream.Start(client, "nut_DisplaySpawnPoints", PLUGIN.eventpoints)
			client:Notify( "Displayed All Points for 10 secs." )
		end
	end
})

ix.command.Add("eventadvforce", {
	adminOnly = true,
	OnRun = function(client, arguments)
		PLUGIN:setSpawnTime(1)
	end
})

ix.command.Add("eventadvpopulate", {
	adminOnly = true,
	OnRun = function(self, client, arguments)
		PLUGIN:setPopulate(true)
	end
})